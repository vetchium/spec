-- =================================================================
--                  REGIONAL DATABASE SCHEMA
-- =================================================================
-- This schema is deployed in each regional database. It stores all
-- operational and PII data for entities homed in that region.
-- =================================================================

-- -----------------
-- ENUM Types
-- -----------------

CREATE TYPE org_user_auth_method AS ENUM ('SSO', 'EMAIL_PASSWORD');
CREATE TYPE sso_provider AS ENUM ('GOOGLE', 'OKTA', 'AZURE_AD', 'OTHER');
CREATE TYPE application_status AS ENUM ('APPLIED', 'SHORTLISTED', 'REJECTED_AT_APPLICATION');
CREATE TYPE candidacy_status AS ENUM (
    'INTERVIEWING',
    'OFFER_EXTENDED',
    'OFFER_ACCEPTED',
    'ONBOARDING',
    'HIRED',
    'INTERVIEW_REJECTED',
    'OFFER_REJECTED',
    'OFFER_RESCINDED',
    'WITHDRAWN',
    'CANDIDATE_NO_SHOW',
    'CANDIDATE_UNSUITABLE'
);
CREATE TYPE interview_status AS ENUM ('SCHEDULED', 'COMPLETED', 'CANCELLED', 'NO_SHOW', 'RESCHEDULED');
CREATE TYPE history_change_reason AS ENUM ('CREATED', 'TRANSFERRED', 'VERIFIED', 'DEACTIVATED', 'REMOVED');
CREATE TYPE opening_question_type AS ENUM ('CHECKBOX', 'RADIO', 'TEXTAREA');
CREATE TYPE opening_status AS ENUM ('DRAFT', 'ACTIVE', 'PAUSED', 'CLOSED', 'ARCHIVED');

-- -----------------
-- Utility Functions & Triggers
-- -----------------

-- Trigger function to automatically set updated_at on row modification.
CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS '
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
' LANGUAGE plpgsql;

-- -----------------
-- Employers & Orgs
-- -----------------

CREATE TABLE employers (
    employer_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    primary_region_code TEXT NOT NULL, -- Reference to a region_code from the global table
    allow_multiple_applications_policy BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON employers
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

-- Stores the regions where an employer operates.
CREATE TABLE employer_operating_regions (
    employer_id UUID NOT NULL REFERENCES employers(employer_id) ON DELETE CASCADE,
    region_code TEXT NOT NULL, -- Reference to a region_code from the global table
    PRIMARY KEY (employer_id, region_code)
);

-- Current state of employer domains. For history, see employer_domains_history.
CREATE TABLE employer_domains (
    domain_name TEXT PRIMARY KEY,
    employer_id UUID NOT NULL REFERENCES employers(employer_id) ON DELETE CASCADE,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    verified_at TIMESTAMPTZ NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
    -- An employer can have only one primary domain. This is enforced by the partial unique index below.
);

CREATE UNIQUE INDEX idx_uq_employer_primary_domain ON employer_domains (employer_id) WHERE is_primary = TRUE;

-- Full audit trail for domain ownership changes.
CREATE TABLE employer_domains_history (
    history_id BIGSERIAL PRIMARY KEY,
    domain_name TEXT NOT NULL,
    employer_id UUID NOT NULL,
    change_reason history_change_reason NOT NULL,
    valid_from TIMESTAMPTZ NOT NULL,
    valid_to TIMESTAMPTZ, -- NULL indicates the current record
    changed_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- -----------------
-- HubUsers (Job Seekers)
-- -----------------

-- This table holds the regional profile.
CREATE TABLE hub_users (
    hub_user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Regional ID
    hub_user_global_id UUID UNIQUE NOT NULL, -- Immutable Global ID
    handle TEXT UNIQUE NOT NULL,
    bio TEXT,
    profile_picture_url TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_hub_users_global_id ON hub_users(hub_user_global_id);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON hub_users
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

-- Current state of HubUser email addresses. For history, see hub_user_email_addresses_history.
CREATE TABLE hub_user_email_addresses (
    email_address TEXT PRIMARY KEY,
    hub_user_id UUID NOT NULL REFERENCES hub_users(hub_user_id) ON DELETE CASCADE,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    is_verified BOOLEAN NOT NULL DEFAULT FALSE,
    verified_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
    -- A user can have only one primary email_address. This is enforced by the partial unique index below.
);

CREATE UNIQUE INDEX idx_uq_hub_user_primary_email_address ON hub_user_email_addresses (hub_user_id) WHERE is_primary = TRUE;

-- Full audit trail for email_address ownership changes.
CREATE TABLE hub_user_email_addresses_history (
    history_id BIGSERIAL PRIMARY KEY,
    email_address TEXT NOT NULL,
    hub_user_id UUID NOT NULL,
    change_reason history_change_reason NOT NULL,
    valid_from TIMESTAMPTZ NOT NULL,
    valid_to TIMESTAMPTZ, -- NULL indicates the current record
    changed_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Full audit trail for handle changes.
CREATE TABLE hub_user_handles_history (
    history_id BIGSERIAL PRIMARY KEY,
    handle TEXT NOT NULL,
    hub_user_id UUID NOT NULL,
    change_reason history_change_reason NOT NULL,
    valid_from TIMESTAMPTZ NOT NULL,
    valid_to TIMESTAMPTZ, -- NULL indicates the current record
    changed_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- OrgUsers (Employer's Users)
CREATE TABLE org_users (
    org_user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    employer_id UUID NOT NULL REFERENCES employers(employer_id) ON DELETE CASCADE,
    email_address TEXT NOT NULL,
    password_hash TEXT, -- Can be null if using SSO
    auth_method org_user_auth_method NOT NULL,
    sso_provider sso_provider, -- Null if auth_method is EMAIL_PASSWORD
    is_email_verified BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (employer_id, email_address)
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON org_users
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

-- Full audit trail for OrgUser email_address changes.
CREATE TABLE org_user_email_addresses_history (
    history_id BIGSERIAL PRIMARY KEY,
    email_address TEXT NOT NULL,
    org_user_id UUID NOT NULL,
    change_reason history_change_reason NOT NULL,
    valid_from TIMESTAMPTZ NOT NULL,
    valid_to TIMESTAMPTZ, -- NULL indicates the current record
    changed_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- -----------------
-- Openings & Applications
-- -----------------

CREATE TABLE openings (
    opening_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    employer_id UUID NOT NULL REFERENCES employers(employer_id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    description TEXT,
    -- The region_code where this opening is located. This is the region of the current database.
    region_code TEXT NOT NULL,
    recruiter_org_user_id UUID REFERENCES org_users(org_user_id) ON DELETE SET NULL,
    hiring_manager_org_user_id UUID REFERENCES org_users(org_user_id) ON DELETE SET NULL,
    status opening_status NOT NULL DEFAULT 'DRAFT',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON openings
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TABLE opening_questions (
    question_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    opening_id UUID NOT NULL REFERENCES openings(opening_id) ON DELETE CASCADE,
    question_text TEXT NOT NULL,
    question_type opening_question_type NOT NULL,
    is_mandatory BOOLEAN NOT NULL DEFAULT FALSE,
    options JSONB, -- For CHECKBOX or RADIO types
    max_chars INT, -- For TEXTAREA type
    display_order SMALLINT NOT NULL
);

CREATE TABLE applications (
    application_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    opening_id UUID NOT NULL REFERENCES openings(opening_id) ON DELETE CASCADE,
    hub_user_global_id UUID NOT NULL, -- Global ID of the applicant
    applicant_home_region_code TEXT NOT NULL, -- HubUser's home region for index table updates
    status application_status NOT NULL DEFAULT 'APPLIED',
    submitted_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    -- A user can only apply to an opening once.
    UNIQUE (opening_id, hub_user_global_id)
);
CREATE INDEX idx_applications_hub_user_global_id ON applications(hub_user_global_id);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON applications
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TABLE application_answers (
    answer_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    application_id UUID NOT NULL REFERENCES applications(application_id) ON DELETE CASCADE,
    question_id UUID NOT NULL REFERENCES opening_questions(question_id) ON DELETE CASCADE,
    answer_text TEXT, -- For TEXTAREA
    selected_options JSONB, -- For CHECKBOX or RADIO
    submitted_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- -----------------
-- Candidacies & Interviews
-- -----------------

CREATE TABLE candidacies (
    candidacy_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    application_id UUID UNIQUE NOT NULL REFERENCES applications(application_id) ON DELETE CASCADE,
    opening_id UUID NOT NULL REFERENCES openings(opening_id) ON DELETE CASCADE,
    hub_user_global_id UUID NOT NULL,
    status candidacy_status NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_candidacies_opening_id ON candidacies(opening_id);
CREATE INDEX idx_candidacies_hub_user_global_id ON candidacies(hub_user_global_id);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON candidacies
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TABLE interviews (
    interview_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    candidacy_id UUID NOT NULL REFERENCES candidacies(candidacy_id) ON DELETE CASCADE,
    status interview_status NOT NULL DEFAULT 'SCHEDULED',
    scheduled_at TIMESTAMPTZ,
    format TEXT, -- e.g., 'Phone Screen', 'On-site Technical'
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE interviewers (
    interview_id UUID NOT NULL REFERENCES interviews(interview_id) ON DELETE CASCADE,
    org_user_id UUID NOT NULL REFERENCES org_users(org_user_id) ON DELETE CASCADE,
    feedback TEXT,
    submitted_feedback_at TIMESTAMPTZ,
    PRIMARY KEY (interview_id, org_user_id)
);

-- -----------------
-- Index Tables (for HubUser's home region)
-- -----------------
-- These tables are populated in the HubUser's home region to provide a
-- consolidated view of their activities across all regions.
--
-- DATA CONSISTENCY PROTOCOL:
-- These tables are updated via an eventually consistent, two-phase process.
-- The order of operations MUST be followed to ensure data integrity without
-- requiring distributed transactions.
--
-- 1.  Phase 1: Write to the Source-of-Truth Table.
--     - The primary record (e.g., an `applications` row) is created in the
--       database of the region where the action occurred (e.g., the opening's region).
--     - This is the authoritative record.
--
-- 2.  Phase 2: Write to the Index Table via Asynchronous, Guaranteed Delivery.
--     - After the Phase 1 write is successfully committed, a message is dispatched
--       via a reliable, asynchronous messaging system.
--     - A background worker in the applicant's home region consumes this message
--       and inserts the corresponding record into the index table below (e.g.,
--       `application_index`).
--     - This operation must be idempotent. If the worker fails, it must be able to
--       retry without creating duplicate index entries.
--
-- This design ensures that the primary user action is fast (a single-region write)
-- while guaranteeing that the user's consolidated view will be updated shortly after.

CREATE TABLE application_index (
    hub_user_global_id UUID NOT NULL,
    application_id UUID NOT NULL,
    application_region_code TEXT NOT NULL, -- The region where the actual application is stored
    opening_id UUID NOT NULL,
    employer_id UUID NOT NULL,
    status application_status NOT NULL,
    submitted_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (hub_user_global_id, application_id)
);

CREATE TABLE candidacy_index (
    hub_user_global_id UUID NOT NULL,
    candidacy_id UUID NOT NULL,
    candidacy_region_code TEXT NOT NULL, -- The region where the actual candidacy is stored
    application_id UUID NOT NULL,
    opening_id UUID NOT NULL,
    employer_id UUID NOT NULL,
    status candidacy_status NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (hub_user_global_id, candidacy_id)
);

-- -----------------
-- Social & Communication Features
-- -----------------

CREATE TABLE posts (
    post_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    author_hub_user_id UUID REFERENCES hub_users(hub_user_id) ON DELETE SET NULL,
    author_employer_id UUID REFERENCES employers(employer_id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    is_anonymous BOOLEAN NOT NULL DEFAULT FALSE, -- For the anonymous community forum
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_post_author CHECK (
        (author_hub_user_id IS NOT NULL AND author_employer_id IS NULL) OR
        (author_hub_user_id IS NULL AND author_employer_id IS NOT NULL)
    )
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON posts
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TABLE comments (
    comment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    post_id UUID NOT NULL REFERENCES posts(post_id) ON DELETE CASCADE,
    author_hub_user_id UUID NOT NULL REFERENCES hub_users(hub_user_id) ON DELETE CASCADE,
    parent_comment_id UUID REFERENCES comments(comment_id) ON DELETE CASCADE, -- For threaded comments
    content TEXT NOT NULL,
    is_anonymous BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON comments
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

-- For internal (hiring team) and external (candidate) communication
CREATE TABLE candidacy_comments (
    comment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    candidacy_id UUID NOT NULL REFERENCES candidacies(candidacy_id) ON DELETE CASCADE,
    is_internal_discussion BOOLEAN NOT NULL, -- TRUE for internal, FALSE for candidate chat
    author_org_user_id UUID REFERENCES org_users(org_user_id) ON DELETE SET NULL,
    author_hub_user_id UUID REFERENCES hub_users(hub_user_id) ON DELETE SET NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    -- An author must be present, and must be of a single type
    CONSTRAINT chk_comment_author CHECK (
      (author_org_user_id IS NOT NULL AND author_hub_user_id IS NULL) OR
      (author_org_user_id IS NULL AND author_hub_user_id IS NOT NULL)
    ),
    -- HubUsers cannot post in internal discussions
    CONSTRAINT chk_internal_discussion_author CHECK (
      is_internal_discussion = FALSE OR author_hub_user_id IS NULL
    )
);

CREATE INDEX idx_candidacy_comments_candidacy_id ON candidacy_comments(candidacy_id);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON candidacy_comments
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();