# Development Partner Questions & Answers
**Stryv Academics - Phase 1 MVP**

## Questions 1-3
- You can find the answers for these questions in ours proposal document.

## 4. Similar platform examples
Although we haven't develop a similiar EduTech platform with Xero/Airwallex integration before. We have experience working on a few platforms with similar tech stacks and other integration. Here are some showcase examples:
- [TODO]
- [TODO]

---

## 5. Airtable Migration Approach

### Migration Strategy (4 Phases)

#### Phase 1: Data Audit (Week 8)
- Export Airtable data to CSV/JSON
- Analyze data quality: missing fields, inconsistent formats, duplicates
- Document findings and create cleanup plan

#### Phase 2: Script Development (Weeks 9-10)

**User Migration**:
- Map Airtable records to `profiles`, `tutors`, `parents`, `students` tables
- Create Xero contacts for each user
- Initialize `credit_balance` and `deduction_balance` to 0
- Set all users to `status='onboarding'` for re-onboarding

**Package Migration**:
- Preserve tutor-student-parent relationships using array fields
- Calculate `hours_remaining` from historical data (if available)
- Mark completed packages as `status='completed'`

**Validation Rules**:
- All foreign key relationships valid (no orphaned records)
- Email addresses unique per user
- Row counts match Airtable → Supabase

#### Phase 3: Dry-Run (Week 11)
- Run migration in staging environment
- Validate data integrity (sampling 50+ records for manual inspection)
- Performance testing (target <2 hours completion time)
- Rollback testing

#### Phase 4: Production Migration (Week 12)
- 2-hour maintenance window (off-peak)
- Transaction-wrapped execution (rollback on error)
- Post-migration validation queries
- User communication with new login instructions

### What Will NOT Be Migrated
- **Historical payments/payouts**: Start fresh (clean slate for financial tracking)
- **Historical lesson records**: New lesson schema doesn't match old data
- **Old T&C acceptances**: All users re-accept during onboarding

### Risks & Mitigation

| Risk | Mitigation |
|------|------------|
| Data quality issues (50% probability) | Early audit Week 8, manual cleanup if needed |
| Xero contact creation failures (35%) | Retry logic, manual creation for failures |
| User confusion (60%) | Clear email communication, FAQ doc, onboarding video |

---

## 6. Xero/Airwallex Integration Strategy

### Xero Integration

#### Authentication: OAuth 2.0 Only (No API Keys)

**Important**: Xero does NOT support API key authentication. All API access requires OAuth 2.0.

**Setup Requirements**:
1. Register app in Xero Developer Portal: https://developer.xero.com/app/manage
2. Obtain **Client ID** and **Client Secret** (not API keys)
3. Configure OAuth 2.0 with PKCE flow

**OAuth Configuration**:
- **Scopes**: `accounting.transactions`, `offline_access`, `openid`, `profile`, `email`
- **Token Management**: Access tokens (30 min), auto-refresh via refresh tokens
- **Storage**: `xero_secrets` table with AES-256 encryption for Client ID & Client Secret

#### Invoice Creation (Client Payments)

**Workflow**:
1. Determine payer (parent or independent student)
2. Calculate credit application: `creditApplied = MIN(creditBalance, invoiceAmount)`
3. Create Xero invoice with line items:
   - Base amount
   - **Credit Applied** (negative line item)
4. Store `xero_invoice_id` in payments table
5. Deduct credit from payer's balance

**Example Line Items**:
```json
[
  {
    "description": "Trial Lesson - Math",
    "quantity": 1,
    "unitAmount": 500.00,
    "accountCode": "200"
  },
  {
    "description": "Credit Applied",
    "quantity": 1,
    "unitAmount": -50.00,
    "accountCode": "200"
  }
]
```

#### Purchase Order + Bill Creation (Tutor Payouts)

**Trigger**: Package completed (hours_remaining=0 OR admin marks complete)

**Workflow**:
1. Calculate payout amount:
   - Base: `totalHours × tutorHourlyRate`
   - Overtime fees
   - Late cancellation fees
   - Transportation fees
2. Apply deductions: `deductionApplied = MIN(deductionBalance, payoutAmount)`
3. Create Xero PO and Bill together with line items:
   - Base hours
   - Additional fees
   - **Deductions Applied** (negative line item)
4. Store `xero_bill_id`, update `payout_status='pending'`
5. Deduct from tutor's `deduction_balance`

**Why PO + Bill Together?**
- Audit trail for agreed-upon payout
- Approval workflow (some clients require PO approval)
- Links tutor services (PO) to payment obligation (Bill)

#### Rate Limiting Strategy
**Xero Limits**: 5 concurrent, 60/minute, 5,000/day

**Mitigation**:
- Exponential backoff on 429 errors
- Request queuing during high-load
- Batch operations (up to 50 items/request)
- Caching contact IDs (1 hour TTL)

### Airwallex Integration

#### Authentication: Restricted API Keys

**Setup Requirements**:
1. Register account at Airwallex: https://www.airwallex.com
2. Access API Keys section in Airwallex Dashboard
3. Create **Restricted API Key** with specific permissions:
   - `payment_intents.create`
   - `payment_links.create`
   - `payouts.create` (for future automation)
4. Obtain **Client ID** and **API Key**

**Security Configuration**:
- **Storage**: `airwallex_secrets` table with AES-256 encryption for Client ID and API Key
- **Never expose**: API keys must NEVER be included in client-side code
- **Header Format**: `x-client-id` and `x-api-key` headers for authentication
- **IP Whitelisting**: Enable in Airwallex Dashboard for production (optional but recommended)
- **Key Rotation**: Rotate keys quarterly, log access for audit

#### Payment Flow (Client Pays)

**Recommended Approach**: Payment Links (faster MVP, lower PCI scope)

**Workflow**:
1. Create payment link via Airwallex API (server-side only):
   ```typescript
   // Server-side API route
   const response = await fetch('https://api.airwallex.com/api/v1/pa/payment_links/create', {
     method: 'POST',
     headers: {
       'Content-Type': 'application/json',
       'x-client-id': process.env.AIRWALLEX_CLIENT_ID,
       'x-api-key': process.env.AIRWALLEX_API_KEY
     },
     body: JSON.stringify({
       amount: 450.00,
       currency: 'HKD',
       merchant_order_id: 'invoice-123', // Idempotency key
       return_url: 'https://stryvacademics.com/payments/success' // Post-payment redirect
     })
   })
   ```
2. Store payment link in payments table
3. Display link to user (redirect to Airwallex-hosted payment page)
4. Receive webhook on payment completion

#### Webhook Handling

**Endpoint**: `POST /api/webhooks/airwallex`

**Security**:
- HMAC-SHA256 signature verification (constant-time comparison)
- **Storage**: `airwallex_secrets` table with AES-256 encryption for Webhook Secret
- Idempotency check (prevent duplicate processing)
- Store raw payload in `airwallex_webhook_events` table

**Event Processing**:
- `payment_intent.succeeded`: Update `payment_status='paid'`, send confirmation email
- `payment_intent.failed`: Notify payer with error message
- `payment_intent.cancelled`: Update `payment_status='cancelled'`

**Best Practice**: Respond 200 within 3 seconds, process asynchronously

#### Payout Flow (Admin Pays Tutor)

**MVP Approach**: Manual (admin uses Airwallex dashboard externally)

**Workflow**:
1. Admin views pending payouts
2. Admin processes payout in Airwallex dashboard
3. Admin returns to platform, clicks "Mark as Sent"
4. Platform updates `payout_status='processing'`
5. Daily cron checks Xero Bill status for reconciliation

---

## 7. Trial Validation Implementation

### Warning-Based Approach

**Philosophy**: Warn but don't block (admin/tutor can override)

### Duplicate Detection Logic

```typescript
async function checkDuplicateTrial(
  studentId: string,
  tutorId: string,
  subjects: string[]
): Promise<{ isDuplicate: boolean }> {
  const existingTrials = await db
    .select()
    .from('lessons')
    .where('student_id', studentId)
    .where('tutor_id', tutorId)
    .where('is_trial', true)

  for (const trial of existingTrials) {
    const subjectOverlap = trial.subjects.some(s => subjects.includes(s))
    if (subjectOverlap) {
      return { isDuplicate: true }
    }
  }

  return { isDuplicate: false }
}
```

### Warning Modal

**Display When**: Duplicate detected (same student + tutor + subject overlap)

**Modal Content**:
```
⚠️ Duplicate Trial Detected

A trial lesson already exists for this combination:
- Student: John Doe
- Tutor: Jane Smith
- Subject: Mathematics
- Trial Date: November 5, 2025
- Outcome: [Pending/Successful/Failed]

Are you sure you want to create another trial?

[Cancel]  [Create Anyway]
```

### Edge Cases

| Scenario | Behavior |
|----------|----------|
| Same tutor-student, **different subjects** | No warning (legitimate) |
| Same subject, **different tutors** | No warning (trial failed, trying new tutor) |
| Same tutor-student-subject, previous trial failed | **Warning displayed**, admin can override |
| Subject overlap (e.g., "Math & Physics" vs "Math & Chemistry") | **Warning displayed**, admin can override |

### Trial Outcome Handling

**Successful**:
- Update `trial_outcome='successful'`, relationship `status='active'`
- Auto-redirect to Create Package form (pre-populated with trial details)

**Failed**:
- Display modal with options:
  - **"Try Different Tutor"**: Reset lead, allow new trial creation
  - **"Full Refund & Exit"**: Process refund, mark lead as 'lost'

**Lost**:
- Update `trial_outcome='lost'`, `lesson_status='cancelled'`, lead `lead_status='lost'`

---

## 8. File Storage Strategy (Supabase Storage)

### Storage Buckets

#### 1. Profile Photos (`profile-photos`)
- **Path**: `/{user_id}/{filename}`
- **Access**: Public read, authenticated write (own folder only)
- **Validation**: JPEG/PNG/GIF, max 5MB
- **Use**: Public tutor profiles, user avatars

#### 2. Lesson Resources (`lesson-resources`)
- **Path**: `/{lesson_id}/{resource_type}/{filename}`
- **Access**: Restricted (tutors upload, assigned students view)
- **Validation**: PDF/TXT/JPEG/PNG/GIF, max 10MB
- **Types**: `lesson_prep`, `supplementary`, `homework`

**RLS Policy Example**:
```sql
-- Students can view resources for their lessons
CREATE POLICY "Students can view own lesson resources"
  ON storage.objects FOR SELECT
  TO authenticated
  USING (
    bucket_id = 'lesson-resources'
    AND EXISTS (
      SELECT 1 FROM lessons
      WHERE lessons.id::text = (storage.foldername(name))[1]
      AND lessons.student_id = auth.uid()
    )
  );
```

#### 3. Payment Receipts (`payment-receipts`)
- **Path**: `/{payment_id}/{filename}`
- **Access**: Payer and admin only
- **Validation**: JPEG/PNG/PDF, max 5MB
- **Use**: Bank transfer receipt uploads

#### 4. T&C Documents (`tc-documents`)
- **Path**: `/{user_id}/{document_type}_{timestamp}.pdf`
- **Access**: User and admin only
- **Generation**: Server-side PDF generation (Puppeteer)
- **Use**: Signed T&C agreements

### File Upload Implementation

**Client-Side Upload**:
```typescript
const handleUpload = async (file: File) => {
  // Validate file type and size
  if (file.size > 10 * 1024 * 1024) {
    alert('File too large. Max 10MB.')
    return
  }

  // Upload to Supabase Storage
  const { data, error } = await supabase.storage
    .from('lesson-resources')
    .upload(`${lessonId}/homework/${file.name}`, file)

  if (error) throw error

  // Get public URL
  const { data: urlData } = supabase.storage
    .from('lesson-resources')
    .getPublicUrl(data.path)

  // Store metadata in database
  await db.insert('lesson_resources').values({
    lesson_id: lessonId,
    file_name: file.name,
    file_url: urlData.publicUrl,
    resource_type: 'homework'
  })
}
```

### Performance & CDN
- **CDN Integration**: Cloudflare CDN (global edge caching)
- **Image Optimization**: Automatic resizing, WebP conversion
- **Cache Control**: Browser/CDN caching headers

### Backup & Retention
- **Automatic Backups**: Included in Supabase daily backups
- **Retention Policy**:
  - Profile photos: Indefinite
  - Lesson resources: 7 years (compliance)
  - Payment receipts: 7 years (compliance)
  - T&C PDFs: Indefinite (legal requirement)

---

## 9. Credit/Deduction Auto-Apply Implementation

### Client Credit System

#### Storage Schema
```sql
CREATE TABLE public.parents (
  user_id UUID PRIMARY KEY,
  credit_balance NUMERIC DEFAULT 0 CHECK (credit_balance >= 0),
  ...
);

CREATE TABLE public.students (
  user_id UUID PRIMARY KEY,
  credit_balance NUMERIC DEFAULT 0 CHECK (credit_balance >= 0), -- Independent students only
  ...
);
```

#### Auto-Apply Logic

**Trigger**: Invoice creation (trial or package)

**Prerequisites**:
1. **Determine Payer**:
   ```typescript
   if (student.parent_id) {
     payerId = student.parent_id // Parent is payer
   } else {
     payerId = studentId // Independent student is payer
   }
   ```

2. **Calculate Credit Application**:
   ```typescript
   const creditApplied = Math.min(creditBalance, invoiceAmount)
   const finalAmount = invoiceAmount - creditApplied
   ```

### Scenario 1: Credit Covers Full Amount

**Condition**: `creditBalance >= invoiceAmount` (finalAmount = 0)

**Workflow** (DB Transaction Only):
```typescript
async function processFullCreditPayment(payerId: string, invoiceAmount: number) {
  // All operations in a single transaction
  await db.transaction(async (trx) => {
    // 1. Deduct credit from balance
    await trx
      .update('parents')
      .set({ credit_balance: db.raw('credit_balance - ?', [invoiceAmount]) })
      .where('user_id', payerId)

    // 2. Create payment record (no Xero invoice needed)
    await trx.insert('payments').values({
      payer_id: payerId,
      amount: 0, // Final amount after credit
      credit_applied: invoiceAmount,
      payment_status: 'paid', // Immediately paid via credit
      xero_invoice_id: null, // No Xero invoice
      created_at: new Date()
    })
  })
}
```

**Key Points**:
- No Xero API call required
- `xero_invoice_id` is `null`
- `payment_status` set to `'paid'` immediately
- Transaction ensures atomic operation (rollback on any error)

### Scenario 2: Credit Partially Covers Amount

**Condition**: `creditBalance < invoiceAmount` (finalAmount > 0)

**Workflow** (Xero + DB with Idempotency):
```typescript
async function processPartialCreditPayment(
  payerId: string,
  invoiceAmount: number,
  creditApplied: number,
  finalAmount: number
) {
  let xeroInvoiceId: string | null = null

  try {
    // Check for existing payment record (idempotency)
    const existingPayment = await db
      .select()
      .from('payments')
      .where('payer_id', payerId)
      .where('amount', finalAmount)
      .where('created_at', '>', new Date(Date.now() - 5 * 60 * 1000)) // Last 5 minutes
      .first()

    if (existingPayment?.xero_invoice_id) {
      // Payment already processed, return existing invoice
      return { success: true, xeroInvoiceId: existingPayment.xero_invoice_id }
    }

    // 1. Create Xero invoice with credit as negative line item
    const xeroResponse = await createXeroInvoice({
      contactId: payerId,
      lineItems: [
        {
          description: 'Trial Lesson - Math',
          quantity: 1,
          unitAmount: invoiceAmount,
          accountCode: '200'
        },
        {
          description: 'Credit Applied',
          quantity: 1,
          unitAmount: -creditApplied,
          accountCode: '200'
        }
      ]
    })

    xeroInvoiceId = xeroResponse.invoiceId

    // 2. Store payment record and deduct credit in transaction
    await db.transaction(async (trx) => {
      // Deduct credit from balance
      await trx
        .update('parents')
        .set({ credit_balance: db.raw('credit_balance - ?', [creditApplied]) })
        .where('user_id', payerId)

      // Create payment record with Xero invoice ID
      await trx.insert('payments').values({
        payer_id: payerId,
        amount: finalAmount, // Amount after credit
        credit_applied: creditApplied,
        payment_status: 'pending',
        xero_invoice_id: xeroInvoiceId,
        created_at: new Date()
      })
    })

    return { success: true, xeroInvoiceId }

  } catch (error) {
    // Error handling: reverse or retry
    if (xeroInvoiceId) {
      // Xero invoice created but DB operation failed
      console.error('Xero invoice created but payment record failed:', error)

      // Option 1: Void Xero invoice (reverse flow)
      await voidXeroInvoice(xeroInvoiceId)

      // Option 2: Retry DB operation (idempotent)
      // await retryPaymentRecordCreation(xeroInvoiceId, payerId, finalAmount, creditApplied)
    }

    throw error
  }
}
```

**Key Points**:
- **Idempotency Check**: Prevents duplicate Xero invoices if system fails during processing
- **Transaction Safety**: DB operations are atomic (credit deduction + payment record)
- **Error Recovery**:
  - **Option 1 (Reverse)**: Void Xero invoice and if DB fails after invoice creation
  - **Option 2 (Retry)**: Retry DB operation with existing `xero_invoice_id` (idempotent)
- `payment_status` set to `'pending'` (awaiting Airwallex payment)

#### Credit Addition (Admin)
**UI**: Simple modal with amount input

```typescript
async function addCredit(userId: string, amount: number) {
  await db.transaction(async (trx) => {
    await trx
      .update('parents')
      .set({ credit_balance: db.raw('credit_balance + ?', [amount]) })
      .where('user_id', userId)

    // Log transaction for audit
    await trx.insert('credit_transactions').values({
      user_id: userId,
      amount: amount,
      type: 'added_by_admin',
      created_at: new Date()
    })
  }
}
```

### Tutor Deduction System

Similiar implementation as Client Credit System, but using credit from tutor's `deduction_balance` during payout processing for equipment/material fees.

### Display in UI

**Parent/Student Settings**:
```
Account Credit Balance: $150.00 HKD

ℹ️ Credit automatically applies to your next invoice.
```

**Tutor Earnings Page**:
```
Deduction Balance: $200.00 HKD

Pending Payout:
  Base: $1,000.00
  Deductions: -$200.00
  Net: $800.00
```

---

## 10. Testing & QA Methodology

### Testing Pyramid

**70% Unit Tests**:
- Jest framework
- Business logic, utility functions, calculations
- **Target**: >80% code coverage

**20% Integration Tests**:
- Jest + Docker (API testing)
- Database operations, external API mocking (MSW)

**10% E2E Tests**:
- Playwright (Chromium, Firefox, WebKit)
- Full user journeys
- Staging environment


### Unit Testing Examples

**Credit Calculation**:
```typescript
describe('Credit Application', () => {
  it('should apply full credit when credit > invoice', () => {
    const result = calculateCreditApplication(500, 600)
    expect(result.creditApplied).toBe(500)
    expect(result.finalAmount).toBe(0)
  })

  it('should apply partial credit when credit < invoice', () => {
    const result = calculateCreditApplication(500, 100)
    expect(result.creditApplied).toBe(100)
    expect(result.finalAmount).toBe(400)
  })
})
```

**Hours Tracking**:
```typescript
describe('Hours Tracking', () => {
  it('should NOT deduct for late cancelled lesson', () => {
    const result = deductHoursFromPackage(10, 2, 'late_cancelled')
    expect(result.hoursRemaining).toBe(10)
  })

  it('should detect overtime', () => {
    const result = deductHoursFromPackage(2, 3, 'completed')
    expect(result.overtimeHours).toBe(1)
  })
})
```

### Automated Integration Testing Example (jest + Docker for Local Supabase)

**Lead Conversion Workflow**:
```typescript
it('should convert lead to trial with account creation', async () => {
  // 1. Create lead via webhook
  await fetch('/api/webhooks/webflow', { ... })

  // 2. Verify lead created
  const lead = await db.select().from('leads').where('email', 'test@example.com').first()
  expect(lead.lead_status).toBe('new')

  // 3. Convert lead (create accounts + trial)
  await fetch(`/api/leads/${lead.id}/convert`, { ... })

  // 4. Verify accounts created
  const parent = await db.select().from('parents').where('email', 'test@example.com').first()
  expect(parent.status).toBe('onboarding')

  // 5. Verify Xero invoice created
  const payment = await db.select().from('payments').first()
  expect(payment.xero_invoice_id).toBeDefined()
})
```

### Automated E2E Testing Example (playwright + Staging Supabase)

**Tutor Onboarding**:
```typescript
test('should complete full onboarding', async ({ page }) => {
  // 1. Admin creates tutor account
  await page.goto('/admin/users')
  await page.click('button:has-text("Create User")')

  // 2. Tutor clicks magic link
  await page.goto(magicLink)

  // 3. Complete profile (Step 1)
  await page.fill('[name="bio"]', 'Experienced tutor...')

  // 4. Complete banking (Step 2)
  await page.fill('[name="accountNumber"]', '123456789')

  // 5. Accept T&C (Step 3)
  await page.check('[name="acceptTC"]')
  await page.click('button:has-text("Accept & Complete")')

  // 6. Verify redirect to dashboard
  await page.waitForURL('/dashboard/tutor')
})
```

### Beta Testing (Weeks 11-12)

**Participants**: 2 admins, 5 tutors, 5 parents, 3 students

**Test Scenarios**:
- Admin: Create users, convert leads, process payments/payouts
- Tutor: Complete onboarding, record lessons, view earnings
- Parent: Pay invoices, view lessons, request tutor
- Student: Complete onboarding, view lessons/resources

**Feedback Collection**:
- Daily Slack channel for bug reports
- Weekly feedback survey
- Screen recordings (Loom)

### CI/CD Testing

**GitHub Actions**:
- Unit tests on every push
- Integration tests with Jest + Docker
- E2E tests with Playwright
- Code coverage reporting (Codecov)
- Lighthouse CI (performance audits)

---

## 11. Post-Launch Support Plans

### Support Phases

#### Week 1: Launch Week (Intensive)
- **Team**: Full team on-call
- **Schedule**: Days 1-3 (24/7), Days 4-7 (business hours)
- **Activities**: Daily standups, real-time error monitoring, admin Slack + support email

#### Weeks 2-4: Stabilization
- **Team**: Senior Developer, 2 On-call Developer, QA
- **Schedule**: Business hours + evening/weekend on-call rotation
- **Activities**: Daily standup, bug triage, weekly retrospective

#### Months 2+: Maintenance
- **Team**: Part-time (Senior Developer 0.25 FT, 1 On-call Developer 0.5 FT)

- **Schedule**: Business hours on-call rotation

- **Activities**: Daily standup, bug triage, weekly retrospective, technical debt backlog

### Hot-Fix Deployment Process

1. Developer creates fix (branch from main)
2. Fast-track PR review (Tech Lead)
3. Deploy to staging, QA verifies
4. Deploy to production
5. Monitor for 1 hour

### Handover Plan (End of Month 3)

**Documentation Delivered**:
- Technical architecture document
- API documentation (Swagger)
- Database schema diagram
- Deployment runbook
- Incident response playbook

**Knowledge Transfer Sessions** (4 × 2 hours):
1. Architecture overview, codebase tour
2. Xero/Airwallex integration deep-dive
3. Common issues and fixes
4. Deployment and monitoring

---

## 12. T&C Implementation Approach

### Modal UI Design

**Desktop Layout**:
- Scrollable content area (max 60vh height)
- Checkbox: "I have read and agree to the terms above"
- Buttons: "Cancel" | "Accept & Continue"
- **Accessibility**: Keyboard navigation, ARIA labels, focus trap

**Mobile Layout** (≤768px):
- Full screen modal (100vh)
- Scrollable content adapts to screen
- Buttons stack vertically
- Touch targets 48x48px minimum

**Scroll Detection**:
```typescript
const handleScroll = (e: React.UIEvent<HTMLDivElement>) => {
  const element = e.currentTarget
  const isAtBottom = element.scrollHeight - element.scrollTop <= element.clientHeight + 50
  if (isAtBottom) {
    setHasScrolledToBottom(true) // Enable checkbox
  }
}
```

### Audit Trail Capture

**Data Captured on Acceptance**:
1. User ID (UUID)
2. Document Type (`tutor_agreement`, `parent_agreement`, `student_agreement`)
3. Document Version (`1.0.0` - semantic versioning)
4. IP Address (from request headers)
5. User Agent (browser/device info)
6. Timestamp (UTC)

**Database Schema**:
```sql
CREATE TABLE public.terms_acceptances (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.profiles(id),
  document_type TEXT NOT NULL,
  document_version TEXT NOT NULL,
  ip_address TEXT NOT NULL,
  user_agent TEXT,
  accepted_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT terms_acceptances_user_document_unique UNIQUE (user_id, document_type)
);
```

**Implementation**:
```typescript
// API route: /api/onboarding/terms
export async function POST(request: Request) {
  const { userId, documentType } = await request.json()

  // Capture audit trail
  await db.insert('terms_acceptances').values({
    user_id: userId,
    document_type: documentType,
    document_version: '1.0.0',
    ip_address: request.headers.get('x-forwarded-for') || 'unknown',
    user_agent: request.headers.get('user-agent') || 'unknown',
    accepted_at: new Date()
  })

  // Generate PDF
  const pdfUrl = await generateTCPDF(userId, documentType)

  // Send confirmation email
  await sendTCConfirmationEmail(userId, pdfUrl)

  // Update user status: onboarding → active
  await db.update('profiles').set({ status: 'active' }).where('id', userId)

  return Response.json({ success: true })
}
```

### PDF Generation

**Approach**: HTML to PDF using Puppeteer

**Workflow**:
1. Load T&C HTML template (versioned)
2. Inject user details and acceptance info
3. Generate PDF with Puppeteer (headless Chrome)
4. Upload to Supabase Storage (`tc-documents` bucket)
5. Return public URL

**Implementation**:
```typescript
export async function generateTCPDF(userId: string, documentType: string): Promise<string> {
  // Get user and acceptance details
  const user = await db.select().from('profiles').where('id', userId).first()
  const acceptance = await db.select().from('terms_acceptances').where('user_id', userId).first()

  // Load T&C content
  const tcContent = await getTCContent(documentType, '1.0.0')

  // Generate HTML with signature block
  const html = `
    <!DOCTYPE html>
    <html>
      <head>
        <style>
          body { font-family: Arial; margin: 40px; }
          .signature-block { margin-top: 40px; padding: 20px; border: 1px solid #ccc; }
        </style>
      </head>
      <body>
        <h1>Terms and Conditions - ${formatDocumentType(documentType)}</h1>
        ${tcContent}
        <div class="signature-block">
          <p><strong>Name:</strong> ${user.first_name} ${user.last_name}</p>
          <p><strong>Accepted on:</strong> ${new Date(acceptance.accepted_at).toLocaleString()}</p>
          <p><strong>IP Address:</strong> ${acceptance.ip_address}</p>
        </div>
      </body>
    </html>
  `

  // Generate PDF
  const browser = await puppeteer.launch({ headless: true })
  const page = await browser.newPage()
  await page.setContent(html)
  const pdfBuffer = await page.pdf({ format: 'A4' })
  await browser.close()

  // Upload to Supabase Storage
  const filePath = `${userId}/${documentType}_${Date.now()}.pdf`
  await supabase.storage.from('tc-documents').upload(filePath, pdfBuffer)

  const { data } = supabase.storage.from('tc-documents').getPublicUrl(filePath)
  return data.publicUrl
}
```

### Email Confirmation

**Email Template** (React Email):
```typescript
export function TCConfirmationEmail({ userName, documentType, acceptedDate, pdfUrl }) {
  return (
    <Html>
      <Body>
        <Container>
          <Heading>Terms and Conditions Confirmed</Heading>
          <Text>Dear {userName},</Text>
          <Text>
            Thank you for accepting the {documentType} on {acceptedDate}.
          </Text>
          <Text>
            A copy of the signed agreement is attached for your records.
          </Text>
          <Link href={pdfUrl}>Download Agreement (PDF)</Link>
        </Container>
      </Body>
    </Html>
  )
}
```

**Sending**:
```typescript
async function sendTCConfirmationEmail(userId: string, pdfUrl: string) {
  const user = await db.select().from('profiles').where('id', userId).first()

  await resend.emails.send({
    from: 'Stryv Academics <noreply@stryvacademics.com>',
    to: user.email,
    subject: 'Terms and Conditions Confirmation',
    react: TCConfirmationEmail({ ... }),
    attachments: [{ filename: 'agreement.pdf', path: pdfUrl }]
  })
}
```

### Version Control

**Semantic Versioning**: `MAJOR.MINOR.PATCH`
- **MAJOR/MINOR**: Breaking changes (require re-acceptance)
- **PATCH**: Typo fixes (no re-acceptance needed)

**Storage**:
```
/content/tc/
  tutor_agreement_v1_0_0.html
  tutor_agreement_v1_1_0.html
  parent_agreement_v1_0_0.html
```

**Re-acceptance Workflow**:
- On next login, if version mismatch detected, show T&C modal again
- User re-accepts, new `terms_acceptances` record created
- Old record retained for audit

### Legal Compliance

**Audit Trail Retention**: 7 years minimum (compliance requirement)

**GDPR Considerations**:
- Data processing consent included in T&C
- Right to access: Users can download PDF from Settings → Legal Documents
- Right to erasure: T&C acceptance records **exempt** (legal obligation)

---

## Summary

This document provides concise technical answers for questions 5-12, focusing on:

- **Airtable Migration**: 4-phase strategy with validation and rollback
- **Xero/Airwallex**: OAuth 2.0, PO+Bill workflow, payment links, webhooks
- **Trial Validation**: Warning-based (non-blocking) with admin override
- **File Storage**: Supabase Storage with RLS, 4 buckets, CDN delivery
- **Credit/Deduction**: Auto-apply logic with Xero line items
- **Testing**: 80%+ coverage, unit/integration/E2E, beta testing
- **Post-Launch**: 1 month support, handover plan
- **T&C**: Modal UI, audit trail, PDF generation, email confirmation

**Key Principles**: Security-first (RLS, encryption), automation (credit/deduction), compliance (audit trails, retention), and scalability (CDN, caching, rate limiting).
