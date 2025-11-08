# Vetchium: Product Requirements Document

**Title:** Vetchium: A Federated Global Talent Platform  
**Version:** 1.0  
**Date:** 2025-11-08  
**Status:** Draft  
**Author:** Gemini

---

## 1. Vision & Opportunity

### 1.1. The Problem

The global talent market is fundamentally broken. It operates on a patchwork of disconnected systems, creating significant friction for all participants:

*   **Employers** struggle to hire efficiently across different geographies, facing a maze of data residency laws (like GDPR), inconsistent workflows, and a lack of unified visibility into their talent pipelines.
*   **Professionals (Candidates)** endure an opaque, frustrating, and often demoralizing job search process. They lack transparency into their application status, have limited direct communication with hiring teams, and must manage profiles across countless disconnected platforms.
*   **Recruitment Agencies** lack integrated tools to collaborate effectively with employers, forcing them to rely on email and spreadsheets, which hinders productivity and performance tracking.

This fragmentation leads to immense wasted time, lost opportunities, and a poor experience for everyone involved.

### 1.2. The Solution: Vetchium

Vetchium is a **globally distributed, federated talent platform** designed from the ground up to solve these challenges. It provides a single, seamless interface for employers, professionals, and recruitment agencies while ensuring data is stored locally in compliance with regional regulations.

Our core innovation is a **federated architecture** that separates the application's logic from data storage. This allows a user in any region to interact with job openings or candidates in any other region as if they were on a single, unified platform, all while their personal data remains in their home region.

### 1.3. Mission

To build the world's most trusted and transparent talent ecosystem, connecting opportunity with talent seamlessly and securely across the globe.

---

## 2. Core Principles

*   **Federated by Design:** Our architecture is built to scale globally while respecting data sovereignty. Data is stored in the user's or organization's home region, ensuring compliance and high performance, without sacrificing a unified user experience.
*   **Trust Through Verification:** We establish legitimacy from the very first step. Employers onboard by verifying domain ownership, and professionals sign up with verified work emails, creating a high-trust network.
*   **Radical Transparency for Candidates:** We empower professionals by giving them unprecedented visibility into their application status, direct lines of communication with recruiters, and a clear understanding of the hiring process.
*   **Powerful Customization for Employers:** We recognize that no two companies hire alike. Vetchium provides fully customizable recruitment pipelines, rejection reasons, and role-based access control to fit any organization's workflow.
*   **A Unified Ecosystem:** We bring all stakeholders—employers, professionals, and agencies—onto a single platform, fostering direct collaboration and eliminating the inefficiencies of disconnected systems.

---

## 3. The Vetchium Experience: Platform Portals

Vetchium consists of four distinct but interconnected portals tailored to the needs of each user group.

### 3.1. Employer Portal
The command center for corporate recruitment.
*   **Secure Onboarding:** Domain-first verification ensures only legitimate company representatives can create and manage accounts.
*   **Custom Workflows:** Define bespoke recruitment pipelines, rejection reasons, and screening questions for each job opening.
*   **Collaborative Hiring:** Facilitate internal discussions, schedule interviews, and gather feedback in a single, centralized place.
*   **Unified Candidate View:** Manage applications and view candidate profiles across all company job openings, regardless of region.
*   **Agency Management:** Seamlessly integrate with and assign openings to partner recruitment agencies.

### 3.2. Professionals Hub
The career development and job-seeking platform for individuals.
*   **Verified Profiles:** Build a rich professional profile, verified through work email addresses, to showcase skills and experience.
*   **Transparent Job Applications:** Apply for jobs and track application status in real-time, from "Applied" to "Hired."
*   **Direct Communication:** Engage in two-way conversations with the hiring team directly within the application thread.
*   **Professional Networking:** Follow companies and other professionals, share insights through posts, and build a network of colleagues.
*   **Anonymous Community:** Participate in candid discussions about workplace topics in a safe, anonymous forum.

### 3.3. Recruitment Agency Portal
A dedicated workspace for recruitment partners to collaborate with employers.
*   **Centralized Job Orders:** View and manage all job openings assigned by employer partners in one dashboard.
*   **Efficient Sourcing:** Source candidates from the Professionals Hub and submit them for consideration.
*   **Performance Analytics:** Track key metrics like candidate progression and time-to-fill to demonstrate value.
*   **Internal Collaboration:** Add private, agency-only notes to candidate profiles to streamline internal assessments.

### 3.4. Vetchium Admin Portal
The central nervous system for platform governance.
*   **Global Management:** Vetchium administrators manage users, platform-wide skill tags (VTags), and allowed signup domains.
*   **Region Configuration:** Define and manage the geographic regions the platform operates in, ensuring compliance with data residency policies.
*   **Content Moderation:** Oversee user-generated content to maintain a professional and safe environment.

---

## 4. System Architecture & Federated Design

Vetchium's key technical differentiator is its federated architecture, which enables a global experience while enforcing local data residency.

### 4.1. Global vs. Regional Databases

*   **Global Database:** A single, central database stores non-sensitive, shared data required for global operations. This includes the list of active regions, platform-wide settings, and SHA-256 digests of user emails for de-duplication and routing purposes. No PII is stored here.
*   **Regional Databases:** Each geographic region (e.g., EU, US-East, IN) has its own independent PostgreSQL database instance. These databases store all sensitive and operational data for users and organizations homed in that region, including profiles, applications, and job openings.

### 4.2. Data Sovereignty & User Experience

*   **Data Residency:** All PII and core entity data is stored in the "home region" of the data owner (the professional or the organization).
*   **Seamless Access:** A user in one region can apply for a job hosted in another. The `Application` record is created in the job's region, but an `Application Index` record is created in the user's home region. This allows the user to view all their applications from their home database, which then fetches detailed data from the appropriate region on demand.
*   **Global Uniqueness:** Critical identifiers like Hub User handles, emails, and employer domains are guaranteed to be unique across the entire platform, enforced via the global database.

### 4.3. Identity & Security

*   **Immutable Global ID:** Each Hub User is assigned a `hub_user_global_id` (UUID) that remains constant, even if they migrate their home region. This allows for consistent tracking and linking of their activity across the distributed system.
*   **Privacy-Preserving Lookups:** By storing only SHA-256 digests of emails in the global database, we can prevent duplicate accounts and route users to their correct home region upon login without exposing PII globally.

---

## 5. Key Workflows & Features

### 5.1. The Application Lifecycle: A Transparent Journey

Vetchium provides a clear, state-driven model for the entire application process, visible to both employers and candidates.

| State | Description |
| :--- | :--- |
| **Applied** | A new, unreviewed application. The entry point for all candidates. |
| **Interviewing** | The candidate is actively engaged in any form of interview. |
| **Offer-Extended** | An official offer has been sent to the candidate. |
| **Offer-Accepted** | The candidate has formally accepted the job offer. |
| **Onboarding** | Post-acceptance administrative phase (background checks, etc.). |
| **Hired** | The candidate has successfully completed onboarding. |
| **Resume-Rejected** | Rejected based on the initial application. |
| **Interview-Rejected** | Rejected after one or more interviews. |
| **Offer-Rejected** | The candidate declined the offer. |
| **Offer-Rescinded** | The employer withdrew the offer during onboarding. |
| **Withdrawn** | The candidate voluntarily withdrew their application. |

### 5.2. Communication Threads

Each candidacy features two distinct communication channels to streamline interactions:

*   **Internal Discussion:** A private thread for the hiring team (Recruiter, Hiring Manager, Interviewers) to discuss the candidate, share feedback, and coordinate.
*   **Candidate Chat:** A direct, two-way messaging thread between the hiring team and the candidate for updates, scheduling, and questions.

---

## 6. Success Metrics

The success of Vetchium will be measured by its ability to create a vibrant and efficient talent ecosystem.

*   **Platform Growth:**
    *   Number of active Professionals, Employers, and Agencies.
    *   Number of active job openings.
*   **Hiring Efficiency:**
    *   Average time-to-fill for job openings.
    *   Offer acceptance rate.
*   **Candidate Experience:**
    *   Candidate satisfaction score (measured via in-platform surveys).
    *   Percentage of applications that receive a terminal status (i.e., are not left in limbo).
*   **Engagement:**
    *   Daily/Monthly Active Users (DAU/MAU) for each portal.
    *   Content creation and interaction in the Professionals Hub.

---

## 7. Future Vision

While Version 1.0 lays the foundation, Vetchium is poised for significant evolution:

*   **AI-Powered Matching:** Develop sophisticated models to score and rank candidates against job descriptions, and recommend relevant opportunities to professionals.
*   **Advanced Analytics:** Provide employers with deep insights into their hiring funnels, diversity metrics, and market benchmarks.
*   **Deeper Integrations:** Integrate with HRIS, calendar, and background check systems to create a truly end-to-end hiring workflow.
*   **Skills-Based Economy:** Move beyond resumes to a VTag-driven model where verified skills become the primary currency of the talent market.
