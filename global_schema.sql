-- =================================================================
--                  GLOBAL DATABASE SCHEMA
-- =================================================================
-- This schema contains shared, non-sensitive data required for
-- global operations, deduplication, and routing. It should be
-- deployed to a single, central database instance.
-- =================================================================

-- Stores the list of all available regions in the platform.
CREATE TABLE regions (
    region_id SMALLINT PRIMARY KEY,
    region_code VARCHAR(10) UNIQUE NOT NULL, -- e.g., 'us-east-1', 'eu-central-1'
    description VARCHAR(255)
);

-- Stores SHA-256 digests of HubUser emails for global deduplication and routing.
-- No PII is stored here.
CREATE TABLE hub_user_email_digests (
    email_digest VARCHAR(64) PRIMARY KEY, -- SHA-256 hash
    hub_user_global_id UUID NOT NULL,
    home_region_id SMALLINT NOT NULL REFERENCES regions(region_id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_hub_user_email_digests_hub_user_global_id ON hub_user_email_digests(hub_user_global_id);

-- Stores SHA-256 digests of Employer domains for global uniqueness checks.
CREATE TABLE employer_domain_digests (
    domain_digest VARCHAR(64) PRIMARY KEY, -- SHA-256 hash
    employer_id UUID NOT NULL,
    home_region_id SMALLINT NOT NULL REFERENCES regions(region_id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_employer_domain_digests_employer_id ON employer_domain_digests(employer_id);

-- Stores SHA-256 digests of HubUser handles for global uniqueness checks.
CREATE TABLE hub_user_handle_digests (
    handle_digest VARCHAR(64) PRIMARY KEY, -- SHA-256 hash
    hub_user_global_id UUID NOT NULL,
    home_region_id SMALLINT NOT NULL REFERENCES regions(region_id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_hub_user_handle_digests_hub_user_global_id ON hub_user_handle_digests(hub_user_global_id);
