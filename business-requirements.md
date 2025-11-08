# Federated Hiring System - Complete Business Requirements

## System Overview
Build a federated hiring system with a Global Database and multiple Regional Databases (PostgreSQL). The system supports Employers creating job Openings, HubUsers applying to them, and tracking the application lifecycle through to Candidacy and Interviews.

---

## Core Entities

### 1. Employers
- Employers are organizations that post job openings
- Each Employer must have at least 1 domain associated with them
- Domains must be verified, and the verification timestamp must be recorded
- At any point in time, a domain must belong to only one Employer
- An Employer can have more than 1 domain at any point in time
- One domain should be identified as the Primary domain for an Employer
- A domain that belonged to Employer X at time t1 may belong to a different Employer Y at time t2
- **Full historical audit trail required** for domain ownership changes
- Employers can operate in multiple regions/geographies
- Employers have a default primary region
- Employers have a policy setting: whether users can apply to multiple openings in the same company (stored per-employer, affects only future applications)

### 2. HubUsers (Job Seekers)
- Each HubUser must have a verified email address
- The email verification timestamp should be captured
- A HubUser can have multiple email addresses
- An email can belong to only one HubUser at a time
- An email address that belonged to HubUser h1 at time t1 may belong to a different HubUser h2 at time t2
- **Full historical audit trail required** for email ownership changes
- HubUsers belong to one particular geography/region at a time
- HubUsers can migrate to a different geography/region
- Upon migration, a new UserProfile is created for the new region
- None of the data from the old geography is migrated
- The default UserProfile matches the region chosen at signup
- HubUser PII data (like emails) should be saved within their home region
- Email digests (SHA-256) can be saved anywhere (including global database)
- HubUsers can apply to any Opening in any region
- HubUsers should be able to query all their Applications and Candidacies from their home region (via index tables)
- There should be no difference for a HubUser to access Applications/Candidacies within their own region vs other regions

### 3. OrgUsers (Employer's Users)
- Employers have users called OrgUsers
- OrgUsers are saved under the Employer
- The Employer chooses which region to use for any OrgUser
- OrgUsers do NOT require email verification by default
- OrgUsers may use OAuth/SSO from the organization
- Some Orgs may manually add OrgUsers via email and ask them to set passwords (without SSO)
- In manual email/password cases, email verification may be needed
- OrgUsers do NOT need email re-verification when changing regions
- OrgUsers can change from one region to another
- OrgUsers need Profile-type records similar to HubUsers for region management
- OrgUsers should be able to query all Applications and Candidacies for their Employer's Openings across all regions
- Authentication method (SSO vs EMAIL_PASSWORD) must be tracked per OrgUser
- SSO provider information should be stored (e.g., GOOGLE, OKTA, AZURE_AD)

### 4. Openings (Job Posts)
- Employers create Openings
- An Opening is created in a specific region chosen by the Employer
- The region must be one of the regions where the Employer operates
- Employers must be able to set the list of regions they operate in
- An Opening is stored in its chosen region and does NOT migrate
- There is no requirement to store Opening metadata in other regions
- Even if an Employer no longer operates in a region, historical data remains (application handles errors)

### 5. Applications
- Any HubUser from any region can apply to any Opening in any region
- The Application is saved in the same region where the Opening was created (NOT the HubUser's region)
- One HubUser cannot apply to the same Opening more than once
- Whether a HubUser can apply to different Openings in the same company depends on the Employer's policy
- The policy is stored per-Employer and applies only to future applications (not retroactive)
- Applications have states: APPLIED, SHORTLISTED, REJECTED_AT_APPLICATION
- When created, an Application has state APPLIED
- An OrgUser can move Applications to SHORTLISTED or REJECTED_AT_APPLICATION
- For cross-region tracking, an Application index entry should be created in the HubUser's home region
- The index contains enough information (IDs and region references) to query the actual Application

### 6. Candidacies
- When an Application is moved to SHORTLISTED, a Candidacy is created
- A Candidacy has a unique ID
- A Candidacy is created in the same geography/region as the Application (Opening's region)
- One Application can lead to 0 or 1 Candidacy (never multiple)
- The Application status remains SHORTLISTED when Candidacy is created
- Candidacy states: ACTIVE, REJECTED_AFTER_INTERVIEW, CANDIDATE_NO_SHOW, CANDIDATE_UNSUITABLE, CANDIDATE_WITHDREW, CANDIDATE_OFFERED, CANDIDATE_REJECTED_OFFER, CANDIDATE_ACCEPTED_OFFER
- The design should NOT assume these are the only states (extensible)
- States should be stored as ENUM for now
- A Candidacy should be able to deduce: OpeningID, ApplicationID, HubUserID from the data model
- For cross-region tracking, a Candidacy index entry should be created in the HubUser's home region
- HubUsers should be able to query all their Candidacies from their home region

### 7. Interviews
- A Candidacy can have multiple Interviews
- An Interview must belong to a Candidacy
- Interviews are tracked with states (e.g., SCHEDULED, COMPLETED, CANCELLED, NO_SHOW, RESCHEDULED)
- Interview states should be extensible (stored as ENUM for now)
- Details like who conducts the interview, scheduling info, feedback can be minimal for now
- Interviews are used for reporting (e.g., how many scheduled for a week, approval percentage per interviewer)

---

## Data Federation & Regional Architecture

### Global Database
- Contains shared lookup data
- Stores region list and their identifiers
- Stores email digests (SHA-256) with hub_user_global_id and region_id
- Used for deduplication during signup
- Used for signin lookups to route users to correct region
- **Beyond authentication, there should NOT be calls going to the global region**

### Regional Databases
- Each region has an independent PostgreSQL instance
- Each regional database has the same schema
- Regional databases are completely unaware of other regions except for region_ids they store
- No database triggers across regions (application logic handles cross-region writes)
- No foreign keys across regions
- Application logic must correctly order writes across multiple databases

### Cross-Region References
- Use composite pattern: entity_id + region_id
- Prefer UUIDs for globally unique IDs
- Use `hub_user_global_id` (UUID) that remains constant across regions for HubUsers
- This enables linking user profiles and tracking across regions

### Index Tables for Query Efficiency
- `application_index`: Stored in HubUser's home region, references Applications across all regions
- `candidacy_index`: Stored in HubUser's home region, references Candidacies across all regions
- Index tables contain denormalized data (status, timestamps, IDs, region references)
- Application logic is responsible for keeping index tables in sync (no database triggers)

### Number of Regions
- The number of regions is not fixed and can vary dynamically
- New regions can be added without schema changes
- Region list comes from global database

---

## Key Constraints & Business Rules

### Domains
- A domain must have exactly ONE Employer at any point in time (UNIQUE constraint on domain)
- An active Employer must have exactly ONE primary domain (UNIQUE constraint)
- Domain verification timestamp is mandatory
- Full audit trail with valid_from and valid_to timestamps

### Emails
- An email must belong to exactly ONE HubUser at any point in time (UNIQUE constraint on email)
- Email verification timestamp is mandatory when verified
- Full audit trail with valid_from and valid_to timestamps
- Email digests (SHA-256) stored globally for deduplication

### Applications
- One HubUser cannot apply to the same Opening twice (UNIQUE constraint on opening_id + hub_user_global_id)
- Employer policy controls whether users can apply to multiple openings in the same employer
- Applications are stored in the Opening's region, not HubUser's region

### Candidacies
- One Application can have at most one Candidacy (UNIQUE constraint on application_id)
- Candidacy is created in the same region as the Application
- Candidacy states are extensible (use ENUM but design for future additions)

### Authentication
- HubUsers: Email verification required
- OrgUsers: SSO or Email/Password
  - SSO: No email verification needed, sso_provider must be set
  - Email/Password: Email verification may be needed

### Migration
- HubUsers and OrgUsers can migrate regions
- Migration creates new profile in new region
- Old profile remains accessible
- For HubUsers: PII stays in home region
- For OrgUsers: No email re-verification needed

---

## Identity & Hashing Strategy

### HubUser Identity
- `hub_user_global_id` (UUID): Immutable global identifier across regions
- `hub_user_id` (UUID): Regional identifier, different per region
- Email SHA-256: For deduplication and privacy

### Email Digests
- Algorithm: SHA-256
- Stored in global database with region_id
- Used for:
  - Deduplication during signup
  - Lookup during signin to route to correct region
  - Can be queried from global table or included in regional tables

### Primary Key Strategy
- Composite keys with region identifier preferred for federated entities
- However, UUIDs are acceptable and simpler (chosen in this design)
- Sequential IDs within each region are avoided due to coordination issues

---

## Query Patterns & Performance

### HubUser Queries
- HubUsers query their home region for application_index and candidacy_index
- Index tables provide complete view of Applications/Candidacies across all regions
- When details are needed, query the specific region using entity_id + region_id

### OrgUser Queries
- OrgUsers query all regions where their Employer operates
- Query pattern: Get operational regions, then query each region for Applications/Candidacies
- Application layer merges results

### Cross-Region Write Pattern
1. Create main entity in target region (e.g., Application in Opening's region)
2. Create index entry in HubUser's home region
3. No database-level coordination; application logic ensures consistency
4. Consider eventual consistency and message queues for reliability

---

## Schema Design Decisions Summary

### Historical Audit
- Separate history tables for domains and emails
- Temporal columns: valid_from, valid_to (NULL means current)
- Change reason tracking (CREATED, TRANSFERRED, VERIFIED, DEACTIVATED)

### Denormalization
- Applications and Candidacies store employer_id, hub_user_global_id, region_ids
- Reduces cross-region joins
- Improves query performance

### Extensibility
- ENUMs for states (can be altered to add new values)
- Flexible schema for Interviews (minimal fields now, expandable later)
- Region list managed in global database (add regions without schema changes)

### Data Locality
- Applications/Candidacies: Opening's region
- HubUser PII: Home region
- Index tables: HubUser's home region
- Employer: Primary region, operates in multiple regions

---

## Implementation Notes

### Transaction Management
- Use distributed transactions or compensating transactions for cross-region writes
- Consider Saga pattern for complex workflows
- Message queues (Kafka, SQS) for reliable index updates

### Error Handling
- Handle region unavailability gracefully
- Stale index data is acceptable (eventual consistency)
- Provide clear error messages for cross-region issues

### Scalability
- Read replicas per region for reporting
- Partition large tables by date
- Cache frequently accessed data (employer policies, region lists, openings)

### Security & Privacy
- HubUser emails remain in home region
- Email digests used for cross-region lookups
- Employer data access controlled by region
- OrgUsers see only their Employer's data

---

## Future Considerations

- Support for more Candidacy and Interview states
- Bulk operations across regions
- Data archival strategies for old Applications/Candidacies
- GDPR compliance for user data deletion across regions
- Performance monitoring and optimization
- Backup and disaster recovery per region
