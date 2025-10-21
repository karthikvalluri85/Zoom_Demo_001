_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Silver Layer Logical Data Model for Zoom Platform Analytics System with standardized data types and comprehensive audit capabilities
## *Version*: 1
## *Updated on*: 
_____________________________________________

# Silver Layer Logical Data Model for Zoom Platform Analytics System

## 1. Silver Layer Logical Model

### 1.1 Si_Meetings
**Description:** Silver layer table containing cleaned and standardized meeting information with enhanced data quality

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| meeting_topic | STRING | Subject or descriptive title of the meeting session, standardized and cleaned |
| duration_minutes | INTEGER | Total duration of the meeting measured in minutes, validated for accuracy |
| end_time | TIMESTAMP | Timestamp indicating when the meeting concluded, standardized to UTC |
| start_time | TIMESTAMP | Timestamp indicating when the meeting began, standardized to UTC |
| load_timestamp | TIMESTAMP | System timestamp when the record was loaded into silver layer |
| update_timestamp | TIMESTAMP | System timestamp when the record was last modified in silver layer |
| source_system | STRING | Identifier of the source system from which data originated |

### 1.2 Si_Licenses
**Description:** Silver layer table containing validated license assignment and management information

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| license_type | STRING | Category or tier of the license (Basic, Pro, Enterprise), standardized values |
| end_date | DATE | Expiration date of the license assignment, validated for logical consistency |
| start_date | DATE | Activation date of the license assignment, validated for logical consistency |
| load_timestamp | TIMESTAMP | System timestamp when the record was loaded into silver layer |
| update_timestamp | TIMESTAMP | System timestamp when the record was last modified in silver layer |
| source_system | STRING | Identifier of the source system from which data originated |

### 1.3 Si_Support_Tickets
**Description:** Silver layer table containing cleaned customer support ticket information with standardized status values

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| resolution_status | STRING | Current status of the support ticket resolution process, standardized values |
| open_date | DATE | Date when the support ticket was initially created, validated for accuracy |
| ticket_type | STRING | Category classification of the support request, standardized categories |
| load_timestamp | TIMESTAMP | System timestamp when the record was loaded into silver layer |
| update_timestamp | TIMESTAMP | System timestamp when the record was last modified in silver layer |
| source_system | STRING | Identifier of the source system from which data originated |

### 1.4 Si_Users
**Description:** Silver layer table containing cleaned and validated user profile and account information

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| email | STRING | Primary email address associated with the user account, validated format |
| user_name | STRING | Display name or username for the platform user, cleaned and standardized |
| plan_type | STRING | Subscription plan tier assigned to the user, standardized values |
| company | STRING | Organization or company name associated with the user, cleaned and standardized |
| load_timestamp | TIMESTAMP | System timestamp when the record was loaded into silver layer |
| update_timestamp | TIMESTAMP | System timestamp when the record was last modified in silver layer |
| source_system | STRING | Identifier of the source system from which data originated |

### 1.5 Si_Billing_Events
**Description:** Silver layer table containing validated financial transaction and billing event information

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| amount | DECIMAL(10,2) | Monetary value associated with the billing transaction, validated for accuracy |
| event_type | STRING | Classification of the billing event (Charge, Refund, Credit, Payment), standardized |
| event_date | DATE | Date when the billing event occurred, validated for logical consistency |
| load_timestamp | TIMESTAMP | System timestamp when the record was loaded into silver layer |
| update_timestamp | TIMESTAMP | System timestamp when the record was last modified in silver layer |
| source_system | STRING | Identifier of the source system from which data originated |

### 1.6 Si_Participants
**Description:** Silver layer table containing validated meeting and webinar participation information

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| leave_time | TIMESTAMP | Timestamp when the participant exited the session, standardized to UTC |
| join_time | TIMESTAMP | Timestamp when the participant entered the session, standardized to UTC |
| load_timestamp | TIMESTAMP | System timestamp when the record was loaded into silver layer |
| update_timestamp | TIMESTAMP | System timestamp when the record was last modified in silver layer |
| source_system | STRING | Identifier of the source system from which data originated |

### 1.7 Si_Webinars
**Description:** Silver layer table containing cleaned webinar event and broadcast information

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| end_time | TIMESTAMP | Timestamp indicating when the webinar concluded, standardized to UTC |
| webinar_topic | STRING | Subject or descriptive title of the webinar event, cleaned and standardized |
| start_time | TIMESTAMP | Timestamp indicating when the webinar began, standardized to UTC |
| registrants | INTEGER | Total number of users registered for the webinar, validated for accuracy |
| load_timestamp | TIMESTAMP | System timestamp when the record was loaded into silver layer |
| update_timestamp | TIMESTAMP | System timestamp when the record was last modified in silver layer |
| source_system | STRING | Identifier of the source system from which data originated |

### 1.8 Si_Feature_Usage
**Description:** Silver layer table containing validated platform feature utilization tracking information

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| feature_name | STRING | Name of the platform feature being tracked, standardized feature names |
| usage_date | DATE | Date when the feature usage occurred, validated for accuracy |
| usage_count | INTEGER | Number of times the feature was utilized, validated for logical consistency |
| load_timestamp | TIMESTAMP | System timestamp when the record was loaded into silver layer |
| update_timestamp | TIMESTAMP | System timestamp when the record was last modified in silver layer |
| source_system | STRING | Identifier of the source system from which data originated |

### 1.9 Si_Data_Quality_Errors
**Description:** Silver layer table for storing data validation errors and quality issues identified during processing

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| error_timestamp | TIMESTAMP | Timestamp when the data quality error was detected |
| source_table | STRING | Name of the source table where the error was found |
| error_type | STRING | Type of data quality error (Missing Value, Invalid Format, Business Rule Violation) |
| error_description | STRING | Detailed description of the data quality issue |
| error_severity | STRING | Severity level of the error (Critical, High, Medium, Low) |
| affected_records | INTEGER | Number of records affected by this error |
| error_column | STRING | Specific column where the error was detected |
| error_value | STRING | The actual value that caused the error |
| validation_rule | STRING | The validation rule that was violated |
| resolution_status | STRING | Current status of error resolution (Open, In Progress, Resolved, Ignored) |
| load_timestamp | TIMESTAMP | System timestamp when the error record was created |
| update_timestamp | TIMESTAMP | System timestamp when the error record was last updated |

### 1.10 Si_Pipeline_Audit
**Description:** Silver layer table for comprehensive audit trail of pipeline execution and data processing activities

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| pipeline_run_id | STRING | Unique identifier for each pipeline execution run |
| pipeline_name | STRING | Name of the data pipeline that was executed |
| execution_start_time | TIMESTAMP | Timestamp when the pipeline execution began |
| execution_end_time | TIMESTAMP | Timestamp when the pipeline execution completed |
| execution_duration_seconds | INTEGER | Total duration of pipeline execution in seconds |
| execution_status | STRING | Final status of pipeline execution (Success, Failed, Partial Success) |
| records_processed | INTEGER | Total number of records processed during execution |
| records_inserted | INTEGER | Number of new records inserted during execution |
| records_updated | INTEGER | Number of existing records updated during execution |
| records_rejected | INTEGER | Number of records rejected due to quality issues |
| source_system | STRING | Source system from which data was processed |
| target_table | STRING | Target table where processed data was loaded |
| error_count | INTEGER | Total number of errors encountered during execution |
| warning_count | INTEGER | Total number of warnings generated during execution |
| data_volume_mb | DECIMAL(10,2) | Volume of data processed in megabytes |
| pipeline_version | STRING | Version of the pipeline that was executed |
| executed_by | STRING | System or user that initiated the pipeline execution |
| configuration_hash | STRING | Hash of pipeline configuration for change tracking |
| load_timestamp | TIMESTAMP | System timestamp when the audit record was created |
| update_timestamp | TIMESTAMP | System timestamp when the audit record was last updated |

## 2. Conceptual Data Model Diagram

### 2.1 Block Diagram Representation

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Si_Users      │────│  Si_Meetings    │────│ Si_Participants │
│                 │    │                 │    │                 │
│ - email         │    │ - meeting_topic │    │ - join_time     │
│ - user_name     │    │ - duration_min  │    │ - leave_time    │
│ - plan_type     │    │ - start_time    │    │ - load_timestamp│
│ - company       │    │ - end_time      │    │ - update_timestamp│
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       │
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  Si_Licenses    │    │  Si_Webinars    │    │Si_Feature_Usage │
│                 │    │                 │    │                 │
│ - license_type  │    │ - webinar_topic │    │ - feature_name  │
│ - start_date    │    │ - start_time    │    │ - usage_date    │
│ - end_date      │    │ - end_time      │    │ - usage_count   │
│ - load_timestamp│    │ - registrants   │    │ - load_timestamp│
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       │
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│Si_Support_Tickets│   │Si_Billing_Events│    │Si_Data_Quality_ │
│                 │    │                 │    │     Errors      │
│ - ticket_type   │    │ - amount        │    │ - error_type    │
│ - open_date     │    │ - event_type    │    │ - source_table  │
│ - resolution_   │    │ - event_date    │    │ - error_severity│
│   status        │    │ - load_timestamp│    │ - affected_records│
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                                       │
                                                       │
                                              ┌─────────────────┐
                                              │ Si_Pipeline_    │
                                              │     Audit       │
                                              │                 │
                                              │ - pipeline_name │
                                              │ - execution_    │
                                              │   status        │
                                              │ - records_      │
                                              │   processed     │
                                              └─────────────────┘
```

### 2.2 Table Relationships

| Source Table | Target Table | Connection Key Field | Relationship Type |
|--------------|--------------|---------------------|-------------------|
| Si_Users | Si_Meetings | user_name → meeting_topic | One-to-Many |
| Si_Users | Si_Webinars | user_name → webinar_topic | One-to-Many |
| Si_Users | Si_Licenses | user_name → license_type | One-to-Many |
| Si_Users | Si_Support_Tickets | user_name → ticket_type | One-to-Many |
| Si_Users | Si_Billing_Events | user_name → event_type | One-to-Many |
| Si_Meetings | Si_Participants | meeting_topic → join_time | One-to-Many |
| Si_Meetings | Si_Feature_Usage | meeting_topic → feature_name | One-to-Many |
| Si_Participants | Si_Users | join_time → user_name | Many-to-One |
| Si_Data_Quality_Errors | Si_Pipeline_Audit | error_timestamp → pipeline_run_id | Many-to-One |
| Si_Pipeline_Audit | All Silver Tables | pipeline_run_id → load_timestamp | One-to-Many |

### 2.3 Data Quality and Audit Integration

| Audit Table | Monitored Tables | Connection Method |
|-------------|------------------|-------------------|
| Si_Data_Quality_Errors | All Si_ Tables | source_table field references table names |
| Si_Pipeline_Audit | All Si_ Tables | target_table field references destination tables |
| Si_Pipeline_Audit | Si_Data_Quality_Errors | pipeline_run_id links execution to error detection |

**Note:** The Silver layer maintains data lineage and quality through comprehensive audit tables while providing cleaned, standardized data for Gold layer consumption. All timestamp fields are standardized to UTC, and data types are optimized for analytical processing. The error and audit tables ensure complete traceability of data processing operations and quality issues.