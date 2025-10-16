# Requirements Document

## Introduction

Stryv Academics is Hong Kong's largest peer-to-peer tutoring platform serving 400+ tutors and 500+ families. This MVP will replace the current fragmented tool stack (WhatsApp, Airtable, Google Calendar, Airwallex, Xero, and Zoom) with a unified web application launching in January 2026.

The platform will centralize operations for four user roles: Admins, Tutors, Parents, and Students. It will streamline lead conversion, trial lesson management, package creation, lesson tracking, payment processing, tutor payouts, and application workflows. The system integrates with Xero (invoicing + Purchase Orders + Bills), Airwallex (payments), Webflow (form submissions), and Resend (email notifications).

Key business differentiators include:
- Trial lesson system with full refund or replacement tutor guarantees
- Automated credit and deduction management systems
- Comprehensive tutor application workflow (5 stages)
- Public tutor profiles for lead conversion
- Mobile-responsive design with role-based navigation

## Functional Requirements

### FR1: User Authentication and Role-Based Access Control

**User Story:** As a platform user, I want secure authentication and access control based on my role, so that I can access only the features and data relevant to my responsibilities.

#### Acceptance Criteria

1. WHEN a user registers or is created by an admin, THEN the system SHALL assign them one role from: admin, tutor, parent, or student
2. WHILE a user has status 'pending', THEN the system SHALL block all platform access and display "Awaiting admin approval"
3. WHILE a user has status 'onboarding', WHEN they attempt to access any platform page, THEN the system SHALL redirect them to the onboarding flow
4. WHILE a user has status 'active', THEN the system SHALL grant full platform access based on their role permissions
5. WHILE a user has status 'inactive', THEN the system SHALL block all platform access and display "Account suspended"
6. IF a user's deleted_at field is set, THEN the system SHALL hide them from all UI and block access
7. WHEN an admin creates a new user account, THEN the system SHALL set their status to 'onboarding' and send a magic link invite email
8. WHEN a user self-registers, THEN the system SHALL set their status to 'pending' and notify admins for approval
9. WHEN an admin approves a pending user, THEN the system SHALL update status to 'onboarding' and send a magic link invite email

### FR2: User Onboarding with Terms and Conditions Acceptance

**User Story:** As a new user (tutor, parent, or student), I want to complete my profile and accept terms and conditions, so that I can activate my account and use the platform.

#### Acceptance Criteria

1. WHEN a user with status 'onboarding' logs in, THEN the system SHALL display the onboarding flow with sequential steps
2. WHILE completing tutor onboarding, THEN the system SHALL require: profile information (bio, subjects, qualifications, rates, photo), banking details, and T&C acceptance
3. WHILE completing parent onboarding, THEN the system SHALL require: profile information, children setup (if applicable), and T&C acceptance
4. WHILE completing student onboarding, THEN the system SHALL require: profile information, parent-link setup (if applicable), and T&C acceptance
5. WHEN displaying the T&C acceptance step, THEN the system SHALL show a scrollable modal (max 60vh height, mobile-responsive) with role-specific agreement content
6. WHEN a user checks the T&C checkbox and submits, THEN the system SHALL capture IP address, user agent, and timestamp
7. WHEN T&C acceptance is submitted, THEN the system SHALL create a terms_acceptances record with document_type matching the user role
8. WHEN T&C acceptance is complete, THEN the system SHALL generate a PDF of the signed agreement and email it to the user
9. WHEN T&C acceptance is complete, THEN the system SHALL update user status from 'onboarding' to 'active'
10. WHEN onboarding is complete, THEN the system SHALL redirect the user to their role-specific dashboard

### FR3: Admin Dashboard and Navigation

**User Story:** As an admin, I want a comprehensive sidebar navigation with access to all platform management tools, so that I can efficiently manage users, packages, lessons, payments, leads, and applications.

#### Acceptance Criteria

1. WHILE a user has role 'admin', THEN the system SHALL display a fixed left sidebar on desktop
2. WHILE viewing the admin interface on mobile (≤768px), THEN the system SHALL display a hamburger menu icon that opens a slide-out sidebar
3. WHEN the admin accesses the Home page, THEN the system SHALL display a real-time activity feed grouped by type and a Tutor Payout Exposure widget
4. WHEN the admin accesses the Users section, THEN the system SHALL display sub-tabs for Tutors, Parents, and Students with filterable tables
5. WHEN the admin clicks a user from the list, THEN the system SHALL navigate to a dedicated detail page with full CRUD operations
6. WHEN the admin accesses the Packages section, THEN the system SHALL display sub-tabs for Active and Completed packages
7. WHEN the admin accesses the Lessons section, THEN the system SHALL display all lessons in a filterable table with a Create button
8. WHEN the admin accesses the Payments section, THEN the system SHALL display all payments with filters by type, status, and date
9. WHEN the admin accesses the Leads section, THEN the system SHALL display all Webflow submissions with a filterable list and side panel detail view
10. WHEN the admin accesses the Applications section, THEN the system SHALL display all tutor applications with filters by stage and status

### FR4: Tutor Dashboard and Navigation

**User Story:** As a tutor, I want a horizontal tab navigation with access to my profile, students, lessons, earnings, and settings, so that I can manage my teaching activities and track my income.

#### Acceptance Criteria

1. WHILE a user has role 'tutor', THEN the system SHALL display horizontal top tabs navigation
2. WHILE viewing the tutor interface on mobile (≤768px), THEN the system SHALL display a hamburger menu with the same navigation structure
3. WHEN the tutor accesses the Home tab, THEN the system SHALL display upcoming lessons and quick stats
4. WHEN the tutor accesses My Profile, THEN the system SHALL allow editing profile information and previewing the public profile
5. WHEN the tutor accesses Students, THEN the system SHALL display a list of assigned students with detail pages showing academic information
6. WHEN the tutor accesses Lessons, THEN the system SHALL allow creating lesson records (completed/late cancelled) and uploading resources
7. WHEN the tutor accesses Earnings, THEN the system SHALL display expected payouts, pending payouts, deduction balance, and payout history
8. WHEN the tutor accesses Settings, THEN the system SHALL provide access to account, password, email, legal documents, and notification preferences

### FR5: Parent Dashboard and Navigation

**User Story:** As a parent, I want a dashboard that prominently displays unpaid invoices and provides access to my children's lessons, tutors, and payment management, so that I can stay informed and fulfill my payment obligations.

#### Acceptance Criteria

1. WHILE a user has role 'parent', THEN the system SHALL display horizontal top tabs navigation with a "Request Tutor" button above
2. WHILE viewing the parent interface on mobile (≤768px), THEN the system SHALL display a hamburger menu with the same navigation structure
3. WHEN the parent accesses the Home tab, THEN the system SHALL display children's upcoming lessons, active packages, and unpaid invoices prominently
4. IF the parent has any payment with status 'pending', THEN the system SHALL disable all tabs except Settings and Payments
5. IF the parent has unpaid invoices, THEN the system SHALL display a prominent banner on the Home tab with payment details
6. WHEN the parent accesses Children, THEN the system SHALL display a list of children with the ability to add children and manage access levels (Full/Limited)
7. WHEN the parent accesses Tutors, THEN the system SHALL display assigned tutors with authenticated profile views
8. WHEN the parent accesses Lessons, THEN the system SHALL display all children's lesson records with filters, package details, and uploaded resources
9. WHEN the parent accesses Payments, THEN the system SHALL display payment overview, invoice details, Airwallex links, and payment history
10. WHEN the parent accesses Settings, THEN the system SHALL provide access to account, password, email, payment methods (with credit balance), legal documents, and notifications

### FR6: Student Dashboard and Navigation

**User Story:** As a student, I want access to my lessons, tutors, and (if applicable) payment information based on my access level, so that I can manage my learning activities independently or within parent-set boundaries.

#### Acceptance Criteria

1. WHILE a user has role 'student', THEN the system SHALL display horizontal top tabs navigation with a "Request Tutor" button above
2. WHILE a student has full access (independent OR parent-granted), THEN the system SHALL display the same navigation as parents including the Payments tab
3. WHILE a student has limited access (parent-linked, restricted), THEN the system SHALL hide the Payments tab and Settings → Payment Methods
4. WHILE viewing the student interface on mobile (≤768px), THEN the system SHALL display a hamburger menu with the same navigation structure
5. WHEN a full-access student accesses Home, THEN the system SHALL display upcoming lessons, active packages, and unpaid invoices (if independent)
6. IF an independent student has any payment with status 'pending', THEN the system SHALL disable all tabs except Settings and Payments
7. WHEN a limited-access student accesses Home, THEN the system SHALL display upcoming lessons and active packages without payment information
8. WHEN a student accesses their profile or settings, THEN the system SHALL display T&C documents that vary based on whether they are independent or parent-linked

### FR7: Lead Management and Conversion

**User Story:** As an admin, I want to manage leads from Webflow submissions through their entire lifecycle (contacted, tutor matching, trial creation, conversion), so that I can efficiently convert inquiries into paying clients.

#### Acceptance Criteria

1. WHEN a Webflow form is submitted, THEN the system SHALL create a lead record with status 'new' and notify admins
2. WHEN the admin views a lead, THEN the system SHALL display all contact information, subjects requested, learning goals, and preferences in a side panel
3. WHEN the admin updates a lead's status, THEN the system SHALL allow progression through: new → contacted → tutor_options_provided → tutor_selected → trial_scheduled → trial_completed → package_confirmed → lost
4. WHEN the admin selects a preferred tutor for a lead, THEN the system SHALL update the preferred_tutor_id field
5. WHEN the admin clicks "Create Trial Lesson" from a lead, IF converted_user_ids exists, THEN the system SHALL skip to trial creation
6. WHEN the admin clicks "Create Trial Lesson" from a lead, IF converted_user_ids is empty, THEN the system SHALL display an account creation modal
7. WHEN the admin creates accounts from a lead, THEN the system SHALL create parent/student records with status 'onboarding', create Xero contacts, send invite emails, and update converted_user_ids
8. WHEN the admin creates a trial lesson, THEN the system SHALL create a lesson record with is_trial=true, hourly_rate_tutor=0, package_id=NULL
9. WHEN a trial lesson is created, THEN the system SHALL check the payer's credit_balance, auto-apply credit to the invoice, and generate a Xero invoice
10. WHEN the admin marks a trial outcome as 'successful', THEN the system SHALL update relationship status to 'active' and redirect to Create Package with pre-populated data

### FR8: Trial Lesson System

**User Story:** As an admin, I want to create trial lessons with automatic validation and flexible override capabilities, so that I can manage trial lessons while maintaining business rules and handling exceptions.

#### Acceptance Criteria

1. WHEN creating a trial lesson for a student-tutor-subject combination, IF a previous trial exists for the same combination, THEN the system SHALL display a warning but allow admin override
2. WHEN creating a trial lesson for a student-tutor with different subjects, THEN the system SHALL NOT display a warning
3. WHEN creating a trial lesson, THEN the system SHALL set hourly_rate_tutor=0 and amount_tutor=0
4. WHEN creating a trial lesson, THEN the system SHALL charge the client the full tutor rate
5. WHEN a trial is created, THEN the system SHALL create or update the student-tutor relationship with status='trial'
6. WHEN generating a trial invoice, THEN the system SHALL check the payer's credit_balance and auto-apply available credit
7. WHEN a trial outcome is set to 'failed', THEN the system SHALL allow the admin to choose between "Try different tutor" or "Full refund & exit"
8. WHEN a trial outcome is set to 'lost', THEN the system SHALL mark the lesson status as 'cancelled' and lead status as 'lost'
9. WHEN a tutor completes a trial lesson, THEN the system SHALL require the same lesson report as regular lessons

### FR9: Package Creation and Management

**User Story:** As an admin, I want to create and manage tutoring packages with multi-student support, credit auto-application, and hours tracking, so that I can efficiently manage ongoing tutoring relationships.

#### Acceptance Criteria

1. WHEN creating a package, THEN the system SHALL allow selecting multiple students and multiple parents
2. WHEN creating a package, THEN the system SHALL require: tutor selection, total hours, client hourly rate, tutor hourly rate, subjects (multi-select), start date, and expiration date
3. WHEN creating a package, THEN the system SHALL display a credit preview showing available credit for the payer
4. WHEN a package is submitted, THEN the system SHALL check the payer's credit_balance and auto-apply available credit to the invoice
5. WHEN a package is created from a successful trial, THEN the system SHALL link the trial via conversion_package_id
6. WHEN a package invoice is generated, THEN the system SHALL display credit applied as a line item in the Xero invoice
7. WHEN a package payment is confirmed, THEN the system SHALL create a payout record with status='expected' and amount based on tutor hourly rate
8. WHEN a completed lesson is recorded, THEN the system SHALL deduct the lesson duration from package hours_remaining
9. WHEN a late cancelled lesson is recorded, THEN the system SHALL NOT deduct hours from the package
10. WHEN lesson duration exceeds hours_remaining, THEN the system SHALL detect overtime and calculate overtime_charge = (duration - hours_remaining) × client_hourly_rate
11. WHEN hours_remaining reaches 0 OR admin marks package complete, THEN the system SHALL trigger the additional fees review workflow

### FR10: Lesson Recording by Tutors

**User Story:** As a tutor, I want to create lesson records with detailed reports and upload resources, so that I can document my teaching and provide materials to students.

#### Acceptance Criteria

1. WHEN creating a lesson record, THEN the system SHALL allow selecting lesson type: Completed or Late Cancelled
2. WHEN creating a lesson record, THEN the system SHALL require: package selection, date, and duration
3. WHEN creating a lesson record, THEN the system SHALL require a lesson report with: focus of lesson, what was covered, highlights (optional), and next steps
4. WHEN creating a completed lesson, THEN the system SHALL deduct the duration from the package's hours_remaining
5. WHEN creating a late cancelled lesson, THEN the system SHALL NOT deduct hours from the package
6. WHEN a lesson record is submitted, THEN the system SHALL store the lesson report in JSONB format
7. WHEN a lesson record is created, THEN the system SHALL display a success modal asking "Upload Resources?"
8. WHEN uploading lesson resources, THEN the system SHALL require selecting resource type: Lesson Prep, Supplementary, or Homework
9. WHEN uploading lesson resources, THEN the system SHALL accept PDF, TXT, JPEG, PNG, GIF files up to 10MB
10. WHEN a resource is uploaded, THEN the system SHALL store it in Supabase Storage at /resources/{lesson_id}/{resource_type}/{filename}
11. WHEN a resource is uploaded, THEN the system SHALL make it immediately visible to the assigned students
12. WHEN creating a lesson, THEN the system SHALL allow uploading transportation receipts as optional attachments

### FR11: Payment Processing and Access Control

**User Story:** As a parent or independent student, I want to pay invoices through multiple payment methods and have automatic credit application, so that I can fulfill payment obligations conveniently while the system blocks access until payment is complete.

#### Acceptance Criteria

1. WHEN an invoice is generated, THEN the system SHALL check the payer's credit_balance and auto-apply credit up to the invoice amount
2. WHEN credit is applied, THEN the system SHALL display it as a line item in the Xero invoice
3. WHEN credit is applied, THEN the system SHALL deduct the applied amount from the payer's credit_balance
4. WHEN an invoice is created, THEN the system SHALL create a payment record with status='pending' or 'paid'
5. WHEN the payer selects card payment, THEN the system SHALL generate an Airwallex payment link
6. WHEN the payer selects bank transfer/FPS, THEN the system SHALL display bank details with invoice reference and a receipt upload area
7. WHEN a receipt is uploaded, THEN the system SHALL set receipt_verification_status='pending' and notify admins via email
8. WHEN an admin views a pending receipt, THEN the system SHALL allow approving or rejecting the payment
9. IF the admin approves a receipt, THEN the system SHALL update payment_status to 'paid'
10. WHILE a parent or independent student has any payment with status='pending', THEN the system SHALL disable all tabs except Settings and Payments
11. WHILE a parent or independent student has unpaid invoices, THEN the system SHALL display a prominent "PAYMENT REQUIRED" banner on their Home dashboard
12. WHEN the admin clicks "Sync Payment Status", THEN the system SHALL poll the Xero API and update payment records

### FR12: Additional Fees Workflow

**User Story:** As an admin, I want the system to automatically compute additional fees (overtime, late cancellations, transportation) at package completion and allow me to review before generating invoices, so that all charges are accurate and transparent.

#### Acceptance Criteria

1. WHEN a package is marked complete (hours_remaining=0 OR admin marks complete), THEN the system SHALL auto-compute overtime, late cancellation fees, and transportation fees
2. WHEN computing overtime fees, THEN the system SHALL calculate: SUM(overtime_hours) × client_hourly_rate
3. WHEN computing late cancellation fees, THEN the system SHALL calculate: COUNT(late_cancelled_lessons) × (0.5 × tutor_hourly_rate)
4. WHEN computing transportation fees, THEN the system SHALL sum all uploaded receipt amounts
5. WHEN additional fees are computed, THEN the system SHALL display an "Additional Fees Review" panel with line-itemized fees
6. WHEN reviewing additional fees, THEN the system SHALL allow the admin to edit or remove each fee line item
7. WHEN the admin clicks "Approve & Generate Invoices", THEN the system SHALL create a Xero Purchase Order and Bill for the tutor
8. WHEN creating the tutor PO and Bill, THEN the system SHALL include line items for base hours, additional fees, and check the tutor's deduction_balance
9. WHEN creating the tutor Bill, THEN the system SHALL auto-apply the tutor's deduction_balance up to the payout amount
10. WHEN creating the tutor Bill, THEN the system SHALL update the payout record with xero_bill_id, status='pending', and deduction_applied amount
11. WHEN creating the client invoice for additional fees, THEN the system SHALL include overtime and late cancellation fees but NOT transportation fees
12. WHEN creating the client invoice for additional fees, THEN the system SHALL check and auto-apply the payer's credit_balance

### FR13: Client Credit Management System

**User Story:** As a parent or independent student, I want my account credit to automatically apply to every invoice, so that I receive the benefit of my credit balance without manual intervention.

#### Acceptance Criteria

1. WHEN a parent or independent student account is created, THEN the system SHALL initialize credit_balance to 0
2. WHEN an admin adds credit to a parent or independent student, THEN the system SHALL display a simple modal requiring only the amount
3. WHEN credit is added, THEN the system SHALL immediately update the user's credit_balance
4. WHEN any invoice is generated for a parent, THEN the system SHALL auto-apply credit from the parent's credit_balance
5. WHEN any invoice is generated for an independent student, THEN the system SHALL auto-apply credit from the student's credit_balance
6. WHEN any invoice is generated for a parent-linked student, THEN the system SHALL auto-apply credit from the parent's credit_balance (not the student's)
7. WHEN calculating credit application, THEN the system SHALL use: credit_applied = MIN(credit_balance, invoice_amount)
8. WHEN credit is applied to an invoice, THEN the system SHALL display "Credit Applied: -$X" as a line item in the Xero invoice
9. WHEN a parent or student views Settings → Payment Methods, THEN the system SHALL display "Account Credit Balance: $X"
10. WHEN displaying credit balance, THEN the system SHALL include a note: "Credit automatically applies to your next invoice"

### FR14: Tutor Deduction Management System

**User Story:** As an admin, I want to manage tutor deductions that automatically apply to every payout, so that I can handle overpayments, penalties, and fees transparently.

#### Acceptance Criteria

1. WHEN a tutor account is created, THEN the system SHALL initialize deduction_balance to 0
2. WHEN an admin adds a deduction to a tutor, THEN the system SHALL display a simple modal requiring only the amount
3. WHEN a deduction is added, THEN the system SHALL immediately update the tutor's deduction_balance
4. WHEN any payout is processed for a tutor, THEN the system SHALL auto-apply deduction from the tutor's deduction_balance
5. WHEN calculating deduction application, THEN the system SHALL use: deduction_applied = MIN(deduction_balance, payout_amount)
6. WHEN deduction is applied to a payout, THEN the system SHALL display "Deductions Applied: -$X" as a line item in the Xero Bill
7. WHEN a tutor views the Earnings tab, THEN the system SHALL display "Deduction Balance: $X"
8. WHEN displaying payout details to a tutor, THEN the system SHALL show: Base: $Y, Deductions: -$X, Net: $Z

### FR15: Tutor Payout Processing

**User Story:** As an admin, I want to process tutor payouts through a workflow that integrates with Xero and Airwallex, so that tutors receive accurate payments with transparent deduction tracking.

#### Acceptance Criteria

1. WHEN a package payment is confirmed, THEN the system SHALL create a payout record with payout_type='package', status='expected', and amount based on tutor hourly rate
2. WHEN a package is completed without additional fees, THEN the system SHALL check the tutor's deduction_balance
3. WHEN a package is completed, THEN the system SHALL create a Xero Purchase Order and Bill together with line items for tutoring services and deductions
4. WHEN the Xero Bill is created, THEN the system SHALL update the payout record with xero_bill_id, status='pending', and deduction_applied
5. WHEN an admin creates a manual payout, THEN the system SHALL create a payout record with payout_type='manual', status='pending', and create a Xero Bill directly (no PO)
6. WHEN the admin processes payment via Airwallex and clicks "Mark as Sent", THEN the system SHALL update payout_status to 'processing' and store payment_sent_date
7. WHEN the system checks Xero Bill status and finds Status=PAID, THEN the system SHALL update payout_status to 'completed'
8. WHEN a tutor views Earnings, THEN the system SHALL display expected payouts (active packages), pending payouts (completed packages), and payout history
9. WHEN displaying pending payouts to tutors, THEN the system SHALL include a note: "All payouts covered by Tutor Agreement signed [date]"

### FR16: Tutor Application Management (5-Stage Workflow)

**User Story:** As an admin, I want to manage tutor applications through a structured 5-stage workflow with email automation, so that I can efficiently evaluate and onboard new tutors.

#### Acceptance Criteria

1. WHEN a tutor application is submitted, THEN the system SHALL create an application record with current_stage='written_response' and written_response_status='to_review'
2. WHEN the admin reviews the written response stage, THEN the system SHALL allow actions: mark as pass, mark as failed, or reject
3. WHEN the admin marks written response as 'pass', THEN the system SHALL update current_stage to 'video_resource' and send an automated email to the applicant
4. WHEN the applicant submits video and resource materials, THEN the system SHALL update video_resource_status to 'to_review'
5. WHEN the admin marks video_resource as 'pass', THEN the system SHALL update current_stage to 'interview' and interview_status to 'to_schedule'
6. WHEN the admin schedules an interview, THEN the system SHALL update interview_status to 'scheduled' and send an automated email with details
7. WHEN the admin marks interview as 'pass', THEN the system SHALL update current_stage to 'onboarding' and onboarding_status to 'to_schedule'
8. WHEN the admin marks any stage as 'failed' or clicks "Reject", THEN the system SHALL update current_stage to 'rejected', store rejection_reason, and send a rejection email
9. WHEN onboarding is completed, THEN the system SHALL create a tutor user account with status='onboarding', update converted_tutor_id, and send invite email
10. WHEN viewing the Applications list, THEN the system SHALL allow filtering by current_stage and status

### FR17: Public Tutor Profile System

**User Story:** As a prospective client (authenticated or not), I want to view tutor profiles with detailed information and request that tutor, so that I can make informed decisions about tutoring services.

#### Acceptance Criteria

1. WHEN a tutor profile is accessed via stryvacademics.com/tutors/[short-hash], THEN the system SHALL display the profile without requiring authentication
2. WHEN displaying a public tutor profile, THEN the system SHALL show: profile photo, name, tagline, subjects taught (PRIMARY), about me, education, certifications (SECONDARY), and awards/qualifications (TERTIARY)
3. WHEN a non-authenticated user clicks "Request This Tutor", THEN the system SHALL redirect to the Webflow form
4. WHEN an authenticated user clicks "Request This Tutor", THEN the system SHALL open the in-platform request form pre-populated with their information
5. WHEN an authenticated parent submits the request form, THEN the system SHALL create a lead record with preferred_tutor_id set
6. WHEN a tutor edits their profile in Settings, THEN the system SHALL provide a "Preview Public Profile" option using the Preply-style layout

### FR18: Request Tutor Form

**User Story:** As a parent, student, or visitor, I want to submit tutor requests with appropriate field pre-population based on my authentication status, so that I can efficiently request tutoring services.

#### Acceptance Criteria

1. WHEN an authenticated parent accesses the Request Tutor form, THEN the system SHALL pre-populate contact details and school information
2. WHEN an authenticated parent submits the form, THEN the system SHALL display a "For Which Student?" dropdown with existing children plus "Add new child" option
3. WHEN an authenticated parent selects "Add new child", THEN the system SHALL expand fields for name and email, and create the student account on submit
4. WHEN an authenticated student accesses the Request Tutor form, THEN the system SHALL pre-populate contact details, school, and auto-assign the student ID
5. WHEN an authenticated student submits the form, THEN the system SHALL hide student selection and contact fields
6. WHEN a non-authenticated user accesses the Request Tutor form, THEN the system SHALL display all fields: contact info, "I am a" (Parent/Student), school (free text), subjects, goals, schedule, and preferred format
7. WHEN the user selects preferred format checkboxes, IF both Online and In-person are checked, THEN the system SHALL set format to 'hybrid'
8. WHEN the user selects preferred format checkboxes, IF only one is checked, THEN the system SHALL set format to that option
9. WHEN the form is submitted, THEN the system SHALL create a lead record and notify admins

### FR19: Xero Integration for Invoicing and Bills

**User Story:** As an admin, I want the system to automatically create Xero contacts, invoices, purchase orders, and bills with proper credit and deduction application, so that all financial transactions are accurately tracked.

#### Acceptance Criteria

1. WHEN a new user account is created, THEN the system SHALL call POST /Contacts to create a Xero contact
2. IF the Xero contact creation fails, THEN the system SHALL log the error, notify the admin, and allow manual retry from the admin panel
3. WHEN a trial or package payment is required, THEN the system SHALL call POST /Invoices to generate a client invoice in Xero
4. WHEN a package is completed, THEN the system SHALL call POST /PurchaseOrders and POST /Bills together to create a PO and Bill for the tutor
5. WHEN a manual payout is created, THEN the system SHALL call POST /Bills directly without creating a PO
6. WHEN the admin clicks "Sync Payment Status", THEN the system SHALL call GET /Invoices/{InvoiceID} to retrieve current payment status
7. WHEN checking payout reconciliation, THEN the system SHALL call GET /Bills/{BillID} to verify payment completion
8. WHEN an invoice includes applied credit, THEN the system SHALL add a line item to the Xero invoice showing "Credit Applied: -$X"
9. WHEN a bill includes applied deductions, THEN the system SHALL add a line item to the Xero Bill showing "Deductions Applied: -$X"

### FR20: Email Notification System

**User Story:** As a user of the platform, I want to receive automated email notifications for important events (account invites, payment confirmations, stage advancements), so that I stay informed about my activities and obligations.

#### Acceptance Criteria

1. WHEN a new user account is created, THEN the system SHALL send an Account Invite email with a magic link and trial/package details
2. WHEN a user accepts T&C, THEN the system SHALL send a T&C Confirmation email with the PDF attachment and acceptance details
3. WHEN a trial payment is pending for 24 hours, THEN the system SHALL send a Trial Payment Reminder email
4. WHEN a trial payment is confirmed, THEN the system SHALL send a Trial Payment Confirmed email
5. WHEN a package is created after a successful trial, THEN the system SHALL send a Package Payment Request email
6. WHEN a package payment is confirmed, THEN the system SHALL send a Package Payment Confirmed email with access details
7. WHEN additional fees are approved, THEN the system SHALL send an Additional Fees Invoice email
8. WHEN a tutor application advances to the next stage, THEN the system SHALL send a Stage Advancement email with next steps
9. WHEN a tutor application is rejected, THEN the system SHALL send an Application Rejected email
10. WHEN onboarding is scheduled for a tutor, THEN the system SHALL send an Onboarding Scheduled email with call details
11. WHEN tutor onboarding is complete, THEN the system SHALL send an Onboarding Complete email with login credentials
12. WHEN a new lead is submitted, THEN the system SHALL send admins a New Lead Submitted email with lead summary and link
13. WHEN a trial is completed, 24 hours later THEN the system SHALL send admins a Trial Completed follow-up reminder email
14. WHEN a payment receipt is uploaded, THEN the system SHALL send admins a Payment Receipt Uploaded email
15. WHEN there are pending payouts, THEN the system SHALL send admins a weekly Tutor Payout Reminder email
16. WHEN users access Settings → Notifications, THEN the system SHALL allow disabling lesson updates, payment updates, and package assignments
17. WHEN users access Settings → Notifications, THEN the system SHALL NOT allow disabling payment confirmations, T&C, account invites, or admin notifications

## Non-Functional Requirements

### NFR1: Mobile Responsiveness and Touch Optimization

**User Story:** As a mobile user, I want the platform to be fully responsive with touch-optimized controls, so that I can efficiently use all features on my mobile device.

#### Acceptance Criteria

1. WHEN the viewport width is ≤768px, THEN the system SHALL display a hamburger menu icon for navigation
2. WHEN the hamburger icon is tapped on mobile, THEN the system SHALL open a slide-out side panel with navigation options
3. WHEN a user taps outside the side panel or navigates to a new page, THEN the system SHALL close the panel
4. WHEN displaying interactive elements on mobile, THEN the system SHALL ensure all tap targets are at least 48x48px
5. WHEN displaying the T&C modal on mobile, THEN the system SHALL ensure it is responsive and scrollable with a max height of 60vh
6. WHEN displaying tables on mobile, THEN the system SHALL use responsive layouts that adapt to smaller screens

### NFR2: Performance and Page Load Times

**User Story:** As a platform user, I want pages to load quickly so that I can access information and complete tasks efficiently.

#### Acceptance Criteria

1. WHEN an authenticated user navigates to any page, THEN the system SHALL load the page in less than 2 seconds
2. WHEN a visitor accesses a public tutor profile, THEN the system SHALL load the page in less than 1 second
3. WHEN the system processes database queries, THEN the system SHALL use appropriate indexes to optimize performance

### NFR3: Data Security and Audit Trail

**User Story:** As a platform administrator, I want all financial transactions and T&C acceptances to be securely tracked with audit trails, so that the platform maintains compliance and accountability.

#### Acceptance Criteria

1. WHEN a user accepts T&C, THEN the system SHALL capture and store IP address, user agent, and timestamp
2. WHEN financial transactions are created, THEN the system SHALL store created_at and updated_at timestamps
3. WHEN tutor applications progress through stages, THEN the system SHALL maintain a stage_transition_history in JSONB format
4. WHEN sensitive data is transmitted, THEN the system SHALL use HTTPS encryption
5. WHEN storing files in Supabase Storage, THEN the system SHALL enforce access controls based on user roles

### NFR4: Integration Reliability and Error Handling

**User Story:** As an admin, I want the system to handle integration failures gracefully with proper error logging and manual retry options, so that temporary issues don't block critical workflows.

#### Acceptance Criteria

1. IF a Xero API call fails, THEN the system SHALL log the error with timestamp and details
2. IF a Xero contact creation fails, THEN the system SHALL notify the admin and allow manual retry from the admin panel
3. IF a Xero invoice/bill creation fails, THEN the system SHALL notify the admin and prevent marking the transaction as complete
4. IF an Airwallex payment link generation fails, THEN the system SHALL display an error message and allow retry
5. IF a Resend email fails to send, THEN the system SHALL log the error and attempt retry up to 3 times

### NFR5: Data Migration Integrity

**User Story:** As a platform administrator, I want data migration from Airtable to be complete and accurate with zero data loss, so that all existing users, packages, and relationships are preserved.

#### Acceptance Criteria

1. WHEN migrating from Airtable, THEN the system SHALL migrate all users (tutors, parents, students) with zero data loss
2. WHEN migrating from Airtable, THEN the system SHALL migrate all existing packages and preserve their relationships
3. WHEN migrating from Airtable, THEN the system SHALL migrate subjects and educational institutions data
4. WHEN migrating from Airtable, THEN the system SHALL migrate leads and applications if tracked
5. WHEN migrating from Airtable, THEN the system SHALL preserve all timestamps and audit trails
6. WHEN migrating from Airtable, THEN the system SHALL initialize all credit_balance and deduction_balance fields to 0
7. WHEN migration is complete, THEN the system SHALL perform validation to ensure data integrity and completeness
