_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Silver Layer Logical Data Model for Zoom Platform Analytics System following medallion architecture principles with data quality and audit structures
## *Version*: 1
## *Updated on*: 
_____________________________________________

# Silver Layer Logical Data Model for Zoom Platform Analytics System

## 1. Silver Layer Logical Model

### 1.1 Si_Users
**Description:** Silver layer table containing cleaned and standardized user profile information with data quality validations

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| email | STRING | Standardized and validated primary email address for user authentication and communication |
| user_name | STRING | Cleaned display name of the user with consistent formatting |
| plan_type | STRING | Standardized subscription plan type (Basic, Pro, Business, Enterprise) |
| company | STRING | Normalized company or organization name with consistent formatting |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into silver layer |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified in silver layer |
| source_system | STRING | Identifier of the source system from which data originated |
| data_quality_score | NUMBER(5,3) | Calculated data quality score based on completeness and accuracy metrics |
| is_active | BOOLEAN | Derived flag indicating if user is currently active based on business rules |

### 1.2 Si_Meetings
**Description:** Silver layer table containing cleaned meeting session data with enhanced analytics and quality metrics

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| meeting_topic | STRING | Cleaned and standardized subject or descriptive title of the meeting |
| duration_minutes | NUMBER | Validated total meeting duration in minutes with outlier detection |
| end_time | TIMESTAMP_NTZ | Standardized meeting end timestamp in UTC format |
| start_time | TIMESTAMP_NTZ | Standardized meeting start timestamp in UTC format |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into silver layer |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified in silver layer |
| source_system | STRING | Identifier of the source system from which data originated |
| meeting_duration_category | STRING | Derived categorization of meeting length (Short, Medium, Long, Extended) |
| is_valid_meeting | BOOLEAN | Data quality flag indicating if meeting data passes validation rules |
| time_zone_offset | NUMBER | Calculated time zone offset for proper temporal analysis |

### 1.3 Si_Licenses
**Description:** Silver layer table containing validated license allocation and subscription management information

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| license_type | STRING | Standardized license category or tier (Basic, Pro, Enterprise) with consistent naming |
| end_date | DATE | Validated license expiration date with future date validation |
| start_date | DATE | Validated license activation date with logical date validation |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into silver layer |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified in silver layer |
| source_system | STRING | Identifier of the source system from which data originated |
| license_duration_days | NUMBER | Calculated license duration in days for analytics |
| is_active_license | BOOLEAN | Derived flag indicating if license is currently active |
| license_tier_rank | NUMBER | Numerical ranking of license tier for analytical purposes |

### 1.4 Si_Support_Tickets
**Description:** Silver layer table containing standardized customer support ticket information with resolution analytics

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| resolution_status | STRING | Standardized current status of support ticket (Open, In Progress, Resolved, Closed) |
| open_date | DATE | Validated date when the support ticket was initially created |
| ticket_type | STRING | Standardized category classification of the support request |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into silver layer |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified in silver layer |
| source_system | STRING | Identifier of the source system from which data originated |
| days_since_opened | NUMBER | Calculated number of days since ticket was opened |
| is_overdue | BOOLEAN | Derived flag indicating if ticket resolution is overdue |
| priority_level | STRING | Derived priority level based on ticket type and age |

### 1.5 Si_Billing_Events
**Description:** Silver layer table containing validated financial transaction and billing event information

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| amount | NUMBER(15,2) | Validated monetary value with proper decimal precision and currency standardization |
| event_type | STRING | Standardized billing event classification (Charge, Refund, Credit, Payment) |
| event_date | DATE | Validated date when the billing event occurred |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into silver layer |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified in silver layer |
| source_system | STRING | Identifier of the source system from which data originated |
| amount_category | STRING | Derived categorization of transaction amount (Small, Medium, Large) |
| is_revenue_event | BOOLEAN | Derived flag indicating if event contributes to revenue |
| fiscal_quarter | STRING | Calculated fiscal quarter for financial reporting |

### 1.6 Si_Participants
**Description:** Silver layer table containing validated meeting and webinar participation information with engagement metrics

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| leave_time | TIMESTAMP_NTZ | Validated timestamp when participant exited the session |
| join_time | TIMESTAMP_NTZ | Validated timestamp when participant entered the session |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into silver layer |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified in silver layer |
| source_system | STRING | Identifier of the source system from which data originated |
| participation_duration_minutes | NUMBER | Calculated participation duration in minutes |
| engagement_level | STRING | Derived engagement level (Low, Medium, High) based on participation duration |
| is_valid_participation | BOOLEAN | Data quality flag indicating valid join/leave time sequence |

### 1.7 Si_Webinars
**Description:** Silver layer table containing validated webinar event and broadcast information with attendance analytics

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| end_time | TIMESTAMP_NTZ | Standardized webinar end timestamp in UTC format |
| webinar_topic | STRING | Cleaned and standardized subject or descriptive title of the webinar |
| start_time | TIMESTAMP_NTZ | Standardized webinar start timestamp in UTC format |
| registrants | NUMBER | Validated total number of users registered for the webinar |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into silver layer |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified in silver layer |
| source_system | STRING | Identifier of the source system from which data originated |
| webinar_duration_minutes | NUMBER | Calculated webinar duration in minutes |
| registration_category | STRING | Derived categorization based on registration count (Small, Medium, Large, Mega) |
| is_successful_webinar | BOOLEAN | Derived flag indicating successful webinar completion |

### 1.8 Si_Feature_Usage
**Description:** Silver layer table containing standardized platform feature utilization tracking with usage analytics

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| feature_name | STRING | Standardized name of the platform feature being tracked |
| usage_date | DATE | Validated date when the feature usage occurred |
| usage_count | NUMBER | Validated number of times the feature was utilized |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the record was loaded into silver layer |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the record was last modified in silver layer |
| source_system | STRING | Identifier of the source system from which data originated |
| usage_intensity | STRING | Derived usage intensity level (Low, Medium, High, Very High) |
| is_peak_usage | BOOLEAN | Derived flag indicating if usage occurred during peak hours |
| feature_category | STRING | Standardized feature category for analytical grouping |

### 1.9 Si_Data_Quality_Errors
**Description:** Silver layer table for storing data validation errors and quality issues identified during processing

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| source_table | STRING | Name of the source table where the error was detected |
| error_type | STRING | Classification of the data quality error (Missing Value, Invalid Format, Business Rule Violation) |
| error_description | STRING | Detailed description of the specific data quality issue |
| error_severity | STRING | Severity level of the error (Critical, High, Medium, Low) |
| affected_column | STRING | Name of the column where the error was detected |
| error_value | STRING | The actual value that caused the error |
| detection_timestamp | TIMESTAMP_NTZ | Timestamp when the error was detected |
| resolution_status | STRING | Current status of error resolution (Open, In Progress, Resolved, Ignored) |
| resolution_timestamp | TIMESTAMP_NTZ | Timestamp when the error was resolved |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the error record was created |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the error record was last updated |

### 1.10 Si_Process_Audit
**Description:** Silver layer table for comprehensive audit trail of data processing pipeline execution and performance

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| process_name | STRING | Name of the data processing pipeline or job |
| execution_start_time | TIMESTAMP_NTZ | Timestamp when the process execution began |
| execution_end_time | TIMESTAMP_NTZ | Timestamp when the process execution completed |
| execution_duration_seconds | NUMBER | Total execution time in seconds |
| records_processed | NUMBER | Total number of records processed during execution |
| records_successful | NUMBER | Number of records successfully processed |
| records_failed | NUMBER | Number of records that failed processing |
| success_rate_percentage | NUMBER(5,2) | Calculated success rate as percentage |
| process_status | STRING | Overall status of the process execution (Success, Failed, Partial Success) |
| error_message | STRING | Error message if process failed or encountered issues |
| resource_usage_cpu | NUMBER(5,2) | CPU usage percentage during process execution |
| resource_usage_memory | NUMBER(10,2) | Memory usage in MB during process execution |
| data_volume_mb | NUMBER(15,2) | Total data volume processed in megabytes |
| load_timestamp | TIMESTAMP_NTZ | System timestamp when the audit record was created |
| update_timestamp | TIMESTAMP_NTZ | System timestamp when the audit record was last updated |

## 2. Conceptual Data Model Diagram

### 2.1 Silver Layer Block Diagram

```
┌─────────────────────┐    ┌─────────────────────┐    ┌─────────────────────┐
│     Si_Users        │────│    Si_Meetings      │────│   Si_Participants   │
│                     │    │                     │    │                     │
│ - email             │    │ - meeting_topic     │    │ - join_time         │
│ - user_name         │    │ - duration_minutes  │    │ - leave_time        │
│ - plan_type         │    │ - start_time        │    │ - participation_    │
│ - company           │    │ - end_time          │    │   duration_minutes  │
│ - data_quality_score│    │ - meeting_duration_ │    │ - engagement_level  │
│ - is_active         │    │   category          │    │ - is_valid_         │
│                     │    │ - is_valid_meeting  │    │   participation     │
└─────────────────────┘    └─────────────────────┘    └─────────────────────┘
         │                           │                           │
         │                           │                           │
┌─────────────────────┐    ┌─────────────────────┐    ┌─────────────────────┐
│    Si_Licenses      │    │    Si_Webinars      │    │  Si_Feature_Usage   │
│                     │    │                     │    │                     │
│ - license_type      │    │ - webinar_topic     │    │ - feature_name      │
│ - start_date        │    │ - start_time        │    │ - usage_date        │
│ - end_date          │    │ - end_time          │    │ - usage_count       │
│ - license_duration_ │    │ - registrants       │    │ - usage_intensity   │
│   days              │    │ - webinar_duration_ │    │ - is_peak_usage     │
│ - is_active_license │    │   minutes           │    │ - feature_category  │
│ - license_tier_rank │    │ - registration_     │    │                     │
│                     │    │   category          │    │                     │
└─────────────────────┘    └─────────────────────┘    └─────────────────────┘
         │                           │
         │                           │
┌─────────────────────┐    ┌─────────────────────┐
│ Si_Support_Tickets  │    │  Si_Billing_Events  │
│                     │    │                     │
│ - resolution_status │    │ - amount            │
│ - open_date         │    │ - event_type        │
│ - ticket_type       │    │ - event_date        │
│ - days_since_opened │    │ - amount_category   │
│ - is_overdue        │    │ - is_revenue_event  │
│ - priority_level    │    │ - fiscal_quarter    │
└─────────────────────┘    └─────────────────────┘

┌─────────────────────┐    ┌─────────────────────┐
│Si_Data_Quality_Errors│   │   Si_Process_Audit  │
│                     │    │                     │
│ - source_table      │    │ - process_name      │
│ - error_type        │    │ - execution_start_  │
│ - error_description │    │   time              │
│ - error_severity    │    │ - execution_end_    │
│ - affected_column   │    │   time              │
│ - detection_        │    │ - records_processed │
│   timestamp         │    │ - success_rate_     │
│ - resolution_status │    │   percentage        │
│                     │    │ - process_status    │
└─────────────────────┘    └─────────────────────┘
```

### 2.2 Table Relationships and Data Flow

| Source Entity | Target Entity | Relationship Key Field | Relationship Type | Business Rule |
|---------------|---------------|----------------------|-------------------|---------------|
| Si_Users | Si_Meetings | user_name → meeting_host | One-to-Many | Each user can host multiple meetings, each meeting has one primary host |
| Si_Users | Si_Webinars | user_name → webinar_host | One-to-Many | Each user can host multiple webinars, each webinar has one primary host |
| Si_Users | Si_Licenses | user_name → license_holder | One-to-Many | Each user can have multiple license assignments over time |
| Si_Users | Si_Support_Tickets | user_name → ticket_creator | One-to-Many | Each user can create multiple support tickets |
| Si_Users | Si_Billing_Events | user_name → billing_user | One-to-Many | Each user can have multiple billing events |
| Si_Meetings | Si_Participants | meeting_topic → session_meeting | One-to-Many | Each meeting can have multiple participants |
| Si_Meetings | Si_Feature_Usage | meeting_topic → usage_session | One-to-Many | Each meeting can generate multiple feature usage records |
| Si_Webinars | Si_Participants | webinar_topic → session_webinar | One-to-Many | Each webinar can have multiple participants |
| Si_Participants | Si_Users | participant_name → user_name | Many-to-One | Multiple participation records can belong to one user |
| All Tables | Si_Data_Quality_Errors | table_name → source_table | One-to-Many | Each table can have multiple data quality errors |
| All Tables | Si_Process_Audit | table_name → processed_table | Many-to-Many | Multiple tables can be processed in one audit cycle |

### 2.3 Data Quality and Audit Integration

#### Data Quality Framework
- **Si_Data_Quality_Errors**: Captures all data validation failures, format issues, and business rule violations
- **Error Classification**: Categorizes errors by type, severity, and resolution status
- **Error Tracking**: Maintains complete lifecycle of error detection, investigation, and resolution
- **Quality Metrics**: Enables calculation of data quality scores and trend analysis

#### Process Audit Framework
- **Si_Process_Audit**: Comprehensive tracking of all ETL pipeline executions
- **Performance Monitoring**: Captures execution times, resource usage, and throughput metrics
- **Success Rate Tracking**: Monitors processing success rates and failure patterns
- **Resource Optimization**: Provides data for performance tuning and capacity planning

#### Silver Layer Enhancements
- **Data Standardization**: Consistent formatting, validation, and cleansing across all entities
- **Derived Attributes**: Business-relevant calculated fields for enhanced analytics
- **Quality Flags**: Boolean indicators for data validity and completeness
- **Temporal Consistency**: Standardized timestamp handling and time zone management
- **Business Rule Validation**: Implementation of comprehensive business logic validation

### 2.4 Key Silver Layer Features

#### Data Transformation Capabilities
1. **Data Cleansing**: Standardization of formats, removal of duplicates, and data validation
2. **Data Enrichment**: Addition of calculated fields, categorizations, and derived metrics
3. **Data Validation**: Implementation of business rules and data quality checks
4. **Data Standardization**: Consistent data types, formats, and naming conventions

#### Quality Assurance Features
1. **Completeness Validation**: Ensuring all required fields are populated
2. **Accuracy Checks**: Validation against business rules and logical constraints
3. **Consistency Verification**: Cross-table validation and referential integrity
4. **Timeliness Monitoring**: Tracking data freshness and processing delays

#### Audit and Governance
1. **Data Lineage**: Complete tracking of data transformation from bronze to silver
2. **Change Tracking**: Monitoring of data modifications and updates
3. **Access Logging**: Recording of all data access and usage patterns
4. **Compliance Monitoring**: Ensuring adherence to data governance policies