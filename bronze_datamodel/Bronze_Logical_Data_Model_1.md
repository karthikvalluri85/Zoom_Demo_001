_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Bronze Layer Logical Data Model for Zoom Platform Analytics System based on source raw schema and conceptual model
## *Version*: 1
## *Updated on*: 
_____________________________________________

# Bronze Layer Logical Data Model for Zoom Platform Analytics System

---

## 1. PII Classification

| Table Name       | Column Name       | PII Classification | Explanation                                                                                  |
|------------------|-------------------|--------------------|----------------------------------------------------------------------------------------------|
| Bz_USERS         | EMAIL             | PII                | Email addresses uniquely identify individuals and are sensitive personal information.       |
| Bz_USERS         | USER_NAME         | PII                | User full names are personal identifiers.                                                   |
| Bz_USERS         | COMPANY           | Potential PII       | Company name may be sensitive depending on context.                                         |
| Bz_LICENSES      | ASSIGNED_TO_USER_ID| PII               | Links license to a specific user ID, which is personal.                                     |
| Bz_SUPPORT_TICKETS| USER_ID           | PII                | User ID identifies individual users raising support tickets.                                |
| Bz_BILLING_EVENTS| USER_ID           | PII                | User ID associated with billing events is personal.                                         |
| Bz_PARTICIPANTS  | USER_ID           | PII                | User ID identifies participants who are individuals.                                        |
| Bz_MEETINGS      | HOST_ID           | PII                | Host ID identifies the user hosting the meeting.                                            |
| Bz_WEBINARS      | HOST_ID           | PII                | Host ID identifies the webinar host.                                                        |

---

## 2. Bronze Layer Logical Model

### Schema: ZOOM_BRONZE_SCHEMA

---

### 2.1 Table: Bz_MEETINGS

| Column Name       | Data Type      | Description                                   |
|-------------------|----------------|-----------------------------------------------|
| UPDATE_TIMESTAMP  | TIMESTAMP_NTZ  | Timestamp when the record was last updated.   |
| MEETING_TOPIC    | TEXT           | Subject or title of the meeting.               |
| DURATION_MINUTES | NUMBER         | Duration of the meeting in minutes.            |
| LOAD_TIMESTAMP   | TIMESTAMP_NTZ  | Timestamp when the record was loaded.          |
| MEETING_ID      | TEXT           | Unique identifier for the meeting.             |
| SOURCE_SYSTEM   | TEXT           | Source system of the data.                      |
| END_TIME        | TIMESTAMP_NTZ  | Meeting end time.                               |
| HOST_ID         | TEXT           | User ID of the meeting host.                    |
| START_TIME      | TIMESTAMP_NTZ  | Meeting start time.                             |

---

### 2.2 Table: Bz_LICENSES

| Column Name       | Data Type      | Description                                   |
|-------------------|----------------|-----------------------------------------------|
| LOAD_TIMESTAMP   | TIMESTAMP_NTZ  | Timestamp when the record was loaded.          |
| LICENSE_TYPE    | TEXT           | Type of license assigned.                       |
| END_DATE        | DATE           | License end date.                               |
| ASSIGNED_TO_USER_ID | TEXT        | User ID to whom the license is assigned.       |
| LICENSE_ID      | TEXT           | Unique license identifier.                      |
| SOURCE_SYSTEM   | TEXT           | Source system of the data.                      |
| UPDATE_TIMESTAMP| TIMESTAMP_NTZ  | Timestamp when the record was last updated.    |
| START_DATE      | DATE           | License start date.                             |

---

### 2.3 Table: Bz_SUPPORT_TICKETS

| Column Name       | Data Type      | Description                                   |
|-------------------|----------------|-----------------------------------------------|
| RESOLUTION_STATUS| TEXT           | Status of ticket resolution.                    |
| UPDATE_TIMESTAMP| TIMESTAMP_NTZ  | Timestamp when the record was last updated.    |
| TICKET_ID       | TEXT           | Unique identifier for the support ticket.      |
| LOAD_TIMESTAMP  | TIMESTAMP_NTZ  | Timestamp when the record was loaded.          |
| OPEN_DATE       | DATE           | Date when the ticket was opened.                |
| USER_ID         | TEXT           | User ID who raised the ticket.                  |
| SOURCE_SYSTEM   | TEXT           | Source system of the data.                      |
| TICKET_TYPE     | TEXT           | Type/category of the support ticket.            |

---

### 2.4 Table: Bz_USERS

| Column Name       | Data Type      | Description                                   |
|-------------------|----------------|-----------------------------------------------|
| EMAIL           | TEXT           | User's primary email address.                   |
| SOURCE_SYSTEM   | TEXT           | Source system of the data.                      |
| USER_NAME       | TEXT           | Full name of the user.                          |
| LOAD_TIMESTAMP  | TIMESTAMP_NTZ  | Timestamp when the record was loaded.          |
| UPDATE_TIMESTAMP| TIMESTAMP_NTZ  | Timestamp when the record was last updated.    |
| USER_ID         | TEXT           | Unique identifier for the user.                 |
| PLAN_TYPE       | TEXT           | Type of Zoom plan assigned to the user.        |
| COMPANY        | TEXT           | Company or organization the user belongs to.   |

---

### 2.5 Table: Bz_BILLING_EVENTS

| Column Name       | Data Type      | Description                                   |
|-------------------|----------------|-----------------------------------------------|
| SOURCE_SYSTEM   | TEXT           | Source system of the data.                      |
| EVENT_ID        | TEXT           | Unique identifier for the billing event.       |
| UPDATE_TIMESTAMP| TIMESTAMP_NTZ  | Timestamp when the record was last updated.    |
| AMOUNT          | NUMBER         | Monetary amount of the billing event.          |
| EVENT_TYPE      | TEXT           | Type/category of billing event.                 |
| LOAD_TIMESTAMP  | TIMESTAMP_NTZ  | Timestamp when the record was loaded.          |
| EVENT_DATE      | DATE           | Date of the billing event.                      |
| USER_ID         | TEXT           | User ID associated with the billing event.     |

---

### 2.6 Table: Bz_PARTICIPANTS

| Column Name       | Data Type      | Description                                   |
|-------------------|----------------|-----------------------------------------------|
| UPDATE_TIMESTAMP| TIMESTAMP_NTZ  | Timestamp when the record was last updated.    |
| MEETING_ID      | TEXT           | Identifier of the meeting the participant joined.|
| SOURCE_SYSTEM   | TEXT           | Source system of the data.                      |
| LOAD_TIMESTAMP  | TIMESTAMP_NTZ  | Timestamp when the record was loaded.          |
| LEAVE_TIME     | TIMESTAMP_NTZ  | Time participant left the meeting.             |
| JOIN_TIME      | TIMESTAMP_NTZ  | Time participant joined the meeting.           |
| USER_ID        | TEXT           | User ID of the participant.                     |
| PARTICIPANT_ID | TEXT           | Unique identifier for the participant record.  |

---

### 2.7 Table: Bz_WEBINARS

| Column Name       | Data Type      | Description                                   |
|-------------------|----------------|-----------------------------------------------|
| END_TIME       | TIMESTAMP_NTZ  | Webinar end time.                               |
| SOURCE_SYSTEM  | TEXT           | Source system of the data.                      |
| WEBINAR_TOPIC  | TEXT           | Topic or title of the webinar.                  |
| START_TIME     | TIMESTAMP_NTZ  | Webinar start time.                             |
| WEBINAR_ID     | TEXT           | Unique identifier for the webinar.              |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ  | Timestamp when the record was loaded.          |
| REGISTRANTS   | NUMBER         | Number of registrants for the webinar.          |
| HOST_ID       | TEXT           | User ID of the webinar host.                    |
| UPDATE_TIMESTAMP| TIMESTAMP_NTZ | Timestamp when the record was last updated.    |

---

### 2.8 Table: Bz_FEATURE_USAGE

| Column Name       | Data Type      | Description                                   |
|-------------------|----------------|-----------------------------------------------|
| FEATURE_NAME   | TEXT           | Name of the Zoom feature used.                  |
| MEETING_ID     | TEXT           | Identifier of the meeting where feature used.  |
| USAGE_DATE    | DATE           | Date of feature usage.                          |
| UPDATE_TIMESTAMP| TIMESTAMP_NTZ | Timestamp when the record was last updated.    |
| SOURCE_SYSTEM | TEXT           | Source system of the data.                      |
| USAGE_ID      | TEXT           | Unique identifier for the usage record.         |
| LOAD_TIMESTAMP| TIMESTAMP_NTZ  | Timestamp when the record was loaded.          |
| USAGE_COUNT  | NUMBER         | Count of feature usage occurrences.             |

---

## 3. Audit Table Design

### Table: Bz_Audit

| Column Name     | Data Type     | Description                                      |
|-----------------|---------------|--------------------------------------------------|
| record_id       | TEXT          | Unique identifier for the audit record.          |
| source_table    | TEXT          | Name of the source table being audited.          |
| load_timestamp  | TIMESTAMP_NTZ | Timestamp when the record was loaded.             |
| processed_by    | TEXT          | Identifier of the process or user who processed. |
| processing_time | NUMBER        | Time taken to process the record (in seconds).   |
| status         | TEXT          | Processing status (e.g., Success, Failed).        |

---

## 4. Conceptual Data Model Diagram (Block Format)

```
[Account] 1---* [Department] 1---* [User] *---1 [Role]
     |                          |               |
     |                          |               |
     |                          *---* [Device]  |
     |                          |               |
     |                          *---* [Usage Metrics]
     |                          |
     |                          *---* [Meeting] 1---* [Participant] 1---* [Session]
     |                                                      |               |
     |                                                      |               *---1 [Device]
     |                                                      |               *---1 [Network Data]
     |                                                      |               *---1 [Quality Metrics]
     |                                                      |               *---1 [Performance Data]
     |                                                      |
     |                                                      *---* [Engagement Statistics]
     |
     *---* [Billing Events]

[Meeting] 1---* [Feature Usage]
[Meeting] 1---* [Performance Data]
```

---

## 5. Relationships Between Tables

- **Account to Department**: One-to-Many (One account has multiple departments)
- **Account to User**: One-to-Many (One account has multiple users)
- **Department to User**: One-to-Many (One department has multiple users)
- **User to Role**: Many-to-One (Multiple users can have the same role)
- **User to Device**: One-to-Many (One user can use multiple devices)
- **User to Usage Metrics**: One-to-Many (One user has multiple usage metric records)
- **User to Billing Events**: One-to-Many (One user can have multiple billing events)
- **User to Support Tickets**: One-to-Many (One user can raise multiple support tickets)
- **User to Participant**: One-to-Many (One user can be participant in multiple meetings)
- **Meeting to Participant**: One-to-Many (One meeting has multiple participants)
- **Meeting to Feature Usage**: One-to-Many (One meeting can have multiple feature usage records)
- **Meeting to Performance Data**: One-to-Many (One meeting can have multiple performance data points)
- **Participant to Session**: One-to-Many (One participant can have multiple sessions)
- **Session to Device**: Many-to-One (Multiple sessions can use the same device)
- **Session to Network Data**: One-to-One (Each session has one network data record)
- **Session to Quality Metrics**: One-to-One (Each session has one quality metrics record)
- **Session to Performance Data**: One-to-One (Each session has one performance data record)
- **Participant to Engagement Statistics**: One-to-Many (One participant has multiple engagement stats)
- **Meeting to Engagement Statistics**: One-to-Many (One meeting has multiple engagement stats)

---

## 6. Column Descriptions for Business Understanding

- **MEETING_ID, USER_ID, PARTICIPANT_ID, LICENSE_ID, TICKET_ID, EVENT_ID, WEBINAR_ID, USAGE_ID**: Unique identifiers for respective entities.
- **LOAD_TIMESTAMP**: Timestamp when data was ingested into the Bronze layer.
- **UPDATE_TIMESTAMP**: Timestamp when the source data was last updated.
- **SOURCE_SYSTEM**: Origin system of the data record.
- **PII Fields**: EMAIL, USER_NAME, HOST_ID, USER_ID - sensitive personal information requiring protection.
- **Date and Time Fields**: START_TIME, END_TIME, JOIN_TIME, LEAVE_TIME, OPEN_DATE, EVENT_DATE, USAGE_DATE - used for temporal analysis.
- **Metrics Fields**: DURATION_MINUTES, USAGE_COUNT, AMOUNT, REGISTRANTS - quantitative measures for analytics.
- **Status Fields**: MEETING_STATUS, RESOLUTION_STATUS, TICKET_TYPE - categorical descriptors for operational status.

---

This completes the comprehensive Bronze Layer Logical Data Model for the Zoom Platform Analytics System.