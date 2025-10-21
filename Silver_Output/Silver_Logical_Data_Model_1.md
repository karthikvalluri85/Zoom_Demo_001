# Silver Layer Logical Data Model for Zoom Platform Analytics System

## 1. Introduction
This document defines the Silver Layer Logical Data Model for the Zoom Platform Analytics System, following medallion architecture principles. The Silver layer refines and standardizes data from the Bronze layer, removes technical identifiers, and introduces structures for error tracking and audit logging. This model supports advanced analytics, data quality, and governance requirements.

## 2. Design Rationale and Assumptions
1. The Silver layer mirrors the Bronze structure but omits all primary key, foreign key, and ID fields to focus on business-relevant attributes.
2. Table names use the 'Si_' prefix for consistency and clarity.
3. Data types are standardized for analytics and interoperability (e.g., TEXT, NUMBER, DATE, TIMESTAMP_NTZ).
4. Error and audit tables are included to support data quality and pipeline traceability.
5. All columns have clear, business-focused descriptions.
6. Relationships are documented at the business-key level, not enforced by technical keys.
7. The model aligns with data governance, privacy, and compliance requirements.
8. Assumes Bronze layer data is already cleansed of duplicates and basic errors.

## 3. Silver Layer Table Structures

### 3.1 Si_Meetings
**Description:** Refined meeting information for analytics, excluding technical identifiers.

| Column Name        | Data Type       | Description                                                      |
|--------------------|----------------|------------------------------------------------------------------|
| meeting_topic      | TEXT           | Subject or descriptive title of the meeting session               |
| duration_minutes   | NUMBER         | Total duration of the meeting measured in minutes                |
| end_time           | TIMESTAMP_NTZ  | Timestamp when the meeting concluded                             |
| start_time         | TIMESTAMP_NTZ  | Timestamp when the meeting began                                 |
| load_timestamp     | TIMESTAMP_NTZ  | System timestamp when the record was loaded into Silver layer    |
| update_timestamp   | TIMESTAMP_NTZ  | System timestamp when the record was last modified               |
| source_system      | TEXT           | Identifier of the source system from which data originated       |

### 3.2 Si_Licenses
**Description:** License assignment and management information, standardized for analytics.

| Column Name        | Data Type       | Description                                                      |
|--------------------|----------------|------------------------------------------------------------------|
| license_type       | TEXT           | Category or tier of the license (Basic, Pro, Enterprise)         |
| end_date           | DATE           | Expiration date of the license assignment                        |
| start_date         | DATE           | Activation date of the license assignment                        |
| load_timestamp     | TIMESTAMP_NTZ  | System timestamp when the record was loaded into Silver layer    |
| update_timestamp   | TIMESTAMP_NTZ  | System timestamp when the record was last modified               |
| source_system      | TEXT           | Identifier of the source system from which data originated       |

### 3.3 Si_Support_Tickets
**Description:** Customer support ticket information for analytics and reporting.

| Column Name        | Data Type       | Description                                                      |
|--------------------|----------------|------------------------------------------------------------------|
| resolution_status  | TEXT           | Current status of the support ticket resolution process          |
| open_date          | DATE           | Date when the support ticket was initially created               |
| ticket_type        | TEXT           | Category classification of the support request                   |
| load_timestamp     | TIMESTAMP_NTZ  | System timestamp when the record was loaded into Silver layer    |
| update_timestamp   | TIMESTAMP_NTZ  | System timestamp when the record was last modified               |
| source_system      | TEXT           | Identifier of the source system from which data originated       |

### 3.4 Si_Users
**Description:** User profile and account information, excluding technical identifiers.

| Column Name        | Data Type       | Description                                                      |
|--------------------|----------------|------------------------------------------------------------------|
| email              | TEXT           | Primary email address associated with the user account           |
| user_name          | TEXT           | Display name or username for the platform user                   |
| plan_type          | TEXT           | Subscription plan tier assigned to the user                      |
| company            | TEXT           | Organization or company name associated with the user            |
| load_timestamp     | TIMESTAMP_NTZ  | System timestamp when the record was loaded into Silver layer    |
| update_timestamp   | TIMESTAMP_NTZ  | System timestamp when the record was last modified               |
| source_system      | TEXT           | Identifier of the source system from which data originated       |

### 3.5 Si_Billing_Events
**Description:** Financial transaction and billing event information for analytics.

| Column Name        | Data Type       | Description                                                      |
|--------------------|----------------|------------------------------------------------------------------|
| amount             | NUMBER         | Monetary value associated with the billing transaction           |
| event_type         | TEXT           | Classification of the billing event (Charge, Refund, etc.)       |
| event_date         | DATE           | Date when the billing event occurred                             |
| load_timestamp     | TIMESTAMP_NTZ  | System timestamp when the record was loaded into Silver layer    |
| update_timestamp   | TIMESTAMP_NTZ  | System timestamp when the record was last modified               |
| source_system      | TEXT           | Identifier of the source system from which data originated       |

### 3.6 Si_Participants
**Description:** Meeting and webinar participation information, standardized for analytics.

| Column Name        | Data Type       | Description                                                      |
|--------------------|----------------|------------------------------------------------------------------|
| leave_time         | TIMESTAMP_NTZ  | Timestamp when the participant exited the session                |
| join_time          | TIMESTAMP_NTZ  | Timestamp when the participant entered the session               |
| load_timestamp     | TIMESTAMP_NTZ  | System timestamp when the record was loaded into Silver layer    |
| update_timestamp   | TIMESTAMP_NTZ  | System timestamp when the record was last modified               |
| source_system      | TEXT           | Identifier of the source system from which data originated       |

### 3.7 Si_Webinars
**Description:** Webinar event and broadcast information, standardized for analytics.

| Column Name        | Data Type       | Description                                                      |
|--------------------|----------------|------------------------------------------------------------------|
| end_time           | TIMESTAMP_NTZ  | Timestamp when the webinar concluded                             |
| webinar_topic      | TEXT           | Subject or descriptive title of the webinar event                |
| start_time         | TIMESTAMP_NTZ  | Timestamp when the webinar began                                 |
| registrants        | NUMBER         | Total number of users registered for the webinar                 |
| load_timestamp     | TIMESTAMP_NTZ  | System timestamp when the record was loaded into Silver layer    |
| update_timestamp   | TIMESTAMP_NTZ  | System timestamp when the record was last modified               |
| source_system      | TEXT           | Identifier of the source system from which data originated       |

### 3.8 Si_Feature_Usage
**Description:** Platform feature utilization tracking information for analytics.

| Column Name        | Data Type       | Description                                                      |
|--------------------|----------------|------------------------------------------------------------------|
| feature_name       | TEXT           | Name of the platform feature being tracked                       |
| usage_date         | DATE           | Date when the feature usage occurred                             |
| usage_count        | NUMBER         | Number of times the feature was utilized                         |
| load_timestamp     | TIMESTAMP_NTZ  | System timestamp when the record was loaded into Silver layer    |
| update_timestamp   | TIMESTAMP_NTZ  | System timestamp when the record was last modified               |
| source_system      | TEXT           | Identifier of the source system from which data originated       |

### 3.9 Si_Error_Log
**Description:** Table to store error data from data quality checks and validation processes.

| Column Name        | Data Type       | Description                                                      |
|--------------------|----------------|------------------------------------------------------------------|
| error_timestamp    | TIMESTAMP_NTZ  | Timestamp when the error was detected                            |
| source_table       | TEXT           | Name of the table where the error occurred                       |
| error_type         | TEXT           | Type/category of the error (validation, transformation, etc.)    |
| error_message      | TEXT           | Detailed error message or description                            |
| error_data         | TEXT           | Raw data or record snapshot that caused the error                |
| process_name       | TEXT           | Name of the process or pipeline step                             |
| severity           | TEXT           | Severity level (INFO, WARNING, ERROR, CRITICAL)                  |

### 3.10 Si_Audit_Log
**Description:** Table to store audit details from pipeline execution and data processing.

| Column Name        | Data Type       | Description                                                      |
|--------------------|----------------|------------------------------------------------------------------|
| audit_timestamp    | TIMESTAMP_NTZ  | Timestamp when the audit event occurred                          |
| source_table       | TEXT           | Name of the table being audited                                  |
| process_name       | TEXT           | Name of the process or pipeline step                             |
| processed_by       | TEXT           | Identifier of the system, process, or user performing the action |
| processing_time_ms | NUMBER         | Duration of the processing operation in milliseconds             |
| status             | TEXT           | Outcome status (SUCCESS, FAILED, PARTIAL)                        |
| details            | TEXT           | Additional audit details or context                              |

## 4. Table Relationships (Business Key Level)
| Source Table      | Target Table      | Connection Field(s)         | Relationship Type |
|-------------------|------------------|-----------------------------|-------------------|
| Si_Users          | Si_Meetings      | user_name → host            | One-to-Many       |
| Si_Users          | Si_Webinars      | user_name → host            | One-to-Many       |
| Si_Users          | Si_Licenses      | user_name → assigned_user   | One-to-Many       |
| Si_Users          | Si_Support_Tickets | user_name → requester      | One-to-Many       |
| Si_Users          | Si_Billing_Events | user_name → billed_user    | One-to-Many       |
| Si_Meetings       | Si_Participants  | meeting_topic → meeting     | One-to-Many       |
| Si_Meetings       | Si_Feature_Usage | meeting_topic → meeting     | One-to-Many       |
| Si_Participants   | Si_Users         | participant_name → user_name| Many-to-One       |

*Note: All relationships are logical and based on business keys, not enforced by technical keys in the Silver layer.*

## 5. Conceptual Data Model Diagram (Block Format)
```
┌─────────────────┐    ┌─────────────────┐    ┌────────────────────┐
│   Si_Users      │────│  Si_Meetings    │────│ Si_Participants    │
│                 │    │                 │    │                    │
│ - email         │    │ - meeting_topic │    │ - join_time        │
│ - user_name     │    │ - duration_min  │    │ - leave_time       │
│ - plan_type     │    │ - start_time    │    │ - load_timestamp   │
│ - company       │    │ - end_time      │    │ - update_timestamp │
└─────────────────┘    └─────────────────┘    └────────────────────┘
         │                       │                       │
         │                       │                       │
┌─────────────────┐    ┌─────────────────┐    ┌────────────────────┐
│  Si_Licenses    │    │  Si_Webinars    │    │ Si_Feature_Usage   │
│                 │    │                 │    │                    │
│ - license_type  │    │ - webinar_topic │    │ - feature_name     │
│ - start_date    │    │ - start_time    │    │ - usage_date       │
│ - end_date      │    │ - end_time      │    │ - usage_count      │
│ - load_timestamp│    │ - registrants   │    │ - load_timestamp   │
└─────────────────┘    └─────────────────┘    └────────────────────┘
         │                       │
         │                       │
┌──────────────────────┐   ┌──────────────────────┐
│Si_Support_Tickets    │   │Si_Billing_Events     │
│ - ticket_type        │   │ - amount             │
│ - open_date          │   │ - event_type         │
│ - resolution_status  │   │ - event_date         │
│ - load_timestamp     │   │ - load_timestamp     │
└──────────────────────┘   └──────────────────────┘

┌──────────────────────┐   ┌──────────────────────┐
│Si_Error_Log          │   │Si_Audit_Log          │
│ - error_timestamp    │   │ - audit_timestamp    │
│ - source_table       │   │ - source_table       │
│ - error_type         │   │ - process_name       │
│ - error_message      │   │ - processed_by       │
│ - error_data         │   │ - processing_time_ms │
│ - process_name       │   │ - status             │
│ - severity           │   │ - details            │
└──────────────────────┘   └──────────────────────┘
```

## 6. Metadata and Compliance
- All PII fields are clearly identified and handled per compliance requirements.
- Data types are standardized for analytics and reporting.
- Audit and error logs support traceability, governance, and operational monitoring.

## 7. Key Design Decisions
1. **No technical keys:** All PK/FK/ID fields are omitted to focus on business logic and analytics.
2. **Naming conventions:** 'Si_' prefix ensures clarity and separation from Bronze/Gold layers.
3. **Error and audit support:** Dedicated tables for error and audit data enable robust data quality and pipeline monitoring.
4. **Data type standardization:** Ensures consistency across the analytics platform.
5. **Business-key relationships:** Relationships are logical, not enforced by technical constraints, supporting flexible analytics.
6. **Compliance alignment:** Model supports privacy, audit, and regulatory requirements.

## 8. Assumptions
- Bronze layer data is already deduplicated and cleansed of basic errors.
- All business keys (e.g., user_name, meeting_topic) are unique within their business context.
- Downstream analytics and reporting will join tables using business keys.
- Error and audit tables are populated by ETL/ELT processes.

---
*End of Silver Layer Logical Data Model for Zoom Platform Analytics System*