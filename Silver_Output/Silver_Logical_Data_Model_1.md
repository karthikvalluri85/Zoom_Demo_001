_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Silver Layer Logical Data Model for Zoom Platform Analytics System
## *Version*: 1
## *Updated on*: 
_____________________________________________

# Silver Layer Logical Data Model

## 1. Silver Layer Logical Model

### 1.1 Si_Users
**Description:** Silver layer table containing cleaned and standardized user profile information with data quality validations applied

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| email | VARCHAR(255) | Primary email address associated with the user account, validated for RFC 5322 compliance |
| user_name | VARCHAR(100) | Display name or username for the platform user, standardized for consistent formatting |
| plan_type | VARCHAR(50) | Subscription plan tier assigned to the user (Basic, Pro, Business, Enterprise) |
| company | VARCHAR(200) | Organization or company name associated with the user, standardized and cleaned |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into silver layer in UTC format |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified in UTC format |
| source_system | VARCHAR(100) | Identifier of the source system from which data originated |
| data_quality_score | DECIMAL(5,3) | Overall data quality score for the record (0.000-100.000) |
| validation_status | VARCHAR(20) | Data validation status (VALID, INVALID, PENDING, CORRECTED) |

### 1.2 Si_Meetings
**Description:** Silver layer table containing cleaned meeting session data with standardized duration calculations and quality metrics

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| meeting_topic | VARCHAR(500) | Subject or descriptive title of the meeting session, cleaned and standardized |
| duration_minutes | INTEGER | Total duration of the meeting measured in minutes (range: 0-2880) |
| end_time | TIMESTAMP_NTZ | Timestamp indicating when the meeting concluded in UTC format |
| start_time | TIMESTAMP_NTZ | Timestamp indicating when the meeting began in UTC format |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into silver layer in UTC format |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified in UTC format |
| source_system | VARCHAR(100) | Identifier of the source system from which data originated |
| data_quality_score | DECIMAL(5,3) | Overall data quality score for the record (0.000-100.000) |
| validation_status | VARCHAR(20) | Data validation status (VALID, INVALID, PENDING, CORRECTED) |

### 1.3 Si_Licenses
**Description:** Silver layer table containing standardized license assignment and management information with validation rules applied

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| license_type | VARCHAR(50) | Category or tier of the license (Basic, Pro, Enterprise), standardized values |
| end_date | DATE | Expiration date of the license assignment, validated for logical consistency |
| start_date | DATE | Activation date of the license assignment, validated for logical consistency |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into silver layer in UTC format |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified in UTC format |
| source_system | VARCHAR(100) | Identifier of the source system from which data originated |
| data_quality_score | DECIMAL(5,3) | Overall data quality score for the record (0.000-100.000) |
| validation_status | VARCHAR(20) | Data validation status (VALID, INVALID, PENDING, CORRECTED) |

### 1.4 Si_Support_Tickets
**Description:** Silver layer table containing standardized customer support ticket information with status validation

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| resolution_status | VARCHAR(50) | Current status of the support ticket resolution process, standardized values |
| open_date | DATE | Date when the support ticket was initially created, validated for consistency |
| ticket_type | VARCHAR(50) | Category classification of the support request, standardized taxonomy |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into silver layer in UTC format |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified in UTC format |
| source_system | VARCHAR(100) | Identifier of the source system from which data originated |
| data_quality_score | DECIMAL(5,3) | Overall data quality score for the record (0.000-100.000) |
| validation_status | VARCHAR(20) | Data validation status (VALID, INVALID, PENDING, CORRECTED) |

### 1.5 Si_Billing_Events
**Description:** Silver layer table containing validated financial transaction and billing event information with currency standardization

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| amount | DECIMAL(15,2) | Monetary value associated with the billing transaction, validated for accuracy |
| event_type | VARCHAR(50) | Classification of the billing event (Charge, Refund, Credit, Payment) |
| event_date | DATE | Date when the billing event occurred, validated for temporal consistency |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into silver layer in UTC format |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified in UTC format |
| source_system | VARCHAR(100) | Identifier of the source system from which data originated |
| data_quality_score | DECIMAL(5,3) | Overall data quality score for the record (0.000-100.000) |
| validation_status | VARCHAR(20) | Data validation status (VALID, INVALID, PENDING, CORRECTED) |

### 1.6 Si_Participants
**Description:** Silver layer table containing validated meeting and webinar participation information with engagement calculations

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| leave_time | TIMESTAMP_NTZ | Timestamp when the participant exited the session in UTC format |
| join_time | TIMESTAMP_NTZ | Timestamp when the participant entered the session in UTC format |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into silver layer in UTC format |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified in UTC format |
| source_system | VARCHAR(100) | Identifier of the source system from which data originated |
| data_quality_score | DECIMAL(5,3) | Overall data quality score for the record (0.000-100.000) |
| validation_status | VARCHAR(20) | Data validation status (VALID, INVALID, PENDING, CORRECTED) |

### 1.7 Si_Webinars
**Description:** Silver layer table containing standardized webinar event information with registration metrics validation

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| end_time | TIMESTAMP_NTZ | Timestamp indicating when the webinar concluded in UTC format |
| webinar_topic | VARCHAR(500) | Subject or descriptive title of the webinar event, cleaned and standardized |
| start_time | TIMESTAMP_NTZ | Timestamp indicating when the webinar began in UTC format |
| registrants | INTEGER | Total number of users registered for the webinar (range: 1-10000) |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into silver layer in UTC format |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified in UTC format |
| source_system | VARCHAR(100) | Identifier of the source system from which data originated |
| data_quality_score | DECIMAL(5,3) | Overall data quality score for the record (0.000-100.000) |
| validation_status | VARCHAR(20) | Data validation status (VALID, INVALID, PENDING, CORRECTED) |

### 1.8 Si_Feature_Usage
**Description:** Silver layer table containing standardized platform feature utilization tracking with usage pattern validation

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| feature_name | VARCHAR(100) | Name of the platform feature being tracked, standardized taxonomy |
| usage_date | DATE | Date when the feature usage occurred, validated for consistency |
| usage_count | INTEGER | Number of times the feature was utilized, validated for reasonableness |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into silver layer in UTC format |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified in UTC format |
| source_system | VARCHAR(100) | Identifier of the source system from which data originated |
| data_quality_score | DECIMAL(5,3) | Overall data quality score for the record (0.000-100.000) |
| validation_status | VARCHAR(20) | Data validation status (VALID, INVALID, PENDING, CORRECTED) |

### 1.9 Si_Data_Quality_Errors
**Description:** Silver layer table for storing data quality validation errors and exceptions identified during processing

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| source_table | VARCHAR(100) | Name of the source table where the error was detected |
| error_type | VARCHAR(50) | Classification of the data quality error (MISSING_VALUE, INVALID_FORMAT, CONSTRAINT_VIOLATION) |
| error_description | VARCHAR(1000) | Detailed description of the data quality issue identified |
| column_name | VARCHAR(100) | Name of the column where the error was detected |
| error_value | VARCHAR(500) | The actual value that caused the validation error |
| severity_level | VARCHAR(20) | Severity classification of the error (LOW, MEDIUM, HIGH, CRITICAL) |
| detection_timestamp | TIMESTAMP_NTZ | Timestamp when the error was detected in UTC format |
| resolution_status | VARCHAR(20) | Current status of error resolution (OPEN, IN_PROGRESS, RESOLVED, IGNORED) |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the error record was created in UTC format |
| source_system | VARCHAR(100) | Identifier of the source system from which data originated |

### 1.10 Si_Process_Audit
**Description:** Silver layer table for comprehensive audit trail of data processing operations and pipeline execution details

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| source_table | VARCHAR(100) | Name of the table being processed in the pipeline operation |
| process_name | VARCHAR(100) | Name of the data processing pipeline or operation |
| process_start_time | TIMESTAMP_NTZ | Timestamp when the processing operation began in UTC format |
| process_end_time | TIMESTAMP_NTZ | Timestamp when the processing operation completed in UTC format |
| processing_duration_ms | BIGINT | Duration of the processing operation in milliseconds |
| records_processed | BIGINT | Total number of records processed in the operation |
| records_success | BIGINT | Number of records successfully processed |
| records_failed | BIGINT | Number of records that failed processing |
| process_status | VARCHAR(20) | Overall status of the processing operation (SUCCESS, FAILED, PARTIAL, WARNING) |
| error_message | VARCHAR(2000) | Detailed error message if processing failed or had warnings |
| processed_by | VARCHAR(100) | Identifier of the system, process, or user that executed the operation |
| pipeline_version | VARCHAR(50) | Version identifier of the processing pipeline used |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the audit record was created in UTC format |
| source_system | VARCHAR(100) | Identifier of the source system from which data originated |

## 2. Conceptual Data Model Diagram

### 2.1 Silver Layer Block Diagram

```
┌─────────────────────┐    ┌─────────────────────┐    ┌─────────────────────┐
│     Si_Users        │────│    Si_Meetings      │────│   Si_Participants   │
│                     │    │                     │    │                     │
│ - email             │    │ - meeting_topic     │    │ - join_time         │
│ - user_name         │    │ - duration_minutes  │    │ - leave_time        │
│ - plan_type         │    │ - start_time        │    │ - load_timestamp    │
│ - company           │    │ - end_time          │    │ - update_timestamp  │
│ - data_quality_score│    │ - data_quality_score│    │ - data_quality_score│
│ - validation_status │    │ - validation_status │    │ - validation_status │
└─────────────────────┘    └─────────────────────┘    └─────────────────────┘
         │                           │                           │
         │                           │                           │
         ▼                           ▼                           ▼
┌─────────────────────┐    ┌─────────────────────┐    ┌─────────────────────┐
│    Si_Licenses      │    │    Si_Webinars      │    │  Si_Feature_Usage   │
│                     │    │                     │    │                     │
│ - license_type      │    │ - webinar_topic     │    │ - feature_name      │
│ - start_date        │    │ - start_time        │    │ - usage_date        │
│ - end_date          │    │ - end_time          │    │ - usage_count       │
│ - data_quality_score│    │ - registrants       │    │ - data_quality_score│
│ - validation_status │    │ - data_quality_score│    │ - validation_status │
└─────────────────────┘    │ - validation_status │    └─────────────────────┘
         │                  └─────────────────────┘             │
         │                           │                           │
         ▼                           ▼                           ▼
┌─────────────────────┐    ┌─────────────────────┐    ┌─────────────────────┐
│ Si_Support_Tickets  │    │  Si_Billing_Events  │    │Si_Data_Quality_Errors│
│                     │    │                     │    │                     │
│ - ticket_type       │    │ - amount            │    │ - source_table      │
│ - open_date         │    │ - event_type        │    │ - error_type        │
│ - resolution_status │    │ - event_date        │    │ - error_description │
│ - data_quality_score│    │ - data_quality_score│    │ - severity_level    │
│ - validation_status │    │ - validation_status │    │ - resolution_status │
└─────────────────────┘    └─────────────────────┘    └─────────────────────┘
                                    │
                                    ▼
                           ┌─────────────────────┐
                           │   Si_Process_Audit  │
                           │                     │
                           │ - process_name      │
                           │ - process_start_time│
                           │ - process_end_time  │
                           │ - records_processed │
                           │ - process_status    │
                           │ - processed_by      │
                           └─────────────────────┘
```

### 2.2 Table Relationships and Connections

| Source Table | Target Table | Connection Method | Relationship Description |
|--------------|--------------|-------------------|-------------------------|
| Si_Users | Si_Meetings | Business Logic Connection | Users are connected to meetings through host relationships |
| Si_Users | Si_Webinars | Business Logic Connection | Users are connected to webinars through host relationships |
| Si_Users | Si_Licenses | Business Logic Connection | Users are assigned licenses through business rules |
| Si_Users | Si_Support_Tickets | Business Logic Connection | Users create and own support tickets |
| Si_Users | Si_Billing_Events | Business Logic Connection | Users generate billing events through usage |
| Si_Meetings | Si_Participants | Business Logic Connection | Meetings contain multiple participants |
| Si_Meetings | Si_Feature_Usage | Business Logic Connection | Meetings generate feature usage events |
| Si_Webinars | Si_Participants | Business Logic Connection | Webinars contain multiple participants |
| Si_Data_Quality_Errors | All Tables | Monitoring Connection | Tracks data quality issues across all silver tables |
| Si_Process_Audit | All Tables | Processing Connection | Audits processing operations for all silver tables |

**Note:** Silver layer maintains business relationships through data lineage and processing logic rather than technical foreign keys, following medallion architecture principles for the silver layer with enhanced data quality and audit capabilities.