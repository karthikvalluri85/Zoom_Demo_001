_____________________________________________
## *Author*: AAVA
## *Created on*:   
## *Description*: Bronze Layer Logical Data Model for Zoom enterprise data platform
## *Version*: 1 
## *Updated on*: 
_____________________________________________

# Bronze Layer Logical Data Model

## 1. PII Classification

| Column Name       | Table           | PII Classification | Reason                                                                 |
|-------------------|-----------------|--------------------|------------------------------------------------------------------------|
| EMAIL             | Bz_USERS        | PII                | Email addresses uniquely identify individuals and are sensitive data. |
| USER_NAME         | Bz_USERS        | PII                | Usernames can identify individuals.                                   |
| HOST_ID           | Bz_MEETINGS, Bz_WEBINARS | PII        | Identifies the host user, potentially sensitive.                      |
| ASSIGNED_TO_USER_ID| Bz_LICENSES     | PII                | Links license to a specific user.                                     |
| USER_ID           | Bz_SUPPORT_TICKETS, Bz_BILLING_EVENTS, Bz_PARTICIPANTS, Bz_USERS | PII | Identifies individual users across systems.                          |
| PARTICIPANT_ID     | Bz_PARTICIPANTS | PII                | Identifies individual participants.                                  |
| COMPANY           | Bz_USERS        | PII                | Company information may be sensitive depending on context.           |

## 2. Bronze Layer Logical Model 

### Table: Bz_MEETINGS
**Description:** Contains raw meeting data from Zoom platform.

| Column Name       | Data Type       | Description                                      |
|-------------------|-----------------|------------------------------------------------|
| MEETING_TOPIC     | TEXT            | Topic or title of the meeting.                   |
| DURATION_MINUTES  | NUMBER          | Duration of the meeting in minutes.              |
| LOAD_TIMESTAMP    | TIMESTAMP_NTZ   | Timestamp when the record was loaded.            |
| SOURCE_SYSTEM     | TEXT            | Source system identifier (e.g., Zoom).           |
| END_TIME          | TIMESTAMP_NTZ   | Meeting end time.                                 |
| START_TIME        | TIMESTAMP_NTZ   | Meeting start time.                               |
| UPDATE_TIMESTAMP  | TIMESTAMP_NTZ   | Timestamp when the record was last updated.      |
| HOST_ID           | TEXT            | Identifier of the meeting host (PII).            |

### Table: Bz_LICENSES
**Description:** Contains license assignment data.

| Column Name       | Data Type       | Description                                      |
|-------------------|-----------------|------------------------------------------------|
| LICENSE_TYPE      | TEXT            | Type of license assigned.                        |
| END_DATE          | DATE            | License end date.                                |
| LOAD_TIMESTAMP    | TIMESTAMP_NTZ   | Timestamp when the record was loaded.            |
| SOURCE_SYSTEM     | TEXT            | Source system identifier.                         |
| START_DATE        | DATE            | License start date.                              |
| UPDATE_TIMESTAMP  | TIMESTAMP_NTZ   | Timestamp when the record was last updated.      |
| ASSIGNED_TO_USER_ID| TEXT            | User to whom the license is assigned (PII).     |

### Table: Bz_SUPPORT_TICKETS
**Description:** Contains support ticket information.

| Column Name       | Data Type       | Description                                      |
|-------------------|-----------------|------------------------------------------------|
| RESOLUTION_STATUS | TEXT            | Status of ticket resolution.                     |
| LOAD_TIMESTAMP    | TIMESTAMP_NTZ   | Timestamp when the record was loaded.            |
| SOURCE_SYSTEM     | TEXT            | Source system identifier.                         |
| OPEN_DATE         | DATE            | Date when the ticket was opened.                 |
| TICKET_TYPE       | TEXT            | Type/category of the ticket.                      |
| UPDATE_TIMESTAMP  | TIMESTAMP_NTZ   | Timestamp when the record was last updated.      |
| USER_ID           | TEXT            | User who raised the ticket (PII).                 |

### Table: Bz_USERS
**Description:** Contains user profile information.

| Column Name       | Data Type       | Description                                      |
|-------------------|-----------------|------------------------------------------------|
| EMAIL             | TEXT            | User email address (PII).                        |
| SOURCE_SYSTEM     | TEXT            | Source system identifier.                         |
| USER_NAME         | TEXT            | User's login or display name (PII).              |
| LOAD_TIMESTAMP    | TIMESTAMP_NTZ   | Timestamp when the record was loaded.            |
| UPDATE_TIMESTAMP  | TIMESTAMP_NTZ   | Timestamp when the record was last updated.      |
| PLAN_TYPE         | TEXT            | Subscription plan type.                           |
| COMPANY           | TEXT            | Company name associated with user (PII).         |

### Table: Bz_BILLING_EVENTS
**Description:** Contains billing event data.

| Column Name       | Data Type       | Description                                      |
|-------------------|-----------------|------------------------------------------------|
| AMOUNT            | NUMBER          | Amount charged or credited.                      |
| EVENT_DATE        | DATE            | Date of the billing event.                       |
| EVENT_TYPE        | TEXT            | Type of billing event (e.g., payment, refund).  |
| LOAD_TIMESTAMP    | TIMESTAMP_NTZ   | Timestamp when the record was loaded.            |
| SOURCE_SYSTEM     | TEXT            | Source system identifier.                         |
| UPDATE_TIMESTAMP  | TIMESTAMP_NTZ   | Timestamp when the record was last updated.      |
| USER_ID           | TEXT            | User associated with the billing event (PII).    |

### Table: Bz_PARTICIPANTS
**Description:** Contains meeting participant details.

| Column Name       | Data Type       | Description                                      |
|-------------------|-----------------|------------------------------------------------|
| JOIN_TIME         | TIMESTAMP_NTZ   | Timestamp when participant joined the meeting.  |
| LEAVE_TIME        | TIMESTAMP_NTZ   | Timestamp when participant left the meeting.    |
| LOAD_TIMESTAMP    | TIMESTAMP_NTZ   | Timestamp when the record was loaded.            |
| SOURCE_SYSTEM     | TEXT            | Source system identifier.                         |
| UPDATE_TIMESTAMP  | TIMESTAMP_NTZ   | Timestamp when the record was last updated.      |
| MEETING_ID        | TEXT            | Meeting identifier (relationship key).             |
| USER_ID           | TEXT            | Participant user identifier (PII).               |

### Table: Bz_WEBINARS
**Description:** Contains webinar event data.

| Column Name       | Data Type       | Description                                      |
|-------------------|-----------------|------------------------------------------------|
| WEBINAR_TOPIC     | TEXT            | Topic or title of the webinar.                   |
| START_TIME        | TIMESTAMP_NTZ   | Webinar start time.                              |
| END_TIME          | TIMESTAMP_NTZ   | Webinar end time.                                |
| LOAD_TIMESTAMP    | TIMESTAMP_NTZ   | Timestamp when the record was loaded.            |
| SOURCE_SYSTEM     | TEXT            | Source system identifier.                         |
| UPDATE_TIMESTAMP  | TIMESTAMP_NTZ   | Timestamp when the record was last updated.      |
| REGISTRANTS       | NUMBER          | Number of registrants for the webinar.           |
| HOST_ID           | TEXT            | Webinar host identifier (PII).                    |

### Table: Bz_FEATURE_USAGE
**Description:** Contains feature usage statistics.

| Column Name       | Data Type       | Description                                      |
|-------------------|-----------------|------------------------------------------------|
| FEATURE_NAME      | TEXT            | Name of the feature used.                        |
| USAGE_DATE        | DATE            | Date when the feature was used.                  |
| LOAD_TIMESTAMP    | TIMESTAMP_NTZ   | Timestamp when the record was loaded.            |
| SOURCE_SYSTEM     | TEXT            | Source system identifier.                         |
| UPDATE_TIMESTAMP  | TIMESTAMP_NTZ   | Timestamp when the record was last updated.      |
| USAGE_COUNT       | NUMBER          | Count of feature usage occurrences.              |
| MEETING_ID        | TEXT            | Meeting identifier associated with usage.        |

## 3. Audit Table Design

### Table: Bz_Audit
**Description:** Tracks processing status of records in Bronze layer.

| Column Name       | Data Type       | Description                                      |
|-------------------|-----------------|------------------------------------------------|
| record_id         | TEXT            | Unique identifier for audit record.             |
| source_table      | TEXT            | Name of the source table the record belongs to. |
| load_timestamp    | TIMESTAMP_NTZ   | Timestamp when the record was loaded.            |
| processed_by      | TEXT            | Identifier of the process or user that processed the record. |
| processing_time   | TIMESTAMP_NTZ   | Timestamp when the record was processed.         |
| status            | TEXT            | Processing status (e.g., success, error).        |

## 4. Conceptual Data Model Diagram

```
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│   Bz_USERS      │◄─────►│Bz_SUPPORT_TICKETS│     │Bz_BILLING_EVENTS│
│                 │       │                 │       │                 │
│ - USER_ID       │       │ - USER_ID       │       │ - USER_ID       │
│ - EMAIL (PII)   │       │ - TICKET_ID     │       │ - EVENT_ID      │
│ - USER_NAME(PII)│       │ - TICKET_TYPE   │       │ - AMOUNT        │
│ - COMPANY (PII) │       │ - OPEN_DATE     │       │ - EVENT_DATE    │
└─────────────────┘       └─────────────────┘       └─────────────────┘
         ▲                         ▲                         ▲
         │                         │                         │
         │ USER_ID                 │ USER_ID                 │ USER_ID
         │                         │                         │
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│Bz_PARTICIPANTS  │◄─────►│  Bz_MEETINGS    │◄─────►│Bz_FEATURE_USAGE │
│                 │       │                 │       │                 │
│ - PARTICIPANT_ID│       │ - MEETING_ID    │       │ - USAGE_ID      │
│ - USER_ID (PII) │       │ - HOST_ID (PII) │       │ - MEETING_ID    │
│ - MEETING_ID    │       │ - MEETING_TOPIC │       │ - FEATURE_NAME  │
│ - JOIN_TIME     │       │ - START_TIME    │       │ - USAGE_COUNT   │
└─────────────────┘       └─────────────────┘       └─────────────────┘
                                   ▲
                                   │
                                   │ HOST_ID
                                   │
                          ┌─────────────────┐
                          │  Bz_WEBINARS    │
                          │                 │
                          │ - WEBINAR_ID    │
                          │ - HOST_ID (PII) │
                          │ - WEBINAR_TOPIC │
                          │ - REGISTRANTS   │
                          └─────────────────┘
                                   ▲
                                   │
                                   │ ASSIGNED_TO_USER_ID
                                   │
                          ┌─────────────────┐
                          │  Bz_LICENSES    │
                          │                 │
                          │ - LICENSE_ID    │
                          │ - LICENSE_TYPE  │
                          │ - ASSIGNED_TO_  │
                          │   USER_ID (PII) │
                          └─────────────────┘
```

### Table Relationships:

1. **Bz_USERS** connects to:
   - **Bz_SUPPORT_TICKETS** via USER_ID (One user can have multiple support tickets)
   - **Bz_BILLING_EVENTS** via USER_ID (One user can have multiple billing events)
   - **Bz_PARTICIPANTS** via USER_ID (One user can participate in multiple meetings)
   - **Bz_LICENSES** via ASSIGNED_TO_USER_ID (One user can have multiple licenses)

2. **Bz_MEETINGS** connects to:
   - **Bz_PARTICIPANTS** via MEETING_ID (One meeting can have multiple participants)
   - **Bz_FEATURE_USAGE** via MEETING_ID (One meeting can have multiple feature usage records)
   - **Bz_USERS** via HOST_ID (One user can host multiple meetings)

3. **Bz_WEBINARS** connects to:
   - **Bz_USERS** via HOST_ID (One user can host multiple webinars)

4. **Bz_FEATURE_USAGE** connects to:
   - **Bz_MEETINGS** via MEETING_ID (Features are used within specific meetings)

5. **Bz_LICENSES** connects to:
   - **Bz_USERS** via ASSIGNED_TO_USER_ID (Licenses are assigned to specific users)