_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Comprehensive Bronze Layer Logical Data Model for Zoom Platform Analytics System following Medallion Architecture principles
## *Version*: 1
## *Updated on*: 
_____________________________________________

# Zoom Platform Analytics System - Bronze Layer Logical Data Model

## 1. PII Classification

### PII Fields Identified:

• **EMAIL** (Bz_USERS)
  - **Reason**: Contains personal email addresses that directly identify individuals and can be used to contact or track specific users

• **USER_NAME** (Bz_USERS)
  - **Reason**: Contains personal names that directly identify individuals and constitute personally identifiable information

• **COMPANY** (Bz_USERS)
  - **Reason**: May reveal employer information linked to individuals, which combined with other data can identify specific persons

• **HOST_ID** (Bz_MEETINGS, Bz_WEBINARS)
  - **Reason**: Unique identifiers that link to specific users hosting meetings, enabling identification of individuals through their meeting activities

• **USER_ID** (Bz_USERS, Bz_PARTICIPANTS, Bz_SUPPORT_TICKETS, Bz_BILLING_EVENTS)
  - **Reason**: Unique user identifiers that can be linked across systems to identify and track individual users' activities and behaviors

• **ASSIGNED_TO_USER_ID** (Bz_LICENSES)
  - **Reason**: User assignment identifiers for licenses that link to specific individuals and their organizational access rights

• **PARTICIPANT_ID** (Bz_PARTICIPANTS)
  - **Reason**: Unique identifiers for meeting participants that can be used to track individual participation patterns and behaviors

## 2. Bronze Layer Logical Model

### 2.1 Bz_MEETINGS
**Description**: Bronze layer table containing raw meeting data from source systems, mirroring the structure of meeting information with metadata enhancements.

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| MEETING_TOPIC | TEXT | Subject or title of the meeting session |
| DURATION_MINUTES | NUMBER | Total length of the meeting measured in minutes |
| END_TIME | TIMESTAMP_NTZ | Scheduled or actual end time of the meeting session |
| START_TIME | TIMESTAMP_NTZ | Scheduled or actual start time of the meeting session |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when the record was loaded into the Bronze layer |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of the last update in the source system |
| SOURCE_SYSTEM | TEXT | Identifier of the origin system from which the data was extracted |

### 2.2 Bz_LICENSES
**Description**: Bronze layer table containing raw license data from source systems, tracking license assignments and validity periods.

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| LICENSE_TYPE | TEXT | Type or category of Zoom license assigned to users |
| END_DATE | DATE | Expiration date of the license assignment |
| START_DATE | DATE | Effective start date of the license assignment |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when the record was loaded into the Bronze layer |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of the last update in the source system |
| SOURCE_SYSTEM | TEXT | Identifier of the origin system from which the data was extracted |

### 2.3 Bz_SUPPORT_TICKETS
**Description**: Bronze layer table containing raw support ticket data from source systems, tracking customer service interactions and resolutions.

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| RESOLUTION_STATUS | TEXT | Current status of the support ticket resolution process |
| OPEN_DATE | DATE | Date when the support ticket was initially opened |
| TICKET_TYPE | TEXT | Category or type of the support ticket issue |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when the record was loaded into the Bronze layer |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of the last update in the source system |
| SOURCE_SYSTEM | TEXT | Identifier of the origin system from which the data was extracted |

### 2.4 Bz_USERS
**Description**: Bronze layer table containing raw user data from source systems, storing user profile and account information.

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| EMAIL | TEXT | Primary email address associated with the user account |
| USER_NAME | TEXT | Full name of the user as registered in the system |
| PLAN_TYPE | TEXT | Type of Zoom subscription plan assigned to the user |
| COMPANY | TEXT | Company or organization name associated with the user |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when the record was loaded into the Bronze layer |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of the last update in the source system |
| SOURCE_SYSTEM | TEXT | Identifier of the origin system from which the data was extracted |

### 2.5 Bz_BILLING_EVENTS
**Description**: Bronze layer table containing raw billing event data from source systems, tracking financial transactions and billing activities.

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| AMOUNT | NUMBER | Monetary amount associated with the billing event |
| EVENT_TYPE | TEXT | Type or category of the billing event transaction |
| EVENT_DATE | DATE | Date when the billing event occurred |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when the record was loaded into the Bronze layer |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of the last update in the source system |
| SOURCE_SYSTEM | TEXT | Identifier of the origin system from which the data was extracted |

### 2.6 Bz_PARTICIPANTS
**Description**: Bronze layer table containing raw participant data from source systems, tracking meeting attendance and participation details.

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| JOIN_TIME | TIMESTAMP_NTZ | Time when the participant joined the meeting session |
| LEAVE_TIME | TIMESTAMP_NTZ | Time when the participant left the meeting session |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when the record was loaded into the Bronze layer |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of the last update in the source system |
| SOURCE_SYSTEM | TEXT | Identifier of the origin system from which the data was extracted |

### 2.7 Bz_WEBINARS
**Description**: Bronze layer table containing raw webinar data from source systems, storing webinar session information and registration details.

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| WEBINAR_TOPIC | TEXT | Subject or title of the webinar session |
| START_TIME | TIMESTAMP_NTZ | Scheduled or actual start time of the webinar session |
| END_TIME | TIMESTAMP_NTZ | Scheduled or actual end time of the webinar session |
| REGISTRANTS | NUMBER | Total number of users registered for the webinar |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when the record was loaded into the Bronze layer |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of the last update in the source system |
| SOURCE_SYSTEM | TEXT | Identifier of the origin system from which the data was extracted |

### 2.8 Bz_FEATURE_USAGE
**Description**: Bronze layer table containing raw feature usage data from source systems, tracking utilization of specific Zoom platform features.

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| FEATURE_NAME | TEXT | Name of the specific Zoom feature that was utilized |
| USAGE_DATE | DATE | Date when the feature usage occurred |
| USAGE_COUNT | NUMBER | Number of times the feature was used during the specified period |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when the record was loaded into the Bronze layer |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of the last update in the source system |
| SOURCE_SYSTEM | TEXT | Identifier of the origin system from which the data was extracted |

## 3. Audit Table Design

### Bz_Audit_Table
**Description**: Comprehensive audit table to track data ingestion processes, monitor data quality, and provide operational visibility into Bronze layer data loading activities.

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| record_id | TEXT | Unique identifier for each audit record entry |
| source_table | TEXT | Name of the source table being processed and loaded |
| load_timestamp | TIMESTAMP_NTZ | Timestamp when the data record was loaded into the Bronze layer |
| processed_by | TEXT | Identifier of the process, job, or user that performed the data loading |
| processing_time | NUMBER | Duration of the processing operation measured in seconds |
| status | TEXT | Status of the processing operation (Success, Failed, Warning, In Progress) |

## 4. Conceptual Data Model Diagram

### Block Diagram Format - Entity Relationships

```
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│   Bz_USERS      │◄──────┤  Bz_LICENSES    │       │ Bz_SUPPORT_     │
│                 │       │                 │       │ TICKETS         │
│ • EMAIL         │       │ • LICENSE_TYPE  │       │                 │
│ • USER_NAME     │       │ • START_DATE    │       │ • TICKET_TYPE   │
│ • PLAN_TYPE     │       │ • END_DATE      │       │ • OPEN_DATE     │
│ • COMPANY       │       │                 │       │ • RESOLUTION_   │
└─────────────────┘       └─────────────────┘       │   STATUS        │
         │                                           └─────────────────┘
         │                                                    │
         │                                                    │
         ▼                                                    ▼
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│ Bz_BILLING_     │       │  Bz_MEETINGS    │◄──────┤ Bz_PARTICIPANTS │
│ EVENTS          │       │                 │       │                 │
│                 │       │ • MEETING_TOPIC │       │ • JOIN_TIME     │
│ • EVENT_TYPE    │       │ • START_TIME    │       │ • LEAVE_TIME    │
│ • AMOUNT        │       │ • END_TIME      │       │                 │
│ • EVENT_DATE    │       │ • DURATION_     │       └─────────────────┘
└─────────────────┘       │   MINUTES       │
                          └─────────────────┘
                                   │
                                   │
                                   ▼
┌─────────────────┐       ┌─────────────────┐
│  Bz_WEBINARS    │       │ Bz_FEATURE_     │
│                 │       │ USAGE           │
│ • WEBINAR_TOPIC │       │                 │
│ • START_TIME    │       │ • FEATURE_NAME  │
│ • END_TIME      │       │ • USAGE_DATE    │
│ • REGISTRANTS   │       │ • USAGE_COUNT   │
└─────────────────┘       └─────────────────┘

                  ┌─────────────────┐
                  │ Bz_Audit_Table  │
                  │                 │
                  │ • record_id     │
                  │ • source_table  │
                  │ • load_timestamp│
                  │ • processed_by  │
                  │ • processing_   │
                  │   time          │
                  │ • status        │
                  └─────────────────┘
```

### Table Relationship Connections:

1. **Bz_USERS ↔ Bz_LICENSES**: Connected through user identification fields
2. **Bz_USERS ↔ Bz_SUPPORT_TICKETS**: Connected through user identification fields
3. **Bz_USERS ↔ Bz_BILLING_EVENTS**: Connected through user identification fields
4. **Bz_MEETINGS ↔ Bz_PARTICIPANTS**: Connected through meeting identification fields
5. **Bz_MEETINGS ↔ Bz_FEATURE_USAGE**: Connected through meeting identification fields
6. **Bz_WEBINARS**: Standalone entity with host relationships to users
7. **Bz_Audit_Table**: Monitors all tables through source_table field connections

### Key Design Rationale:

1. **Source Data Fidelity**: All Bronze layer tables mirror the exact structure of source systems, ensuring complete data preservation and traceability.

2. **Metadata Enhancement**: Each table includes standard metadata columns (LOAD_TIMESTAMP, UPDATE_TIMESTAMP, SOURCE_SYSTEM) for operational tracking and data lineage.

3. **PII Identification**: Comprehensive classification of personally identifiable information enables proper data governance and compliance with privacy regulations.

4. **Audit Capabilities**: Dedicated audit table provides complete visibility into data ingestion processes, supporting operational monitoring and troubleshooting.

5. **Naming Convention**: Consistent 'Bz_' prefix clearly identifies Bronze layer tables and supports data governance frameworks.

6. **Key Field Exclusion**: Removal of primary and foreign key fields focuses the Bronze layer on business-relevant data attributes while maintaining referential context through business keys.

7. **Scalable Architecture**: Design supports the medallion architecture pattern, enabling efficient data flow from Bronze to Silver and Gold layers.