_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Bronze Layer Logical Data Model for Zoom Platform Analytics System following medallion architecture
## *Version*: 1
## *Updated on*: 
_____________________________________________

# Bronze Layer Logical Data Model for Zoom Platform Analytics System

## 1. PII Classification

| Column Name | Table Name | Reason for PII Classification |
|-------------|------------|------------------------------|
| EMAIL | Bz_USERS | Personal email address that uniquely identifies an individual user and can be used to contact them directly |
| USER_NAME | Bz_USERS | Full name of the user which is personally identifiable information that can identify a specific individual |
| USER_ID | Multiple Tables | User identifier that can be used to track and identify specific individuals across different systems and activities |
| PARTICIPANT_ID | Bz_PARTICIPANTS | Unique identifier for meeting participants that can be linked back to individual users |
| HOST_ID | Bz_MEETINGS, Bz_WEBINARS | Identifier for meeting/webinar hosts that references specific user identities |
| ASSIGNED_TO_USER_ID | Bz_LICENSES | User identifier in license assignments that can identify specific individuals |

## 2. Bronze Layer Logical Model

### Table: Bz_MEETINGS
**Description:** Contains meeting session data from the Zoom platform including timing, duration, and topic information

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| MEETING_TOPIC | TEXT | Subject or title of the meeting session |
| DURATION_MINUTES | NUMBER | Total length of the meeting in minutes |
| END_TIME | TIMESTAMP_NTZ | Scheduled or actual end time of the meeting |
| START_TIME | TIMESTAMP_NTZ | Scheduled or actual start time of the meeting |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when data was loaded into Bronze layer |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of last update in source system |
| SOURCE_SYSTEM | TEXT | Source system identifier |

### Table: Bz_LICENSES
**Description:** Contains license information and assignments for Zoom platform users

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| LICENSE_TYPE | TEXT | Type of Zoom license (Basic, Pro, Business, Enterprise) |
| END_DATE | DATE | License expiration date |
| START_DATE | DATE | License activation date |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when data was loaded into Bronze layer |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of last update in source system |
| SOURCE_SYSTEM | TEXT | Source system identifier |

### Table: Bz_SUPPORT_TICKETS
**Description:** Contains support ticket information for user issues and requests

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| RESOLUTION_STATUS | TEXT | Current status of ticket resolution (Open, In Progress, Resolved, Closed) |
| OPEN_DATE | DATE | Date when the support ticket was created |
| TICKET_TYPE | TEXT | Category or type of support issue |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when data was loaded into Bronze layer |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of last update in source system |
| SOURCE_SYSTEM | TEXT | Source system identifier |

### Table: Bz_USERS
**Description:** Contains user profile and account information for Zoom platform users

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| EMAIL | TEXT | User's primary email address (PII) |
| USER_NAME | TEXT | Full name of the user (PII) |
| PLAN_TYPE | TEXT | Zoom subscription plan type assigned to user |
| COMPANY | TEXT | Company or organization the user belongs to |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when data was loaded into Bronze layer |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of last update in source system |
| SOURCE_SYSTEM | TEXT | Source system identifier |

### Table: Bz_BILLING_EVENTS
**Description:** Contains billing and payment event information for Zoom services

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| AMOUNT | NUMBER | Monetary amount associated with the billing event |
| EVENT_TYPE | TEXT | Type of billing event (Charge, Refund, Credit, etc.) |
| EVENT_DATE | DATE | Date when the billing event occurred |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when data was loaded into Bronze layer |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of last update in source system |
| SOURCE_SYSTEM | TEXT | Source system identifier |

### Table: Bz_PARTICIPANTS
**Description:** Contains participant information for meeting attendees and their session details

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| JOIN_TIME | TIMESTAMP_NTZ | Time when participant joined the meeting |
| LEAVE_TIME | TIMESTAMP_NTZ | Time when participant left the meeting |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when data was loaded into Bronze layer |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of last update in source system |
| SOURCE_SYSTEM | TEXT | Source system identifier |

### Table: Bz_WEBINARS
**Description:** Contains webinar session information including timing and registration data

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| WEBINAR_TOPIC | TEXT | Subject or title of the webinar |
| START_TIME | TIMESTAMP_NTZ | Scheduled or actual start time of the webinar |
| END_TIME | TIMESTAMP_NTZ | Scheduled or actual end time of the webinar |
| REGISTRANTS | NUMBER | Total number of users registered for the webinar |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when data was loaded into Bronze layer |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of last update in source system |
| SOURCE_SYSTEM | TEXT | Source system identifier |

### Table: Bz_FEATURE_USAGE
**Description:** Contains usage statistics for various Zoom platform features during meetings

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| FEATURE_NAME | TEXT | Name of the Zoom feature used (Screen Share, Chat, Recording, etc.) |
| USAGE_DATE | DATE | Date when the feature was used |
| USAGE_COUNT | NUMBER | Number of times the feature was used in the session |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when data was loaded into Bronze layer |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of last update in source system |
| SOURCE_SYSTEM | TEXT | Source system identifier |

## 3. Audit Table Design

### Table: Bz_AUDIT_TABLE
**Description:** Tracks data processing and loading activities for all Bronze layer tables

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| record_id | TEXT | Unique identifier for the audit record |
| source_table | TEXT | Name of the source table from which data was ingested |
| load_timestamp | TIMESTAMP_NTZ | Timestamp when the record was loaded into Bronze layer |
| processed_by | TEXT | Identifier of the process, job, or user who processed the data |
| processing_time | NUMBER | Time taken to process the record in seconds |
| status | TEXT | Processing status (Success, Failed, In Progress, Skipped) |

## 4. Conceptual Data Model Diagram

```
┌─────────────────┐       ┌─────────────────┐
│   Bz_USERS      │◄─────►│  Bz_LICENSES    │
│                 │       │                 │
│ Connected by:   │       │ Connected by:   │
│ USER_ID         │       │ ASSIGNED_TO_    │
│                 │       │ USER_ID         │
└─────────────────┘       └─────────────────┘
         │                          │
         │                          │
         ▼                          ▼
┌─────────────────┐       ┌─────────────────┐
│  Bz_MEETINGS    │◄─────►│ Bz_PARTICIPANTS │
│                 │       │                 │
│ Connected by:   │       │ Connected by:   │
│ HOST_ID         │       │ MEETING_ID &    │
│ MEETING_ID      │       │ USER_ID         │
└─────────────────┘       └─────────────────┘
         │                          │
         │                          │
         ▼                          ▼
┌─────────────────┐       ┌─────────────────┐
│ Bz_FEATURE_     │       │ Bz_SUPPORT_     │
│ USAGE           │       │ TICKETS         │
│                 │       │                 │
│ Connected by:   │       │ Connected by:   │
│ MEETING_ID      │       │ USER_ID         │
└─────────────────┘       └─────────────────┘
         │                          │
         │                          │
         ▼                          ▼
┌─────────────────┐       ┌─────────────────┐
│  Bz_WEBINARS    │       │ Bz_BILLING_     │
│                 │       │ EVENTS          │
│ Connected by:   │       │                 │
│ HOST_ID         │       │ Connected by:   │
│                 │       │ USER_ID         │
└─────────────────┘       └─────────────────┘
```

**Relationship Descriptions:**

1. **Bz_USERS ↔ Bz_LICENSES**: Connected by USER_ID field, showing which licenses are assigned to which users
2. **Bz_USERS ↔ Bz_MEETINGS**: Connected by HOST_ID field, linking users to meetings they host
3. **Bz_MEETINGS ↔ Bz_PARTICIPANTS**: Connected by MEETING_ID field, showing which participants attended which meetings
4. **Bz_USERS ↔ Bz_PARTICIPANTS**: Connected by USER_ID field, linking participants to their user profiles
5. **Bz_MEETINGS ↔ Bz_FEATURE_USAGE**: Connected by MEETING_ID field, tracking feature usage within specific meetings
6. **Bz_USERS ↔ Bz_SUPPORT_TICKETS**: Connected by USER_ID field, linking support tickets to users who created them
7. **Bz_USERS ↔ Bz_WEBINARS**: Connected by HOST_ID field, linking users to webinars they host
8. **Bz_USERS ↔ Bz_BILLING_EVENTS**: Connected by USER_ID field, linking billing events to specific users