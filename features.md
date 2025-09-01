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
| Onboard a new organization via DNS verification       | Admin                                        | Core | 3      |
| Change own password                                   | Any Authenticated User                       | Core | 1      |
| Invite new users to the organization                  | Admin                                        | Core | 3      |
| Update roles and permissions of existing users        | Admin                                        | Core | 3      |
| Disable or re-enable user accounts                    | Admin                                        | Core | 3      |
| View and filter a list of all organization users      | Admin                                        | Core | 3      |
| Add and manage multiple company domains               | Admin                                        | Core | 9      |
| **Dashboard & Reporting**                             |                                              |      |        |
| View dashboard with key metrics                       | Admin, Recruiter, Hiring Manager             | Core | 3      |
| Export candidate data and reports                     | Admin, Recruiter                             | Core | 11     |
| **Company Profile**                                   |                                              |      |        |
| Manage company branding (logo, banner)                | Admin                                        | Core | 9      |
| Manage internal cost centers (CRUD)                   | Admin                                        | Core | 9      |
| Manage company office locations (CRUD)                | Admin                                        | Core | 9      |
| **Recruitment Workflow**                              |                                              |      |        |
| Create and manage job templates                       | Admin, Recruiter                             | Core | 6      |
| Create and manage a library of custom pipeline stages | Admin                                        | Core | 4      |
| Create and manage a library of rejection reasons      | Admin                                        | Core | 6      |
| Create and update job openings                        | Admin, Recruiter                             | Core | 3      |
| View list of all job openings                         | Admin, Recruiter, Hiring Manager             | Core | 3      |
| Change the status of an opening                       | Admin, Recruiter                             | Core | 3      |
| Manage "watchers" for an opening                      | Admin, Recruiter                             | Core | 6      |
| Assign skill tags (VTags) to openings                 | Admin, Recruiter                             | Core | 6      |
| Add, edit, or remove questions for an opening         | Admin, Recruiter                             | Core | 6      |
| View applicant responses to questions                 | Admin, Recruiter, Hiring Manager             | Core | 6      |
| View list of candidates for an opening                | Admin, Recruiter, Hiring Manager             | Core | 3      |
| View a candidate's resume and profile                 | Admin, Recruiter, Hiring Manager, Interviewer| Core | 3      |
| Move candidates through pipeline stages               | Admin, Recruiter, Hiring Manager             | Core | 4      |
| Bulk actions on candidates (e.g., bulk reject)        | Admin, Recruiter, Hiring Manager             | Core | 4      |
| Organize applications using color tags                | Admin, Recruiter, Hiring Manager             | Core | 4      |
| Use internal discussion thread on a candidacy         | Admin, Recruiter, Hiring Manager, Interviewer| Core | 3      |
| Use candidate chat thread                             | Recruiter, Hiring Manager                    | Core | 7      |
| Make an official job offer to a candidate             | Admin, Recruiter                             | Core | 7      |
| **Scheduling & Interviews**                           |                                              |      |        |
| Integrate with Google/Outlook calendars               | Admin, Recruiter                             | Core | 7      |
| Schedule interviews for a candidate                   | Admin, Recruiter                             | Core | 7      |
| Add or remove interviewers for a scheduled event      | Admin, Recruiter                             | Core | 7      |
| RSVP to interview invitations                         | Interviewer                                  | Core | 7      |
| View all scheduled interviews                         | Admin, Recruiter, Hiring Manager, Interviewer| Core | 7      |
| Submit interview feedback/assessment                  | Interviewer                                  | Core | 7      |
| View interview feedback for a candidate               | Admin, Recruiter, Hiring Manager             | Core | 7      |
| **Branding & Communication**                          |                                              |      |        |
| Create, update, and delete company posts              | Admin, Recruiter                             | Core | 8      |
| **Agency Management**                                 |                                              |      |        |
| Add and remove Recruitment Agencies                   | Admin                                        | Core | 6      |
| Assign a Recruiter to a job opening                   | Admin, Recruiter                             | Core | 6      |
| Change the assigned Recruiter for an opening          | Admin, Recruiter                             | Core | 6      |
| **Notifications**                                     |                                              |      |        |
| Receive in-app and email notifications                | Any Authenticated User                       | Core | 11     |

## 2. Professionals Hub

| Feature                                               | Needed Role(s)                               | Tier       | Sprint |
|-------------------------------------------------------|----------------------------------------------|------------|--------|
| **Account & Profile**                                 |                                              |            |        |
| Sign up and authenticate                              | Any User                                     | Free       | 1      |
| Forgot Password                                       | Any User                                     | Free       | 1      |
| Change own password                                   | User                                         | Free       | 1      |
| Change handle (username)                              | User                                         | Premium    | 10     |
| Write a professional bio                              | User                                         | Free       | 1      |
| Upload a profile picture                              | User                                         | Free       | 1      |
| Manage work history, education, and achievements      | User                                         | Free       | 2      |
| Add and verify multiple official email addresses      | User                                         | Free       | 2      |
| Manage profile privacy settings                       | User                                         | Free       | 2      |
| **Job Seeking**                                       |                                              |            |        |
| Search, filter, and view job openings                 | Any User                                     | Free       | 2      |
| Create and manage job alerts                          | User                                         | Free       | 2      |
| Save jobs to a list                                   | User                                         | Free       | 2      |
| Apply for an open position                            | User                                         | Free       | 2      |
| View past applications and withdraw an application    | User                                         | Free       | 2      |
| Track candidacy stage and chat with hiring team       | User (as Applicant)                          | Free       | 2      |
| View and RSVP to interview invitations                | User (as Applicant)                          | Free       | 7      |
| AI-powered resume scoring against job descriptions    | User                                         | Premium    | 10     |
| Request and store onboarding documents post-offer     | User                                         | Premium+   | 10     |
| **Networking & Social**                               |                                              |            |        |
| View profiles of other users and companies            | Any User                                     | Free       | 8      |
| Follow/unfollow other users and companies             | User                                         | Free       | 8      |
| Create posts                                          | User                                         | Free       | 8      |
| Interact with posts (upvote, downvote, comment)       | Any User                                     | Free       | 8      |
| Manage comments on own posts                          | User                                         | Free       | 8      |
| Delete own posts or comments                          | User                                         | Free       | 8      |
| Direct message another user                           | User                                         | Premium    | 11     |
| **Anonymous Community Forum**                         |                                              |            |        |
| Create, view, and delete anonymous posts/comments     | Any User                                     | Free       | 8      |
| Anonymously vote on posts and comments                | Any User                                     | Free       | 8      |
| **Colleague Connections**                             |                                              |            |        |
| Send, accept, or reject colleague requests            | Any User                                     | Free       | 9      |
| Verify colleague status via work email                | Any User                                     | Free       | 9      |
| Remove a colleague                                    | Any User                                     | Free       | 9      |
| Endorse a colleague for a job application             | User (to a Colleague)                        | Free       | 9      |
| **Safety & Moderation**                               |                                              |            |        |
| Block and unblock another Hub User                    | User                                         | Free       | 12     |
| Report a user, post, or job opening                   | User                                         | Free       | 12     |
| **Notifications**                                     |                                              |            |        |
| Receive in-app and email notifications                | User                                         | Free       | 11     |

## 3. Recruitment Agency Portal

| Feature                                               | Needed Role(s)                               | Tier       | Sprint |
|-------------------------------------------------------|----------------------------------------------|------------|--------|
| **Account & Access**                                  |                                              |            |        |
| Onboard and authenticate                              | Any Agency User                              | Standard   | 1      |
| Forgot Password                                       | Any Agency User                              | Standard   | 1      |
| Change own password                                   | Any Agency User                              | Standard   | 1      |
| Invite new users to the agency                        | Admin                                        | Standard   | 5      |
| Update roles and permissions of existing users        | Admin                                        | Standard   | 5      |
| Disable or re-enable user accounts                    | Admin                                        | Standard   | 5      |
| View and filter a list of all agency users            | Admin                                        | Standard   | 5      |
| **Performance & Reporting**                           |                                              |            |        |
| View agency performance dashboard (KPIs)              | Admin, Recruiter                             | Standard   | 5      |
| Generate and export client reports                    | Admin, Recruiter                             | Enterprise | 11     |
| **Recruitment Workflow**                              |                                              |            |        |
| View assigned job openings                            | Recruiter                                    | Standard   | 5      |
| View candidate pipeline for each job                  | Recruiter                                    | Standard   | 4      |
| Source candidates from the Professionals Hub          | Recruiter                                    | Standard   | 5      |
| Submit candidates for an opening                      | Recruiter                                    | Standard   | 5      |
| View status of submitted candidates                   | Recruiter                                    | Standard   | 5      |
| Schedule interviews and coordinate with candidates    | Recruiter                                    | Standard   | 7      |
| Add private notes on a candidacy (agency-visible)     | Recruiter                                    | Standard   | 5      |
| **Intelligence**                                      |                                              |            |        |
| Add private notes to any Hub User's profile           | Recruiter                                    | Standard   | 10     |
| Use AI-powered search to find candidates              | Recruiter                                    | Enterprise | 10     |
| **Notifications**                                     |                                              |            |        |
| Receive in-app and email notifications                | Any Agency User                              | Standard   | 11     |

## 4. Vetchium Admin Portal

| Feature                                               | Needed Role(s)                               | Tier | Sprint |
|-------------------------------------------------------|----------------------------------------------|------|--------|
| **Dashboard & Analytics**                             |                                              |      |        |
| View platform analytics dashboard                     | Super Admin                                  | N/A  | 12     |
| **User Management**                                   |                                              |      |        |
| Invite new Employer or Hub users                      | Super Admin                                  | N/A  | 1      |
| Block, unblock, disable, or re-enable any user account| Super Admin                                  | N/A  | 1      |
| View and filter a list of all users on the platform   | Super Admin                                  | N/A  | 1      |
| **Platform Data & Content**                           |                                              |      |        |
| Manage allowed/denied domains for Hub User signup     | Super Admin                                  | N/A  | 12     |
| Manage skill tags (VTags) (CRUD)                      | Super Admin                                  | N/A  | 12     |
| View and delete any user-generated post or comment    | Content Moderator                            | N/A  | 12     |
| Review and act on user-reported content               | Content Moderator                            | N/A  | 12     |
| **Platform Configuration**                            |                                              |      |        |
| Manage geographic regions and data residency policies | Super Admin                                  | N/A  | 1      |
| Manage subscription plans and tiers                   | Super Admin                                  | N/A  | 10     |
| Manage email templates                                | Super Admin                                  | N/A  | 11     |
| Broadcast system announcements                        | Super Admin                                  | N/A  | 11     |

# Sprints

This section provides a high-level overview of the features planned for each sprint, reprioritized based on your feedback.

### Sprint 1: Core Platform Setup & Authentication
- **Goal:** Establish foundational authentication, user management, and core platform configuration.
- **Features:** User Sign-up/Onboarding (all portals), Sign-in, Forgot Password, Basic Profile (Bio/Pic), Admin User Management (Invite, Block, View), Data Residency Policy Management.

### Sprint 2: Professionals Hub - Profile & Job Seeking
- **Goal:** Build the core job-seeker experience, focusing on profile creation and job discovery/application.
- **Features:** Detailed Profile (Work History, Education), Privacy Settings, Job Search & Alerts, Saved Jobs, Job Application & Tracking.

### Sprint 3: Employer - Foundational Recruitment
- **Goal:** Enable employers to set up their organization, manage users, and handle basic job postings and candidate review.
- **Features:** Organization Onboarding, User & Role Management, Create/Manage Job Openings, View Candidate List & Profiles, Internal Discussion Threads, Basic Dashboard.

### Sprint 4: Pipeline Management
- **Goal:** Implement a robust and flexible candidate pipeline system for employers and agencies.
- **Features:** Custom Pipeline Stage Creation, Moving Candidates, Bulk Actions (e.g., Reject), Color Tagging, Agency Pipeline View.

### Sprint 5: Recruitment Agency - Core Workflow
- **Goal:** Equip recruitment agencies with the tools to manage their team, source candidates, and track performance.
- **Features:** Agency User Management, View Assigned Jobs, Source & Submit Candidates, View Candidate Status, Private Notes, Performance Dashboard.

### Sprint 6: Advanced Recruitment Configuration
- **Goal:** Provide employers with advanced tools to customize and streamline their recruitment process.
- **Features:** Job Templates, Custom Rejection Reasons, Job Watchers, VTag Assignment, Custom Application Questions, Agency Management.

### Sprint 7: Interviews, Scheduling & Offers
- **Goal:** Integrate scheduling, streamline the entire interview process, and enable job offers.
- **Features:** Calendar Integration, Interview Scheduling & RSVPs, Feedback Submission/Viewing, Candidate Chat, Make Official Offer.

### Sprint 8: Professionals Hub - Social & Community
- **Goal:** Launch the social networking and community aspects of the Professionals Hub.
- **Features:** View User/Company Profiles, Follow/Unfollow, Create & Interact with Posts, Anonymous Community Forum.

### Sprint 9: Colleague Connections & Company Branding
- **Goal:** Enable professional connections and enhance company branding capabilities.
- **Features:** Colleague Requests, Colleague Verification via Work Email, Endorsements, Company Profile/Branding Management.

### Sprint 10: Monetization & Premium Features
- **Goal:** Implement the billing system and roll out the first set of paid (Premium/Enterprise) features.
- **Features:** Admin Subscription Management, AI Resume Scoring, AI Candidate Search, Storing Onboarding Documents, Changing Handles.

### Sprint 11: Notifications & Advanced Reporting
- **Goal:** Implement a platform-wide notification system and advanced reporting capabilities.
- **Features:** In-App & Email Notifications, Admin Announcements & Email Templates, Exportable Reports for Employers & Agencies, Direct Messaging.

### Sprint 12: Platform Integrity & Administration
- **Goal:** Build tools for platform safety, content moderation, and final administrative functions.
- **Features:** User/Content Reporting, Blocking Users, Admin Moderation Tools, VTag Management, Domain Management, Platform Analytics Dashboard.