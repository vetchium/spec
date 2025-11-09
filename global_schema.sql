-- =================================================================
--                  GLOBAL DATABASE SCHEMA
-- =================================================================
-- This schema contains shared, non-sensitive data required for
-- global operations, deduplication, and routing. It should be
-- deployed to a single, central database instance.
-- =================================================================

-- ENUM for the status of a region
CREATE TYPE region_status AS ENUM ('ACTIVE', 'INACTIVE', 'MAINTENANCE');

-- Stores the list of all available regions in the platform.
CREATE TABLE regions (
    region_code TEXT PRIMARY KEY, -- e.g., 'us-east-1', 'eu-central-1'
    description TEXT,
    status region_status NOT NULL DEFAULT 'ACTIVE'
);

-- Stores SHA-256 digests of HubUser email addresses for global deduplication and routing.
-- No PII is stored here.
CREATE TABLE hub_user_email_address_digests (
    email_digest TEXT PRIMARY KEY, -- SHA-256 hash
    hub_user_global_id UUID NOT NULL,
    home_region_code TEXT NOT NULL REFERENCES regions(region_code),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_hub_user_email_address_digests_hub_user_global_id ON hub_user_email_address_digests(hub_user_global_id);

-- Stores SHA-256 digests of Employer domains for global uniqueness checks.
CREATE TABLE employer_domain_digests (
    domain_digest TEXT PRIMARY KEY, -- SHA-256 hash
    employer_id UUID NOT NULL,
    home_region_code TEXT NOT NULL REFERENCES regions(region_code),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_employer_domain_digests_employer_id ON employer_domain_digests(employer_id);

-- Stores SHA-256 digests of HubUser handles for global uniqueness checks.
CREATE TABLE hub_user_handle_digests (
    handle_digest TEXT PRIMARY KEY, -- SHA-256 hash
    hub_user_global_id UUID NOT NULL,
    home_region_code TEXT NOT NULL REFERENCES regions(region_code),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_hub_user_handle_digests_hub_user_global_id ON hub_user_handle_digests(hub_user_global_id);
