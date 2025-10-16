# Implementation Plan

This implementation plan outlines the development tasks for the Stryv Academics MVP platform. The plan is organized into sequential milestones that build upon each other, ensuring incremental progress with early testing and validation.

## Milestones

1. **Milestone 1 - Foundation & Infrastructure (October 2025)**
   - Tasks: 1-8
   - Focus: Database schema, authentication, core infrastructure

2. **Milestone 2 - User Management & Onboarding (November 2025)**
   - Tasks: 9-16
   - Focus: User CRUD, onboarding workflows, T&C acceptance, profile management

3. **Milestone 3 - Lead & Trial Management (November 2025)**
   - Tasks: 17-24
   - Focus: Lead capture, trial lessons, conversion workflows

4. **Milestone 4 - Package & Lesson Management (November-December 2025)**
   - Tasks: 25-32
   - Focus: Package creation, lesson recording, hours tracking, resources

5. **Milestone 5 - Payment Processing (December 2025)**
   - Tasks: 33-40
   - Focus: Invoice generation, payment methods, credit system, access control

6. **Milestone 6 - Tutor Payout System (December 2025)**
   - Tasks: 41-48
   - Focus: Payout tracking, deduction management, Xero Bill integration

7. **Milestone 7 - Additional Features (December 2025)**
   - Tasks: 49-56
   - Focus: Applications, public profiles, request forms, additional fees

8. **Milestone 8 - Integration & Polish (January 2026)**
   - Tasks: 57-64
   - Focus: Email notifications, data migration, testing, deployment

## Task List

### Milestone 1: Foundation & Infrastructure

- [ ] 1. Initialize Next.js project with TypeScript and core dependencies
  - Create Next.js 15 project with App Router
  - Configure TypeScript with strict mode
  - Install and configure Tailwind CSS 4
  - Set up shadcn/ui component library
  - Configure ESLint and Prettier
  - Set up Git repository with .gitignore
  - Create basic project structure (`/app`, `/lib`, `/components`)
  - Note: See `docs/specs/stryv-mvp/design.md` for techstack details

- [ ] 2. Set up Supabase project and configure environment
  - Create Supabase project (production + staging)
  - Configure environment variables in Vercel
  - Install `@supabase/supabase-js` and `@supabase/ssr` packages
  - Create Supabase client utilities for server and client
  - Configure connection pooling for serverless (transaction mode, port 6543)
  - Set up Supabase Storage buckets for profile photos, lesson resources, receipts
  - Test database connectivity
  - _Requirements: NFR1.1_

- [ ] 3. Design and implement database schema
  - Create core tables: `profiles`, `tutors`, `parents`, `students`
  - Create relationship tables: `student_tutor_relationships`
  - Create operational tables: `packages`, `lessons`, `lesson_resources`
  - Create financial tables: `payments`, `tutor_payouts`
  - Create auxiliary tables: `leads`, `tutor_applications`, `terms_acceptances`
  - Create integration tables: `xero_tokens`, `airwallex_customers`, `webhook_events`
  - Add all necessary indexes (composite, partial, GIN)
  - Apply foreign key constraints and check constraints
  - Note: See `docs/specs/stryv-mvp/design.md` for complete schema definitions
  - _Requirements: FR1, FR2, FR3_

  - [ ] 3.1. Enable Row Level Security on all tables
    - Enable RLS on all user-data tables
    - Create helper functions: `auth.user_role()`, `auth.user_status()`
    - Create RLS policies for `profiles` table (basic user isolation)
    - Create RLS policies for `tutors`, `parents`, `students` tables
    - Create RLS policies for `packages`, `lessons` tables (multi-entity access)
    - Create RLS policies for `payments`, `tutor_payouts` tables
    - Create RLS policies for `leads`, `tutor_applications` tables (admin-only)
    - Create RLS policies for integration tables (`xero_tokens`, `airwallex_customers`)
    - Test policies with different user roles using JWT claim mocking
    - Note: See `docs/specs/stryv-mvp/design.md` section "Row Level Security Implementation"
    - _Requirements: NFR3.1, NFR3.2_

- [ ] 4. Implement authentication system with Supabase Auth
  - Configure Supabase Auth settings (magic link enabled)
  - Create authentication utilities (`lib/auth`)
  - Implement magic link email flow
  - Create session management utilities
  - Set up JWT handling with role claims in `app_metadata`
  - Create middleware for route protection
  - Implement automatic token refresh logic
  - Test authentication flow end-to-end
  - _Requirements: FR1.1-FR1.9_

  - [ ] 4.1. Implement role-based middleware
    - Create `middleware.ts` with session verification
    - Implement role checking against route configuration
    - Create route configuration map (path → allowed roles)
    - Add redirect logic for unauthorized access (401 → login, 403 → dashboard)
    - Test middleware with different user roles
    - Note: See `docs/specs/stryv-mvp/design.md` section "Authentication & Authorization Module"
    - _Requirements: FR1.1, FR1.6_

- [ ] 5. Create base UI components and layout system
  - Implement responsive navigation components (sidebar for admin, top tabs for others)
  - Create hamburger menu for mobile (≤768px)
  - Build dashboard layout components
  - Create form components with validation (shadcn/ui)
  - Implement table components with filtering and pagination
  - Create modal/dialog components
  - Build button, input, select, and other form elements
  - Ensure all touch targets are 48x48px minimum
  - Test responsive behavior across viewports
  - _Requirements: NFR1.1-NFR1.6_

- [ ] 6. Set up Xero API integration infrastructure
  - Install `xero-node` SDK
  - Create Xero client initialization utility (`lib/integrations/xero`)
  - Implement OAuth 2.0 with PKCE flow
  - Create API routes for OAuth: `/api/xero/connect`, `/api/xero/callback`
  - Implement token storage with encryption (AES-256) in `xero_tokens` table
  - Create token refresh mechanism with retry logic
  - Implement rate limiter with exponential backoff
  - Create wrapper functions for common Xero API calls
  - Test OAuth flow and token refresh in sandbox
  - Note: See `docs/specs/stryv-mvp/design.md` section "Xero API Integration"
  - _Requirements: FR19.1-FR19.9_

- [ ] 7. Set up Airwallex API integration infrastructure
  - Install Airwallex SDK (if available) or create REST client
  - Create Airwallex client initialization utility (`lib/integrations/airwallex`)
  - Create API routes for payment intent creation: `/api/payments/create-intent`
  - Implement webhook endpoint: `/api/webhooks/airwallex`
  - Create webhook signature verification with HMAC-SHA256
  - Implement idempotency checking for webhook events
  - Create wrapper functions for payment link generation
  - Store webhook events in `webhook_events` table for audit
  - Test payment flow in Airwallex sandbox
  - Note: See `docs/specs/stryv-mvp/design.md` section "Airwallex API Integration"
  - _Requirements: FR11.5_

- [ ] 8. Configure Resend email integration with React Email
  - Install `resend` and `@react-email/components` packages
  - Create Resend client utility (`lib/integrations/resend`)
  - Set up email template directory structure (`emails/`)
  - Create base email layout component with branding
  - Implement email sending utility with retry logic
  - Create email logging in `email_log` table
  - Set up email preview server for development (`npm run email:dev`)
  - Test email sending in Resend sandbox
  - _Requirements: FR20.1-FR20.17_

### Milestone 2: User Management & Onboarding

- [ ] 9. Implement user CRUD operations (Admin)
  - Create API routes: `GET/POST /api/users`, `GET/PATCH/DELETE /api/users/:id`
  - Implement user creation with Xero contact sync
  - Add user approval workflow (pending → onboarding)
  - Create user detail page with full profile view
  - Implement soft delete with `deleted_at` field
  - Add error handling for Xero contact creation failures
  - Create admin panel for manual Xero sync retry
  - Test user creation, update, and deletion flows
  - _Dependencies: 1, 2, 3, 4, 6_
  - _Requirements: FR2.1-FR2.9_

  - [ ] 9.1. Implement credit management (Parents/Students)
    - Create API routes: `POST /api/users/:id/credit`
    - Add credit/deduct credit modal in admin UI
    - Implement credit balance updates in database
    - Create transaction history logging
    - Display credit balance in user profile
    - Test credit addition and deduction flows
    - _Requirements: FR13.1-FR13.10_

  - [ ] 9.2. Implement deduction management (Tutors)
    - Create API routes: `POST /api/users/:id/deduction`
    - Add deduction modal in admin UI
    - Implement deduction balance updates in database
    - Create transaction history logging
    - Display deduction balance in tutor profile
    - Test deduction addition flows
    - _Requirements: FR14.1-FR14.8_

- [ ] 10. Build tutor onboarding flow
  - Create onboarding route: `/onboarding/tutor`
  - Implement Step 1: Profile information form (bio, subjects, qualifications, rates, photo upload)
  - Implement Step 2: Banking details form
  - Implement Step 3: T&C acceptance modal (scrollable, 60vh max, checkbox, PDF download)
  - Add form validation with Zod schemas
  - Implement progress tracking across steps
  - Create API routes: `POST /api/onboarding/profile`, `POST /api/onboarding/details`, `POST /api/onboarding/terms`
  - Test complete onboarding flow
  - _Dependencies: 4, 5_
  - _Requirements: FR2.2-FR2.10_

  - [ ] 10.1. Implement T&C acceptance audit trail
    - Capture IP address, user agent, timestamp on T&C acceptance
    - Store acceptance in `terms_acceptances` table
    - Generate PDF of signed agreement
    - Send T&C confirmation email with PDF attachment
    - Update user status from 'onboarding' to 'active'
    - Test T&C acceptance and PDF generation
    - _Requirements: FR2.6-FR2.9_

- [ ] 11. Build parent onboarding flow
  - Create onboarding route: `/onboarding/parent`
  - Implement Step 1: Profile information form
  - Implement Step 2: Children setup form (optional, can add later)
  - Implement Step 3: T&C acceptance modal (same as tutor)
  - Add "Add Child" functionality with name and email fields
  - Create child accounts during onboarding submission
  - Test parent onboarding with and without children
  - _Dependencies: 4, 5, 10_
  - _Requirements: FR2.2-FR2.10_

- [ ] 12. Build student onboarding flow
  - Create onboarding route: `/onboarding/student`
  - Implement Step 1: Profile information form
  - Implement Step 2: Parent-link setup (if applicable)
  - Implement Step 3: T&C acceptance modal (role-specific for independent vs parent-linked)
  - Add logic to determine access level (full vs limited)
  - Test independent student and parent-linked student flows
  - _Dependencies: 4, 5, 10_
  - _Requirements: FR2.2-FR2.10, FR6.1-FR6.8_

- [ ] 13. Implement admin dashboard
  - Create dashboard route: `/dashboard/admin`
  - Build activity feed component (real-time, grouped by type)
  - Create Tutor Payout Exposure widget (Expected/Pending/Processing/Total)
  - Add quick action buttons (Create User, Create Package, etc.)
  - Implement dashboard data fetching with caching
  - Test admin dashboard with sample data
  - _Dependencies: 5_
  - _Requirements: FR3.3_

- [ ] 14. Implement tutor dashboard
  - Create dashboard route: `/dashboard/tutor`
  - Display upcoming lessons (next 7 days)
  - Show quick stats: Total Lessons, Active Packages, Pending Payouts
  - Add quick action buttons (Record Lesson, View Students)
  - Test tutor dashboard with sample data
  - _Dependencies: 5_
  - _Requirements: FR4.3_

- [ ] 15. Implement parent dashboard
  - Create dashboard route: `/dashboard/parent`
  - Display children's upcoming lessons
  - Show active packages
  - Display unpaid invoices prominently with banner
  - Implement payment blocking (disable tabs except Settings/Payments if unpaid)
  - Test parent dashboard with unpaid invoice scenario
  - _Dependencies: 5_
  - _Requirements: FR5.3-FR5.5_

- [ ] 16. Implement student dashboard
  - Create dashboard route: `/dashboard/student`
  - Display upcoming lessons
  - Show active packages
  - Conditionally display payment info (full access only)
  - Implement access level logic (full vs limited)
  - Test both full and limited access student dashboards
  - _Dependencies: 5_
  - _Requirements: FR6.1-FR6.8_

### Milestone 3: Lead & Trial Management

- [ ] 17. Set up Webflow webhook integration
  - Create webhook endpoint: `POST /api/webhooks/webflow`
  - Implement webhook signature verification
  - Create payload mapping from Webflow to `leads` table schema
  - Implement lead record creation
  - Send admin email notification on new lead
  - Add error handling and retry logic
  - Test webhook with Webflow sandbox/test events
  - _Dependencies: 3, 8_
  - _Requirements: FR7.1_

- [ ] 18. Implement lead management UI (Admin)
  - Create leads list page: `/admin/leads`
  - Implement filterable table (status, date range)
  - Create lead detail side panel with all lead information
  - Add communication notes editor
  - Implement status progression UI (dropdown with stage options)
  - Add tutor selection dropdown (offered tutors, preferred tutor)
  - Test lead list and detail views
  - _Dependencies: 5, 17_
  - _Requirements: FR7.2, FR7.3_

- [ ] 19. Implement lead conversion workflow
  - Create "Create Trial Lesson" button on lead detail
  - Implement auto-detection of existing accounts (check `converted_user_ids`)
  - Create account creation modal if accounts don't exist
  - Add account creation logic (parent/student with status='onboarding')
  - Send invite emails via Resend
  - Update lead with `converted_user_ids`
  - Test conversion with and without existing accounts
  - _Dependencies: 9, 18_
  - _Requirements: FR7.6-FR7.10, FR8.1-FR8.9_

- [ ] 20. Implement trial lesson creation
  - Create trial lesson form in lead detail panel
  - Add subject multi-select (for this trial)
  - Implement duplicate trial validation (warning only, allow override)
  - Create trial lesson with `is_trial=true`, `hourly_rate_tutor=0`, `package_id=NULL`
  - Create/update student-tutor relationship with `status='trial'`
  - Check payer's credit balance and auto-apply
  - Generate Xero invoice with credit line item
  - Create payment record
  - Update lead with `trial_lesson_id`
  - Test trial creation with credit application
  - _Dependencies: 6, 19_
  - _Requirements: FR8.1-FR8.9_

  - [ ] 20.1. Implement trial outcome handling
    - Add trial outcome selector on trial lesson detail page
    - Implement "Successful" outcome logic:
      - Update `trial_outcome='successful'`
      - Update relationship `status='active'`
      - Update lead `lead_status='trial_completed'`
      - Redirect to Create Package form with pre-populated data
    - Implement "Failed" outcome logic:
      - Display options: "Try different tutor" OR "Full refund & exit"
      - Process refund in Xero/Airwallex if selected
      - Reset lead or mark as 'lost'
    - Implement "Lost" outcome logic:
      - Update `trial_outcome='lost'`
      - Update `lesson_status='cancelled'`
      - Update lead `lead_status='lost'`
    - Test all outcome scenarios
    - _Requirements: FR8.7, FR8.8_

- [ ] 21. Create package creation UI (Admin)
  - Create package form route: `/admin/packages/new`
  - Add multi-select for students and parents
  - Add tutor selection dropdown
  - Create form fields: total hours, client hourly rate, tutor hourly rate, subjects (multi-select), start date, expiration date
  - Display credit preview (show payer's available credit)
  - Add form validation
  - Test package form with multiple students/parents
  - _Dependencies: 5, 9_
  - _Requirements: FR9.1-FR9.3_

- [ ] 22. Implement package creation logic
  - Create API route: `POST /api/packages`
  - Implement package record creation
  - Link trial lesson if applicable (`conversion_package_id`)
  - Check payer's credit balance and auto-apply
  - Generate Xero invoice with credit shown as line item
  - Create payment record
  - Update lead status to 'package_confirmed' if from trial
  - Create payout record with `status='expected'` after payment confirmed
  - Test package creation and credit application
  - _Dependencies: 6, 21_
  - _Requirements: FR9.4-FR9.7_

- [ ] 23. Implement package detail view (Admin)
  - Create package detail route: `/admin/packages/:id`
  - Display package information (students, parents, tutor, hours)
  - Show lessons table with hours tracking
  - Display hours used, hours remaining, overtime detection
  - Show payment status and payout status
  - Add "Mark Complete" button
  - Test package detail view with various states
  - _Dependencies: 5, 22_
  - _Requirements: FR9.8-FR9.11_

- [ ] 24. Implement package hours tracking logic
  - Create function to deduct hours on completed lessons
  - Implement overtime detection: `if (duration > hours_remaining)`
  - Calculate overtime charge: `overtime_hours × client_hourly_rate`
  - Ensure late cancelled lessons do NOT deduct hours
  - Update `hours_used` and `hours_remaining` fields
  - Test hours tracking with completed and late cancelled lessons
  - _Dependencies: 22_
  - _Requirements: FR9.8-FR9.10_

### Milestone 4: Package & Lesson Management

- [ ] 25. Implement lesson recording UI (Tutor)
  - Create lesson recording route: `/tutor/lessons/new`
  - Add lesson type selector: Completed or Late Cancelled
  - Create package selection dropdown (tutor's active packages only)
  - Add date and duration inputs
  - Build lesson report form (focus, covered, highlights, next steps)
  - Add transportation receipt upload (optional)
  - Test lesson recording form
  - _Dependencies: 5, 22_
  - _Requirements: FR10.1-FR10.3_

- [ ] 26. Implement lesson recording logic
  - Create API route: `POST /api/lessons`
  - Store lesson report in `lesson_report` JSONB field
  - Deduct hours from package if lesson type is 'completed'
  - Do NOT deduct hours if lesson type is 'late_cancelled'
  - Check for overtime and store overtime amount
  - Upload transportation receipt to Supabase Storage
  - Display success modal: "Upload Resources?"
  - Test lesson recording with hours deduction
  - _Dependencies: 2, 24, 25_
  - _Requirements: FR10.4-FR10.6_

- [ ] 27. Implement lesson resource upload
  - Create resource upload component (modal after lesson creation)
  - Add resource type selector: Lesson Prep, Supplementary, Homework
  - Implement file upload with validation (PDF, TXT, JPEG, PNG, GIF, max 10MB)
  - Upload to Supabase Storage at `/resources/{lesson_id}/{resource_type}/{filename}`
  - Store resource metadata in `lesson_resources` table
  - Set `is_visible_to_student=true` by default
  - Test resource upload and storage
  - _Dependencies: 2, 26_
  - _Requirements: FR10.7-FR10.11_

- [ ] 28. Implement lesson list and detail views (Tutor)
  - Create lessons list route: `/tutor/lessons`
  - Display filterable table (date range, package, student)
  - Create lesson detail view with lesson report
  - Show uploaded resources with download links
  - Allow editing lesson records anytime
  - Test lesson list and detail views
  - _Dependencies: 5, 26, 27_
  - _Requirements: FR10.6_

- [ ] 29. Implement lesson views for parents/students
  - Create lessons list route: `/parent/lessons`, `/student/lessons`
  - Display children's lessons for parents (with student filter)
  - Display own lessons for students
  - Show lesson reports and uploaded resources
  - Add resource download functionality
  - Filter resources by `is_visible_to_student=true`
  - Test lesson views for both parent and student roles
  - _Dependencies: 5, 26, 27_
  - _Requirements: FR5.8, FR6.7_

- [ ] 30. Implement students list and detail views (Tutor)
  - Create students list route: `/tutor/students`
  - Display assigned students (from active packages or lessons)
  - Create student detail view with academic information
  - Show lesson history for each student
  - Test student list and detail views
  - _Dependencies: 5, 22_
  - _Requirements: FR4.5_

- [ ] 31. Implement children management (Parent)
  - Create children list route: `/parent/children`
  - Display children with access level indicators (Full/Limited)
  - Add "Add Child" button with form
  - Implement access level selection (Full/Limited)
  - Create child account creation logic
  - Test adding children with different access levels
  - _Dependencies: 9, 16_
  - _Requirements: FR5.6_

- [ ] 32. Implement profile editing
  - Create profile edit routes: `/profile/edit`, `/tutor/profile/edit`, `/parent/profile/edit`
  - Add profile photo upload to Supabase Storage
  - Implement role-specific field editing
  - Create API route: `PATCH /api/profile`
  - Add validation for required fields
  - Test profile editing for all roles
  - _Dependencies: 2, 9_
  - _Requirements: FR4.4, FR5.6_

### Milestone 5: Payment Processing

- [ ] 33. Implement invoice generation (Xero)
  - Create utility function for invoice creation (`lib/integrations/xero/invoices.ts`)
  - Implement credit auto-apply logic: `credit_applied = MIN(credit_balance, invoice_amount)`
  - Generate line items: base amount + credit applied (negative line item)
  - Call Xero API: `POST /Invoices`
  - Store `xero_invoice_id` in payment record
  - Deduct credit from payer's `credit_balance`
  - Test invoice generation with credit application
  - _Dependencies: 6, 22_
  - _Requirements: FR11.1-FR11.3, FR13.4-FR13.8_

- [ ] 34. Implement Airwallex payment link generation
  - Create API route: `POST /api/payments/:id/airwallex-link`
  - Call Airwallex API to create payment link
  - Store payment link in payment record
  - Return link to frontend for display
  - Test payment link generation
  - _Dependencies: 7, 33_
  - _Requirements: FR11.5_

- [ ] 35. Implement bank transfer/FPS payment flow
  - Create payment detail component with bank details display
  - Show: Bank name, account number, SWIFT/FPS ID, invoice reference
  - Add receipt upload area
  - Create API route: `POST /api/payments/:id/upload-receipt`
  - Upload receipt to Supabase Storage
  - Set `receipt_verification_status='pending'`
  - Send admin email notification
  - Test receipt upload flow
  - _Dependencies: 2, 8, 33_
  - _Requirements: FR11.6-FR11.8_

- [ ] 36. Implement receipt verification (Admin)
  - Create payments list route: `/admin/payments`
  - Add filter for "Pending Verification"
  - Display receipt in modal/side panel
  - Add "Approve" and "Reject" buttons
  - Create API route: `POST /api/payments/:id/verify-receipt`
  - Update `payment_status='paid'` on approval
  - Send confirmation email to payer
  - Test receipt verification flow
  - _Dependencies: 5, 8, 35_
  - _Requirements: FR11.9_

- [ ] 37. Implement payment status sync (Xero)
  - Create "Sync Payment Status" button in admin payments list
  - Create API route: `POST /api/payments/sync`
  - Call Xero API: `GET /Invoices/{InvoiceID}` for each pending payment
  - Update `payment_status` in database based on Xero status
  - Honor `if-modified-since` header for efficiency
  - Test manual sync and status updates
  - _Dependencies: 6, 33_
  - _Requirements: FR11.12_

- [ ] 38. Implement access control based on payment status
  - Create utility function to check for pending payments
  - Integrate check into middleware for parent/student routes
  - Disable all tabs except Settings and Payments if unpaid
  - Display "PAYMENT REQUIRED" banner on dashboard
  - Test access control with pending payment
  - _Dependencies: 4, 15, 16_
  - _Requirements: FR11.10, FR11.11_

- [ ] 39. Implement payments list for parents/students
  - Create payments route: `/parent/payments`, `/student/payments`
  - Display invoice list with status, amount, due date
  - Show payment method options for each invoice
  - Add Airwallex payment link button
  - Add bank transfer details and receipt upload
  - Display payment history
  - Test payment list for both parent and student roles
  - _Dependencies: 5, 33, 34, 35_
  - _Requirements: FR5.9, FR6.7_

- [ ] 40. Implement credit display in settings
  - Add credit balance display in Settings → Payment Methods
  - Show note: "Credit automatically applies to your next invoice"
  - Display credit transaction history
  - Test credit display for parents and independent students
  - _Dependencies: 5, 9.1_
  - _Requirements: FR13.9, FR13.10_

### Milestone 6: Tutor Payout System

- [ ] 41. Implement payout record creation
  - Create utility function for payout creation
  - Generate payout on package payment confirmation
  - Set `payout_type='package'`, `status='expected'`
  - Calculate amount: `total_hours × tutor_hourly_rate`
  - Store payout record in `tutor_payouts` table
  - Test payout creation after payment
  - _Dependencies: 3, 22, 33_
  - _Requirements: FR15.1_

- [ ] 42. Implement Xero Bill creation for package completion
  - Create utility function for Bill creation (`lib/integrations/xero/bills.ts`)
  - Detect package completion (hours_remaining=0 OR admin marks complete)
  - Check tutor's `deduction_balance`
  - Create Xero Purchase Order and Bill together
  - Generate line items: base hours + deductions (negative line item)
  - Update payout record: `xero_bill_id`, `status='pending'`, `deduction_applied`
  - Deduct from tutor's `deduction_balance`
  - Test Bill creation with deductions
  - _Dependencies: 6, 24, 41_
  - _Requirements: FR15.2-FR15.4, FR14.5-FR14.6_

- [ ] 43. Implement manual payout creation (Admin)
  - Create manual payout form route: `/admin/payouts/new`
  - Add tutor selection dropdown
  - Create line items input (description, amount, type)
  - Create API route: `POST /api/payouts`
  - Generate Xero Bill directly (no PO)
  - Set `payout_type='manual'`, `status='pending'`
  - Test manual payout creation
  - _Dependencies: 5, 6, 42_
  - _Requirements: FR15.5_

- [ ] 44. Implement payout processing (Admin)
  - Create payouts list route: `/admin/payouts`
  - Add filters: status (expected, pending, processing, completed), tutor
  - Display payout breakdown: base, fees, deductions, net
  - Add "Mark as Sent" button for pending payouts
  - Create modal for payment sent date and Airwallex ID input
  - Update `payout_status='processing'` on submission
  - Test payout marking flow
  - _Dependencies: 5, 42_
  - _Requirements: FR15.6_

- [ ] 45. Implement payout reconciliation
  - Create scheduled job (Supabase Edge Function + cron) to check Bill status
  - Call Xero API: `GET /Bills/{BillID}` for each processing payout
  - Update `payout_status='completed'` when Bill.Status=PAID
  - Add manual "Mark as Reconciled" button in admin UI
  - Test automatic and manual reconciliation
  - _Dependencies: 6, 44_
  - _Requirements: FR15.7_

- [ ] 46. Implement tutor earnings view
  - Create earnings route: `/tutor/earnings`
  - Display expected payouts (active packages) with hours progress
  - Show pending payouts (completed packages) with breakdown
  - Display deduction balance if applicable
  - Show payout history with status
  - Add note: "All payouts covered by Tutor Agreement signed [date]"
  - Test earnings view with various payout states
  - _Dependencies: 5, 41, 42_
  - _Requirements: FR15.8, FR15.9, FR14.7, FR14.8_

- [ ] 47. Implement deduction display in tutor earnings
  - Show "Deduction Balance: $X" prominently
  - Display payout breakdown: Base: $Y, Deductions: -$X, Net: $Z
  - Test deduction display with various amounts
  - _Dependencies: 46_
  - _Requirements: FR14.7, FR14.8_

- [ ] 48. Implement additional fees workflow
  - Detect package completion trigger
  - Auto-compute overtime fees: `SUM(overtime_hours) × client_hourly_rate`
  - Auto-compute late cancellation fees: `COUNT(late_cancelled_lessons) × (0.5 × tutor_hourly_rate)`
  - Auto-compute transportation fees: `SUM(receipt_amounts)`
  - Display "Additional Fees Review" panel in admin UI
  - Allow editing/removing fee line items
  - Add "Approve & Generate Invoices" button
  - Create tutor Bill (base + fees + deductions)
  - Create client Invoice (overtime + late cancel only, NOT transport)
  - Auto-apply credit/deduction
  - Test additional fees computation and invoice generation
  - _Dependencies: 24, 26, 33, 42_
  - _Requirements: FR12.1-FR12.12_

### Milestone 7: Additional Features

- [ ] 49. Implement tutor application management
  - Create applications list route: `/admin/applications`
  - Add filters: stage, status
  - Display application cards with current stage indicator
  - Create detail side panel with all application data
  - Add stage-specific action buttons: "Advance", "Reject", "Schedule"
  - Create API routes: `POST /api/applications/:id/advance`, `POST /api/applications/:id/reject`, `POST /api/applications/:id/schedule`
  - Update stage and status on actions
  - Store stage transition history in `stage_transition_history` JSONB
  - Send automated emails on stage transitions
  - Test full application workflow (5 stages)
  - _Dependencies: 5, 8_
  - _Requirements: FR16.1-FR16.10_

- [ ] 50. Implement tutor account creation from application
  - Add logic to create tutor account when onboarding stage completes
  - Set `status='onboarding'`
  - Update application `converted_tutor_id`
  - Send invite email with magic link
  - Test account creation from application
  - _Dependencies: 9, 49_
  - _Requirements: FR16.9_

- [ ] 51. Implement public tutor profile system
  - Create public profile route: `/tutors/[slug]`
  - Generate short hash slugs for each tutor (`public_profile_slug`)
  - Display: profile photo, name, tagline, subjects taught (PRIMARY)
  - Show: about me, education, certifications (SECONDARY)
  - Display: awards, qualifications (TERTIARY)
  - Add "Request This Tutor" button
  - Implement Preply-style layout
  - Test public profile access without authentication
  - _Dependencies: 5_
  - _Requirements: FR17.1-FR17.5_

- [ ] 52. Implement tutor profile preview for tutors
  - Add "Preview Public Profile" button in tutor settings
  - Create preview modal using same layout as public profile
  - Test preview functionality
  - _Dependencies: 51_
  - _Requirements: FR17.6_

- [ ] 53. Implement "Request Tutor" form
  - Create request form route: `/request-tutor`
  - Pre-populate fields for authenticated users (contact details, school)
  - Add "For Which Student?" dropdown for parents (existing children + "Add new child")
  - Auto-assign student ID for authenticated students
  - Show all fields for non-authenticated users
  - Add "I am a" selector (Parent/Student) for non-authenticated
  - Create preferred format checkboxes (Online, In-person → hybrid if both)
  - Create API route: `POST /api/request-tutor`
  - Create lead record on submission
  - Create child account if "Add new child" selected
  - Redirect non-authenticated users to Webflow form
  - Test all three user scenarios (parent, student, non-authenticated)
  - _Dependencies: 5, 9, 17_
  - _Requirements: FR18.1-FR18.9_

- [ ] 54. Implement "Request This Tutor" button logic
  - Add preferred_tutor_id to request form when coming from public profile
  - Pre-populate tutor selection in lead record
  - Test request from public profile
  - _Dependencies: 51, 53_
  - _Requirements: FR17.4_

- [ ] 55. Implement tutors list for parents
  - Create tutors route: `/parent/tutors`
  - Display assigned tutors (from active packages)
  - Show authenticated tutor profile view (not public profile)
  - Test tutors list
  - _Dependencies: 5, 22_
  - _Requirements: FR5.7_

- [ ] 56. Implement settings pages for all roles
  - Create settings routes: `/settings`, `/tutor/settings`, `/parent/settings`, `/student/settings`
  - Add tabs: Account, Password, Email, Notifications
  - Add role-specific tabs:
    - Tutors: Legal Documents (view/download T&C)
    - Parents: Payment Methods (credit balance), Legal Documents
    - Students: Payment Methods (if full access), Legal Documents
  - Create email preferences UI (checkboxes for optional notifications)
  - Create API routes: `PATCH /api/notifications/preferences`
  - Test settings for all roles
  - _Dependencies: 5, 10, 11, 12_
  - _Requirements: FR4.8, FR5.10, FR6.8, FR20.16, FR20.17_

### Milestone 8: Integration & Polish

- [ ] 57. Implement all email templates with React Email
  - Create template for Account Invite (magic link + trial/package details)
  - Create template for T&C Confirmation (PDF attachment)
  - Create template for Trial Payment Reminder (24h after creation)
  - Create template for Trial Payment Confirmed
  - Create template for Package Payment Request
  - Create template for Package Payment Confirmed
  - Create template for Additional Fees Invoice
  - Create template for Stage Advancement (tutor applications)
  - Create template for Application Rejected
  - Create template for Onboarding Scheduled
  - Create template for Onboarding Complete
  - Create template for New Lead Submitted (admin)
  - Create template for Trial Completed (admin, 24h after)
  - Create template for Payment Receipt Uploaded (admin)
  - Create template for Tutor Payout Reminder (weekly, admin)
  - Test all email templates in preview server
  - _Dependencies: 8_
  - _Requirements: FR20.1-FR20.15_

- [ ] 58. Implement scheduled email triggers
  - Create Supabase Edge Function for scheduled emails
  - Set up cron jobs for:
    - Trial Payment Reminder (24h after trial creation if unpaid)
    - Trial Completed Follow-up (24h after trial completion)
    - Weekly Tutor Payout Reminder (if pending payouts exist)
  - Test scheduled email triggers
  - _Dependencies: 8, 57_
  - _Requirements: FR20.3, FR20.13, FR20.15_

- [ ] 59. Implement data migration from Airtable
  - Create migration script for users (tutors, parents, students)
  - Migrate packages with relationships preserved
  - Migrate subjects and educational institutions
  - Migrate leads and applications (if tracked)
  - Initialize all credit_balance and deduction_balance to 0
  - Preserve timestamps and audit trails
  - Run post-migration validation
  - Test migration script in staging environment
  - _Requirements: NFR5.1-NFR5.7_

- [ ] 60. Implement comprehensive testing suite
  - _Dependencies: All implementation tasks_

  - [ ] 60.1. Create unit tests for utility functions
    - Test credit/deduction calculation logic
    - Test hours tracking and overtime detection
    - Test session validation and role checking
    - Test JWT encoding/decoding
    - Test email template rendering
    - Achieve >80% code coverage
    - _Requirements: NFR1.1_

  - [ ] 60.2. Create integration tests for workflows
    - Test lead conversion: Webflow → accounts → trial → package
    - Test payment flow: invoice → payment → access control
    - Test payout flow: package complete → Bill → payout
    - Test onboarding flow: all 3 steps → active status
    - Test user creation + Xero contact sync
    - Test credit application to invoice
    - _Requirements: NFR1.1_

  - [ ] 60.3. Create end-to-end tests with Playwright
    - Test user login via magic link
    - Test admin creates user → user receives invite → completes onboarding
    - Test complete lead lifecycle: new → contacted → trial → package
    - Test client pays invoice → access granted
    - Test tutor records lesson → resources uploaded → student views resources
    - Test unpaid invoice → tabs disabled → payment banner displayed
    - _Requirements: NFR1.1_

- [ ] 61. Set up monitoring and error tracking
  - Configure Sentry for error tracking
  - Set up LogTail for structured logging
  - Configure Vercel Analytics
  - Monitor Supabase database performance
  - Set up alerts for critical errors (Xero/Airwallex failures, payment receipt uploads)
  - Create admin dashboard for monitoring
  - Test error reporting and alerting
  - _Requirements: NFR4.1-NFR4.5_

- [ ] 62. Implement security hardening
  - Enable HTTPS enforcement (Vercel automatic)
  - Configure security headers (CSP, X-Frame-Options, etc.)
  - Implement rate limiting on auth endpoints (5 req/min per IP)
  - Add rate limiting on API routes (100 req/min per IP)
  - Configure CORS policies
  - Enable audit logging for admin actions
  - Test security measures
  - _Requirements: NFR3.1-NFR3.5_

- [ ] 63. Conduct beta testing with 10-20 users
  - Recruit beta testers (2 admins, 5 tutors, 5 parents, 3 students)
  - Provide test accounts and scenarios
  - Monitor user feedback and bug reports
  - Fix critical bugs identified during beta
  - Collect performance metrics
  - Validate all workflows work as expected
  - _Requirements: All functional requirements_

- [ ] 64. Deploy to production
  - Set up production Supabase project
  - Configure production environment variables in Vercel
  - Set up production Xero, Airwallex, Resend credentials
  - Configure DNS to point to Vercel
  - Run data migration in production
  - Enable monitoring and alerting
  - Conduct smoke tests
  - Go live!
  - _Requirements: All requirements_
