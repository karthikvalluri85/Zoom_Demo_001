_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Bronze Layer Logical Data Model for Zoom Platform Analytics System with comprehensive PII classification, audit design, and conceptual data model diagram
## *Version*: 1
## *Updated on*: 
_____________________________________________

# Bronze Layer Logical Data Model for Zoom Platform Analytics System

## 1. PII Classification

| Column Name | Table | PII Classification | Reason for Classification |
|-------------|-------|-------------------|---------------------------|
| email | Bz_Users | Yes | Email addresses are personally identifiable information that can be used to directly contact and identify individuals |
| user_name | Bz_Users | Yes | User names can be used to identify specific individuals within the system and may contain personal information |
| company | Bz_Users | Yes | Company information can reveal employment details and organizational affiliations of users |
| host_id | Bz_Meetings, Bz_Webinars | Yes | Host IDs are linked to specific users and can be used to identify meeting/webinar organizers |
| user_id | Bz_Support_Tickets, Bz_Billing_Events, Bz_Participants | Yes | User IDs are unique identifiers that directly link to individual users and their activities |
| assigned_to_user_id | Bz_Licenses | Yes | This field directly identifies which user a license is assigned to, making it personally identifiable |
| participant_id | Bz_Participants | Yes | Participant IDs can be used to track individual participation patterns and identify specific users |
| meeting_id | Bz_Participants, Bz_Feature_Usage | Potentially | Meeting IDs may contain information that could indirectly identify participants or meeting content |

## 2. Bronze Layer Logical Model

### 2.1 Bz_Meetings
**Description:** Bronze layer table containing meeting information mirrored from raw meetings data

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| meeting_topic | TEXT | Subject or descriptive title of the meeting session |
| duration_minutes | NUMBER | Total duration of the meeting measured in minutes |
| end_time | TIMESTAMP_NTZ | Timestamp indicating when the meeting concluded |
| start_time | TIMESTAMP_NTZ | Timestamp indicating when the meeting began |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into bronze layer |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified |
| source_system | TEXT | Identifier of the source system from which data originated |

### 2.2 Bz_Licenses
**Description:** Bronze layer table containing license assignment and management information

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| license_type | TEXT | Category or tier of the license (Basic, Pro, Enterprise) |
| end_date | DATE | Expiration date of the license assignment |
| start_date | DATE | Activation date of the license assignment |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into bronze layer |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified |
| source_system | TEXT | Identifier of the source system from which data originated |

### 2.3 Bz_Support_Tickets
**Description:** Bronze layer table containing customer support ticket information

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| resolution_status | TEXT | Current status of the support ticket resolution process |
| open_date | DATE | Date when the support ticket was initially created |
| ticket_type | TEXT | Category classification of the support request |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into bronze layer |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified |
| source_system | TEXT | Identifier of the source system from which data originated |

### 2.4 Bz_Users
**Description:** Bronze layer table containing user profile and account information

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| email | TEXT | Primary email address associated with the user account |
| user_name | TEXT | Display name or username for the platform user |
| plan_type | TEXT | Subscription plan tier assigned to the user |
| company | TEXT | Organization or company name associated with the user |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into bronze layer |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified |
| source_system | TEXT | Identifier of the source system from which data originated |

### 2.5 Bz_Billing_Events
**Description:** Bronze layer table containing financial transaction and billing event information

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| amount | NUMBER | Monetary value associated with the billing transaction |
| event_type | TEXT | Classification of the billing event (Charge, Refund, Credit, Payment) |
| event_date | DATE | Date when the billing event occurred |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into bronze layer |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified |
| source_system | TEXT | Identifier of the source system from which data originated |

### 2.6 Bz_Participants
**Description:** Bronze layer table containing meeting and webinar participation information

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| leave_time | TIMESTAMP_NTZ | Timestamp when the participant exited the session |
| join_time | TIMESTAMP_NTZ | Timestamp when the participant entered the session |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into bronze layer |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified |
| source_system | TEXT | Identifier of the source system from which data originated |

### 2.7 Bz_Webinars
**Description:** Bronze layer table containing webinar event and broadcast information

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| end_time | TIMESTAMP_NTZ | Timestamp indicating when the webinar concluded |
| webinar_topic | TEXT | Subject or descriptive title of the webinar event |
| start_time | TIMESTAMP_NTZ | Timestamp indicating when the webinar began |
| registrants | NUMBER | Total number of users registered for the webinar |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into bronze layer |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified |
| source_system | TEXT | Identifier of the source system from which data originated |

### 2.8 Bz_Feature_Usage
**Description:** Bronze layer table containing platform feature utilization tracking information

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| feature_name | TEXT | Name of the platform feature being tracked |
| usage_date | DATE | Date when the feature usage occurred |
| usage_count | NUMBER | Number of times the feature was utilized |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into bronze layer |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified |
| source_system | TEXT | Identifier of the source system from which data originated |

## 3. Audit Table Design

### 3.1 Bz_Audit_Log
**Description:** Comprehensive audit table for tracking data processing and lineage across all bronze layer tables

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| record_id | TEXT | Unique identifier for each audit log entry |
| source_table | TEXT | Name of the bronze layer table being audited |
| load_timestamp | TIMESTAMP_NTZ | Timestamp when the data processing operation began |
| processed_by | TEXT | Identifier of the system, process, or user performing the operation |
| processing_time | NUMBER | Duration of the processing operation measured in milliseconds |
| status | TEXT | Outcome status of the processing operation (SUCCESS, FAILED, PARTIAL) |

## 4. Conceptual Data Model Diagram

### 4.1 Block Diagram Representation

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Bz_Users      │────│  Bz_Meetings    │────│ Bz_Participants │
│                 │    │                 │    │                 │
│ - email         │    │ - meeting_topic │    │ - join_time     │
│ - user_name     │    │ - duration_min  │    │ - leave_time    │
│ - plan_type     │    │ - start_time    │    │ - load_timestamp│
│ - company       │    │ - end_time      │    │ - update_timestamp│
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       │
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  Bz_Licenses    │    │  Bz_Webinars    │    │Bz_Feature_Usage │
│                 │    │                 │    │                 │
│ - license_type  │    │ - webinar_topic │    │ - feature_name  │
│ - start_date    │    │ - start_time    │    │ - usage_date    │
│ - end_date      │    │ - end_time      │    │ - usage_count   │
│ - load_timestamp│    │ - registrants   │    │ - load_timestamp│
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │
         │                       │
┌─────────────────┐    ┌─────────────────┐
│Bz_Support_Tickets│   │Bz_Billing_Events│
│                 │    │                 │
│ - ticket_type   │    │ - amount        │
│ - open_date     │    │ - event_type    │
│ - resolution_   │    │ - event_date    │
│   status        │    │ - load_timestamp│
└─────────────────┘    └─────────────────┘
```

### 4.2 Table Relationships

| Source Table | Target Table | Connection Key Field | Relationship Type |
|--------------|--------------|---------------------|-------------------|
| Bz_Users | Bz_Meetings | user_name → host_id | One-to-Many |
| Bz_Users | Bz_Webinars | user_name → host_id | One-to-Many |
| Bz_Users | Bz_Licenses | user_name → assigned_to_user_id | One-to-Many |
| Bz_Users | Bz_Support_Tickets | user_name → user_id | One-to-Many |
| Bz_Users | Bz_Billing_Events | user_name → user_id | One-to-Many |
| Bz_Meetings | Bz_Participants | meeting_topic → meeting_id | One-to-Many |
| Bz_Meetings | Bz_Feature_Usage | meeting_topic → meeting_id | One-to-Many |
| Bz_Participants | Bz_Users | participant_id → user_id | Many-to-One |

**Note:** All bronze layer tables maintain referential integrity through business key relationships rather than technical foreign keys, following medallion architecture principles for the bronze layer.