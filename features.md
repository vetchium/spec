# Vetchium Platform Features by Portal

This document outlines the features for each portal and the roles required to perform them.

## 1. EmployerPortal

Possible Tiers: None

| Feature                                               | Tier | Needed Role(s)                               |
|-------------------------------------------------------|------|----------------------------------------------|
| **Account & Access**                                  |      |                                              |
| Sign-in to an existing organization                   |      | Any Authenticated User                       |
| Onboard a new organization via DNS verification       |      | Initial Administrator                        |
| Change own password                                   |      | Any Authenticated User                       |
| Invite new users to the organization                  |      | Admin                                        |
| Update roles and permissions of existing users        |      | Admin                                        |
| Disable or re-enable user accounts                    |      | Admin                                        |
| View and filter a list of all organization users      |      | Admin                                        |
| Add and manage multiple company domains               |      | Admin                                        |
| **Company Profile**                                   |      |                                              |
| Manage internal cost centers (CRUD)                   |      | Admin                                        |
| Manage company office locations (CRUD)                |      | Admin                                        |
| **Recruitment Workflow**                              |      |                                              |
| Create and manage a library of custom pipeline stages |      | Admin                                        |
| Create and manage a library of rejection reasons      |      | Admin                                        |
| Create and update job openings                        |      | Admin, Recruiter                             |
| View list of all job openings                         |      | Admin, Recruiter, Hiring Manager             |
| Change the status of an opening                       |      | Admin, Recruiter                             |
| Manage "watchers" for an opening                      |      | Admin, Recruiter                             |
| Assign skill tags (VTags) to openings                 |      | Admin, Recruiter                             |
| Add, edit, or remove questions for an opening         |      | Admin, Recruiter                             |
| View applicant responses to questions                 |      | Admin, Recruiter, Hiring Manager             |
| View list of candidates for an opening                |      | Admin, Recruiter, Hiring Manager             |
| View a candidate's resume and profile                 |      | Admin, Recruiter, Hiring Manager, Interviewer|
| Move candidates through pipeline stages               |      | Admin, Recruiter, Hiring Manager             |
| Organize applications using color tags                |      | Admin, Recruiter, Hiring Manager             |
| Use internal discussion thread on a candidacy         |      | Admin, Recruiter, Hiring Manager, Interviewer|
| Use candidate chat thread                             |      | Recruiter, Hiring Manager                    |
| Make an official job offer to a candidate             |      | Admin, Recruiter                             |
| Schedule interviews for a candidate                   |      | Admin, Recruiter                             |
| Add or remove interviewers for a scheduled event      |      | Admin, Recruiter                             |
| RSVP to interview invitations                         |      | Interviewer                                  |
| View all scheduled interviews                         |      | Admin, Recruiter, Hiring Manager, Interviewer|
| Submit interview feedback/assessment                  |      | Interviewer                                  |
| View interview feedback for a candidate               |      | Admin, Recruiter, Hiring Manager             |
| **Branding & Communication**                          |      |                                              |
| Create, update, and delete company posts              |      | Admin, Recruiter                             |
| **Agency Management**                                 |      |                                              |
| Add and remove Recruitment Agencies                   |      | Admin                                        |
| Assign a Recruiter to a job opening                   |      | Admin, Recruiter                             |
| Change the assigned Recruiter for an opening          |      | Admin, Recruiter                             |

## 2. HubPortal

Possible Tiers: Free, Silver, Gold

| Feature                                               | Tier                          | Needed Role(s)                               |
|-------------------------------------------------------|-------------------------------|----------------------------------------------|
| **Account & Profile**                                 |                               |                                              |
| Sign up and authenticate                              |                               | Any User                                     |
| Change handle (username)                              | Silver, Gold                  | User                                         |
| Write a professional bio                              |                               | Any User                                     |
| Upload a profile picture                              | Silver, Gold                  | User                                         |
| Manage work history, education, and achievements      |                               | Any User                                     |
| Add and verify multiple official email addresses      |                               | Any User                                     |
| **Job Seeking**                                       |                               |                                              |
| Search, filter, and view job openings                 |                               | Any User                                     |
| Apply for an open position                            |                               | Any User                                     |
| View past applications and withdraw an application    |                               | Any User                                     |
| Track candidacy stage and chat with hiring team       |                               | Any User (as Applicant)                      |
| View and RSVP to interview invitations                |                               | Any User (as Applicant)                      |
| AI-powered resume scoring against job descriptions    | Silver, Gold                  | User                                         |
| Request and store onboarding documents post-offer     | Gold                          | User                                         |
| **Networking & Social**                               |                               |                                              |
| View profiles of other users and companies            |                               | Any User                                     |
| Follow/unfollow other users and companies             |                               | Any User                                     |
| Create posts                                          | Free (Limited), Silver, Gold  | User                                         |
| Interact with posts (upvote, downvote, comment)       |                               | Any User                                     |
| Manage comments on own posts                          |                               | Any User                                     |
| Delete own posts or comments                          |                               | Any User                                     |
| **Anonymous Community Forum**                         |                               |                                              |
| Create, view, and delete anonymous posts/comments     |                               | Any User                                     |
| Anonymously vote on posts and comments                |                               | Any User                                     |
| **Colleague Connections**                             |                               |                                              |
| Send, accept, or reject colleague requests            |                               | Any User                                     |
| Remove a colleague                                    |                               | Any User                                     |
| Endorse a colleague for a job application             |                               | Any User (to a Colleague)                    |
| **Safety & Moderation**                               |                               |                                              |
| Block and unblock another Hub User                    |                               | Any User                                     |

## 3. AgencyPortal

Possible Tiers: Silver, Gold

| Feature                                               | Tier           | Needed Role(s)                               |
|-------------------------------------------------------|----------------|----------------------------------------------|
| **Account & Access**                                  |                |                                              |
| Onboard and authenticate                              |                | Any Agency User                              |
| Change own password                                   |                | Any Agency User                              |
| Invite new users to the agency                        |                | Admin                                        |
| Update roles and permissions of existing users        |                | Admin                                        |
| Disable or re-enable user accounts                    |                | Admin                                        |
| View and filter a list of all agency users            |                | Admin                                        |
| **Performance**                                       |                |                                              |
| View agency performance dashboard (KPIs)              |                | Admin, Recruiter                             |
| **Recruitment Workflow**                              |                |                                              |
| View assigned job openings                            |                | Recruiter                                    |
| Source candidates from the Professionals Hub          |                | Recruiter                                    |
| Submit candidates for an opening                      |                | Recruiter                                    |
| View status of submitted candidates                   |                | Recruiter                                    |
| Schedule interviews and coordinate with candidates    |                | Recruiter                                    |
| Add private notes on a candidacy (agency-visible)     |                | Recruiter                                    |
| **Intelligence**                                      |                |                                              |
| Add private notes to any Hub User's profile           | Silver+        | Recruiter                                    |
| Use AI-powered search to find candidates              | Gold           | Recruiter                                    |

## 4. AdminPortal

Possible Tiers: None

| Feature                                               | Tier | Needed Role(s)                               |
|-------------------------------------------------------|------|----------------------------------------------|
| **User Management**                                   |      |                                              |
| Invite new Employer or Hub users                      |      | Super Admin                                  |
| Block, unblock, disable, or re-enable any user account|      | Super Admin                                  |
| View and filter a list of all users on the platform   |      | Super Admin                                  |
| **Platform Data & Content**                           |      |                                              |
| Manage allowed/denied domains for Hub User signup     |      | Super Admin                                  |
| Manage skill tags (VTags) (CRUD)                      |      | Super Admin                                  |
| View and delete any user-generated post or comment    |      | Content Moderator                            |
| Review and act on user-reported content               |      | Content Moderator                            |
| **Platform Configuration**                            |      |                                              |
| Manage geographic regions and data residency policies |      | Super Admin                                  |
