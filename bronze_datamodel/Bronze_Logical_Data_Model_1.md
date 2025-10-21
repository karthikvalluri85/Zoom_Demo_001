# Bronze Layer Logical Data Model for Zoom Platform Analytics System

---

## 1. Metadata

- **Author:** AAVA
- **Version:** 1
- **Description:** This document presents the comprehensive Bronze Layer Logical Data Model for the Zoom Platform Analytics System. It mirrors the source raw data structure from the zoom_raw_schema into the zoom_bronze_schema with the required transformations, metadata additions, PII classification, audit table design, and a conceptual data model diagram.

---

## 2. PII Classification and Reasons

| Column Name       | Table           | PII Classification | Reason for Classification                                  |
|-------------------|-----------------|--------------------|------------------------------------------------------------|
| email             | Bz_Users        | Yes                | Email is personally identifiable information used to contact or identify a user.
|
| user_name         | Bz_Users        | Yes                | Usernames can identify individuals uniquely in the system.
|
| host_id           | Bz_Meetings, Bz_Webinars | Yes        | Host ID links to a user and can identify the host of meetings/webinars.
|
| user_id           | Multiple tables | Yes                | User ID is a unique identifier for users, considered PII.
|
| assigned_to_user_id| Bz_Licenses     | Yes                | Identifies the user assigned to a license.
|
| participant_id    | Bz_Participants | Yes                | Identifies individual participants uniquely.
|
| registrants       | Bz_Webinars     | Yes                | Number of registrants may not be PII, but if it contains user details, it is PII.
|
| company           | Bz_Users        | Yes                | Company name can be sensitive depending on context.

Other fields such as timestamps, event types, counts, and metadata are not PII.

---

## 3. Bronze Layer Logical Data Model

### 3.1 Bz_Meetings
| Column Name       | Data Type | Business Description                          |
|-------------------|-----------|----------------------------------------------|
| meeting_topic     | string    | Topic or title of the meeting                 |
| duration_minutes  | integer   | Duration of the meeting in minutes            |
| end_time          | datetime  | Meeting end timestamp                          |
| start_time        | datetime  | Meeting start timestamp                        |
| load_timestamp    | datetime  | Timestamp when the record was loaded          |
| update_timestamp  | datetime  | Timestamp when the record was last updated    |
| source_system     | string    | Source system identifier (e.g., Zoom Raw)     |

### 3.2 Bz_Licenses
| Column Name         | Data Type | Business Description                          |
|---------------------|-----------|----------------------------------------------|
| license_type        | string    | Type of license assigned                      |
| end_date            | date      | License expiration date                        |
| start_date          | date      | License start date                             |
| load_timestamp      | datetime  | Timestamp when the record was loaded          |
| update_timestamp    | datetime  | Timestamp when the record was last updated    |
| source_system       | string    | Source system identifier (e.g., Zoom Raw)     |

### 3.3 Bz_Support_Tickets
| Column Name         | Data Type | Business Description                          |
|---------------------|-----------|----------------------------------------------|
| resolution_status   | string    | Status of ticket resolution                    |
| open_date           | datetime  | Date and time when ticket was opened          |
| ticket_type         | string    | Type/category of support ticket                |
| load_timestamp      | datetime  | Timestamp when the record was loaded          |
| update_timestamp    | datetime  | Timestamp when the record was last updated    |
| source_system       | string    | Source system identifier (e.g., Zoom Raw)     |

### 3.4 Bz_Users
| Column Name         | Data Type | Business Description                          |
|---------------------|-----------|----------------------------------------------|
| email               | string    | User's email address                           |
| user_name           | string    | User's display or login name                   |
| plan_type           | string    | Subscription plan type of the user             |
| company             | string    | Company or organization the user belongs to   |
| load_timestamp      | datetime  | Timestamp when the record was loaded          |
| update_timestamp    | datetime  | Timestamp when the record was last updated    |
| source_system       | string    | Source system identifier (e.g., Zoom Raw)     |

### 3.5 Bz_Billing_Events
| Column Name         | Data Type | Business Description                          |
|---------------------|-----------|----------------------------------------------|
| event_id            | string    | Unique identifier for billing event            |
| amount              | decimal   | Amount charged or credited                      |
| event_type          | string    | Type of billing event (payment, refund, etc.) |
| event_date          | datetime  | Date and time of the billing event             |
| load_timestamp      | datetime  | Timestamp when the record was loaded          |
| update_timestamp    | datetime  | Timestamp when the record was last updated    |
| source_system       | string    | Source system identifier (e.g., Zoom Raw)     |

### 3.6 Bz_Participants
| Column Name         | Data Type | Business Description                          |
|---------------------|-----------|----------------------------------------------|
| meeting_id          | string    | Identifier of the meeting                       |
| leave_time          | datetime  | Timestamp when participant left the meeting    |
| join_time           | datetime  | Timestamp when participant joined the meeting  |
| load_timestamp      | datetime  | Timestamp when the record was loaded          |
| update_timestamp    | datetime  | Timestamp when the record was last updated    |
| source_system       | string    | Source system identifier (e.g., Zoom Raw)     |

### 3.7 Bz_Webinars
| Column Name         | Data Type | Business Description                          |
|---------------------|-----------|----------------------------------------------|
| end_time            | datetime  | Webinar end timestamp                           |
| webinar_topic       | string    | Topic or title of the webinar                   |
| start_time          | datetime  | Webinar start timestamp                         |
| registrants         | integer   | Number of registrants for the webinar          |
| load_timestamp      | datetime  | Timestamp when the record was loaded          |
| update_timestamp    | datetime  | Timestamp when the record was last updated    |
| source_system       | string    | Source system identifier (e.g., Zoom Raw)     |

### 3.8 Bz_Feature_Usage
| Column Name         | Data Type | Business Description                          |
|---------------------|-----------|----------------------------------------------|
| feature_name        | string    | Name of the feature used                        |
| usage_date          | date      | Date when the feature was used                  |
| usage_count         | integer   | Number of times the feature was used            |
| load_timestamp      | datetime  | Timestamp when the record was loaded          |
| update_timestamp    | datetime  | Timestamp when the record was last updated    |
| source_system       | string    | Source system identifier (e.g., Zoom Raw)     |

---

## 4. Audit Table Design

| Column Name       | Data Type | Business Description                          |
|-------------------|-----------|----------------------------------------------|
| record_id         | string    | Unique identifier for the audit record         |
| source_table      | string    | Name of the source table being audited         |
| load_timestamp    | datetime  | Timestamp when the record was loaded           |
| processed_by      | string    | Identifier of the process or user processing   |
| processing_time   | integer   | Time taken to process the record (in seconds) |
| status            | string    | Processing status (e.g., success, failure)     |

Table Name: zoom_bronze_schema.Bz_Audit_Log

---

## 5. Conceptual Data Model Diagram (Block Format)

```
+----------------+       +----------------+       +----------------+
|    Bz_Users    |<----->|  Bz_Meetings   |<----->| Bz_Participants|
+----------------+       +----------------+       +----------------+
       ^                        ^                         ^
       |                        |                         |
+----------------+       +----------------+       +----------------+
| Bz_Licenses    |       |  Bz_Webinars   |       | Bz_Feature_Usage|
+----------------+       +----------------+       +----------------+
       ^                        ^                         
       |                        |                         
+----------------+       +----------------+       +----------------+
| Bz_Support_Tickets|    | Bz_Billing_Events|     | Bz_Audit_Log    |
+----------------+       +----------------+       +----------------+
```

- Relationships:
  - Bz_Users linked to Bz_Meetings and Bz_Webinars via host_id/user_id
  - Bz_Participants linked to Bz_Meetings via meeting_id
  - Bz_Feature_Usage linked to Bz_Meetings via meeting_id
  - Bz_Licenses linked to Bz_Users via assigned_to_user_id
  - Bz_Support_Tickets linked to Bz_Users via user_id
  - Bz_Billing_Events linked to Bz_Users via user_id

---

*End of Bronze Layer Logical Data Model Document.*
