# Vetchium Platform Features by Portal

The Vetchium platform consists of four main front-ends:

- **Employer Portal**: The Employer Portal is the interface for company representatives to manage their organization's presence, recruitment processes, and user access on the Vetchium platform.
- **Professionals Hub**: The Professionals Hub is the social and career-oriented platform for individual professionals (Hub Users). It allows them to build a profile, find jobs, network, and discuss industry topics.
- **Recruitment Agency Portal**: The Recruitment Agency Portal is the interface for recruitment agencies to manage their users, track their performance, and carry out recruitment tasks on behalf of employers.
- **Vetchium Admin Portal**: The Vetchium Admin Portal is the interface for Vetchium administrators to manage the platform's core data, users, and settings.

This document outlines the features for each portal, the roles required, the associated tier, and the development sprint.

## 1. Employer Portal

| Feature                                               | Needed Role(s)                               | Tier | Sprint |
|-------------------------------------------------------|----------------------------------------------|------|--------|
| **Account & Access**                                  |                                              |      |        |
| Sign-in to an existing organization                   | Any Authenticated User                       | Core | 1      |
| Forgot Password                                       | Any User                                     | Core | 1      |
| Onboard a new organization via DNS verification       | Admin                                        | Core | 1      |
| Change own password                                   | Any Authenticated User                       | Core | 1      |
| Invite new users to the organization                  | Admin                                        | Core | 2      |
| Update roles and permissions of existing users        | Admin                                        | Core | 2      |
| Disable or re-enable user accounts                    | Admin                                        | Core | 2      |
| View and filter a list of all organization users      | Admin                                        | Core | 2      |
| Add and manage multiple company domains               | Admin                                        | Core | 9      |
| **Dashboard & Reporting**                             |                                              |      |        |
| View dashboard with key metrics                       | Admin, Recruiter, Hiring Manager             | Core | 3      |
| Export candidate data and reports                     | Admin, Recruiter                             | Core | 10     |
| **Company Profile**                                   |                                              |      |        |
| Manage company branding (logo, banner)                | Admin                                        | Core | 9      |
| Manage internal cost centers (CRUD)                   | Admin                                        | Core | 9      |
| Manage company office locations (CRUD)                | Admin                                        | Core | 9      |
| **Recruitment Workflow**                              |                                              |      |        |
| Create and manage job templates                       | Admin, Recruiter                             | Core | 4      |
| Create and manage a library of custom pipeline stages | Admin                                        | Core | 6      |
| Create and manage a library of rejection reasons      | Admin                                        | Core | 6      |
| Create and update job openings                        | Admin, Recruiter                             | Core | 2      |
| View list of all job openings                         | Admin, Recruiter, Hiring Manager             | Core | 2      |
| Change the status of an opening                       | Admin, Recruiter                             | Core | 2      |
| Manage "watchers" for an opening                      | Admin, Recruiter                             | Core | 4      |
| Assign skill tags (VTags) to openings                 | Admin, Recruiter                             | Core | 4      |
| Add, edit, or remove questions for an opening         | Admin, Recruiter                             | Core | 4      |
| View applicant responses to questions                 | Admin, Recruiter, Hiring Manager             | Core | 4      |
| View list of candidates for an opening                | Admin, Recruiter, Hiring Manager             | Core | 2      |
| View a candidate's resume and profile                 | Admin, Recruiter, Hiring Manager, Interviewer| Core | 2      |
| Move candidates through pipeline stages               | Admin, Recruiter, Hiring Manager             | Core | 2      |
| Bulk actions on candidates (e.g., bulk reject)        | Admin, Recruiter, Hiring Manager             | Core | 6      |
| Organize applications using color tags                | Admin, Recruiter, Hiring Manager             | Core | 6      |
| Use internal discussion thread on a candidacy         | Admin, Recruiter, Hiring Manager, Interviewer| Core | 2      |
| Use candidate chat thread                             | Recruiter, Hiring Manager                    | Core | 6      |
| Make an official job offer to a candidate             | Admin, Recruiter                             | Core | 6      |
| **Scheduling & Interviews**                           |                                              |      |        |
| Integrate with Google/Outlook calendars               | Admin, Recruiter                             | Core | 7      |
| Schedule interviews for a candidate                   | Admin, Recruiter                             | Core | 7      |
| Add or remove interviewers for a scheduled event      | Admin, Recruiter                             | Core | 7      |
| RSVP to interview invitations                         | Interviewer                                  | Core | 7      |
| View all scheduled interviews                         | Admin, Recruiter, Hiring Manager, Interviewer| Core | 7      |
| Submit interview feedback/assessment                  | Interviewer                                  | Core | 7      |
| View interview feedback for a candidate               | Admin, Recruiter, Hiring Manager             | Core | 7      |
| **Branding & Communication**                          |                                              |      |        |
| Create, update, and delete company posts              | Admin, Recruiter                             | Core | 5      |
| **Agency Management**                                 |                                              |      |        |
| Add and remove Recruitment Agencies                   | Admin                                        | Core | 4      |
| Assign a Recruiter to a job opening                   | Admin, Recruiter                             | Core | 4      |
| Change the assigned Recruiter for an opening          | Admin, Recruiter                             | Core | 4      |
| **Notifications**                                     |                                              |      |        |
| Receive in-app and email notifications                | Any Authenticated User                       | Core | 10     |

## 2. Professionals Hub

| Feature                                               | Needed Role(s)                               | Tier       | Sprint |
|-------------------------------------------------------|----------------------------------------------|------------|--------|
| **Account & Profile**                                 |                                              |            |        |
| Sign up and authenticate                              | Any User                                     | Free       | 1      |
| Forgot Password                                       | Any User                                     | Free       | 1      |
| Change own password                                   | User                                         | Free       | 1      |
| Change handle (username)                              | User                                         | Premium    | 8      |
| Write a professional bio                              | User                                         | Free       | 1      |
| Upload a profile picture                              | User                                         | Free       | 1      |
| Manage work history, education, and achievements      | User                                         | Free       | 9      |
| Add and verify multiple official email addresses      | User                                         | Free       | 9      |
| Manage profile privacy settings                       | User                                         | Free       | 9      |
| See who viewed your profile                           | User                                         | Premium+   | 8      |
| **Job Seeking**                                       |                                              |            |        |
| Search, filter, and view job openings                 | Any User                                     | Free       | 3      |
| Create and manage job alerts                          | User                                         | Free       | 3      |
| Save jobs to a list                                   | User                                         | Free       | 3      |
| Apply for an open position                            | User                                         | Free       | 3      |
| View past applications and withdraw an application    | User                                         | Free       | 3      |
| Track candidacy stage and chat with hiring team       | User (as Applicant)                          | Free       | 3      |
| View and RSVP to interview invitations                | User (as Applicant)                          | Free       | 7      |
| AI-powered resume scoring against job descriptions    | User                                         | Premium    | 8      |
| Request and store onboarding documents post-offer     | User                                         | Premium+   | 8      |
| **Networking & Social**                               |                                              |            |        |
| View profiles of other users and companies            | Any User                                     | Free       | 5      |
| Follow/unfollow other users and companies             | User                                         | Free       | 5      |
| Create posts                                          | User                                         | Free       | 5      |
| Interact with posts (upvote, downvote, comment)       | Any User                                     | Free       | 5      |
| Manage comments on own posts                          | User                                         | Free       | 5      |
| Delete own posts or comments                          | User                                         | Free       | 5      |
| Direct message another user                           | User                                         | Premium    | 10     |
| **Anonymous Community Forum**                         |                                              |            |        |
| Create, view, and delete anonymous posts/comments     | Any User                                     | Free       | 5      |
| Anonymously vote on posts and comments                | Any User                                     | Free       | 5      |
| **Colleague Connections**                             |                                              |            |        |
| Send, accept, or reject colleague requests            | User                                         | Free       | 9      |
| Remove a colleague                                    | User                                         | Free       | 9      |
| Endorse a colleague for a job application             | User (to a Colleague)                        | Free       | 9      |
| **Safety & Moderation**                               |                                              |            |        |
| Block and unblock another Hub User                    | User                                         | Free       | 11     |
| Report a user, post, or job opening                   | User                                         | Free       | 11     |
| **Notifications**                                     |                                              |            |        |
| Receive in-app and email notifications                | User                                         | Free       | 10     |

## 3. Recruitment Agency Portal

| Feature                                               | Needed Role(s)                               | Tier       | Sprint |
|-------------------------------------------------------|----------------------------------------------|------------|--------|
| **Account & Access**                                  |                                              |            |        |
| Onboard and authenticate                              | Any Agency User                              | Standard   | 1      |
| Forgot Password                                       | Any Agency User                              | Standard   | 1      |
| Change own password                                   | Any Agency User                              | Standard   | 1      |
| Invite new users to the agency                        | Admin                                        | Standard   | 2      |
| Update roles and permissions of existing users        | Admin                                        | Standard   | 2      |
| Disable or re-enable user accounts                    | Admin                                        | Standard   | 2      |
| View and filter a list of all agency users            | Admin                                        | Standard   | 2      |
| **Performance & Reporting**                           |                                              |            |        |
| View agency performance dashboard (KPIs)              | Admin, Recruiter                             | Standard   | 3      |
| Generate and export client reports                    | Admin, Recruiter                             | Enterprise | 10     |
| **Recruitment Workflow**                              |                                              |            |        |
| View assigned job openings                            | Recruiter                                    | Standard   | 4      |
| View candidate pipeline for each job                  | Recruiter                                    | Standard   | 4      |
| Source candidates from the Professionals Hub          | Recruiter                                    | Standard   | 4      |
| Submit candidates for an opening                      | Recruiter                                    | Standard   | 4      |
| View status of submitted candidates                   | Recruiter                                    | Standard   | 4      |
| Schedule interviews and coordinate with candidates    | Recruiter                                    | Standard   | 7      |
| Add private notes on a candidacy (agency-visible)     | Recruiter                                    | Standard   | 4      |
| **Intelligence**                                      |                                              |            |        |
| Add private notes to any Hub User's profile           | Recruiter                                    | Standard   | 8      |
| Use AI-powered search to find candidates              | Recruiter                                    | Enterprise | 8      |
| **Notifications**                                     |                                              |            |        |
| Receive in-app and email notifications                | Any Agency User                              | Standard   | 10     |

## 4. Vetchium Admin Portal

| Feature                                               | Needed Role(s)                               | Tier | Sprint |
|-------------------------------------------------------|----------------------------------------------|------|--------|
| **Dashboard & Analytics**                             |                                              |      |        |
| View platform analytics dashboard                     | Super Admin                                  | N/A  | 3      |
| **User Management**                                   |                                              |      |        |
| Invite new Employer or Hub users                      | Super Admin                                  | N/A  | 1      |
| Block, unblock, disable, or re-enable any user account| Super Admin                                  | N/A  | 1      |
| View and filter a list of all users on the platform   | Super Admin                                  | N/A  | 1      |
| **Platform Data & Content**                           |                                              |      |        |
| Manage allowed/denied domains for Hub User signup     | Super Admin                                  | N/A  | 11     |
| Manage skill tags (VTags) (CRUD)                      | Super Admin                                  | N/A  | 11     |
| View and delete any user-generated post or comment    | Content Moderator                            | N/A  | 11     |
| Review and act on user-reported content               | Content Moderator                            | N/A  | 11     |
| **Platform Configuration**                            |                                              |      |        |
| Manage geographic regions and data residency policies | Super Admin                                  | N/A  | 11     |
| Manage subscription plans and tiers                   | Super Admin                                  | N/A  | 8      |
| Manage email templates                                | Super Admin                                  | N/A  | 10     |
| Broadcast system announcements                        | Super Admin                                  | N/A  | 10     |

# Sprints

This section provides a high-level overview of the features planned for each sprint.

### Sprint 1: Core Authentication & Account MVP
- **Goal:** Establish the foundational authentication and account management for all portals.
- **Features:** User Sign-up/Onboarding, Sign-in, Forgot Password, Change Password, Basic Profile (Bio/Picture), Admin ability to manage users.

### Sprint 2: Employer & Agency - User Management & Basic Job Workflow
- **Goal:** Enable employers and agencies to manage their teams and basic job openings.
- **Features:** Invite/manage organization users, Create/view job openings, View candidate lists and profiles, Move candidates in a basic pipeline, Internal discussion threads.

### Sprint 3: Hub & Agency - Job Discovery & Dashboards
- **Goal:** Allow professionals to find and apply for jobs, and provide basic dashboards.
- **Features:** Search/filter jobs, Job alerts, Saved jobs, Apply to job, Track application status, Employer & Agency dashboards.

### Sprint 4: Core Recruitment Workflow (Employer & Agency)
- **Goal:** Build out the main recruitment workflow for employers and agencies.
- **Features:** Job templates, Assigning VTags, Custom questions, Agency candidate submission, Agency pipeline view, Agency private notes.

### Sprint 5: Hub Social & Community Features
- **Goal:** Launch the social networking and community aspects of the Professionals Hub.
- **Features:** User/company profiles, Follow/unfollow, Create/interact with posts (upvote, comment), Anonymous forum.

### Sprint 6: Advanced Recruitment Features
- **Goal:** Enhance the recruitment workflow with more advanced tools.
- **Features:** Custom pipeline stages, Rejection reasons, Bulk actions on candidates, Color tags, Candidate chat, Make official offer.

### Sprint 7: Scheduling & Interviews
- **Goal:** Integrate scheduling and streamline the interview process.
- **Features:** Calendar integration, Interview scheduling, Interviewer management, RSVPs, Feedback submission and viewing.

### Sprint 8: Monetization & Premium Features
- **Goal:** Implement the billing system and roll out the first set of paid features.
- **Features:** Admin management of tiers, AI resume scoring, AI candidate search, "Who viewed my profile", Store onboarding documents, Change handle.

### Sprint 9: Profile & Onboarding Enhancement
- **Goal:** Deepen the profile capabilities for users and companies.
- **Features:** Detailed work/education history, Profile privacy, Colleague connections & endorsements, Company branding, locations, and cost centers.

### Sprint 10: Notifications & Communication
- **Goal:** Implement a comprehensive notification system and enhance communication tools.
- **Features:** In-app and email notifications for all portals, Hub direct messaging, Admin announcement system, Exportable reports.

### Sprint 11: Platform Integrity & Moderation
- **Goal:** Build tools for platform safety, content moderation, and administration.
- **Features:** User/content reporting, Blocking users, Admin content moderation tools, Manage VTags, Manage domains, Data residency policies.
