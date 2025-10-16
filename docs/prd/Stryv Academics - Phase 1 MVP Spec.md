## Page 1

# Stryv Academics - Phase 1 MVP Spec

Phase 1 MVP | Target Launch: January 2026

---

## Executive Summary

Stryv Academics is Hong Kong's largest peer-to-peer tutoring platform (400+ tutors, 500+ families). We're building a unified web application to replace our fragmented tool stack (6+ platforms) and centralize operations for admins, tutors, parents, and students.

**Current Challenge:** Users navigate WhatsApp, Airtable, Google Calendar, Airwallex, Xero, and Zoom separately.

**MVP Goal:** Launch a unified platform by January 2026 with comprehensive admin tools, public tutor profiles for lead conversion, and full-featured dashboards for tutors, parents, and students.

---

## Technical Stack

*   **Frontend:** Next.js, TypeScript, React
*   **Backend:** Supabase (PostgreSQL database + authentication)
*   **Platform:** Web application (desktop-optimized, mobile-responsive)
*   **Integrations:**
    *   Xero API (invoicing + Purchase Orders + Bills)
    *   Airwallex API (payments)
    *   Webflow (form submissions)
    *   Resend (email notifications)

---

## User Roles & Navigation Architecture

### Mobile & Responsive Design

**Pattern:** Hamburger menu navigation on mobile (≤768px)

*   Hamburger icon (top-left) opens slide-out side panel
*   Applies to all roles (admin sidebar + non-admin top tabs)

---


## Page 2

* Touch-optimized tap targets (48x48px minimum)
* Panel closes on navigation or backdrop tap

## Desktop Navigation by Role

* **Admin:** Fixed left sidebar
* **Tutor/Parent/Student:** Horizontal top tabs

---

## Admin Navigation (Sidebar)

### Home - Dashboard landing page

* Recent activity feed (real-time, grouped by type)
* Tutor Payout Exposure widget (Expected/Pending/Processing/Total)

### Users - Sub-tabs: Tutors | Parents | Students

* List view: Filterable table
* Detail pages: Full CRUD operations
* Credit management (Parents, Independent Students)
* Deduction management (Tutors)
* UX: Click from list → dedicated detail page

### Packages - Sub-tabs: Active | Completed

* List view: Filterable table
* Create button (top-right)
* Detail page: Package info, lessons, hours tracking, payment/payout status
* Auto-triggers: Additional fees review on completion
* Edit controls: Adjust hours, mark complete

### Lessons

* List view: All lessons, filterable
* Create button: Toggle standard/trial (trials hide tutor rate field)
* Detail view: Lesson info, uploaded resources
* Trial lessons: "Create Package" button available

### Payments

* List view: All payments, filterable (type, status, date)
* Manual "Sync Payment Status" button (polls Xero API)
* Receipt verification workflow (view, approve/reject)

---


## Page 3

# Leads

*   List view: All leads from Webflow, filterable
*   Detail panel (side panel pattern)
*   Lead progression: Status updates, tutor matching, trial creation
*   Auto-detects: Existing accounts before trial creation
*   Converts to: Parent/student accounts

# Applications

*   List view: All tutor applications, filterable (stage, status)
*   Detail panel (side panel pattern)
*   5 stages: Written Response → Video & Resource → Interview → Rejected/Onboarding
*   Stage actions: Move forward, reject, add notes
*   Email automation: Triggers on stage changes

Settings - Standard account settings

---

## Tutor Navigation (Top Tabs)

### Onboarding Flow:

1.  Profile Information (bio, subjects, qualifications, rates, photo)
2.  Banking & Payment Details
3.  T&C Acceptance (scrollable modal, checkbox, auto-email PDF)

### Navigation Tabs:

*   **Home**: Dashboard with upcoming lessons, quick stats
*   **My Profile**: Edit profile, preview public profile (Preply-style)
*   **Students**: List view, detail pages (academic info)
*   **Lessons**: Create lesson records (completed/late cancelled), upload resources, edit anytime
*   **Earnings**: Expected payouts (active packages), pending payouts (completed), deduction balance, history
*   **Settings**: Account, Password, Email, **Legal Documents** (view/download T&C), Notifications

No "Request Tutor" button (tutors don't need this)

---

## Parent Navigation (Top Tabs)

---


## Page 4

## Onboarding Flow:

1.  Profile Information
2.  Children Setup (if applicable)
3.  **T&C Acceptance** (scrollable modal, checkbox, auto-email PDF)

### Above Navigation: "Request Tutor" button → In-platform form (pre-populated if authenticated)

## Navigation Tabs:

*   **Home:** Dashboard with children's upcoming lessons, active packages, **UNPAID invoices prominently displayed**
*   **Children:** List view, add child, detail pages (manage access levels: Full/Limited)
*   **Tutors:** Assigned tutors list, authenticated profile view
*   **Lessons:** All children's lesson records (filterable), package details, uploaded resources
*   **Payments:** Overview, invoice details, Airwallex links, bank transfer/FPS upload, payment history
*   **Settings:** Account, Password, Email, **Payment Methods** (credit balance display), **Legal Documents**, Notifications

## UX: Payment Blocking

*   If unpaid items exist → All tabs except Settings/Payments disabled
*   Home shows prominent banner

---

## Student Navigation (Top Tabs)

### Two Account Types:

#### Full-Access Student (independent OR parent-granted access):

*   Same navigation as Parent
*   Can view/manage payments
*   Has credit balance (if independent)

#### Limited-Access Student (parent-linked, restricted):

*   Same navigation EXCEPT Payments tab hidden
*   Settings → Payment Methods hidden
*   Parent manages all payments

### Onboarding Flow: Same as Parent (T&C varies: independent vs parent-linked)

### Above Navigation: "Request Tutor" button

---


## Page 5

# User Status System

## Status Definitions

```sql
status USER_STATUS NOT NULL DEFAULT 'pending'
WHERE USER_STATUS enum = ('pending', 'onboarding', 'active', 'inactive')
```

## Status Progression:

### Self-Initiated Accounts:
*   None
    *   pending -> (Admin approves) -> onboarding -> (Complete profile + T&C) -> active

### Admin-Created Accounts:
*   None
    *   onboarding -> (Complete profile + T&C) -> active

## Status Meanings:

*   **pending**: Awaiting admin approval, no platform access
*   **onboarding**: Approved, must complete profile + T&C acceptance, redirected to onboarding on every login
*   **active**: Onboarding complete, full platform access
*   **inactive**: Temporary suspension, access blocked

## Soft Delete: `deleted_at` field (separate from status)

*   When set: Hidden from UI, access blocked, scheduled for hard-delete (30-90 days)

---


## Page 6

# Database Architecture

## Existing Infrastructure

Core tables for users, tutors, students, parents, lessons, packages, and relationships already exist in Supabase. **Developers must review existing schema before proposing modifications.**

---

## Required Database Modifications

### 1. Lessons Table - Add Trial Fields

```sql
-- Add these fields:
is_trial BOOLEAN NOT NULL DEFAULT false
trial_outcome TEXT CHECK (trial_outcome IN ('pending', 'successful', 'failed', 'lost'))
trial_feedback TEXT
conversion_package_id UUID REFERENCES packages(id)
lesson_report JSONB -- Ensure exists: {focus, covered, highlights, next_steps}

-- Update enum:
lesson_status -- Add 'late_cancelled' to existing enum
```

**Business Rules:**

*   Trial lessons: `is_trial=true, hourly_rate_tutor=0, amount_tutor=0, package_id=NULL`
*   Trial outcomes: pending (scheduled), successful (→package), failed (refund), lost (never happened)
*   Trial validation: Application warning only (no DB constraint), admin can override
*   Late cancelled lessons: Do NOT deduct from package hours
*   Completed lessons: Auto-deduct from package hours

### 2. Student-Tutor Relationships Table - Add Status

---


## Page 7

SQL
```sql
-- Update enum to include:
relationship_status -- Add 'trial' to existing enum
```

**Business Rules:**

*   Trial created → status = 'trial'
*   Trial successful → status = 'active'
*   Trial failed/lost → relationship deleted or 'inactive'

3. **Users Table - Add Credit Balance**

SQL
```sql
credit_balance NUMERIC DEFAULT 0 CHECK (credit_balance >= 0)
```

**Applies to:** Parents, Independent Students (NOT parent-linked students)

4. **Tutors Table - Add Deduction Balance**

SQL
```sql
deduction_balance NUMERIC DEFAULT 0 CHECK (deduction_balance >= 0)
```

**Applies to:** Tutors only

---

## New Tables Required

1. **Leads Table**

SQL
```sql
CREATE TABLE leads (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    -- Contact
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL,

---


## Page 8

sql
phone TEXT,
school TEXT,
is_parent_inquiry BOOLEAN NOT NULL,

-- Subjects & preferences
subjects_requested TEXT[] NOT NULL,
learning_goals TEXT,
current_challenges TEXT,
preferred_schedule TEXT,
preferred_format TEXT CHECK (preferred_format IN ('online', 'in-person', 'hybrid')),

-- Progression
lead_status TEXT NOT NULL DEFAULT 'new' CHECK (lead_status IN (
    'new', 'contacted', 'tutor_options_provided',
    'tutor_selected',
    'trial_scheduled', 'trial_completed', 'package_confirmed',
    'lost'
)),
lost_reason TEXT,

-- Relationships
preferred_tutor_id UUID REFERENCES users(id),
trial_lesson_id UUID REFERENCES lessons(id),
converted_user_ids UUID[],  -- [parent_id] and/or [student_id]
offered_tutor_ids UUID[],

-- Tracking
communication_notes TEXT,
stage_history JSONB,

created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);
```

No unique constraints - admin needs flexibility for multiple leads per student

---


## Page 9

## 2. Payments Table

```sql
CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    payment_type TEXT NOT NULL CHECK (payment_type IN ('trial_lesson', 'package', 'additional_fees')),
    package_id UUID NOT NULL REFERENCES packages(id),
    payer_user_id UUID NOT NULL REFERENCES users(id),
    amount NUMERIC NOT NULL, -- Final amount after credit
    payment_method TEXT CHECK (payment_method IN ('card', 'bank_transfer', 'fps')),
    payment_status TEXT NOT NULL DEFAULT 'pending' CHECK (payment_status IN ('pending', 'paid', 'refunded', 'cancelled')),
    -- External integrations
    xero_invoice_id TEXT,
    airwallex_payment_link TEXT,
    -- Bank transfer handling
    receipt_url TEXT,
    receipt_verification_status TEXT CHECK (receipt_verification_status IN ('pending', 'approved', 'rejected')),
    -- Refund & credit tracking
    refund_amount NUMERIC,
    refund_reason TEXT,
    refund_date TIMESTAMP WITH TIME ZONE,
    ...
);

---


## Page 10

sql
credit_applied NUMERIC DEFAULT 0,

paid_at TIMESTAMP WITH TIME ZONE,
created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);
```

3. Lesson Resources Table

```sql
CREATE TABLE lesson_resources (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    lesson_id UUID NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,

    file_name TEXT NOT NULL,
    file_url TEXT NOT NULL, -- Supabase Storage URL
    file_type TEXT NOT NULL, -- 'pdf', 'image', 'text', 'other'
    file_size_bytes INTEGER,

    resource_type TEXT NOT NULL CHECK (resource_type IN (
        'lesson_prep', 'supplementary', 'homework'
    )),

    uploaded_by UUID NOT NULL REFERENCES users(id),
    description TEXT,
    is_visible_to_student BOOLEAN NOT NULL DEFAULT true,

    uploaded_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),

    INDEX idx_lesson_resources_lesson_id (lesson_id),
    INDEX idx_lesson_resources_type (resource_type)
);

---


## Page 11

Storage: Supabase Storage /resources/{lesson_id}/{resource_type}/{filename}
Limits: 10MB per file, supported types: PDF, TXT, JPEG, PNG, GIF

---

## 4. Tutor Applications Table

```sql
CREATE TABLE tutor_applications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    applicant_email TEXT NOT NULL,
    applicant_name TEXT NOT NULL,

    -- Overall tracking
    current_stage TEXT NOT NULL CHECK (current_stage IN (
        'written_response', 'video_resource', 'interview',
        'rejected', 'onboarding'
    )),

    -- Per-stage status
    written_response_status TEXT CHECK (written_response_status IN ('to_review', 'pass', 'failed')),
    video_resource_status TEXT CHECK (video_resource_status IN ('pending', 'to_review', 'pass', 'failed')),
    interview_status TEXT CHECK (interview_status IN ('to_schedule', 'scheduled', 'pass', 'failed')),
    onboarding_status TEXT CHECK (onboarding_status IN ('to_schedule', 'scheduled', 'completed')),

    -- Stage data
    stage_1_data JSONB,
    stage_2_data JSONB,
    stage_3_data JSONB,

    evaluation_notes TEXT,
    rejection_reason TEXT,
    converted_tutor_id UUID REFERENCES users(id),

---


## Page 12

sql
stage_transition_history JSONB,
created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
activated_at TIMESTAMP WITH TIME ZONE
);
```

5 Stages: Written Response → Video & Resource → Interview → Rejected/Onboarding (terminal)

---

## 5. Tutor Payouts Table

SQL

```sql
CREATE TABLE tutor_payouts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tutor_user_id UUID NOT NULL REFERENCES users(id),
    payout_type TEXT NOT NULL CHECK (payout_type IN ('package', 'manual')),
    package_id UUID REFERENCES packages(id), -- NULL for manual
    amount NUMERIC NOT NULL, -- Final after deductions
    xero_bill_id TEXT,
    payout_status TEXT NOT NULL DEFAULT 'expected' CHECK (payout_status IN (
        'expected', -- Package paid, awaiting completion
        'pending', -- Bill created, awaiting payment
        'processing', -- Payment sent via Airwallex
        'completed', -- Reconciled in Xero
        'cancelled'
    )),
    airwallex_payout_id TEXT,
    payment_sent_date DATE,

---


## Page 13

reconciled_date DATE,
deduction_applied NUMERIC DEFAULT 0,

line_items JSONB, -- For manual payouts

created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

**Status Flow:**

*   Package payouts: **expected** → pending → processing → completed
*   Manual payouts: **pending** → processing → completed

---

6. Terms Acceptances Table

```sql
CREATE TABLE terms_acceptances (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    user_id UUID NOT NULL REFERENCES users(id),

    document_type TEXT NOT NULL CHECK (document_type IN (
        'tutor_agreement', 'parent_agreement', 'student_agreement'
    )),

    document_version TEXT NOT NULL,

    -- Audit trail
    ip_address TEXT NOT NULL,
    user_agent TEXT,
    accepted_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),

    CONSTRAINT terms_acceptances_user_document_unique UNIQUE
    (user_id, document_type)
);

---


## Page 14

sql
CREATE INDEX idx_terms_acceptances_user_id ON terms_acceptances(user_id);
CREATE INDEX idx_terms_acceptances_document_type ON terms_acceptances(document_type);
```

No admin agreement required

# Critical Business Logic Rules

## Trial Lesson System

**Rule:** One trial per tutor per subject combination (soft validation, admin override allowed)

**Validation:** Application-level warning only, no database constraint

**Examples:**

*   ☑ Trial [Math] → Can do trial [English] w/o warning
*   ☑ Trial [Math] → Can do trial [Math, English] w/o warning (different combination)
*   ⚠️ Trial [Math] → Warning if creating another [Math], admin can override
*   ☑ Trial [Math] failed → Can do replacement trial [Math] with another tutor w/o warning

**Characteristics:**

*   Platform takes 100% commission
*   Tutor receives $0
*   Tutor completes same lesson report as regular lessons
*   Client pays full rate upfront
*   If unsatisfied → full refund OR free replacement tutor

---

## Package Hours Tracking

### Completed Lessons:

*   Deduct duration from package total_hours
*   Update hours_used and hours_remaining

---


## Page 15

## Late Cancelled Lessons:

*   Do NOT deduct hours
*   Marked with `lesson_status='late_cancelled'`

## Overtime Detection:

*   If `duration > hours_remaining` → overtime detected
*   Overtime hours = `duration - hours_remaining`
*   Overtime charge = `overtime_hours * client_hourly_rate`

## Package Completion:

*   When `hours_remaining = 0` OR admin marks complete
*   Auto-triggers additional fees computation

---

## Payment & Access Control

### Unpaid Invoices Block Access:

*   If any payment with `status='pending'` exists
*   All tabs except Settings/Payments disabled
*   Home dashboard shows prominent "PAYMENT REQUIRED" banner

### UX Pattern - Payment Required State:

*   PRIMARY: Alert banner with invoice details
*   SECONDARY: Amount due (show credit applied)
*   TERTIARY: Payment method options
*   Locked: Most navigation tabs (grayed/disabled state)
*   Accessible: Settings, Payments

### Multi-Package Support:

*   Parents can have multiple active packages (different children/tutors)
*   Each tracked independently with own payment

---

## Client Credit System (Auto-Apply)

### Who Gets Credit:

*   ☑ Parents (applies to ANY child invoice)
*   ☑ Independent students

---


## Page 16

* ❌ Parent-linked students (parent manages, parent gets credit)

## How It Works:
* Stored in users.credit_balance
* **Auto-applies to EVERY invoice** (no confirmation)
* Uses all available credit (up to invoice amount)
* Transparent in Xero invoice as line item

## Application Logic:
1. Determine payer: package.parent_id OR package.student_id
2. Calculate: credit_applied = MIN(credit_balance, invoice_amount)
3. Calculate: final_amount = invoice_amount - credit_applied
4. Deduct from user's credit_balance
5. Display in Xero: "Credit Applied: -$X"

## Admin Management:
* Location: User Profile → Account Credit
* Simple modal: Amount only (no notes)
* Immediate update to credit_balance

## User View:
* Settings → Payment Methods: "Account Credit Balance: $X"
* Note: "Credit automatically applies to your next invoice"

---

## Tutor Deduction System (Auto-Apply)

### Who Gets Deductions:
* ☑ Tutors only

### How It Works:
* Stored in tutors.deduction_balance
* **Auto-applies to EVERY payout** (no confirmation)
* Uses all available deduction (up to payout amount)
* Transparent in Xero Bill as line item

### Use Cases:
* Accidental overpayments
* Late cancellation penalties

---


## Page 17

* Equipment/material fees
* Platform fees

**Application Logic:**

1. Calculate: `deduction_applied = MIN(deduction_balance, payout_amount)`
2. Calculate: `final_payout = payout_amount - deduction_applied`
3. Deduct from tutor's `deduction_balance`
4. Display in Xero Bill: "Deductions Applied: -$X"

**Admin Management:**

* Location: Tutor Profile → Deductions
* Simple modal: Amount only (no notes)
* Immediate update to `deduction_balance`

**Tutor View:**

* Earnings tab: "Deduction Balance: $X"
* Payout breakdown: "Base: $Y, Deductions: -$X, Net: $Z"

---

## Late Cancellation Fees

### Calculation:

* One fee per late cancelled lesson (regardless of duration)
* Fee = 50% × `tutor_hourly_rate`
* Example: Tutor earns $50/hr → Fee = $25 (even if 2hr lesson)

### Aggregation:

* At package completion, sum all late cancellation fees
* Number of `late_cancelled_lessons` × fee amount

---

## Additional Fees Workflow

**Trigger:** Package completion (all hours consumed OR admin marks complete)

**Auto-Computation:**

1. **Overtime:** Sum `overtime_hours` × `client_hourly_rate`
2. **Late Cancellations:** Count lessons × (50% × `tutor_hourly_rate`)
3. **Transportation:** Sum uploaded receipt amounts

---


## Page 18

## Admin Review:

*   System displays "Additional Fees Review" panel
*   Line-itemized fees (each editable/removable)
*   Admin clicks "Approve & Generate Invoices"

## System Actions:

1.  **Create Xero PO + Bill (Tutor):**
    *   Line items: Base hours + additional fees + deductions
    *   Auto-applies tutor's deduction_balance
    *   Updates payout record: xero_bill_id, status='pending', deduction_applied
2.  **Create Xero Invoice (Client):**
    *   Line items: Overtime + late cancellations (NOT transport)
    *   Auto-applies payer's credit_balance
    *   Creates payment record
3.  **Client receives email notification**
4.  **Invoice appears in Payments tab**

---

## Xero Integration (Native API)

### Purchase Order & Bill Workflow

**CRITICAL:** Xero POs and Bills track what we owe tutors (self-billed invoices for contractors)

### Package Confirmation Flow:

1.  Package payment received from client
2.  Create payout record:
    *   payout_type='package', status='expected'
    *   amount = base_hours × tutor_hourly_rate
    *   xero_bill_id = NULL (no bill yet)
3.  Tutor sees expected payout in Earnings

### Package Completion Flow:

#### Without Additional Fees:

1.  All hours consumed OR admin marks complete

---


## Page 19

2. Check tutor's deduction_balance
3. Create Xero PO + Bill together:
    * Line items: Tutoring services + deductions
    * Total: final_amount (after deductions)
4. Update payout: xero_bill_id, status='pending', deduction_applied

**With Additional Fees:**

1. Package completion detected
2. Admin reviews/approves additional fees
3. Create Xero PO + Bill together:
    * Line items: Base hours + fees (late cancel, overtime, transport) + deductions
4. Update payout record
5. Create client invoice (separate - overtime + late cancel only)

**Manual Payout Flow:**

1. Admin creates manual payout (bonuses, events)
2. Check tutor's deduction_balance
3. Create Xero Bill directly (no PO, no 'expected' stage)
4. Create payout record: payout_type='manual', status='pending'

---

## Required Xero API Endpoints

1. POST /Contacts - Create contact on account setup
2. POST /Invoices - Generate client invoices (trials, packages, fees)
3. POST /PurchaseOrders + Bill - Create PO + Bill together for package completion
4. POST /Bills - Create bill for manual payouts
5. GET /Invoices/{InvoiceID} - Sync payment status (admin manual trigger)
6. GET /Bills/{BillID} - Check reconciliation for payout completion

**Error Handling:**

* Log errors, notify admin
* Don't block account creation if contact fails
* Allow manual retry from admin panel

---

## Lead Management & Conversion

### Lead Lifecycle

---


## Page 20

# Stages:

1.  new → Webflow submission received
2.  contacted → Admin reached out
3.  tutor_options_provided → Profile links shared
4.  tutor_selected → Lead chose tutor
5.  trial_scheduled → Trial created, accounts exist
6.  trial_completed → Trial finished, awaiting feedback
7.  package_confirmed → Package created (converted!)
8.  lost → Did not convert

# Lead Structure Flexibility

## Admin decides granularity:

*   One lead with multiple subjects for one tutor, OR
*   Multiple leads (one per subject) for different tutors
*   No system constraints

# Account Creation & Trial Flow

## When admin clicks "Create Trial Lesson" from Lead:

### Step 1: Auto-detect existing accounts

*   If converted_user_ids exists → Skip to trial creation
*   If empty → Show account creation modal

### Step 2a: Account Creation (if needed)

*   Create parent/student accounts (status='onboarding')
*   Create Xero contact
*   Send invite emails (magic link, 7-day expiry)
*   Update lead: converted_user_ids, lead_status='trial_scheduled'

### Step 2b: Trial Lesson Creation

*   Select subjects (multi-select for this trial)
*   Check for existing trial (warning only, can override)
*   Create trial lesson: is_trial=true, hourly_rate_tutor=0, package_id=NULL
*   Create/update student-tutor relationship: status='trial'
*   Check payer's credit_balance
*   Auto-apply credit to trial invoice
*   Generate Xero invoice (with credit line item if applied)
*   Create payment record
*   Update lead: trial_lesson_id

---


## Page 21

# Trial Outcome Handling

## Outcome 1: Successful

*   trial_outcome='successful'
*   relationship.status='active'
*   lead_status='trial_completed'
*   Admin redirected to Create Package (pre-populated)

## Outcome 2: Failed (Refund)

*   Admin chooses: Try different tutor OR Full refund & exit
*   Process full refund in Xero/Airwallex
*   If replacement: Reset lead, present new tutors, create new trial
*   If exit: lead_status='lost'

## Outcome 3: Lost (Never Happened)

*   trial_outcome='lost'
*   lesson_status='cancelled'
*   lead_status='lost'


# Package & Lesson Management

## Create Package

**Location:** Admin → Packages → "Create Package" OR Lessons → Trial Detail → "Create Package"

**Form Fields:**

*   Students (multi-select)
*   Parents (multi-select)
*   Tutor, Total Hours, Rates (client + tutor)
*   Subjects (multi-select), Start Date, Expiration Date
*   Credit preview display

**On Submit:**

1.  Create package record
2.  Link trial (if applicable): conversion_package_id
3.  Check payer's credit_balance, auto-apply
4.  Generate Xero invoice (with credit shown)

---


## Page 22

5. Create payment record
6. Update lead (if applicable): `lead_status='package_confirmed'`
7. After payment confirmed: Create payout record (`status='expected'`)

---

## Tutor Lesson Recording

**Location:** Tutor → Lessons → "Create Lesson Record"

**Form Structure:**

*   Type: Completed OR Late Cancelled
*   Package selection, Date, Duration
*   **Lesson Report** (required for all lessons):
    *   Focus of lesson
    *   What was covered
    *   Highlights (optional)
    *   Next steps
*   Transportation receipt upload (optional)

**After Submit:**

*   Lesson record created
*   If completed: Deduct hours, check overtime
*   If late cancelled: Do NOT deduct hours
*   Store lesson report
*   Success modal: "Upload Resources?"

**Resource Upload:**

*   Type: Lesson Prep / Supplementary / Homework
*   Files: PDF, TXT, images (10MB limit)
*   Immediately visible to students
*   Storage: Supabase /resources/{lesson_id}/{resource_type}/

---

## Payments & Invoicing

### Payment Flow Overview

1.  Admin creates package/lesson → Check payer's credit
2.  Auto-apply credit → Calculate final amount
3.  Generate Xero invoice (credit shown as line item)

---


## Page 23

4. Payment record created (status='pending' or 'paid')
5. Client pays → Access enabled

## Bank Transfer / FPS Payment

### Client View (side panel):

*   Display Priority:
    *   PRIMARY: Bank details (name, number, SWIFT/FPS ID)
    *   SECONDARY: Amount due, invoice reference
    *   TERTIARY: Receipt upload area
*   Upload receipt → receipt_verification_status='pending'
*   Admin receives email notification

### Admin Verification:

*   Admin → Payments → Filter: Pending verification
*   View receipt, Approve/Reject
*   If approved: payment_status='paid'

---

## Tutor Payout Processing

### Admin Workflow:

1.  **View Pending Payouts:** Admin → Payments → Tutor Payouts
    *   Display: Tutor name, amount breakdown (base, fees, deductions, net)
2.  **Process Payment:**
    *   Admin sends via Airwallex
    *   Returns to platform, clicks "Mark as Sent"
    *   Enters payment date, optional Airwallex ID
    *   payout_status='processing'
3.  **Reconciliation:**
    *   System periodically checks Xero Bills
    *   When Bill.Status=PAID → payout_status='completed'
    *   Manual "Mark as Reconciled" option available

### Tutor View (Earnings Tab):

**Display Priority:**

*   PRIMARY: Expected Earnings (active packages)

---


## Page 24

*   Package details, tutor rate, expected amount, hours progress
*   SECONDARY: Pending Payouts (completed packages)
    *   Base amount, fees breakdown, deductions, net payout
    *   Note: "All payouts covered by Tutor Agreement signed [date]"
*   TERTIARY: Deduction balance (if applicable), payout history

---

# Tutor Applications

## 5-Stage Workflow

### Stages:

1.  Written Response (status: to_review, pass, failed)
2.  Video & Resource (status: pending, to_review, pass, failed)
3.  Interview (status: to_schedule, scheduled, pass, failed)
4.  Rejected (terminal)
5.  Onboarding (status: to_schedule, scheduled, completed) → Active tutor

### Admin Interface:

*   List view: Filterable by stage/status
*   Detail panel (side panel pattern)
*   Actions: Move forward, reject, add notes
*   Email automation: Triggers on stage transitions

---

# Email Notification System

**Implementation:** Resend API (native, no Make.com)

## Required Automated Emails

### Account & Onboarding:

1.  Account Invite - Magic link, trial/package details
2.  T&C Confirmation - PDF attachment, acceptance details

### Trial Lessons:
3.  Trial Payment Reminder - 24h after creation, pending payment
4.  Trial Payment Confirmed - Payment received

---


## Page 25

**Packages:**
5. Package Payment Request - After successful trial
6. Package Payment Confirmed - Payment received, access enabled
7. Additional Fees Invoice - Admin approved fees

**Applications:**
8. Stage Advancement - Next steps per stage
9. Application Rejected - Polite rejection
10. Onboarding Scheduled - Call details
11. Onboarding Complete - Login credentials, orientation

**Admin Notifications:**
12. New Lead Submitted - Lead summary, link
13. Trial Completed - Follow-up reminder (24h after)
14. Payment Receipt Uploaded - Verification required
15. Tutor Payout Reminder - Weekly (if pending payouts)

**Email Preferences:**

*   Users can disable: Lesson updates, payment updates, package assignments
*   Cannot disable: Payment confirmations, T&C, account invites, admin notifications

---

# Public Tutor Profile System

**URL Pattern:** stryvacademics.com/tutors/[short-hash]

**Access:** No authentication required

**UX Pattern:** Preply-style tutor profile layout

**Display Priority:**

*   PRIMARY: Profile photo, name, tagline, subjects taught
*   SECONDARY: About me, education, certifications
*   TERTIARY: Awards, additional qualifications

**CTA:** "Request This Tutor" button

*   Non-authenticated users → Redirect to Webflow form
*   Authenticated users → Open in-platform request form (creates lead)

---

# Request Tutor Form

**Form Logic:**

**Authenticated Parents:**

---


## Page 26

*   Pre-populated: Contact details, school
*   Visible: "For Which Student?" dropdown (existing + "Add new child")
*   If "Add new child": Expand fields (name, email), create account on submit

**Authenticated Students:**

*   Pre-populated: Contact details, school
*   Auto-assigned: Student ID
*   Hidden: Student selection, contact fields

**Non-Authenticated:**

*   Show all fields: Contact info, I am a (Parent/Student), school (free text)
*   Subjects, goals, schedule, preferred format

**Preferred Format:**

*   Checkboxes: Online, In-person
*   Logic: Both=hybrid, One=that option, Neither=prompt

---

# Key User Flows

## Flow 1: Lead Conversion (Webflow → Trial → Package)

1.  Lead submits form → System creates lead record
2.  Admin contacts via WhatsApp → Status: 'contacted'
3.  Admin shares tutor profiles → Status: 'tutor_options_provided'
4.  Lead selects tutor → Admin updates preferred_tutor_id
5.  **Admin creates trial:**
    *   Auto-detects existing accounts
    *   If none: Create parent/student (status='onboarding'), Xero contact, send invites
    *   Create trial lesson, check credit, auto-apply, generate invoice
6.  **Client onboarding:**
    *   Login via magic link → Onboarding flow
    *   Complete profile + T&C → Status: 'active'
7.  **Client pays for trial** → Access enabled (partial)
8.  **Tutor conducts trial** → Submits report, uploads resources
9.  **Admin gets feedback** → Marks outcome
10. **If successful:** Create package → Check credit → Auto-apply → Invoice
11. **Client pays package:**
    *   Payout created (status='expected')
    *   Access fully enabled
12. **Lead status: 'package_confirmed'** (fully converted)

---


## Page 27

## Flow 2: Package Completion → Additional Fees

1. Final lesson consumes remaining hours
2. **Auto-computation**: Overtime, late cancellations, transportation
3. **Admin reviews**: Additional Fees panel, edit amounts
4. **Admin approves**:
    * Create Xero PO + Bill (tutor): Base + fees, check deductions, auto-apply
    * Update payout: xero_bill_id, status='pending', deduction_applied
    * Create Xero Invoice (client): Overtime + late cancel, check credit, auto-apply
    * Create payment record
5. **Client receives email** (notes credit if applied)
6. **Client pays** → Package fully closed

## Flow 3: User Onboarding with T&C

1. User receives invite email → Clicks magic link
2. **Step 1**: Profile setup (role-specific fields)
3. **Step 2**: Role-specific setup (e.g., tutor banking, parent children)
4. **Step 3: T&C Acceptance**
    * Scrollable modal (max 60vh, mobile-responsive)
    * Agreement content (role-specific: tutor includes self-billing)
    * Checkbox: "I have read and agree" (48x48px touch target)
    * Optional download PDF button
5. **User accepts**:
    * System captures: IP address, user agent, timestamp
    * Creates terms_acceptances record
    * Generates PDF of signed agreement
    * Auto-emails PDF to user
    * Updates user.status: 'onboarding' → 'active'
6. **Redirect to dashboard** → Full platform access
7. **View anytime**: Settings → Legal Documents

## Development Milestones

### Milestone 1: October 2025

* Database schema (modifications + new tables including terms_acceptances)
* Authentication & role-based access

---


## Page 28

*   User management (CRUD, credit/deduction interfaces)
*   T&C onboarding step (all roles except admin)
*   T&C modal UI (mobile-responsive)
*   T&C confirmation email with PDF

## Milestone 2: November 2025

*   Lead management (full lifecycle)
*   Account creation (auto-detection)
*   Trial system (warning-based validation)
*   Package creation
*   Lesson recording (tutor interface)
*   Dashboards (all roles)
*   Public tutor profiles
*   Xero integration: Contacts, Invoices (with credit auto-apply)

## Milestone 3: December 2025

*   Payment processing (Airwallex, bank transfer/FPS)
*   Receipt verification workflow
*   Additional fees (computation, review, invoices)
*   Lesson resources (upload, storage, download)
*   Tutor applications (5-stage workflow)
*   Tutor payouts (expected → pending → processing → completed)
*   Xero PO+Bill workflow (with deduction auto-apply)
*   Manual payouts
*   Credit & deduction systems (admin interfaces, auto-apply logic)

## Milestone 4: January 2026

*   Request Tutor form (authenticated/non-authenticated, "add child" feature)
*   Data migration from Airtable
*   Integration completion (Xero native, Webflow direct, Resend)
*   End-to-end testing
*   Beta testing (10-20 users)
*   Security audit
*   Production deployment

**Target:** January 2026 Launch

---

# Success Criteria

---


## Page 29

# Authentication & Onboarding

*   All roles complete onboarding with T&C acceptance
*   Status progression works (pending → onboarding → active)
*   T&C legally binding (checkbox, audit trail, PDF)
*   Role-based access control enforces permissions

# Core Workflows

*   Lead conversion: Webflow → Trial → Package
*   Package lifecycle: Creation → Lessons → Completion → Fees
*   Payment processing: Invoice → Payment → Access control
*   Tutor payouts: Expected → Pending → Processing → Completed

# Business Logic

*   Trial validation (warning-based, override allowed)
*   Credit auto-applies to all invoices
*   Deduction auto-applies to all payouts
*   Hours tracking accurate (deduct completed, not late cancelled)
*   Overtime detection works
*   Late cancellation fees correct (one per lesson)
*   Additional fees trigger on completion

# Integrations

*   Xero: Contacts, Invoices, PO+Bills, reconciliation detection
*   Airwallex: Payment links functional
*   Resend: All automated emails send
*   Webflow: Direct webhook (no Make.com)

# UX Requirements

*   Payment blocking works (unpaid → restricted access)
*   Mobile-responsive (hamburger menu, touch targets 48x48px)
*   Page loads <2s (authenticated), <1s (public profiles)
*   Public tutor profiles accessible without login

---

# Data Migration from Airtable

**Migrate FROM Airtable:**

*   **Tutors**
    *   Name
    *   Email
    *   Phone
    *   Bio
    *   Subjects taught
    *   Availability
    *   Location
    *   Profile picture
    *   Rating (average rating, number of reviews)
    *   Pricing (hourly rate, minimum session length)
    *   Specializations
    *   Teaching style
    *   Languages spoken
    *   Availability calendar (weekly/monthly view)
    *   Reviews (with timestamps)
    *   Custom fields for additional tutor information
*   **Lessons**
    *   Tutor name
    *   Subject
    *   Lesson type
    *   Duration
    *   Date
    *   Time
    *   Location
    *   Price
    *   Notes
    *   Student feedback
    *   Custom fields for additional lesson details
*   **Students**
    *   Name
    *   Email
    *   Phone
    *   Bio
    *   Subjects learned
    *   Availability
    *   Location
    *   Profile picture
    *   Rating (average rating, number of lessons taken)
    *   Custom fields for additional student information
*   **Packages**
    *   Tutor name
    *   Subject
    *   Lesson type
    *   Duration
    *   Price
    *   Description
    *   Custom fields for additional package details
*   **Invoices**
    *   Invoice ID
    *   Tutor name
    *   Student name
    *   Subject
    *   Lesson type
    *   Duration
    *   Price
    *   Date
    *   Due date
    *   Payment status
    *   Notes
    *   Custom fields for additional invoice details
*   **Payments**
    *   Transaction ID
    *   Tutor name
    *   Student name
    *   Subject
    *   Lesson type
    *   Duration
    *   Price
    *   Date
    *   Payment method
    *   Payment status
    *   Notes
    *   Custom fields for additional payment details
*   **Recurring Packages**
    *   Tutor name
    *   Subject
    *   Lesson type
    *   Duration
    *   Price
    *   Start date
    *   End date
    *   Recurrence pattern
    *   Notes
    *   Custom fields for additional recurring package details
*   **Custom Fields**
    *   Any custom fields defined in Airtable that need to be migrated to the new system.
*   **Custom Scripts**
    *   Any custom scripts or workflows defined in Airtable that need to be migrated to the new system.
*   **Custom Apps**
    *   Any custom apps or integrations defined in Airtable that need to be migrated to the new system.

**Migrate TO Airtable:**

*   **Tutors**
    *   Name
    *   Email
    *   Phone
    *   Bio
    *   Subjects taught
    *   Availability
    *   Location
    *   Profile picture
    *   Rating (average rating, number of reviews)
    *   Custom fields for additional tutor information
*   **Lessons**
    *   Tutor name
    *   Subject
    *   Lesson type
    *   Duration
    *   Date
    *   Time
    *   Location
    *   Price
    *   Notes
    *   Student feedback
    *   Custom fields for additional lesson details
*   **Students**
    *   Name
    *   Email
    *   Phone
    *   Bio
    *   Subjects learned
    *   Availability
    *   Location
    *   Profile picture
    *   Rating (average rating, number of lessons taken)
    *   Custom fields for additional student information
*   **Packages**
    *   Tutor name
    *   Subject
    *   Lesson type
    *   Duration
    *   Price
    *   Description
    *   Custom fields for additional package details
*   **Invoices**
    *   Invoice ID
    *   Tutor name
    *   Student name
    *   Subject
    *   Lesson type
    *   Duration
    *   Price
    *   Date
    *   Due date
    *   Payment status
    *   Notes
    *   Custom fields for additional invoice details
*   **Payments**
    *   Transaction ID
    *   Tutor name
    *   Student name
    *   Subject
    *   Lesson type
    *   Duration
    *   Price
    *   Date
    *   Payment method
    *   Payment status
    *   Notes
    *   Custom fields for additional payment details
*   **Recurring Packages**
    *   Tutor name
    *   Subject
    *   Lesson type
    *   Duration
    *   Price
    *   Start date
    *   End date
    *   Recurrence pattern
    *   Notes
    *   Custom fields for additional recurring package details
*   **Custom Fields**
    *   Any custom fields defined in Airtable that need to be migrated to the new system.
*   **Custom Scripts**
    *   Any custom scripts or workflows defined in Airtable that need to be migrated to the new system.
*   **Custom Apps**
    *   Any custom apps or integrations defined in Airtable that need to be migrated to the new system.

**Data Migrations:**

*   **Tutor Data Migration**
    *   Migrate all tutors' data from Airtable to the new system.
    *   Ensure all custom fields are correctly mapped and populated.
    *   Update any custom scripts or workflows related to tutor management.
*   **Lesson Data Migration**
    *   Migrate all lesson data from Airtable to the new system.
    *   Ensure all custom fields are correctly mapped and populated.
    *   Update any custom scripts or workflows related to lesson management.
*   **Student Data Migration**
    *   Migrate all student data from Airtable to the new system.
    *   Ensure all custom fields are correctly mapped and populated.
    *   Update any custom scripts or workflows related to student management.
*   **Package Data Migration**
    *   Migrate all package data from Airtable to the new system.
    *   Ensure all custom fields are correctly mapped and populated.
    *   Update any custom scripts or workflows related to package management.
*   **Invoice Data Migration**
    *   Migrate all invoice data from Airtable to the new system.
    *   Ensure all custom fields are correctly mapped and populated.
    *   Update any custom scripts or workflows related to invoice management.
*   **Payment Data Migration**
    *   Migrate all payment data from Airtable to the new system.
    *   Ensure all custom fields are correctly mapped and populated.
    *   Update any custom scripts or workflows related to payment management.
*   **Recurring Package Data Migration**
    *   Migrate all recurring package data from Airtable to the new system.
    *   Ensure all custom fields are correctly mapped and populated.
    *   Update any custom scripts or workflows related to recurring package management.

**Note:** The above list provides a high-level overview of the data migration process. Each step may require further customization based on specific requirements and constraints.

---


## Page 30

*   ☑ Users (all roles)
*   ☑ Packages (if exist)
*   ☑ Subjects
*   ☑ Educational institutions
*   ☑ Leads (if tracked)
*   ☑ Applications (if tracked)

**Start Fresh (NOT in Airtable):**

*   ❌ Payments
*   ❌ Payouts
*   ❌ Relationships
*   ❌ Lessons
*   ❌ Terms Acceptances

**Requirements:**

*   Zero data loss
*   Preserve timestamps/audit trails
*   Maintain relationships
*   Validation post-migration
*   Credit/deduction balances start at $0

---

# Post-MVP Roadmap

**Phase 2 (Feb-Apr 2026):** Scheduling, Google Calendar sync, real-time chat, resource sharing, contract re-acceptance flow

**Phase 3 (May-Sep 2026):** Video calling, whiteboarding, lesson recording

**Phase 4 (Oct-Nov 2026):** Native iOS app

**Phase 5 (Dec 2026-Feb 2027):** AI features, marketplace enhancements

Detailed planning contingent on Phase 1 success

---

# Budget & Timeline

**Phase 1 MVP Budget:** Open to proposals

**Timeline:** October 2025 - January 2026 (4 months)

---


## Page 31

**Beta:** November-December 2025

**Launch:** January 2026

---

## Contact Information

**Project Lead:** Zach
**Email:** zach@stryvacademics.com
**Business:** Levitate Limited (trading as Stryv Academics)
**Website:** stryvacademics.com

---

## Questions for Development Partners

1. Timeline for Phase 1 delivery (within 4 months)
2. Cost breakdown by milestone
3. Team composition & experience (Supabase, Next.js, EdTech, APIs)
4. Similar platform examples
5. Airtable migration approach
6. Xero/Airwallex integration strategy (PO+Bill workflow)
7. Trial validation implementation (warning-based)
8. File storage strategy (Supabase)
9. Credit/deduction auto-apply implementation
10. Testing & QA methodology
11. Post-launch support plans
12. T&C implementation approach (modal UI, audit trail, PDF generation, email)

---

## End of Specification