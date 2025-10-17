# Development Partner Questions & Answers
**Stryv Academics MVP Platform**
**Date: December 2024**

---

## 1. Timeline for Phase 1 Delivery (Within 4 Months)

### Overview
Phase 1 (MVP) will be delivered in **13 weeks** from October 27, 2025 to January 25, 2026, which is approximately **3.25 months** - well within the 4-month requirement.

### Timeline Breakdown

| Week(s) | Dates | Milestone | Key Deliverables | Status |
|---------|-------|-----------|------------------|--------|
| **Week 1** | Oct 27-Nov 2 | Milestone 1 | Kickoff, schema 50%, design foundations | Foundation |
| **Week 2** | Nov 3-9 | Milestone 1 | Schema 100%, database complete, auth working | Foundation |
| **Week 3** | Nov 10-16 | Milestone 1 | User CRUD, T&C flow, admin dashboard | Foundation |
| **Week 4** | Nov 17-23 | Milestone 1 | All dashboards, mobile responsive ✅ | Foundation |
| **Weeks 5-6** | Nov 24-Dec 7 | Milestone 2 | Leads, trials, packages, Xero ✅ | Core Features |
| **Weeks 7-8** | Dec 8-21 | Milestone 3 | Payments, Airwallex, credit system | Payments |
| **Weeks 9-10** | Dec 22-Jan 4 | Milestone 3 | Payouts, fees, applications ⚠️ Holidays | Payouts |
| **Weeks 11-12** | Jan 5-18 | Milestone 4 | Testing, migration, security audit | Launch Prep |
| **Week 13** | Jan 19-25 | Milestone 4 | Beta testing, launch prep, go-live 🚀 | Launch |

### Critical Path Items
1. **Weeks 1-2**: Schema discovery (MUST complete by end Week 2)
2. **Week 2**: Xero/Airwallex sandbox ready (blocks integration work)
3. **Weeks 3-4**: T&C flow and RBAC complete (blocks user activation)
4. **Weeks 5-6**: Trial system and Xero Invoices (blocks lead conversion)
5. **Weeks 7-8**: Credit auto-apply and Airwallex (blocks go-live)
6. **Weeks 9-10**: Xero PO+Bill workflow (blocks tutor payouts)
7. **Weeks 11-12**: Data migration and security audit (blocks production)

### Risk Mitigation
- **Holiday Risk (Dec 25-Jan 1)**: Reduced capacity weeks accounted for in planning
- **Buffer Built-In**: 8-10% efficiency buffer included in estimates
- **Parallel Work Streams**: 8 FTE working simultaneously on different features
- **Early Testing**: Each milestone includes testing and validation

---

## 2. Cost Breakdown by Milestone

### Total Budget: $41,100 USD
**Team Composition**: 8 FTE (9 people) over 13 weeks

### Milestone Cost Breakdown

| Milestone | Duration | Focus Area | Man-Days | Cost (USD) |
|-----------|----------|------------|----------|------------|
| **Milestone 1** | Weeks 1-4 | Foundation, Auth, User Management, T&C | 160 | $11,200 |
| **Milestone 2** | Weeks 5-6 | Leads, Trials, Packages, Xero | 80 | $5,600 |
| **Milestone 3** | Weeks 7-10 | Payments, Payouts, Fees, Applications | 160 | $11,200 |
| **Milestone 4** | Weeks 11-13 | Testing, Migration, Launch | 120 | $8,400 |
| **Total** | 13 weeks | **Complete MVP** | **520** | **$41,100** |

### Team Cost Breakdown (Vietnam Rates)

| Role | FTE | Days | Rate/Day | Subtotal (USD) |
|------|-----|------|----------|----------------|
| **Tech Lead** | 1.0 | 60 | $100 | $6,000 |
| **Senior Full-Stack** | 1.0 | 60 | $90 | $5,400 |
| **Full-Stack Dev #1** | 1.0 | 60 | $70 | $4,200 |
| **Full-Stack Dev #2** | 1.0 | 60 | $70 | $4,200 |
| **Full-Stack Dev #3** | 1.0 | 60 | $70 | $4,200 |
| **Full-Stack Dev #4** | 1.0 | 60 | $70 | $4,200 |
| **UI/UX Designer** | 1.0 | 60 | $75 | $4,500 |
| **QA Engineer Lead** | 1.0 | 60 | $65 | $3,900 |
| **DevOps** | 0.5 | 30 | $80 | $2,400 |
| **PM** | 0.5 | 30 | $70 | $2,100 |
| **TOTAL** | **8 FTE** | **480** | - | **$41,100** |

### Payment Milestones (Suggested)
- **25% upfront** ($10,275): Upon contract signing and kickoff
- **25% at Milestone 1 completion** ($10,275): After Week 4 (all dashboards working)
- **25% at Milestone 3 completion** ($10,275): After Week 10 (payments and payouts complete)
- **25% at launch** ($10,275): After successful production deployment

### Cost Range with Variations
- **Conservative Budget Tier**: $37,000 - $41,000 USD
- **Mid-Range Standard Tier**: $41,000 - $46,000 USD (Recommended)
- **Premium Senior Tier**: $46,000 - $52,000 USD

---

## 3. Team Composition & Experience

### Core Development Team (8 FTE)

#### 1. Tech Lead / Senior Architect (1 FT)
**Required Experience**:
- 8+ years full-stack development
- **Supabase expertise**: PostgreSQL, RLS policies, Supabase Auth, Edge Functions
- **Next.js 15 expertise**: App Router, Server Components, Server Actions, TypeScript
- **EdTech experience**: Previous work on learning management systems or tutoring platforms
- **API integrations**: Xero, Airwallex, or similar financial/payment APIs
- **Architecture**: Microservices, serverless, event-driven systems

**Responsibilities**:
- Overall architecture design and technical decisions
- Complex integrations (Xero PO+Bill workflow, Airwallex)
- Supabase schema discovery and documentation (Weeks 1-2)
- Code reviews and technical mentoring
- Critical path blocking issues

#### 2. Senior Full-Stack Developer (1 FT)
**Required Experience**:
- 6+ years full-stack development
- **Next.js & React**: Advanced hooks, context, Server Components
- **Financial logic**: Payment processing, credit systems, invoicing
- **Database design**: Complex relational schemas, query optimization
- **EdTech**: Previous work on student/tutor platforms or educational systems

**Responsibilities**:
- Payment processing workflows (credit auto-apply, additional fees)
- Tutor payout system (4-stage status flow)
- Data migration from Airtable
- Complex business logic implementation

#### 3-6. Full-Stack Developers (4 FT)
**Required Experience**:
- 4+ years full-stack development
- **Next.js & TypeScript**: Proficiency with App Router, Server Actions
- **React**: Component-based architecture, state management
- **REST APIs**: Design and implementation
- **Supabase**: Database queries, file storage, authentication

**Responsibilities** (divided):
- **Dev #1**: Lead management, trial system, package creation
- **Dev #2**: User dashboards (Admin, Tutor, Parent, Student)
- **Dev #3**: Lesson recording, resource upload, applications workflow
- **Dev #4**: Tutor profiles, Request Tutor form, email system

#### 7. UI/UX Designer (1 FT)
**Required Experience**:
- 5+ years UI/UX design
- **EdTech experience**: Educational platforms, multi-role interfaces
- **Design systems**: Creating component libraries, style guides
- **Mobile-first design**: Responsive layouts, touch optimization
- **Tools**: Figma, Adobe XD, or similar

**Responsibilities**:
- Full design system creation (no brand guidelines provided)
- Preply-style tutor profile design
- Mobile-responsive layouts (hamburger menu, touch targets)
- User flow diagrams for all 4 roles
- Figma prototypes and component library
- T&C modal and onboarding screens

#### 8. QA Engineer Lead (1 FT)
**Required Experience**:
- 5+ years QA/testing
- **Test automation**: Playwright, Jest, Cypress
- **EdTech testing**: Multi-role workflows, financial transactions
- **Security testing**: OWASP Top 10, penetration testing
- **Performance testing**: Load testing, stress testing

**Responsibilities**:
- Test strategy and planning
- Automated testing setup (E2E, integration)
- Manual testing critical flows
- Bug tracking and regression testing
- Security testing coordination
- Beta testing management

### Supporting Team (1 FTE Part-Time)

#### 9. DevOps Engineer (0.5 FT)
**Required Experience**:
- **Vercel**: Next.js deployment, environment configuration
- **Supabase**: Database migrations, RLS policies, Edge Functions
- **CI/CD**: GitHub Actions, automated testing pipelines
- **Monitoring**: Sentry, LogTail, or similar tools

**Responsibilities**:
- Supabase environment setup (dev/staging/prod)
- CI/CD pipeline configuration
- Vercel deployment automation
- Monitoring and logging setup
- Performance optimization

#### 10. Project Manager (0.5 FT)
**Required Experience**:
- 5+ years project management
- **Agile/Scrum**: Sprint planning, daily standups
- **EdTech projects**: Educational platforms or SaaS products
- **Stakeholder management**: Client communication, requirement clarification

**Responsibilities**:
- Sprint planning and daily standups
- Stakeholder communication
- Risk management
- Timeline tracking
- Beta testing coordination

### Team Experience Requirements Summary
- **Supabase**: All developers must have Supabase experience (PostgreSQL, RLS, Auth)
- **Next.js 15**: All developers must have Next.js App Router experience
- **EdTech**: At least 50% of the team should have EdTech or multi-role platform experience
- **Financial APIs**: Tech Lead and Senior Dev must have Xero/Stripe/similar API experience
- **TypeScript**: All developers must be proficient in TypeScript

---

## 4. Similar Platform Examples

### Primary Reference: Preply
**URL**: https://preply.com

**Why Preply?**
- **Tutor Profiles**: Stryv's public tutor profiles are designed in "Preply-style" (as specified in requirements)
- **Multi-sided marketplace**: Tutors, students, and parents similar to Stryv
- **Trial lessons**: Preply offers trial lessons with satisfaction guarantees
- **Package purchasing**: Students buy lesson packages from tutors

**Preply Features to Reference**:
- Tutor profile layout: Photo, bio, subjects, qualifications, reviews
- Search and filter functionality
- Trial lesson booking flow
- Package selection interface
- Student dashboard for lesson management

### Secondary Reference: Wyzant
**URL**: https://www.wyzant.com

**Relevant Features**:
- **Multi-role platform**: Tutors, students, parents
- **Lead management**: Request tutor form similar to Stryv
- **Payment processing**: Integrated invoicing and payment
- **Lesson tracking**: Students track lessons and resources
- **Tutor applications**: Multi-stage vetting process

### Tertiary Reference: Tutor.com
**URL**: https://www.tutor.com

**Relevant Features**:
- **Parent dashboard**: Children management, lesson tracking
- **Payment methods**: Multiple payment options (card, bank transfer)
- **Resource sharing**: Tutors share lesson materials with students
- **Administrative backend**: Comprehensive admin tools

### Additional References for Specific Features

**Financial Management (Xero-like)**:
- **QuickBooks Online**: Invoice generation, bill management
- **FreshBooks**: Credit application, payment tracking

**Application Management**:
- **Workable**: Multi-stage hiring workflow
- **Greenhouse**: Application tracking and stage management

**Mobile Navigation**:
- **Notion**: Hamburger menu, responsive design
- **Slack**: Mobile-first navigation, touch optimization

---

## 5. Airtable Migration Approach

### Migration Strategy

#### Phase 1: Data Audit (Week 8)
**Objective**: Understand Airtable data quality and completeness

**Steps**:
1. **Export Airtable data** to CSV/JSON
2. **Analyze data quality**:
   - Missing required fields
   - Inconsistent data formats (dates, phone numbers, emails)
   - Duplicate records
   - Broken relationships (missing foreign keys)
3. **Document findings** and create cleanup plan
4. **Estimate manual cleanup effort** (if needed)

#### Phase 2: Migration Script Development (Weeks 9-10)
**Objective**: Build automated migration pipeline

**Script Components**:
1. **User Migration**:
   - Map Airtable user records to `profiles`, `tutors`, `parents`, `students` tables
   - Create Xero contacts for each user
   - Initialize `credit_balance` and `deduction_balance` to 0
   - Generate magic link invites for all users (status='onboarding')

2. **Package Migration**:
   - Map Airtable package records to `packages` table
   - Preserve tutor-student-parent relationships (use `student_ids[]`, `parent_ids[]`)
   - Calculate `hours_remaining` if historical lesson data exists
   - Mark completed packages as `status='completed'`

3. **Subject & Institution Migration**:
   - Extract unique subjects from Airtable (normalize spelling/casing)
   - Extract schools/institutions
   - Populate `subjects` and `institutions` reference tables (if separate)

4. **Lead & Application Migration** (if tracked in Airtable):
   - Map leads to `leads` table
   - Map applications to `tutor_applications` table
   - Preserve stage history if available

5. **Timestamp Preservation**:
   - Map `created_at`, `updated_at` fields
   - Preserve audit trails (user registration dates, package creation dates)

**Validation Rules**:
- All required fields populated (no NULL values where NOT NULL)
- All foreign key relationships valid (no orphaned records)
- Email addresses unique per user
- Phone numbers formatted consistently
- Dates in valid range (not future dates for historical records)

#### Phase 3: Dry-Run Migration (Week 11)
**Objective**: Test migration in staging environment

**Steps**:
1. **Run migration script** against staging Supabase project
2. **Validate data integrity**:
   - Row counts match expected (Airtable count = Supabase count)
   - Random sampling (check 50+ records for accuracy)
   - Relationship integrity (all foreign keys valid)
   - Zero data loss (no missing records)
3. **Performance testing**: Migration completes within acceptable time (<4 hours)
4. **Rollback testing**: Can restore from backup if needed

#### Phase 4: Production Migration (Week 12, Day 1)
**Objective**: Migrate production data with zero downtime

**Steps**:
1. **Schedule maintenance window**: 2-hour window (off-peak hours)
2. **Backup production database** (Supabase automatic + manual export)
3. **Run migration script** with transaction wrapping (rollback on error)
4. **Post-migration validation**:
   - Run validation queries (row counts, relationship checks)
   - Test critical user flows (login, create package, record lesson)
   - Verify Xero contact sync
5. **Go/No-Go decision**: If validation fails, rollback and reschedule
6. **User communication**: Email all users with new login instructions

### What Will NOT Be Migrated

**Historical Financial Data**:
- **Payments**: `payments` table starts fresh (no historical invoices)
- **Payouts**: `tutor_payouts` table starts fresh (no historical payouts)
- **Rationale**: Clean slate for financial tracking, avoids complex Xero reconciliation

**Historical Lesson Records**:
- **Lessons**: `lessons` table starts fresh (new lesson recording system)
- **Rationale**: Old lesson data doesn't fit new schema (lesson report JSONB structure)

**Terms Acceptances**:
- **T&C**: `terms_acceptances` table starts fresh
- **Rationale**: All users must re-accept T&C during onboarding (new legally binding format)

### Migration Risks & Mitigation

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Data quality issues (missing fields, duplicates) | High (50%) | +10-15 days | Early data audit (Week 8), manual cleanup if needed |
| Airtable API rate limits | Medium (30%) | +3-5 days | Batch requests, exponential backoff, run overnight |
| Xero contact creation failures | Medium (35%) | +5 days | Retry logic, manual creation for failures, continue migration |
| User confusion after migration | High (60%) | +5 days support | Clear email communication, onboarding video, FAQ doc |
| Data loss during migration | Low (10%) | Critical | Transaction wrapping, pre-migration backup, validation checks |

### Migration Rollback Plan
**If migration fails**:
1. **Immediate**: Restore Supabase database from pre-migration backup (<30 minutes)
2. **Investigate**: Review error logs, identify root cause
3. **Fix**: Correct migration script, re-test in staging
4. **Reschedule**: New production migration window (24-48 hours later)

### Post-Migration Support
**Week 12 (Days 2-7)**:
- Daily standups to triage migration issues
- Dedicated support channel (Slack/email) for user questions
- Hot-fix deployments for critical bugs
- Monitor user feedback and error logs

---

## 6. Xero/Airwallex Integration Strategy (PO+Bill Workflow)

### Xero Integration Architecture

#### Authentication: OAuth 2.0 with PKCE
**Setup**:
1. **Xero App Registration**: Create Xero app in Developer Portal
2. **Scopes Required**: `accounting.transactions`, `offline_access`, `openid`, `profile`, `email`
3. **OAuth Flow**:
   - User (admin) clicks "Connect Xero" in platform
   - Redirect to Xero authorization page
   - User approves, Xero redirects back with authorization code
   - Exchange code for access token + refresh token (PKCE validation)
   - Store tokens in `xero_tokens` table (encrypted with AES-256)

**Token Management**:
- **Access tokens expire after 30 minutes**: Auto-refresh before expiry
- **Refresh tokens valid indefinitely**: Use to get new access tokens
- **Retry logic**: If API call returns 401, refresh token and retry once

#### Invoice Creation (Client Payments)

**Trigger**: Trial or Package is created

**Workflow**:
1. **Determine Payer**:
   - If student has `parent_id`: Payer is parent
   - If student is independent: Payer is student
   - Get payer's `credit_balance`

2. **Calculate Credit Application**:
   ```javascript
   const creditApplied = Math.min(creditBalance, invoiceAmount)
   const finalAmount = invoiceAmount - creditApplied
   ```

3. **Create Xero Invoice**:
   ```typescript
   POST /api.xro/2.0/Invoices
   {
     "Type": "ACCREC", // Accounts Receivable
     "Contact": { "ContactID": "xero_contact_id" },
     "LineItems": [
       {
         "Description": "Trial Lesson - Math",
         "Quantity": 1,
         "UnitAmount": 500.00,
         "AccountCode": "200" // Revenue account
       },
       {
         "Description": "Credit Applied",
         "Quantity": 1,
         "UnitAmount": -50.00, // Negative line item
         "AccountCode": "200"
       }
     ],
     "DueDate": "2025-11-15",
     "Status": "AUTHORISED"
   }
   ```

4. **Store Invoice ID**:
   - Save `xero_invoice_id` in `payments` table
   - Deduct `credit_applied` from payer's `credit_balance`
   - Create payment record with `payment_status='pending'`

**Error Handling**:
- **Xero API failure**: Retry 3 times with exponential backoff
- **Contact not found**: Create Xero contact first, then retry invoice
- **Validation error**: Log details, notify admin, allow manual retry

#### Purchase Order + Bill Creation (Tutor Payouts)

**Trigger**: Package is completed (hours_remaining=0 OR admin marks complete)

**Workflow**:

1. **Calculate Payout Amount**:
   ```javascript
   const baseAmount = totalHours × tutorHourlyRate
   const overtimeFees = overtimeHours × tutorHourlyRate
   const lateCancelFees = lateCancelCount × (0.5 × tutorHourlyRate)
   const transportFees = sum(transportReceipts)

   const grossPayout = baseAmount + overtimeFees + lateCancelFees + transportFees
   ```

2. **Apply Deductions**:
   ```javascript
   const deductionApplied = Math.min(tutorDeductionBalance, grossPayout)
   const netPayout = grossPayout - deductionApplied
   ```

3. **Create Purchase Order** (optional, for tracking):
   ```typescript
   POST /api.xro/2.0/PurchaseOrders
   {
     "Contact": { "ContactID": "tutor_xero_contact_id" },
     "LineItems": [
       {
         "Description": "Tutoring Services - Package #123",
         "Quantity": 10, // total hours
         "UnitAmount": 50.00, // tutor hourly rate
         "AccountCode": "400" // Expense account
       },
       {
         "Description": "Overtime Fees",
         "Quantity": 2,
         "UnitAmount": 50.00,
         "AccountCode": "400"
       },
       {
         "Description": "Deductions Applied",
         "Quantity": 1,
         "UnitAmount": -100.00, // Negative line item
         "AccountCode": "400"
       }
     ],
     "Status": "AUTHORISED"
   }
   ```

4. **Create Bill** (linked to PO):
   ```typescript
   POST /api.xro/2.0/Bills
   {
     "Type": "ACCPAY", // Accounts Payable
     "Contact": { "ContactID": "tutor_xero_contact_id" },
     "LineItems": [
       // Same line items as PO
     ],
     "DueDate": "2025-12-01",
     "Status": "AUTHORISED",
     "Reference": "PO-123" // Link to PO (optional)
   }
   ```

5. **Store Bill ID**:
   - Save `xero_bill_id` in `tutor_payouts` table
   - Update `payout_status='pending'`
   - Deduct `deduction_applied` from tutor's `deduction_balance`
   - Store `deduction_applied` amount in payout record

**Why PO + Bill Together?**
- **Audit trail**: PO documents the agreed-upon payout before payment
- **Approval workflow**: Some clients require PO approval before Bill payment
- **Tracking**: Links tutor services (PO) to payment obligation (Bill)

**Manual Payouts** (one-off payments):
- Create **Bill only** (no PO)
- Use for bonuses, event payments, adjustments

#### Payment & Bill Status Sync

**Payment Status Sync** (Manual Trigger):
1. Admin clicks "Sync Payment Status" in admin UI
2. For each pending payment:
   ```typescript
   GET /api.xro/2.0/Invoices/{InvoiceID}
   ```
3. Check `Invoice.Status`:
   - `PAID` → Update `payment_status='paid'` in database
   - `VOIDED` → Update `payment_status='cancelled'`
4. Send confirmation email to payer if newly paid

**Bill Reconciliation** (Automatic, Daily Cron):
1. Scheduled job runs daily (midnight)
2. For each processing payout:
   ```typescript
   GET /api.xro/2.0/Bills/{BillID}
   ```
3. Check `Bill.Status`:
   - `PAID` → Update `payout_status='completed'`, store `reconciled_date`
   - `VOIDED` → Update `payout_status='cancelled'`

#### Rate Limiting Strategy
**Xero API Limits**:
- **Concurrent**: 5 calls simultaneously
- **Minute**: 60 calls/minute
- **Daily**: 5,000 calls/day per org (resets midnight UTC)

**Mitigation**:
- **Exponential backoff**: If 429 (rate limit), wait `Retry-After` header seconds
- **Request queuing**: Queue requests during high-load periods
- **Batch operations**: Use batch endpoints for bulk updates (up to 50 items/request)
- **Caching**: Cache contact IDs, organization details (1 hour TTL)

### Airwallex Integration Architecture

#### Payment Flow (Client Pays Invoice)

**Option 1: Payment Links** (Recommended for MVP)

**Workflow**:
1. **Invoice created**: After Xero invoice generation
2. **Generate payment link**:
   ```typescript
   POST /api/v1/pa/payment_links/create
   {
     "amount": 450.00,
     "currency": "HKD",
     "merchant_order_id": "invoice-123-20251115", // Idempotency key
     "reference": "Trial Lesson - Invoice #123",
     "return_url": "https://stryvacademics.com/payments/success",
     "expiry_time": "2025-11-30T23:59:59Z"
   }
   ```
3. **Store link**: Save `airwallex_payment_link` in `payments` table
4. **Display to user**: Show link on invoice detail page
5. **User clicks**: Redirects to Airwallex-hosted payment page (PCI-compliant)
6. **Payment complete**: Airwallex sends webhook to platform

**Option 2: Payment Intents** (Future Enhancement)

**Workflow**:
1. **Create payment intent** (server-side):
   ```typescript
   POST /api/v1/pa/payment_intents/create
   {
     "amount": 450.00,
     "currency": "HKD",
     "merchant_order_id": "invoice-123-20251115",
     "customer_id": "airwallex_customer_id" // Created on user registration
   }
   ```
2. **Return client secret** to frontend
3. **Embed Airwallex Payment Element** in React component
4. **User enters card**: Directly in platform (PCI-compliant iframe)
5. **Payment complete**: Webhook received

**Recommended**: Use **Payment Links** for MVP (faster implementation, lower PCI scope)

#### Webhook Handling

**Endpoint**: `POST /api/webhooks/airwallex`

**Security**:
1. **Signature verification**:
   ```typescript
   const computedSignature = crypto
     .createHmac('sha256', process.env.AIRWALLEX_WEBHOOK_SECRET)
     .update(rawBody)
     .digest('hex')

   if (!crypto.timingSafeEqual(
     Buffer.from(signature),
     Buffer.from(computedSignature)
   )) {
     return res.status(401).json({ error: 'Invalid signature' })
   }
   ```

2. **Idempotency check**:
   ```typescript
   const existingEvent = await db
     .select()
     .from('webhook_events')
     .where('event_id', payload.id)
     .first()

   if (existingEvent) {
     return res.status(200).json({ message: 'Already processed' })
   }
   ```

**Event Handling**:
- **payment_intent.succeeded**:
  - Update `payment_status='paid'` in database
  - Send confirmation email to payer
  - Grant platform access (remove payment blocking)
- **payment_intent.failed**:
  - Notify payer with error message
  - Log failure reason
- **payment_intent.cancelled**:
  - Update `payment_status='cancelled'`
  - Notify admin

**Webhook Best Practices**:
- **Respond quickly**: Return 200 within 3 seconds, process asynchronously
- **Retry handling**: Airwallex retries failed webhooks (exponential backoff)
- **Audit logging**: Store all webhook payloads in `webhook_events` table

#### Payout Flow (Admin Pays Tutor)

**Manual Process** (MVP):
1. Admin views pending payouts in admin UI
2. Admin processes payout **outside platform** via Airwallex dashboard:
   - Transfers funds to tutor's bank account
   - Records `airwallex_payout_id` (from Airwallex)
3. Admin returns to platform, clicks "Mark as Sent"
4. Platform updates `payout_status='processing'`, stores `payment_sent_date`
5. Daily cron job checks Xero Bill status for reconciliation

**Future Enhancement** (API-Driven):
- Use Airwallex Payouts API to initiate transfers programmatically
- Receive webhook for payout completion
- Fully automate tutor payout process

---

## 7. Trial Validation Implementation (Warning-Based)

### Overview
Trial validation is **warning-based**, meaning the system displays a warning to admins when a duplicate trial is detected, but **allows override** to accommodate legitimate edge cases (e.g., same tutor-student pair for different subjects).

### Validation Rules

#### Rule 1: Duplicate Trial Detection
**Definition**: A duplicate trial exists if:
- **Same student**
- **Same tutor**
- **Same subject** (at least one subject overlap)
- Previous trial exists with `is_trial=true`

**Trigger**: When admin creates a trial lesson from lead conversion

**Implementation**:
```typescript
async function checkDuplicateTrial(
  studentId: string,
  tutorId: string,
  subjects: string[]
): Promise<{ isDuplicate: boolean; existingTrial?: Lesson }> {
  const existingTrials = await db
    .select()
    .from('lessons')
    .where('student_id', studentId)
    .where('tutor_id', tutorId)
    .where('is_trial', true)

  for (const trial of existingTrials) {
    const subjectOverlap = trial.subjects.some(s => subjects.includes(s))
    if (subjectOverlap) {
      return { isDuplicate: true, existingTrial: trial }
    }
  }

  return { isDuplicate: false }
}
```

#### Rule 2: Warning Display
**UI Behavior**:
- **Modal popup** with warning message:
  ```
  ⚠️ Duplicate Trial Detected

  A trial lesson already exists for this student-tutor-subject combination:
  - Student: John Doe
  - Tutor: Jane Smith
  - Subject: Mathematics
  - Trial Date: November 5, 2025
  - Trial Outcome: [Pending/Successful/Failed]

  Are you sure you want to create another trial?

  [Cancel]  [Create Anyway]
  ```

- **"Create Anyway" button**: Proceeds with trial creation
- **"Cancel" button**: Returns to lead detail page

#### Rule 3: No Blocking
**Key Principle**: System does **NOT block** trial creation, only warns

**Rationale**:
- **Legitimate use cases**:
  - Same tutor-student for **different subject** (Math trial after English trial)
  - Previous trial **failed** due to scheduling issues (not tutor mismatch)
  - Client requested second trial to re-evaluate after tutor improvement
- **Admin discretion**: Admins know context, system shouldn't enforce rigid rules

### Edge Cases Handled

#### Case 1: Different Subjects
**Scenario**: Student had Math trial with Tutor A, now wants English trial with Tutor A

**Behavior**:
- **No warning**: Subjects are different, no duplicate detected
- Trial creation proceeds normally

#### Case 2: Same Subject, Different Tutors
**Scenario**: Student had Math trial with Tutor A, now wants Math trial with Tutor B

**Behavior**:
- **No warning**: Tutors are different, this is expected (first trial failed, trying different tutor)
- Trial creation proceeds normally

#### Case 3: Same Tutor-Student-Subject, Previous Trial Failed
**Scenario**: Student had Math trial with Tutor A (outcome='failed'), now wants to retry

**Behavior**:
- **Warning displayed**: Duplicate detected
- **Admin can override**: Admin knows context (e.g., client requested second chance)
- Trial creation allowed after override

#### Case 4: Same Tutor-Student, Subject Overlap
**Scenario**: Student had "Math & Physics" trial with Tutor A, now wants "Math & Chemistry" trial

**Behavior**:
- **Warning displayed**: "Math" overlaps
- **Admin can override**: Admin knows context
- Trial creation allowed after override

### Trial Outcome Handling

#### Successful Trial
**Flow**:
1. Admin marks trial outcome as "Successful"
2. System updates:
   - `trial_outcome='successful'`
   - Relationship `status='active'`
   - Lead `lead_status='trial_completed'`
3. **Auto-redirect**: Admin redirected to Create Package form with pre-populated data:
   - Tutor: Same tutor
   - Student: Same student
   - Subjects: Trial subjects
   - Start Date: Today
4. Admin adjusts package details (hours, rates) and submits
5. System links package to trial via `conversion_package_id`

#### Failed Trial
**Flow**:
1. Admin marks trial outcome as "Failed"
2. System displays **modal with options**:
   - **Option 1: "Try Different Tutor"**:
     - Lead status updated to `tutor_options_provided`
     - Admin can assign new preferred tutor
     - Admin can create new trial with different tutor (no warning, different tutor)
   - **Option 2: "Full Refund & Exit"**:
     - System processes refund in Xero/Airwallex
     - Lead status updated to `lost`
     - Relationship status updated to `inactive`

#### Lost Trial
**Flow**:
1. Admin marks trial outcome as "Lost"
2. System updates:
   - `trial_outcome='lost'`
   - `lesson_status='cancelled'`
   - Lead `lead_status='lost'`
   - Relationship `status='inactive'`
3. **No further action**: Lead is closed

### Database Schema for Trials

```sql
-- Lessons table (trials are lessons with is_trial=true)
CREATE TABLE public.lessons (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tutor_id UUID NOT NULL REFERENCES public.profiles(id),
  student_id UUID NOT NULL REFERENCES public.profiles(id),
  package_id UUID REFERENCES public.packages(id), -- NULL for trials

  scheduled_at TIMESTAMPTZ NOT NULL,
  duration NUMERIC NOT NULL,

  lesson_status TEXT NOT NULL CHECK (lesson_status IN ('scheduled', 'completed', 'cancelled', 'late_cancelled')),

  -- Trial fields
  is_trial BOOLEAN NOT NULL DEFAULT false,
  trial_outcome TEXT CHECK (trial_outcome IN ('pending', 'successful', 'failed', 'lost')),
  trial_feedback TEXT,
  conversion_package_id UUID REFERENCES public.packages(id),

  -- Rates (0 for tutor in trials)
  hourly_rate_tutor NUMERIC NOT NULL DEFAULT 0,
  amount_tutor NUMERIC NOT NULL DEFAULT 0,

  subjects TEXT[] NOT NULL, -- Store trial subjects for duplicate detection

  -- Lesson report
  lesson_report JSONB,

  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for duplicate trial detection
CREATE INDEX idx_lessons_trial_duplicate
  ON lessons(student_id, tutor_id, is_trial)
  WHERE is_trial = true;
```

### Testing Strategy

**Unit Tests**:
- Test duplicate detection logic with various subject combinations
- Test warning display conditions
- Test trial outcome transitions

**Integration Tests**:
- Create trial → Warning displayed → Override → Trial created
- Successful trial → Auto-redirect to package creation → Package linked
- Failed trial → Refund option → Xero/Airwallex refund processed

**E2E Tests** (Playwright):
- Admin creates trial for existing tutor-student-subject → Warning modal appears
- Admin clicks "Create Anyway" → Trial created successfully
- Admin marks trial successful → Package creation form pre-populated

---

## 8. File Storage Strategy (Supabase Storage)

### Overview
All file uploads (profile photos, lesson resources, receipts, T&C PDFs) are stored in **Supabase Storage**, which is S3-compatible object storage with built-in security and CDN delivery.

### Storage Buckets

#### 1. Profile Photos Bucket
**Name**: `profile-photos`

**Path Structure**: `/{user_id}/{filename}`

**Example**: `/f47ac10b-58cc-4372-a567-0e02b2c3d479/avatar.jpg`

**Access Control**:
- **Public read**: Yes (profile photos are public for tutor profiles)
- **Write**: Authenticated users (own profile only)
- **RLS Policy**:
  ```sql
  -- Users can upload to their own folder only
  CREATE POLICY "Users can upload own profile photo"
    ON storage.objects FOR INSERT
    TO authenticated
    WITH CHECK (
      bucket_id = 'profile-photos'
      AND (storage.foldername(name))[1] = auth.uid()::text
    );

  -- Anyone can view profile photos (public)
  CREATE POLICY "Anyone can view profile photos"
    ON storage.objects FOR SELECT
    TO public
    USING (bucket_id = 'profile-photos');
  ```

**File Validation**:
- **Allowed types**: JPEG, PNG, GIF
- **Max size**: 5MB
- **Virus scanning**: Enabled (Supabase built-in)

#### 2. Lesson Resources Bucket
**Name**: `lesson-resources`

**Path Structure**: `/{lesson_id}/{resource_type}/{filename}`

**Example**: `/a1b2c3d4-e5f6-g7h8-i9j0-k1l2m3n4o5p6/homework/algebra_worksheet.pdf`

**Access Control**:
- **Public read**: No (restricted to assigned students and tutors)
- **Write**: Tutors only (for their own lessons)
- **RLS Policy**:
  ```sql
  -- Tutors can upload to their lesson folders
  CREATE POLICY "Tutors can upload lesson resources"
    ON storage.objects FOR INSERT
    TO authenticated
    WITH CHECK (
      bucket_id = 'lesson-resources'
      AND auth.user_role() = 'tutor'
      AND EXISTS (
        SELECT 1 FROM lessons
        WHERE lessons.id::text = (storage.foldername(name))[1]
        AND lessons.tutor_id = auth.uid()
      )
    );

  -- Students can view resources for their lessons
  CREATE POLICY "Students can view own lesson resources"
    ON storage.objects FOR SELECT
    TO authenticated
    USING (
      bucket_id = 'lesson-resources'
      AND auth.user_role() IN ('student', 'parent')
      AND EXISTS (
        SELECT 1 FROM lessons
        JOIN lesson_resources ON lesson_resources.lesson_id = lessons.id
        WHERE lessons.id::text = (storage.foldername(name))[1]
        AND (
          lessons.student_id = auth.uid() -- Student's own lesson
          OR EXISTS ( -- Parent's child's lesson
            SELECT 1 FROM students
            WHERE students.user_id = lessons.student_id
            AND students.parent_id = auth.uid()
          )
        )
      )
    );
  ```

**File Validation**:
- **Allowed types**: PDF, TXT, JPEG, PNG, GIF
- **Max size**: 10MB
- **Virus scanning**: Enabled

**Metadata Stored**:
```sql
CREATE TABLE public.lesson_resources (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  lesson_id UUID NOT NULL REFERENCES public.lessons(id) ON DELETE CASCADE,

  file_name TEXT NOT NULL,
  file_url TEXT NOT NULL, -- Supabase Storage URL
  file_type TEXT NOT NULL, -- pdf, image, text, other
  file_size_bytes INTEGER,

  resource_type TEXT NOT NULL CHECK (resource_type IN ('lesson_prep', 'supplementary', 'homework')),

  uploaded_by UUID NOT NULL REFERENCES public.profiles(id),
  description TEXT,
  is_visible_to_student BOOLEAN NOT NULL DEFAULT true,

  uploaded_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

#### 3. Payment Receipts Bucket
**Name**: `payment-receipts`

**Path Structure**: `/{payment_id}/{filename}`

**Example**: `/p1q2r3s4-t5u6-v7w8-x9y0-z1a2b3c4d5e6/bank_transfer_receipt.jpg`

**Access Control**:
- **Public read**: No (admin and payer only)
- **Write**: Parents and independent students (for their own payments)
- **RLS Policy**:
  ```sql
  -- Payers can upload receipts for their payments
  CREATE POLICY "Payers can upload payment receipts"
    ON storage.objects FOR INSERT
    TO authenticated
    WITH CHECK (
      bucket_id = 'payment-receipts'
      AND EXISTS (
        SELECT 1 FROM payments
        WHERE payments.id::text = (storage.foldername(name))[1]
        AND payments.payer_user_id = auth.uid()
      )
    );

  -- Admins and payers can view receipts
  CREATE POLICY "Admins and payers can view receipts"
    ON storage.objects FOR SELECT
    TO authenticated
    USING (
      bucket_id = 'payment-receipts'
      AND (
        auth.user_role() = 'admin'
        OR EXISTS (
          SELECT 1 FROM payments
          WHERE payments.id::text = (storage.foldername(name))[1]
          AND payments.payer_user_id = auth.uid()
        )
      )
    );
  ```

**File Validation**:
- **Allowed types**: JPEG, PNG, PDF
- **Max size**: 5MB
- **Virus scanning**: Enabled

#### 4. T&C Documents Bucket
**Name**: `tc-documents`

**Path Structure**: `/{user_id}/{document_type}_{timestamp}.pdf`

**Example**: `/f47ac10b-58cc-4372-a567-0e02b2c3d479/tutor_agreement_20251115.pdf`

**Access Control**:
- **Public read**: No (user and admin only)
- **Write**: System-generated (server-side only, not direct upload)
- **RLS Policy**:
  ```sql
  -- Users can view their own T&C PDFs
  CREATE POLICY "Users can view own T&C documents"
    ON storage.objects FOR SELECT
    TO authenticated
    USING (
      bucket_id = 'tc-documents'
      AND (storage.foldername(name))[1] = auth.uid()::text
    );

  -- Admins can view all T&C documents
  CREATE POLICY "Admins can view all T&C documents"
    ON storage.objects FOR SELECT
    TO authenticated
    USING (
      bucket_id = 'tc-documents'
      AND auth.user_role() = 'admin'
    );
  ```

**File Validation**:
- **Type**: PDF only
- **Max size**: 2MB
- **Generation**: Server-side PDF generation using `puppeteer` or `@react-pdf/renderer`

### File Upload Implementation

#### Client-Side Upload (React Component)

```typescript
// components/FileUpload.tsx
import { useState } from 'react'
import { createClient } from '@/lib/supabase/client'

export function FileUpload({
  bucket,
  path,
  onUploadComplete
}: {
  bucket: string
  path: string
  onUploadComplete: (url: string) => void
}) {
  const [uploading, setUploading] = useState(false)
  const supabase = createClient()

  const handleUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (!file) return

    // Validate file type
    const allowedTypes = ['image/jpeg', 'image/png', 'application/pdf']
    if (!allowedTypes.includes(file.type)) {
      alert('Invalid file type. Only JPEG, PNG, PDF allowed.')
      return
    }

    // Validate file size (10MB)
    if (file.size > 10 * 1024 * 1024) {
      alert('File too large. Max size is 10MB.')
      return
    }

    setUploading(true)

    try {
      const filePath = `${path}/${file.name}`
      const { data, error } = await supabase.storage
        .from(bucket)
        .upload(filePath, file, {
          cacheControl: '3600',
          upsert: false // Prevent overwriting
        })

      if (error) throw error

      // Get public URL
      const { data: urlData } = supabase.storage
        .from(bucket)
        .getPublicUrl(filePath)

      onUploadComplete(urlData.publicUrl)
    } catch (error) {
      console.error('Upload error:', error)
      alert('Upload failed. Please try again.')
    } finally {
      setUploading(false)
    }
  }

  return (
    <div>
      <input
        type="file"
        onChange={handleUpload}
        disabled={uploading}
        accept=".jpg,.jpeg,.png,.pdf"
      />
      {uploading && <p>Uploading...</p>}
    </div>
  )
}
```

#### Server-Side Upload (for T&C PDFs)

```typescript
// lib/storage/upload-tc-pdf.ts
import { createClient } from '@/lib/supabase/server'
import puppeteer from 'puppeteer'

export async function generateAndUploadTCPDF(
  userId: string,
  documentType: 'tutor_agreement' | 'parent_agreement' | 'student_agreement',
  htmlContent: string
): Promise<string> {
  const supabase = createClient()

  // Generate PDF from HTML using Puppeteer
  const browser = await puppeteer.launch()
  const page = await browser.newPage()
  await page.setContent(htmlContent)
  const pdfBuffer = await page.pdf({ format: 'A4' })
  await browser.close()

  // Upload to Supabase Storage
  const timestamp = Date.now()
  const filePath = `${userId}/${documentType}_${timestamp}.pdf`

  const { data, error } = await supabase.storage
    .from('tc-documents')
    .upload(filePath, pdfBuffer, {
      contentType: 'application/pdf',
      cacheControl: '3600'
    })

  if (error) throw error

  // Get public URL
  const { data: urlData } = supabase.storage
    .from('tc-documents')
    .getPublicUrl(filePath)

  return urlData.publicUrl
}
```

### File Download Implementation

```typescript
// lib/storage/download-file.ts
import { createClient } from '@/lib/supabase/server'

export async function downloadFile(
  bucket: string,
  filePath: string
): Promise<Blob> {
  const supabase = createClient()

  const { data, error } = await supabase.storage
    .from(bucket)
    .download(filePath)

  if (error) throw error

  return data
}

// API route: /api/resources/:id/download
export async function GET(request: Request, { params }: { params: { id: string } }) {
  const resourceId = params.id

  // Get resource metadata from database
  const resource = await db
    .select()
    .from('lesson_resources')
    .where('id', resourceId)
    .first()

  if (!resource) {
    return new Response('Resource not found', { status: 404 })
  }

  // Verify user has access (RLS handles this, but double-check)
  // ...

  // Download from Supabase Storage
  const blob = await downloadFile('lesson-resources', resource.file_url)

  // Return file
  return new Response(blob, {
    headers: {
      'Content-Type': resource.file_type,
      'Content-Disposition': `attachment; filename="${resource.file_name}"`
    }
  })
}
```

### Performance & CDN

**Supabase Storage Features**:
- **CDN Integration**: Files served via Cloudflare CDN (global edge caching)
- **Image Optimization**: Automatic resizing, format conversion (WebP)
- **Cache Control**: Set cache headers for browser/CDN caching

**URL Structure**:
```
https://[PROJECT_REF].supabase.co/storage/v1/object/public/[BUCKET]/[PATH]
```

**Image Transformations** (for profile photos):
```typescript
const { data } = supabase.storage
  .from('profile-photos')
  .getPublicUrl('user-id/avatar.jpg', {
    transform: {
      width: 200,
      height: 200,
      resize: 'cover', // or 'contain', 'fill'
      quality: 80,
      format: 'webp'
    }
  })
```

### Backup & Retention

**Automatic Backups**:
- Supabase includes storage in database backups (daily)
- Point-in-time recovery available (paid tier)

**Manual Backups**:
- Export all files from buckets via Supabase CLI
- Store in separate S3 bucket for disaster recovery

**Retention Policy**:
- **Profile photos**: Indefinite (until user deletes account)
- **Lesson resources**: 7 years (compliance requirement)
- **Payment receipts**: 7 years (compliance requirement)
- **T&C PDFs**: Indefinite (legal requirement)

**Cleanup on User Deletion**:
- When user is soft-deleted (`deleted_at` set), files remain
- After 90 days, if hard-deleted, trigger cleanup job:
  ```typescript
  // Delete all user files
  await supabase.storage.from('profile-photos').remove([`${userId}/`])
  await supabase.storage.from('tc-documents').remove([`${userId}/`])
  ```

---

## 9. Credit/Deduction Auto-Apply Implementation

### Overview
The credit/deduction auto-apply system ensures that:
- **Client credit balances** automatically reduce invoice amounts
- **Tutor deduction balances** automatically reduce payout amounts
- **No manual intervention** required (fully automated)
- **Transparent**: Credit/deductions shown as line items in Xero

### Client Credit System

#### Credit Storage

```sql
-- Parents table
CREATE TABLE public.parents (
  user_id UUID PRIMARY KEY REFERENCES public.profiles(id),
  credit_balance NUMERIC DEFAULT 0 CHECK (credit_balance >= 0),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Students table (independent students only)
CREATE TABLE public.students (
  user_id UUID PRIMARY KEY REFERENCES public.profiles(id),
  parent_id UUID REFERENCES public.parents(user_id), -- NULL for independent
  access_level TEXT DEFAULT 'limited' CHECK (access_level IN ('full', 'limited')),
  credit_balance NUMERIC DEFAULT 0 CHECK (credit_balance >= 0), -- Only for independent students
  school TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

#### Credit Application Logic

**Trigger**: Invoice is created (trial or package)

**Workflow**:

1. **Determine Payer**:
   ```typescript
   async function determinePayer(studentId: string): Promise<string> {
     const student = await db
       .select()
       .from('students')
       .where('user_id', studentId)
       .first()

     if (student.parent_id) {
       return student.parent_id // Parent is payer
     } else {
       return studentId // Independent student is payer
     }
   }
   ```

2. **Get Credit Balance**:
   ```typescript
   async function getCreditBalance(payerId: string): Promise<number> {
     const payer = await db
       .select()
       .from('profiles')
       .where('id', payerId)
       .first()

     if (payer.role === 'parent') {
       const parent = await db.select().from('parents').where('user_id', payerId).first()
       return parent.credit_balance
     } else {
       const student = await db.select().from('students').where('user_id', payerId).first()
       return student.credit_balance || 0
     }
   }
   ```

3. **Calculate Credit Application**:
   ```typescript
   function calculateCreditApplication(
     invoiceAmount: number,
     creditBalance: number
   ): { creditApplied: number; finalAmount: number } {
     const creditApplied = Math.min(creditBalance, invoiceAmount)
     const finalAmount = invoiceAmount - creditApplied

     return { creditApplied, finalAmount }
   }

   // Example:
   // invoiceAmount = 500, creditBalance = 100 → creditApplied = 100, finalAmount = 400
   // invoiceAmount = 500, creditBalance = 600 → creditApplied = 500, finalAmount = 0
   ```

4. **Create Xero Invoice with Credit Line Item**:
   ```typescript
   async function createInvoiceWithCredit(
     contactId: string,
     invoiceAmount: number,
     creditApplied: number,
     description: string
   ): Promise<string> {
     const xeroClient = getXeroClient()

     const lineItems = [
       {
         description: description, // e.g., "Trial Lesson - Math"
         quantity: 1,
         unitAmount: invoiceAmount,
         accountCode: '200' // Revenue account
       }
     ]

     // Add credit line item if credit is applied
     if (creditApplied > 0) {
       lineItems.push({
         description: `Credit Applied`,
         quantity: 1,
         unitAmount: -creditApplied, // Negative amount
         accountCode: '200'
       })
     }

     const invoice = await xeroClient.accountingApi.createInvoices(
       tenantId,
       {
         invoices: [
           {
             type: Invoice.TypeEnum.ACCREC,
             contact: { contactID: contactId },
             lineItems,
             status: Invoice.StatusEnum.AUTHORISED,
             dueDate: new Date(Date.now() + 14 * 24 * 60 * 60 * 1000) // 14 days
           }
         ]
       }
     )

     return invoice.body.invoices[0].invoiceID
   }
   ```

5. **Deduct Credit from Balance**:
   ```typescript
   async function deductCredit(
     payerId: string,
     creditApplied: number
   ): Promise<void> {
     const payer = await db
       .select()
       .from('profiles')
       .where('id', payerId)
       .first()

     if (payer.role === 'parent') {
       await db
         .update('parents')
         .set({
           credit_balance: db.raw('credit_balance - ?', [creditApplied])
         })
         .where('user_id', payerId)
     } else {
       await db
         .update('students')
         .set({
           credit_balance: db.raw('credit_balance - ?', [creditApplied])
         })
         .where('user_id', payerId)
     }

     // Log transaction for audit
     await db.insert('credit_transactions').values({
       user_id: payerId,
       amount: -creditApplied,
       type: 'applied_to_invoice',
       description: `Credit applied to invoice`,
       created_at: new Date()
     })
   }
   ```

6. **Store Payment Record**:
   ```typescript
   await db.insert('payments').values({
     payment_type: 'trial_lesson',
     package_id: packageId,
     payer_user_id: payerId,
     amount: finalAmount, // After credit
     payment_status: 'pending',
     xero_invoice_id: invoiceId,
     credit_applied: creditApplied,
     created_at: new Date()
   })
   ```

#### Credit Addition (Admin Action)

**UI**: Admin clicks "Add Credit" on parent/student profile

**Modal**:
```
Add Credit

Amount: [___] HKD

[Cancel]  [Add Credit]
```

**Backend**:
```typescript
async function addCredit(
  userId: string,
  amount: number,
  adminId: string
): Promise<void> {
  const user = await db.select().from('profiles').where('id', userId).first()

  if (user.role === 'parent') {
    await db
      .update('parents')
      .set({
        credit_balance: db.raw('credit_balance + ?', [amount])
      })
      .where('user_id', userId)
  } else {
    await db
      .update('students')
      .set({
        credit_balance: db.raw('credit_balance + ?', [amount])
      })
      .where('user_id', userId)
  }

  // Log transaction
  await db.insert('credit_transactions').values({
    user_id: userId,
    amount: amount,
    type: 'added_by_admin',
    description: `Credit added by admin`,
    added_by: adminId,
    created_at: new Date()
  })
}
```

### Tutor Deduction System

#### Deduction Storage

```sql
-- Tutors table
CREATE TABLE public.tutors (
  user_id UUID PRIMARY KEY REFERENCES public.profiles(id),
  bio TEXT,
  subjects TEXT[] NOT NULL,
  qualifications TEXT[],
  hourly_rate NUMERIC NOT NULL,
  deduction_balance NUMERIC DEFAULT 0 CHECK (deduction_balance >= 0),
  banking_name TEXT,
  banking_account TEXT,
  banking_swift TEXT,
  public_profile_slug TEXT UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

#### Deduction Application Logic

**Trigger**: Package is completed, Xero Bill is created

**Workflow**:

1. **Get Deduction Balance**:
   ```typescript
   async function getDeductionBalance(tutorId: string): Promise<number> {
     const tutor = await db
       .select()
       .from('tutors')
       .where('user_id', tutorId)
       .first()

     return tutor.deduction_balance || 0
   }
   ```

2. **Calculate Deduction Application**:
   ```typescript
   function calculateDeductionApplication(
     payoutAmount: number,
     deductionBalance: number
   ): { deductionApplied: number; netPayout: number } {
     const deductionApplied = Math.min(deductionBalance, payoutAmount)
     const netPayout = payoutAmount - deductionApplied

     return { deductionApplied, netPayout }
   }

   // Example:
   // payoutAmount = 1000, deductionBalance = 200 → deductionApplied = 200, netPayout = 800
   // payoutAmount = 1000, deductionBalance = 1500 → deductionApplied = 1000, netPayout = 0
   ```

3. **Create Xero Bill with Deduction Line Item**:
   ```typescript
   async function createBillWithDeduction(
     contactId: string,
     payoutAmount: number,
     deductionApplied: number,
     lineItems: Array<{ description: string; amount: number }>
   ): Promise<string> {
     const xeroClient = getXeroClient()

     const billLineItems = lineItems.map(item => ({
       description: item.description,
       quantity: 1,
       unitAmount: item.amount,
       accountCode: '400' // Expense account
     }))

     // Add deduction line item if deduction is applied
     if (deductionApplied > 0) {
       billLineItems.push({
         description: `Deductions Applied`,
         quantity: 1,
         unitAmount: -deductionApplied, // Negative amount
         accountCode: '400'
       })
     }

     const bill = await xeroClient.accountingApi.createBills(
       tenantId,
       {
         bills: [
           {
             type: Bill.TypeEnum.ACCPAY,
             contact: { contactID: contactId },
             lineItems: billLineItems,
             status: Bill.StatusEnum.AUTHORISED,
             dueDate: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000) // 30 days
           }
         ]
       }
     )

     return bill.body.bills[0].billID
   }
   ```

4. **Deduct from Tutor Balance**:
   ```typescript
   async function deductFromTutor(
     tutorId: string,
     deductionApplied: number
   ): Promise<void> {
     await db
       .update('tutors')
       .set({
         deduction_balance: db.raw('deduction_balance - ?', [deductionApplied])
       })
       .where('user_id', tutorId)

     // Log transaction
     await db.insert('deduction_transactions').values({
       tutor_id: tutorId,
       amount: -deductionApplied,
       type: 'applied_to_payout',
       description: `Deduction applied to payout`,
       created_at: new Date()
     })
   }
   ```

5. **Store Payout Record**:
   ```typescript
   await db.insert('tutor_payouts').values({
     tutor_user_id: tutorId,
     payout_type: 'package',
     package_id: packageId,
     amount: netPayout, // After deductions
     xero_bill_id: billId,
     payout_status: 'pending',
     deduction_applied: deductionApplied,
     created_at: new Date()
   })
   ```

#### Deduction Addition (Admin Action)

**UI**: Admin clicks "Add Deduction" on tutor profile

**Modal**:
```
Add Deduction

Amount: [___] HKD
Reason: [_______________]

[Cancel]  [Add Deduction]
```

**Backend**:
```typescript
async function addDeduction(
  tutorId: string,
  amount: number,
  reason: string,
  adminId: string
): Promise<void> {
  await db
    .update('tutors')
    .set({
      deduction_balance: db.raw('deduction_balance + ?', [amount])
    })
    .where('user_id', tutorId)

  // Log transaction
  await db.insert('deduction_transactions').values({
    tutor_id: tutorId,
    amount: amount,
    type: 'added_by_admin',
    description: reason,
    added_by: adminId,
    created_at: new Date()
  })
}
```

### Display in User Interfaces

#### Parent/Student Settings → Payment Methods
```
Account Credit Balance: $150.00 HKD

ℹ️ Credit automatically applies to your next invoice.

Recent Credit Activity:
- Nov 15, 2025: Credit applied to invoice #123 (-$50.00)
- Nov 10, 2025: Credit added by admin (+$200.00)
```

#### Tutor Earnings Page
```
Deduction Balance: $200.00 HKD

Pending Payouts:
- Package #123: $1,000.00
  - Base: $1,000.00
  - Deductions: -$200.00
  - Net: $800.00

Recent Deduction Activity:
- Nov 15, 2025: Deduction applied to payout #45 (-$200.00)
- Nov 5, 2025: Deduction added by admin (+$200.00) - Reason: Overpayment correction
```

### Testing Strategy

**Unit Tests**:
- Credit calculation: `calculateCreditApplication()`
- Deduction calculation: `calculateDeductionApplication()`
- Edge cases: creditBalance > invoiceAmount, deductionBalance > payoutAmount

**Integration Tests**:
- Create invoice → Credit auto-applied → Balance updated
- Create payout → Deduction auto-applied → Balance updated
- Admin adds credit → Balance updates → Next invoice uses credit

**E2E Tests**:
- Parent pays invoice with credit → Credit line item in Xero
- Tutor receives payout with deduction → Deduction line item in Xero

---

## 10. Testing & QA Methodology

### Testing Strategy Overview

**Approach**: Three-tier testing pyramid
1. **Unit Tests** (70% of tests): Fast, isolated function testing
2. **Integration Tests** (20% of tests): API routes, database operations, external integrations
3. **End-to-End Tests** (10% of tests): Full user journeys with Playwright

### Testing Stack

**Unit Testing**:
- **Framework**: Jest
- **Coverage**: >80% code coverage requirement
- **Focus**: Business logic, utility functions, calculations

**Integration Testing**:
- **Framework**: Jest + Supertest (API testing)
- **Database**: Supabase test project (separate from dev/staging)
- **Mocking**: MSW (Mock Service Worker) for external APIs

**End-to-End Testing**:
- **Framework**: Playwright
- **Browsers**: Chromium, Firefox, WebKit (mobile + desktop)
- **Environment**: Staging Supabase project

**Performance Testing**:
- **Tool**: Lighthouse CI (automated performance audits)
- **Targets**: LCP <2s, FID <100ms, CLS <0.1

**Security Testing**:
- **Tool**: OWASP ZAP (automated penetration testing)
- **Focus**: SQL injection, XSS, CSRF, authentication bypass

### Unit Testing

**Location**: `/tests/unit/`

**Example: Credit Calculation Tests**
```typescript
// tests/unit/credit.test.ts
import { calculateCreditApplication } from '@/lib/payments/credit'

describe('Credit Application Logic', () => {
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

  it('should handle zero credit', () => {
    const result = calculateCreditApplication(500, 0)
    expect(result.creditApplied).toBe(0)
    expect(result.finalAmount).toBe(500)
  })
})
```

**Example: Hours Tracking Tests**
```typescript
// tests/unit/hours.test.ts
import { deductHoursFromPackage } from '@/lib/packages/hours'

describe('Hours Tracking', () => {
  it('should deduct hours for completed lesson', () => {
    const result = deductHoursFromPackage(10, 2, 'completed')
    expect(result.hoursRemaining).toBe(8)
    expect(result.hoursUsed).toBe(2)
    expect(result.overtimeHours).toBe(0)
  })

  it('should NOT deduct hours for late cancelled lesson', () => {
    const result = deductHoursFromPackage(10, 2, 'late_cancelled')
    expect(result.hoursRemaining).toBe(10)
    expect(result.hoursUsed).toBe(0)
    expect(result.overtimeHours).toBe(0)
  })

  it('should detect overtime when duration > hoursRemaining', () => {
    const result = deductHoursFromPackage(2, 3, 'completed')
    expect(result.hoursRemaining).toBe(0)
    expect(result.hoursUsed).toBe(3)
    expect(result.overtimeHours).toBe(1)
  })
})
```

### Integration Testing

**Location**: `/tests/integration/`

**Example: Lead Conversion Workflow Test**
```typescript
// tests/integration/lead-conversion.test.ts
import { createTestClient } from '@/tests/utils/test-client'
import { db } from '@/lib/db'

describe('Lead Conversion Workflow', () => {
  let adminToken: string

  beforeEach(async () => {
    // Create admin user and get auth token
    adminToken = await createTestUser('admin')
  })

  afterEach(async () => {
    // Clean up test data
    await db.delete('leads').where('email', 'test@example.com')
  })

  it('should convert lead to trial with account creation', async () => {
    // 1. Create lead via Webflow webhook
    const webhookResponse = await fetch('/api/webhooks/webflow', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Webflow-Signature': generateWebflowSignature(leadData)
      },
      body: JSON.stringify({
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        subjects: ['Math'],
        isParent: true
      })
    })
    expect(webhookResponse.status).toBe(200)

    // 2. Verify lead created
    const lead = await db.select().from('leads').where('email', 'john.doe@example.com').first()
    expect(lead).toBeDefined()
    expect(lead.lead_status).toBe('new')

    // 3. Convert lead (create accounts + trial)
    const conversionResponse = await fetch(`/api/leads/${lead.id}/convert`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${adminToken}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        tutorId: 'test-tutor-id',
        subjects: ['Math']
      })
    })
    expect(conversionResponse.status).toBe(200)

    // 4. Verify accounts created
    const parent = await db.select().from('parents').where('email', 'john.doe@example.com').first()
    expect(parent).toBeDefined()
    expect(parent.status).toBe('onboarding')

    // 5. Verify trial created
    const trial = await db.select().from('lessons').where('is_trial', true).where('student_id', parent.id).first()
    expect(trial).toBeDefined()
    expect(trial.hourly_rate_tutor).toBe(0)

    // 6. Verify Xero invoice created
    const payment = await db.select().from('payments').where('package_id', trial.id).first()
    expect(payment.xero_invoice_id).toBeDefined()
    expect(payment.credit_applied).toBeGreaterThanOrEqual(0)
  })
})
```

**Example: Payment Flow Test**
```typescript
// tests/integration/payment.test.ts
describe('Payment Processing', () => {
  it('should create invoice with credit applied', async () => {
    // 1. Add credit to parent
    await fetch(`/api/users/${parentId}/credit`, {
      method: 'POST',
      headers: { 'Authorization': `Bearer ${adminToken}` },
      body: JSON.stringify({ amount: 100 })
    })

    // 2. Create package (triggers invoice)
    const packageResponse = await fetch('/api/packages', {
      method: 'POST',
      headers: { 'Authorization': `Bearer ${adminToken}` },
      body: JSON.stringify({
        tutorId,
        studentIds: [studentId],
        parentIds: [parentId],
        totalHours: 10,
        clientHourlyRate: 50,
        tutorHourlyRate: 40
      })
    })
    expect(packageResponse.status).toBe(201)

    // 3. Verify credit applied
    const payment = await db.select().from('payments').where('payer_user_id', parentId).first()
    expect(payment.credit_applied).toBe(100)
    expect(payment.amount).toBe(400) // 500 - 100

    // 4. Verify credit balance deducted
    const parent = await db.select().from('parents').where('user_id', parentId).first()
    expect(parent.credit_balance).toBe(0)
  })
})
```

### End-to-End Testing

**Location**: `/tests/e2e/`

**Example: Complete Onboarding Flow**
```typescript
// tests/e2e/onboarding.spec.ts
import { test, expect } from '@playwright/test'

test.describe('Tutor Onboarding', () => {
  test('should complete full onboarding with T&C acceptance', async ({ page }) => {
    // 1. Admin creates tutor account
    await page.goto('/admin/users')
    await page.click('button:has-text("Create User")')
    await page.fill('[name="email"]', 'tutor@example.com')
    await page.selectOption('[name="role"]', 'tutor')
    await page.click('button:has-text("Send Invite")')

    // 2. Tutor receives email (simulated)
    const magicLink = await getMagicLinkFromEmail('tutor@example.com')

    // 3. Tutor clicks magic link
    await page.goto(magicLink)
    expect(await page.textContent('h1')).toBe('Welcome to Stryv Academics')

    // 4. Step 1: Profile Information
    await page.fill('[name="firstName"]', 'Jane')
    await page.fill('[name="lastName"]', 'Smith')
    await page.fill('[name="bio"]', 'Experienced math tutor with 10 years of teaching.')
    await page.click('[name="subjects"] >> text=Mathematics')
    await page.click('button:has-text("Next")')

    // 5. Step 2: Banking Details
    await page.fill('[name="bankName"]', 'HSBC')
    await page.fill('[name="accountNumber"]', '123456789')
    await page.fill('[name="swiftCode"]', 'HSBCHKHH')
    await page.click('button:has-text("Next")')

    // 6. Step 3: T&C Acceptance
    await page.waitForSelector('[data-testid="tc-modal"]')
    expect(await page.isVisible('[data-testid="tc-modal"]')).toBe(true)

    // Scroll to bottom of T&C
    await page.evaluate(() => {
      document.querySelector('[data-testid="tc-content"]').scrollTop = 10000
    })

    // Check T&C checkbox
    await page.check('[name="acceptTC"]')
    await page.click('button:has-text("Accept & Complete")')

    // 7. Verify redirect to dashboard
    await page.waitForURL('/dashboard/tutor')
    expect(await page.textContent('h1')).toBe('Dashboard')

    // 8. Verify T&C PDF received via email
    const emailReceived = await checkEmailSent('tutor@example.com', 'T&C Confirmation')
    expect(emailReceived).toBe(true)
  })
})
```

**Example: Payment Access Control**
```typescript
// tests/e2e/payment-blocking.spec.ts
test('should block access when payment is pending', async ({ page }) => {
  // 1. Login as parent with unpaid invoice
  await page.goto('/login')
  await page.fill('[name="email"]', 'parent@example.com')
  await page.click('button:has-text("Send Magic Link")')
  const magicLink = await getMagicLinkFromEmail('parent@example.com')
  await page.goto(magicLink)

  // 2. Verify banner displayed on dashboard
  await page.waitForSelector('[data-testid="payment-required-banner"]')
  expect(await page.isVisible('[data-testid="payment-required-banner"]')).toBe(true)
  expect(await page.textContent('[data-testid="payment-required-banner"]')).toContain('PAYMENT REQUIRED')

  // 3. Verify tabs are disabled
  expect(await page.isDisabled('a:has-text("Children")')).toBe(true)
  expect(await page.isDisabled('a:has-text("Tutors")')).toBe(true)
  expect(await page.isDisabled('a:has-text("Lessons")')).toBe(true)

  // 4. Verify Settings and Payments tabs are enabled
  expect(await page.isDisabled('a:has-text("Settings")')).toBe(false)
  expect(await page.isDisabled('a:has-text("Payments")')).toBe(false)

  // 5. Pay invoice (simulate)
  await page.click('a:has-text("Payments")')
  await page.click('button:has-text("Pay Now")')
  await page.fill('[name="cardNumber"]', '4242424242424242') // Test card
  await page.click('button:has-text("Submit Payment")')

  // 6. Verify access restored
  await page.waitForSelector('[data-testid="payment-required-banner"]', { state: 'hidden' })
  expect(await page.isDisabled('a:has-text("Children")')).toBe(false)
})
```

### Manual Testing

**Beta Testing Plan** (Weeks 11-12):

**Participants**:
- 2 Admins (internal Stryv staff)
- 5 Tutors (existing Stryv tutors)
- 5 Parents (existing Stryv clients)
- 3 Students (existing Stryv students)

**Test Scenarios**:
1. **Admin**:
   - Create users (tutor, parent, student)
   - Convert lead → trial → package
   - Process payments (verify receipts)
   - Process tutor payouts
   - Handle additional fees

2. **Tutor**:
   - Complete onboarding (full flow)
   - Record lessons (completed and late cancelled)
   - Upload lesson resources
   - View earnings and payouts

3. **Parent**:
   - Complete onboarding
   - Add children
   - Pay invoices (card and bank transfer)
   - View lessons and resources
   - Request tutor

4. **Student**:
   - Complete onboarding (independent)
   - View lessons and resources
   - Request tutor

**Feedback Collection**:
- Daily Slack channel for bug reports
- Weekly feedback survey (usability, bugs, feature requests)
- Screen recording of critical flows (Loom)

### Automated Testing in CI/CD

**GitHub Actions Workflow**:
```yaml
name: Test Suite

on: [push, pull_request]

jobs:
  unit-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: 18
      - run: npm ci
      - run: npm run test:unit
      - run: npm run test:coverage
      - uses: codecov/codecov-action@v3 # Upload coverage

  integration-tests:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: postgres
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - run: npm ci
      - run: npm run db:migrate:test
      - run: npm run test:integration

  e2e-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - run: npm ci
      - run: npx playwright install --with-deps
      - run: npm run build
      - run: npm run test:e2e
      - uses: actions/upload-artifact@v3
        if: failure()
        with:
          name: playwright-screenshots
          path: tests/e2e/screenshots/
```

### Performance Testing

**Lighthouse CI** (automated on every PR):
- **Targets**: LCP <2s, FID <100ms, CLS <0.1
- **Pages tested**:
  - `/dashboard/admin`
  - `/dashboard/tutor`
  - `/dashboard/parent`
  - `/tutors/[slug]` (public profile)

**Load Testing** (manual, pre-launch):
- **Tool**: Artillery or k6
- **Scenarios**:
  - 100 concurrent users creating lessons
  - 50 concurrent payment submissions
  - Spike test: 500 users login simultaneously

---

## 11. Post-Launch Support Plans

### Support Structure

#### Week 1: Launch Week (Intensive Support)
**Team Availability**: Full team on-call

**Schedule**:
- **Days 1-3**: 24/7 on-call rotation (2-hour shifts)
- **Days 4-7**: Business hours coverage (9 AM - 6 PM HKT)

**Daily Activities**:
- **Morning standup** (9 AM HKT): Review overnight issues, plan day
- **Lunch sync** (1 PM HKT): Check in on progress, triage new issues
- **Evening standup** (6 PM HKT): Review day, prioritize critical bugs

**Monitoring**:
- **Sentry**: Real-time error alerts to Slack
- **Vercel Analytics**: Page load times, Web Vitals
- **Supabase Dashboard**: Database performance, connection pool
- **LogTail**: Application logs, API errors

**Support Channels**:
- **Admin Slack channel**: Direct line to Stryv team
- **User support email**: support@stryvacademics.com (monitored 24/7)
- **In-app chat**: Intercom or similar (optional)

#### Weeks 2-4: Stabilization Phase
**Team Availability**: Core team (Tech Lead, 2 Developers, QA)

**Schedule**:
- **Business hours coverage** (9 AM - 6 PM HKT)
- **On-call rotation**: 1 developer per evening/weekend

**Daily Activities**:
- **Daily standup** (9 AM HKT)
- **Bug triage** (10 AM HKT): Prioritize by severity
- **Weekly retrospective** (Friday 3 PM HKT): Lessons learned, improvements

**Support Channels**:
- **Admin Slack channel**: Business hours
- **User support email**: 12-hour SLA

#### Months 2-3: Maintenance Phase
**Team Availability**: Part-time support (Tech Lead 0.25 FT, 1 Developer 0.5 FT)

**Schedule**:
- **Weekly check-ins** (Monday 9 AM HKT)
- **Monthly release cycle**: Bug fixes, minor enhancements

**Support Channels**:
- **User support email**: 24-hour SLA
- **Quarterly reviews**: Product roadmap, feature prioritization

### Support SLAs

| Issue Severity | Response Time | Resolution Target | Example |
|----------------|---------------|-------------------|---------|
| **P0 - Critical** | 1 hour | 4 hours | Platform down, payment processing broken, data loss |
| **P1 - High** | 4 hours | 24 hours | Feature broken (e.g., lesson recording fails), Xero sync error |
| **P2 - Medium** | 24 hours | 3 days | UI bug, minor calculation error, email not sent |
| **P3 - Low** | 72 hours | 2 weeks | Cosmetic issue, feature request, performance optimization |

### Issue Tracking

**Tool**: GitHub Issues or Jira

**Workflow**:
1. **User reports issue** → Support email or Slack
2. **PM triages** → Assigns severity, creates ticket
3. **Dev assigned** → Investigates, provides ETA
4. **Fix deployed** → Hot-fix (P0/P1) or scheduled release (P2/P3)
5. **User notified** → Confirmation email with fix details

### Hot-Fix Deployment Process

**P0/P1 Issues**:
1. **Developer creates fix** → Branch from main
2. **PR review** → Tech Lead approves (fast-track)
3. **Deploy to staging** → QA verifies fix
4. **Deploy to production** → Vercel deployment
5. **Monitor** → 1-hour monitoring period

**Deployment Windows**:
- **Emergency**: Anytime (P0 only)
- **High Priority**: Business hours (P1)
- **Scheduled**: Weekly release (P2/P3)

### User Communication

**Status Page**: status.stryvacademics.com (optional)
- Display: Operational, Degraded Performance, Partial Outage, Full Outage
- Updates: Real-time during incidents

**Email Notifications**:
- **Scheduled maintenance**: 48-hour advance notice
- **Unplanned downtime**: Immediate notification, updates every 30 minutes
- **Post-incident report**: Sent within 24 hours of resolution

### Knowledge Base

**Location**: docs.stryvacademics.com or Help Center

**Content**:
- **User guides**: How to complete onboarding, record lessons, pay invoices
- **FAQs**: Common questions (payment methods, T&C, trial refunds)
- **Video tutorials**: Onboarding walkthrough, dashboard overview
- **Troubleshooting**: Common error messages, solutions

**Maintenance**: Updated monthly based on support ticket trends

### Handover Plan

**End of Month 3**:
1. **Documentation handover**:
   - Technical architecture document
   - API documentation (Swagger/OpenAPI)
   - Database schema diagram
   - Deployment runbook
   - Incident response playbook

2. **Knowledge transfer sessions** (4 sessions, 2 hours each):
   - Session 1: Architecture overview, codebase tour
   - Session 2: Xero/Airwallex integration deep-dive
   - Session 3: Common issues and fixes
   - Session 4: Deployment and monitoring

3. **Transition to internal team**:
   - Stryv hires in-house developer (if applicable)
   - Gradual handover over 2 weeks
   - Developer team available for consultation (ad-hoc, billable)

### Retainer Options (Post-3 Months)

**Option 1: Maintenance Retainer**
- **Hours**: 10 hours/month
- **Cost**: $700 USD/month (at $70/hour)
- **Includes**: Bug fixes, minor enhancements, support tickets
- **Excludes**: New feature development

**Option 2: Development Retainer**
- **Hours**: 40 hours/month
- **Cost**: $2,800 USD/month (at $70/hour)
- **Includes**: New features, integrations, performance optimization
- **Excludes**: 24/7 support (business hours only)

**Option 3: Ad-Hoc Support**
- **Billing**: Hourly ($70-100/hour depending on developer seniority)
- **No commitment**: Pay-as-you-go
- **Response time**: Best effort (no SLA)

---

## 12. T&C Implementation Approach (Modal UI, Audit Trail, PDF Generation, Email)

### Overview
The T&C (Terms and Conditions) acceptance system ensures **legally binding agreements** are captured for all user roles (tutor, parent, student) with a complete **audit trail** for compliance.

### T&C Modal UI

#### Design Specifications

**Desktop Layout**:
```
┌─────────────────────────────────────────────────────┐
│  Terms and Conditions - Tutor Agreement       [X]   │
├─────────────────────────────────────────────────────┤
│  ┌────────────────────────────────────────────┐ ↑  │
│  │ Scrollable Content Area (max 60vh)         │ │  │
│  │                                             │ │  │
│  │ 1. Introduction                             │ │  │
│  │    Welcome to Stryv Academics...            │ │  │
│  │                                             │ │  │
│  │ 2. Tutor Responsibilities                   │ │  │
│  │    - Deliver high-quality lessons...        │ │  │
│  │    - Maintain professionalism...            │ │  │
│  │                                             │ │  │
│  │ 3. Payment Terms                            │ │  │
│  │    - Payouts processed monthly...           │ │  │
│  │    - Deductions may apply...                │ │  │
│  │                                             │ ↓  │
│  └────────────────────────────────────────────┘    │
│                                                      │
│  [✓] I have read and agree to the terms above       │
│                                                      │
│  [Cancel]                     [Accept & Continue]   │
└─────────────────────────────────────────────────────┘
```

**Mobile Layout** (≤768px):
- Modal takes up full screen (100vh)
- Scrollable content area adapts to screen height (60vh max)
- Buttons stack vertically
- Touch targets 48x48px minimum

**Accessibility**:
- **Keyboard navigation**: Tab through checkbox, buttons
- **Screen reader**: ARIA labels for modal, content, checkbox
- **Focus trap**: Can't tab outside modal when open
- **Escape key**: Closes modal (returns to onboarding step)

#### Implementation

```typescript
// components/TCModal.tsx
import { useState } from 'react'
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog'
import { Checkbox } from '@/components/ui/checkbox'
import { Button } from '@/components/ui/button'

interface TCModalProps {
  isOpen: boolean
  onClose: () => void
  onAccept: () => void
  documentType: 'tutor_agreement' | 'parent_agreement' | 'student_agreement'
  content: string // HTML content of T&C
}

export function TCModal({ isOpen, onClose, onAccept, documentType, content }: TCModalProps) {
  const [hasScrolledToBottom, setHasScrolledToBottom] = useState(false)
  const [isChecked, setIsChecked] = useState(false)

  const handleScroll = (e: React.UIEvent<HTMLDivElement>) => {
    const element = e.currentTarget
    const isAtBottom = element.scrollHeight - element.scrollTop <= element.clientHeight + 50
    if (isAtBottom) {
      setHasScrolledToBottom(true)
    }
  }

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-3xl max-h-[80vh]">
        <DialogHeader>
          <DialogTitle>
            Terms and Conditions - {formatDocumentType(documentType)}
          </DialogTitle>
        </DialogHeader>

        <div
          className="overflow-y-auto max-h-[60vh] prose prose-sm"
          onScroll={handleScroll}
          data-testid="tc-content"
        >
          <div dangerouslySetInnerHTML={{ __html: content }} />
        </div>

        <div className="flex items-center space-x-2 mt-4">
          <Checkbox
            id="accept-tc"
            checked={isChecked}
            onCheckedChange={setIsChecked}
            disabled={!hasScrolledToBottom}
          />
          <label
            htmlFor="accept-tc"
            className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
          >
            I have read and agree to the terms above
          </label>
        </div>

        <div className="flex justify-end space-x-2 mt-4">
          <Button variant="outline" onClick={onClose}>
            Cancel
          </Button>
          <Button
            onClick={onAccept}
            disabled={!isChecked}
          >
            Accept & Continue
          </Button>
        </div>
      </DialogContent>
    </Dialog>
  )
}

function formatDocumentType(type: string): string {
  const types = {
    'tutor_agreement': 'Tutor Agreement',
    'parent_agreement': 'Parent Agreement',
    'student_agreement': 'Student Agreement'
  }
  return types[type] || 'Agreement'
}
```

### Audit Trail Capture

#### Data Captured

When user clicks "Accept & Continue", the system captures:

1. **User ID**: UUID of the user accepting
2. **Document Type**: 'tutor_agreement', 'parent_agreement', or 'student_agreement'
3. **Document Version**: Semantic version (e.g., '1.0.0')
4. **IP Address**: User's IP address at time of acceptance
5. **User Agent**: Browser and device information
6. **Timestamp**: Exact date/time of acceptance (UTC)

#### Implementation

```typescript
// lib/tc/capture-acceptance.ts
import { createClient } from '@/lib/supabase/server'

interface TCAcceptanceData {
  userId: string
  documentType: 'tutor_agreement' | 'parent_agreement' | 'student_agreement'
  documentVersion: string
  ipAddress: string
  userAgent: string
}

export async function captureTC Acceptance(data: TCAcceptanceData): Promise<void> {
  const supabase = createClient()

  // Store acceptance record
  const { error } = await supabase
    .from('terms_acceptances')
    .insert({
      user_id: data.userId,
      document_type: data.documentType,
      document_version: data.documentVersion,
      ip_address: data.ipAddress,
      user_agent: data.userAgent,
      accepted_at: new Date().toISOString()
    })

  if (error) throw error
}

// API route: /api/onboarding/terms
export async function POST(request: Request) {
  const { userId, documentType } = await request.json()

  // Get IP address from request headers
  const ipAddress = request.headers.get('x-forwarded-for') ||
                    request.headers.get('x-real-ip') ||
                    'unknown'

  // Get user agent
  const userAgent = request.headers.get('user-agent') || 'unknown'

  // Get current T&C version from config
  const documentVersion = getTCVersion(documentType) // e.g., '1.0.0'

  // Capture acceptance
  await captureTCAcceptance({
    userId,
    documentType,
    documentVersion,
    ipAddress,
    userAgent
  })

  // Generate and upload PDF
  const pdfUrl = await generateTCPDF(userId, documentType, documentVersion)

  // Send confirmation email with PDF attachment
  await sendTCConfirmationEmail(userId, pdfUrl)

  // Update user status: onboarding → active
  await updateUserStatus(userId, 'active')

  return Response.json({ success: true })
}
```

#### Database Schema

```sql
CREATE TABLE public.terms_acceptances (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.profiles(id),
  document_type TEXT NOT NULL CHECK (document_type IN ('tutor_agreement', 'parent_agreement', 'student_agreement')),
  document_version TEXT NOT NULL, -- e.g., '1.0.0'
  ip_address TEXT NOT NULL,
  user_agent TEXT,
  accepted_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  -- Ensure one acceptance per user per document type
  CONSTRAINT terms_acceptances_user_document_unique UNIQUE (user_id, document_type)
);

CREATE INDEX idx_terms_acceptances_user_id ON terms_acceptances(user_id);
CREATE INDEX idx_terms_acceptances_type ON terms_acceptances(document_type);
CREATE INDEX idx_terms_acceptances_date ON terms_acceptances(accepted_at);
```

### PDF Generation

#### Approach: HTML to PDF

**Library**: `puppeteer` (headless Chrome) or `@react-pdf/renderer`

**Recommendation**: Use **Puppeteer** for MVP (easier to style, matches web UI exactly)

#### Implementation

```typescript
// lib/tc/generate-pdf.ts
import puppeteer from 'puppeteer'
import { createClient } from '@/lib/supabase/server'

export async function generateTCPDF(
  userId: string,
  documentType: string,
  documentVersion: string
): Promise<string> {
  const supabase = createClient()

  // Get user details
  const { data: user } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', userId)
    .single()

  // Get acceptance record
  const { data: acceptance } = await supabase
    .from('terms_acceptances')
    .select('*')
    .eq('user_id', userId)
    .eq('document_type', documentType)
    .single()

  // Load T&C HTML template
  const tcContent = await getTCContent(documentType, documentVersion)

  // Generate HTML with user details and acceptance info
  const html = `
    <!DOCTYPE html>
    <html>
      <head>
        <meta charset="UTF-8">
        <style>
          body { font-family: Arial, sans-serif; margin: 40px; }
          h1 { color: #333; }
          .signature-block {
            margin-top: 40px;
            padding: 20px;
            border: 1px solid #ccc;
            background: #f9f9f9;
          }
        </style>
      </head>
      <body>
        <h1>Terms and Conditions - ${formatDocumentType(documentType)}</h1>
        <p><strong>Version:</strong> ${documentVersion}</p>

        ${tcContent}

        <div class="signature-block">
          <h3>Acceptance Details</h3>
          <p><strong>Name:</strong> ${user.first_name} ${user.last_name}</p>
          <p><strong>Email:</strong> ${user.email}</p>
          <p><strong>Accepted on:</strong> ${new Date(acceptance.accepted_at).toLocaleString()}</p>
          <p><strong>IP Address:</strong> ${acceptance.ip_address}</p>
          <p><strong>User Agent:</strong> ${acceptance.user_agent}</p>

          <p style="margin-top: 20px;">
            By checking the acceptance box on ${new Date(acceptance.accepted_at).toDateString()},
            you electronically agreed to the terms and conditions above. This document serves as
            proof of your acceptance.
          </p>
        </div>
      </body>
    </html>
  `

  // Generate PDF using Puppeteer
  const browser = await puppeteer.launch({
    headless: true,
    args: ['--no-sandbox', '--disable-setuid-sandbox'] // For serverless
  })
  const page = await browser.newPage()
  await page.setContent(html)
  const pdfBuffer = await page.pdf({
    format: 'A4',
    printBackground: true,
    margin: { top: '20mm', right: '20mm', bottom: '20mm', left: '20mm' }
  })
  await browser.close()

  // Upload PDF to Supabase Storage
  const timestamp = Date.now()
  const filePath = `${userId}/${documentType}_${timestamp}.pdf`

  const { error: uploadError } = await supabase.storage
    .from('tc-documents')
    .upload(filePath, pdfBuffer, {
      contentType: 'application/pdf',
      cacheControl: '3600'
    })

  if (uploadError) throw uploadError

  // Get public URL
  const { data: urlData } = supabase.storage
    .from('tc-documents')
    .getPublicUrl(filePath)

  return urlData.publicUrl
}

async function getTCContent(documentType: string, version: string): Promise<string> {
  // Load T&C content from database or file
  // Version control: Different content for different versions
  const tcTemplates = {
    'tutor_agreement': await import(`@/content/tc/tutor_agreement_v${version.replace(/\./g, '_')}.html`),
    'parent_agreement': await import(`@/content/tc/parent_agreement_v${version.replace(/\./g, '_')}.html`),
    'student_agreement': await import(`@/content/tc/student_agreement_v${version.replace(/\./g, '_')}.html`)
  }

  return tcTemplates[documentType]?.default || ''
}
```

### Email Confirmation

#### Email Template

```typescript
// emails/TCConfirmation.tsx
import {
  Body,
  Container,
  Head,
  Heading,
  Html,
  Img,
  Link,
  Preview,
  Text
} from '@react-email/components'

interface TCConfirmationEmailProps {
  userName: string
  documentType: string
  acceptedDate: string
  pdfUrl: string
}

export function TCConfirmationEmail({
  userName,
  documentType,
  acceptedDate,
  pdfUrl
}: TCConfirmationEmailProps) {
  return (
    <Html>
      <Head />
      <Preview>Terms and Conditions Confirmation - Stryv Academics</Preview>
      <Body style={main}>
        <Container style={container}>
          <Img
            src="https://stryvacademics.com/logo.png"
            width="150"
            height="50"
            alt="Stryv Academics"
            style={logo}
          />
          <Heading style={h1}>Terms and Conditions Confirmed</Heading>

          <Text style={text}>
            Dear {userName},
          </Text>

          <Text style={text}>
            Thank you for accepting the {formatDocumentType(documentType)} on {acceptedDate}.
          </Text>

          <Text style={text}>
            Your acceptance has been recorded, and a copy of the signed agreement is attached
            to this email for your records.
          </Text>

          <Text style={text}>
            You can also download the agreement at any time from your account settings.
          </Text>

          <Link href={pdfUrl} style={button}>
            Download Agreement (PDF)
          </Link>

          <Text style={text}>
            If you have any questions, please contact us at support@stryvacademics.com.
          </Text>

          <Text style={footer}>
            © 2025 Stryv Academics. All rights reserved.
          </Text>
        </Container>
      </Body>
    </Html>
  )
}

// Styles
const main = { backgroundColor: '#f6f9fc', fontFamily: 'Arial, sans-serif' }
const container = { margin: '0 auto', padding: '20px', maxWidth: '600px' }
const logo = { margin: '0 auto' }
const h1 = { color: '#333', fontSize: '24px', fontWeight: 'bold', margin: '20px 0' }
const text = { color: '#333', fontSize: '16px', lineHeight: '24px', margin: '10px 0' }
const button = {
  backgroundColor: '#007bff',
  color: '#fff',
  padding: '12px 24px',
  textDecoration: 'none',
  borderRadius: '4px',
  display: 'inline-block',
  margin: '20px 0'
}
const footer = { color: '#999', fontSize: '12px', margin: '20px 0' }
```

#### Email Sending

```typescript
// lib/tc/send-confirmation-email.ts
import { Resend } from 'resend'
import { TCConfirmationEmail } from '@/emails/TCConfirmation'

const resend = new Resend(process.env.RESEND_API_KEY)

export async function sendTCConfirmationEmail(
  userId: string,
  pdfUrl: string
): Promise<void> {
  // Get user details
  const user = await db.select().from('profiles').where('id', userId).first()
  const acceptance = await db
    .select()
    .from('terms_acceptances')
    .where('user_id', userId)
    .orderBy('accepted_at', 'desc')
    .first()

  // Send email
  const { error } = await resend.emails.send({
    from: 'Stryv Academics <noreply@stryvacademics.com>',
    to: user.email,
    subject: 'Terms and Conditions Confirmation',
    react: TCConfirmationEmail({
      userName: `${user.first_name} ${user.last_name}`,
      documentType: acceptance.document_type,
      acceptedDate: new Date(acceptance.accepted_at).toLocaleDateString(),
      pdfUrl
    }),
    attachments: [
      {
        filename: `${acceptance.document_type}_${user.first_name}_${user.last_name}.pdf`,
        path: pdfUrl // Resend will download from URL and attach
      }
    ]
  })

  if (error) throw error

  // Log email sent
  await db.insert('email_log').values({
    user_id: userId,
    notification_type: 'tc_confirmation',
    to_email: user.email,
    subject: 'Terms and Conditions Confirmation',
    sent_at: new Date(),
    status: 'sent'
  })
}
```

### T&C Version Control

#### Versioning Strategy

**Semantic Versioning**: `MAJOR.MINOR.PATCH`
- **MAJOR**: Breaking changes (require re-acceptance by all users)
- **MINOR**: New clauses or sections (require re-acceptance)
- **PATCH**: Typo fixes, clarifications (no re-acceptance needed)

**Example**:
- `1.0.0`: Initial version (launch)
- `1.1.0`: Added data retention clause (all users must re-accept)
- `1.1.1`: Fixed typo in clause 3 (no re-acceptance needed)

#### Storage

**File-based**:
```
/content/tc/
  tutor_agreement_v1_0_0.html
  tutor_agreement_v1_1_0.html
  parent_agreement_v1_0_0.html
  parent_agreement_v1_1_0.html
  student_agreement_v1_0_0.html
```

**Config**:
```typescript
// lib/tc/config.ts
export const TC_VERSIONS = {
  tutor_agreement: '1.0.0',
  parent_agreement: '1.0.0',
  student_agreement: '1.0.0'
}

export function getTCVersion(documentType: string): string {
  return TC_VERSIONS[documentType] || '1.0.0'
}
```

#### Re-acceptance Workflow

**Trigger**: When `MAJOR` or `MINOR` version is updated

**Workflow**:
1. Admin updates T&C version in config
2. System detects version mismatch for existing users:
   ```typescript
   const userAcceptance = await db
     .select()
     .from('terms_acceptances')
     .where('user_id', userId)
     .where('document_type', documentType)
     .first()

   const currentVersion = getTCVersion(documentType)

   if (userAcceptance.document_version !== currentVersion) {
     // User needs to re-accept
     return { requiresReAcceptance: true }
   }
   ```
3. On next login, user sees T&C modal again
4. User re-accepts, new `terms_acceptances` record created (old record retained for audit)

### Legal Compliance

#### Audit Trail Requirements

**Retention**: 7 years minimum (compliance requirement)

**Contents**:
- Who accepted (user ID, name, email)
- What they accepted (document type, version)
- When they accepted (timestamp)
- Where they accepted (IP address)
- How they accepted (user agent, device)

**Access**: Admin-only access to audit trail (GDPR compliance)

#### GDPR Considerations

**Data Processing Consent**: T&C includes data processing consent clause

**Right to Access**: Users can download their T&C PDF anytime from Settings → Legal Documents

**Right to Erasure**: T&C acceptance records are **exempt** from deletion (legal obligation to retain)

---

## Summary

This document provides comprehensive answers to all 12 development partner questions based on the Stryv Academics MVP specifications and estimation document. The platform will be delivered in **13 weeks** (Oct 27, 2025 - Jan 25, 2026) for **$41,100 USD** by a team of **8 FTE** with extensive experience in Supabase, Next.js, EdTech, and API integrations.

Key highlights:
- **Aggressive timeline** with built-in buffer and risk mitigation
- **Transparent cost breakdown** by milestone and team role
- **Experienced team** with specific expertise requirements
- **Comprehensive integration strategy** for Xero PO+Bill workflow and Airwallex
- **Warning-based trial validation** with admin override
- **Secure file storage** with Supabase Storage and RLS policies
- **Automated credit/deduction system** with Xero line items
- **Rigorous testing methodology** with 80%+ code coverage
- **Post-launch support** with clear SLAs and handover plan
- **Legally binding T&C** with complete audit trail

**Contact**: For questions or clarifications, please reach out to the development team lead.

**Next Steps**: Review this document, provide feedback, and proceed with contract signing to begin Week 1 kickoff on October 27, 2025.
