# Vetchium Platform API Specification

This document outlines the functional specification for the Vetchium platform, which consists of four main front-ends: the Employer Portal, the Professionals Hub, the Recruitment Agency Portal, and the Vetchium Admin Portal. The specification is described from the perspective of its end-users. This document will be used to generate the APIs that will be needed to satisfy the below specification.

---

## 1. Employer Portal

The Employer Portal is the interface for company representatives to manage their organization's presence, recruitment processes, and user access on the Vetchium platform.

### User Persona: Employer User

An individual who works for a registered employer. They can have various roles and permissions (e.g., Admin, Recruiter, Hiring Manager) that grant them access to different functionalities.

### Core Functionalities:

#### A. Account & Access Management
- **Onboarding & Authentication**: The onboarding process for an employer organization is initiated through domain verification, ensuring that only legitimate representatives can create an account.

    - **Domain-First Sign-In**: The sign-in process begins with the user entering their company's domain name (e.g., `yourcompany.com`).
    - **Existing Organizations**: If the domain is already registered with Vetchium, the system will display fields for the user's email address and password. Upon successful authentication, the user receives a token to proceed, potentially including a subsequent Two-Factor Authentication (TFA) step.
    - **New Organization Onboarding**: If the domain is not yet registered, the system triggers a verification process:
        1.  **DNS Record Check**: Vetchium performs a DNS lookup for a specific TXT record: `vetchium-admin.<domain>.<tld>`. The value of this record must be the email address of the designated administrator.
        2.  **Admin Signup Invitation**: A password setup email, containing a unique and time-sensitive signup URL, is sent to the email address retrieved from the DNS record.
        3.  **Initial Admin Setup**: The recipient of the email follows the signup URL to set their password and officially create the employer account. This user automatically becomes the first administrator for the organization on Vetchium.
    - **Standard Authentication**: For all subsequent logins by registered users, authentication includes email/password sign-in, a two-factor authentication (TFA) step, and a "forgot password" flow for account recovery.
- **Domain Management**: The initial administrator can add and manage multiple domains owned by the same employer. Each new domain must be verified using the same DNS TXT record procedure (`vetchium-admin.<new-domain>.<tld>`) to prove ownership.
- **Password Management**: Any logged-in user can change their own password.
- **User Administration**: Users with administrative rights can:
    - Invite new users to the organization's portal.
    - Update the roles and permissions of existing users.
    - Disable or re-enable user accounts.
    - View and filter a list of all users within their organization.

#### B. Company Profile & Structure
- **Cost Centers**: Admins can define, rename, update, and manage internal cost centers for organizational mapping.
- **Locations**: Admins can add, update, and manage the company's physical or remote office locations.

#### C. Recruitment Workflow
- **Custom Recruitment Pipelines**:
    - Admins can create and manage a library of custom pipeline stages for their organization (e.g., "Phone Screen," "Technical Interview," "Offer Stage," "Background Check").
    - For each job opening, the creator can define a specific pipeline by selecting and ordering stages from the company's library. This allows for flexible, per-opening recruitment workflows.
- **Custom Rejection Reasons**:
    - Admins can create and manage a library of rejection reasons for their organization (e.g., "Does not meet qualifications," "Salary expectations too high," "Better candidates in pipeline," "Not a culture fit").
    - This allows for detailed analytics on why candidates are being disqualified.
- **Job Openings**:
    - Create, update, and view detailed job openings. Each opening must have one internal Recruiter and one Hiring Manager assigned.
    - Filter and view a list of all current and past openings.
    - Change the status of an opening (e.g., Active, Paused, Closed).
    - Manage a list of "watchers" (internal users) who receive notifications for a specific opening.
    - Search for and assign skill tags (VTags) to openings for better discoverability.
- **Candidate Applications**:
    - View a list of all candidates who have applied for an opening.
    - View a candidate's resume and their detailed professional profile (bio, education, achievements).
    - Manage applications by moving candidates through the custom pipeline stages defined for the job opening.
    - Organize applications using internal-facing color tags.
- **Candidacy Management**:
    - **Candidacy States**: Each application has a single, system-managed state that reflects its position in the recruitment lifecycle. An application moves from `Applied` to either `Interviewing` or a terminal state.
    - **Candidacy States List**: The states are grouped by their position in the hiring lifecycle:
        - **Active States**:
            - `Applied`: A new, unreviewed application. The entry point for all candidates.
            - `Interviewing`: The candidate is actively engaged in any form of interview (phone, video, on-site, etc.).
            - `Offer-Extended`: An official offer has been sent to the candidate for review.
            - `Offer-Accepted`: The candidate has formally accepted the job offer, triggering the final administrative phase.
            - `Onboarding`: Post-acceptance phase where document collection, background checks, and other administrative verifications occur.
        - **Terminal States - Success**:
            - `Hired`: The candidate has successfully completed onboarding and is officially designated as an employee.
        - **Terminal States - Unsuccessful**:
            - `Resume-Rejected`: The candidate was rejected based on their initial application, before any interview occurred.
            - `Interview-Rejected`: The candidate was rejected after participating in one or more interviews.
            - `Offer-Rejected`: The candidate has declined the job offer. This can be due to various reasons such as salary, benefits, or accepting another offer.
            - `Offer-Rescinded`: The employer has withdrawn the offer during the `Onboarding` phase due to issues like a failed background check or visa unavailability.
            - `Withdrawn`: The candidate has voluntarily withdrawn their application from consideration at any point in the process.
    - **Communication Threads**: Each candidacy has two dedicated communication threads:
        - **Internal Discussion**: A private thread for the Recruiter, Hiring Manager, and all assigned Interviewers to discuss the candidate, share feedback, and coordinate internally.
        - **Candidate Chat**: A thread for the Recruiter and Hiring Manager to communicate directly with the candidate for coordination and updates.
    - Make an official job offer to a candidate, which moves the candidacy state to `Offer-Extended` and notifies the candidate.
- **Interview Scheduling & Feedback**:
    - Schedule interviews for a candidate, specifying the format and details.
    - Add or remove internal users as interviewers for a scheduled event.
    - Interviewers can RSVP to interview invitations.
    - View all scheduled interviews for an opening or a specific candidate.
    - Submit and view interview feedback/assessments for a candidate.

#### D. Employer Branding & Communication
- **Company Posts**: Users with appropriate permissions can create, update, delete, and view posts that are published on the company's public page in the Professionals Hub.

#### E. Recruitment Agency Management
- **Adding and Removing Agencies**: Admins can search for, add, and remove Recruitment Agencies from their list of approved partners.
- **Assigning Recruiters**: For any job opening, an Admin or Recruiter can assign a specific Recruiter from an approved agency or an internal user, to manage the sourcing and application process.
- **Changing Recruiters**: The assigned Recruiter for an opening or a specific candidacy can be changed at any time.

---

## 2. Professionals Hub

The Professionals Hub is the social and career-oriented platform for individual professionals (Hub Users). It allows them to build a profile, find jobs, network, and discuss industry topics.

### User Persona: Hub User (Professional)

An individual professional using the platform for career growth, job seeking, and networking. Users can be on a Free or a Paid tier, with some features being exclusive to paid users.

### Core Functionalities:

#### A. Account & Profile Management
- **Onboarding & Authentication**: Users can only sign up using a professional (work) email address from a domain approved by the platform. Public email domains (e.g., gmail.com, yahoo.com) are not permitted for initial registration. Standard authentication includes email/password sign-in (with TFA) and a "forgot password" flow. After signingup, users can change the primary email address from the work email to their personal email address (gmail or yahoo or whatever).
- **Handle**: Upon signup, users get a unique handle (username). Paid users can check for handle availability and change it.
- **Profile Building**:
    - **Bio & Picture**: Users can write a professional bio. Paid users can upload a profile picture.
    - **Work History**: Users can add, update, and delete entries in their professional work history.
    - **Education & Achievements**: Users can list their educational background and professional achievements.
    - **Official Email**: Users can add and verify multiple official (work) email addresses to their profile to unlock certain features.

#### B. Job Seeking & Applications
- **Discover Openings**: Users can search, filter (by tags, location, etc.), and view job openings from all employers.
- **Apply**: Users can apply for any open position.
- **Manage Applications**: Users can view a list of all their past applications and have the ability to withdraw an active application.
- **Track Candidacy**:
    - Users can view the current stage of their application in the hiring pipeline, providing more transparency.
    - **Communicate with Hiring Team**: Users can engage in a two-way conversation with the Recruiter and Hiring Manager via the "Candidate Chat" thread on their application.
    - They can view and RSVP to interview invitations scheduled by the employer.

#### C. Networking & Social Interaction
- **User & Company Profiles**: Users can view the profiles of other professionals and follow companies.
- **Following**: Users can follow/unfollow other users and companies to see their posts in own timeline.
- **Posts & Timeline**:
    - Users can create posts to share with their followers and the wider community. (Free users have limits).
    - The home timeline shows a feed of posts from followed users and organizations.
    - Users can interact with posts by upvoting, downvoting, and commenting.
- **Post Management**: Users can manage comments on their own posts (enable/disable) and delete their own posts or comments.

#### D. Anonymous Community Forum (Incognito)
- **Anonymous Identity**: All interactions in this section are anonymous.
- **Posts & Comments**: Users can create, view, and delete anonymous posts and comments.
- **Voting**: Users can anonymously upvote or downvote posts and comments to signal relevance and quality.
- **Discussions**: Users can view replies to comments and get a direct link to a specific comment for sharing.

#### E. Colleague Connections
- **Eligibility**: To become colleagues, two Hub Users must have at least one common, verified official email domain.
- **Connection Flow**:
    - **Request**: A user can send a colleague request to an eligible user. A pending request can exist in only one direction at a time.
    - **Accept**: The recipient can accept the request, establishing a mutual colleague connection.
    - **Reject**: If User B rejects User A's request, User A cannot send another request to User B. However, User B (who rejected the request) can choose to send a request to User A in the future.
    - **Remove Colleague**: If User A removes User B as a colleague, the connection is severed. User B cannot send a new request to User A. However, User A (who initiated the removal) can choose to send a new request to User B in the future.
- **Endorsements**: Colleagues can endorse each other for job applications.

#### F. User Blocking and Unblocking
- **Blocking a User**: A Hub User can block another Hub User at any time. The blocked user is not notified. Blocking is intended to prevent unwanted interactions.
    - **Immediate Effects**:
        - If the blocker and the blocked user were following each other, both follow connections are immediately severed.
        - If they were colleagues, the colleague connection is removed.
        - These connections are not automatically restored upon unblocking.
    - **Interaction Restrictions**:
        - **Viewing Content**: Both users can still view each other's profiles and public posts. Blocking is not a cloaking mechanism.
        - **Mutual Interaction Block**: To prevent targeted harassment, the interaction block is mutual. Neither the blocker nor the blocked user can:
            - Follow the other user.
            - Send a colleague request to the other user.
            - Comment on or reply to the other user's posts.
            - Upvote or downvote the other user's posts or comments.
- **Unblocking a User**:
    - A user can unblock another user at any time from their settings.
    - **Effects**:
        - The mutual interaction block is lifted.
        - Both users are now able to follow each other, send colleague requests, and interact with each other's content again.
        - Past follows, colleague connections, or other interactions are not automatically restored.

---

## 3. Recruitment Agency Portal

The Recruitment Agency Portal is the interface for recruitment agencies to manage their users, track their performance, and carry out recruitment tasks on behalf of employers.

### User Persona: Agency User

An individual who works for a registered recruitment agency. They can have various roles and permissions (e.g., Admin, Recruiter) that grant them access to different functionalities.

### Core Functionalities:

#### A. Account & Access Management
- **Onboarding & Authentication**: A new user can be invited to the platform by an agency Admin. They can set their password upon first login. Standard authentication includes email/password sign-in, a two-factor authentication (TFA) step, and a "forgot password" flow for account recovery.
- **Password Management**: Any logged-in user can change their own password.
- **User Administration**: Users with administrative rights can:
    - Invite new users to the agency's portal.
    - Update the roles and permissions of existing users.
    - Disable or re-enable user accounts.
    - View and filter a list of all users within their agency.

#### B. Agency Performance Dashboard
- **Performance Metrics**: Admins and Recruiters can view a dashboard that displays key performance indicators (KPIs) for their agency, such as:
    - Number of assigned job openings.
    - Number of candidates submitted.
    - Candidate progression through the hiring stages (e.g., shortlisted, interviewing, hired).
    - Time-to-fill metrics.

#### C. Recruitment Workflow
- **Assigned Openings**: Recruiters can view a list of all job openings they have been assigned to by employers.
- **Candidate Sourcing**: Recruiters can search for and source potential candidates from the Professionals Hub.
- **Candidate Management**: For their assigned openings, Recruiters can:
    - Submit candidates for consideration.
    - View the status of their submitted candidates.
    - Schedule interviews and coordinate with candidates.
    - Add private notes and comments on a candidacy, visible only to other users within their own agency.

#### D. Private Notes on Professionals
- **Adding Notes**: Agency users can add private notes to any Hub User's profile, using the Hub User's handle as a key. These notes are strictly internal to the agency and are **not shared with employers**. They can be used to track candidate suitability and internal assessments.

#### E. Tiers and Plans

**TODO**: The tiers and plans for Recruitment Agencies are not yet finalized. The following is a sample and should be updated.

- **Free Tier**: Allows agencies to manage their users (CRUD operations for Recruiters).
- **Silver Tier**: Includes all Free Tier features, plus the ability to add private notes about Hub Users.
- **Gold Tier**: Includes all Silver Tier features, plus access to AI-powered search to find candidates based on notes and profile data.

---

## 4. Vetchium Admin Portal

The Vetchium Admin Portal is the interface for Vetchium administrators to manage the platform's core data, users, and settings.

### User Persona: Vetchium Admin

An employee of Vetchium with super-user privileges to manage the platform.

### Core Functionalities:

#### A. User Management
- **User Administration**:
    - Invite new users to the platform (both Employer and Hub users).
    - Block/unblock or disable/re-enable user accounts.
    - View and filter a list of all users on the platform.

#### B. Content & Data Management
- **Signup Domain Management**: Admins can manage the list of email domains that are permitted or denied for Hub User registration, ensuring only users with professional email addresses can join.
- **Tags (VTags)**: Admins can create, read, update, and delete (CRUD) the skill tags used across the platform for job openings and user profiles.
- **Region Management**: A platform super admin can manage the available geographic regions for data storage and define data residency policies.

---

## Roles and Permissions (RBAC)

The Vetchium platform uses a Role-Based Access Control (RBAC) model to manage user permissions. Roles are defined independently for each portal and are designed to be extensible, allowing for the future addition of new roles with minimal impact on the existing system.

### A. Employer Portal Roles

| Role             | Permissions                                                                                                                                                                                                                                                        |
|------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Admin**        | **[Full Control]** Can perform all actions: User Management (Invite, update roles, disable/re-enable users), Company Profile (Manage cost centers and locations), Recruitment (Create/update/manage all job openings and candidates), Branding (Create and manage company posts). |
| **Recruiter**    | **[Recruitment Focus]** Can manage the full lifecycle of recruitment: Job Openings (Create, update, and manage openings), Candidate Management (View, filter, and manage all candidates), Interviews (Schedule interviews and manage interviewers), Branding (Create and manage company posts). |
| **Hiring Manager**| **[Limited Recruitment View]** Has a focused view on specific job openings: Job Openings (View details of openings they are "watcher" on), Candidate Management (View and manage candidates for their assigned openings), Interviews (Can be added as an interviewer and can view/submit feedback). |
| **Interviewer**  | **[Interview Focus]** The most limited role: Candidate Details (View profile and resume for candidates they are scheduled to interview), Interview Feedback (RSVP to interview invites and submit their own feedback). |

### B. Professionals Hub Roles

| Role        | Permissions                                                                                                                                                                                                                                                        |
|-------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Free User**   | **[Standard Access]** Account (Full account and profile management without paid features), Job Seeking (Search, view, and apply for all job openings), Social (Follow users/companies, create limited posts, comment, vote), Incognito (Full access to the anonymous community forum). |
| **Silver User** | **[Enhanced Access]** Includes all Free User permissions, plus: AI-powered resume scoring against job descriptions.                                                                                                                                      |
| **Gold User**   | **[Premium Access]** Includes all Silver User permissions, plus: The ability to request, gather, and store initial onboarding documents (e.g., degree certificates, proof of previous employment) from a candidate after an offer has been accepted.             |

### C. Vetchium Admin Portal Roles

| Role                | Permissions                                                                                                                                                                                                                           |
|---------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Super Admin**     | **[Platform-Wide Full Control]** Can perform all administrative actions: User Management (Invite, block, and manage all users), Content Management (Full CRUD on VTags), Platform Settings (Manage regions and other global configurations). |
| **Content Moderator**| **[Content Focus]** Can manage user-generated content: Posts & Comments (View and delete any user-generated posts/comments), User Reporting (Review and act on user-reported content).                                                     |

### D. Recruitment Agency Portal Roles

| Role             | Permissions                                                                                                                                                                                                                                                        |
|------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Admin**        | **[Full Control]** Can perform all actions: User Management (Invite, update roles, disable/re-enable users), Agency Performance (View dashboard).                                                                                                   |
| **Recruiter**    | **[Recruitment Focus]** Can manage the full lifecycle of recruitment for assigned openings: Candidate Management (View, filter, and manage all candidates), Interviews (Schedule interviews and manage interviewers).                                               |


## Geographically Distributed System

The Vetchium platform operates as a single, globally distributed system. While there is only one Vetchium platform, its underlying infrastructure and data storage are spread across multiple geographic regions (e.g., European Union, India, North America) to ensure high performance and compliance with local data residency regulations.

### Data Residency and Constraints

To meet regulatory requirements, data is stored in a "Home Region" assigned to the entity that owns the data.

- **Hub User Data**: All core data for a Hub User (including their Posts, Comments, and Profile) is stored in the Home Region selected during their account creation. Users can request to migrate their profile and data to another region, subject to platform policies.
- **Organization Data**: An Employer's presence on the platform consists of a single top-level Organization and an optional hierarchy of Sub-Organizations.
    - Each entity (the top-level Organization and each Sub-Organization) must have a "Home Region" assigned to it at the time of its creation. This selection is permanent and cannot be changed.
    - Data created for a specific entity is stored in its designated Home Region. For example, a job opening created for "Acme Gmbh" (a sub-organization with its Home Region in the EU) will have its data stored in the EU region, even if the parent organization's Home Region is in Singapore.
    - While data storage is regional, it is accessible globally to all authorized users of the platform, subject to their permissions.
- **Platform-Wide Unique Identifiers**: To ensure a seamless global user experience, the following must be unique across the entire platform, regardless of region:
    - Organization domain names (associated with the top-level Organization)
    - Hub User handles
    - Hub User email addresses

## API Guidelines
- All APIs should take JSON encoded request bodies and response bodies
- Path parameters and URL parameters should be minimized
- All endpoints should be protected with Authentication and Authorization checks. Endpoints that should not be protected (Like for example, Login, Forgot Password, etc.) need to be called out as Unprotected.
- All top-level APIs which returns a list of items should support pagination. There must be support for a Limit field, an explicit mention of the Sorting Order (Ascending or Descending), Some kind of Offset field to indicate the fetching boundary.
- All fields in the request bodies should have limits on length, validation checks
- In case of errors, the API responses should clearly convey which of the request fields are failing or causing an error in case of HTTP 400 errors. The way in which the errors should be parsed to understand the cause of the error for validation failures should be standardized.

### TODOs and Open Questions
- **Pagination Strategy**: The current specification suggests offset-based pagination. We need to evaluate and consider recommending **cursor-based pagination** (using a `next_page_token` or similar). This approach is generally more performant and robust for real-time systems and avoids issues with data shifting between pages.