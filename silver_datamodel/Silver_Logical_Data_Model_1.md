_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Silver Layer Logical Data Model for Zoom Platform Analytics System
## *Version*: 1
## *Updated on*: 
_____________________________________________

# Silver Layer Logical Data Model for Zoom Platform Analytics System

## 1. Silver Layer Logical Model

### 1.1 Si_Users
**Description:** Silver layer table containing standardized and validated user profile information with enhanced data quality

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| email | STRING | Standardized primary email address with format validation and domain verification |
| user_name | STRING | Cleansed and normalized display name with consistent formatting |
| plan_type | STRING | Standardized subscription plan type with controlled vocabulary (Basic, Pro, Business, Enterprise) |
| company | STRING | Normalized company name with standardized formatting and duplicate resolution |
| load_timestamp | TIMESTAMP_NTZ | UTC timestamp when record was processed into silver layer with millisecond precision |
| update_timestamp | TIMESTAMP_NTZ | UTC timestamp of last modification with change tracking capabilities |
| source_system | STRING | Validated source system identifier with lineage tracking |

### 1.2 Si_Meetings
**Description:** Silver layer table containing enriched and validated meeting session data with quality metrics

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| meeting_topic | STRING | Cleansed meeting subject with standardized formatting and content validation |
| duration_minutes | NUMBER | Validated meeting duration with business rule compliance (0-2880 minutes) |
| end_time | TIMESTAMP_NTZ | Standardized meeting end timestamp in UTC with timezone normalization |
| start_time | TIMESTAMP_NTZ | Standardized meeting start timestamp in UTC with timezone normalization |
| load_timestamp | TIMESTAMP_NTZ | UTC timestamp when record was processed into silver layer with millisecond precision |
| update_timestamp | TIMESTAMP_NTZ | UTC timestamp of last modification with change tracking capabilities |
| source_system | STRING | Validated source system identifier with lineage tracking |

### 1.3 Si_Licenses
**Description:** Silver layer table containing validated license allocation data with compliance tracking

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| license_type | STRING | Standardized license category with controlled vocabulary and validation |
| end_date | DATE | Validated license expiration date with business rule compliance |
| start_date | DATE | Validated license activation date with temporal consistency checks |
| load_timestamp | TIMESTAMP_NTZ | UTC timestamp when record was processed into silver layer with millisecond precision |
| update_timestamp | TIMESTAMP_NTZ | UTC timestamp of last modification with change tracking capabilities |
| source_system | STRING | Validated source system identifier with lineage tracking |

### 1.4 Si_Support_Tickets
**Description:** Silver layer table containing standardized customer support data with resolution analytics

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| resolution_status | STRING | Standardized ticket status with controlled vocabulary (Open, In Progress, Resolved, Closed) |
| open_date | DATE | Validated ticket creation date with temporal consistency validation |
| ticket_type | STRING | Standardized ticket category with controlled classification (Technical, Billing, General) |
| load_timestamp | TIMESTAMP_NTZ | UTC timestamp when record was processed into silver layer with millisecond precision |
| update_timestamp | TIMESTAMP_NTZ | UTC timestamp of last modification with change tracking capabilities |
| source_system | STRING | Validated source system identifier with lineage tracking |

### 1.5 Si_Billing_Events
**Description:** Silver layer table containing validated financial transaction data with compliance controls

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| amount | NUMBER | Validated monetary amount with precision controls and range validation |
| event_type | STRING | Standardized billing event classification (Charge, Refund, Credit, Payment) |
| event_date | DATE | Validated transaction date with temporal consistency and business rule compliance |
| load_timestamp | TIMESTAMP_NTZ | UTC timestamp when record was processed into silver layer with millisecond precision |
| update_timestamp | TIMESTAMP_NTZ | UTC timestamp of last modification with change tracking capabilities |
| source_system | STRING | Validated source system identifier with lineage tracking |

### 1.6 Si_Participants
**Description:** Silver layer table containing validated participant engagement data with quality metrics

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| leave_time | TIMESTAMP_NTZ | Standardized participant exit timestamp with UTC normalization and validation |
| join_time | TIMESTAMP_NTZ | Standardized participant entry timestamp with UTC normalization and validation |
| load_timestamp | TIMESTAMP_NTZ | UTC timestamp when record was processed into silver layer with millisecond precision |
| update_timestamp | TIMESTAMP_NTZ | UTC timestamp of last modification with change tracking capabilities |
| source_system | STRING | Validated source system identifier with lineage tracking |

### 1.7 Si_Webinars
**Description:** Silver layer table containing enriched webinar event data with registration analytics

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| end_time | TIMESTAMP_NTZ | Standardized webinar end timestamp with UTC normalization and validation |
| webinar_topic | STRING | Cleansed webinar subject with standardized formatting and content validation |
| start_time | TIMESTAMP_NTZ | Standardized webinar start timestamp with UTC normalization and validation |
| registrants | NUMBER | Validated registration count with range validation and business rule compliance |
| load_timestamp | TIMESTAMP_NTZ | UTC timestamp when record was processed into silver layer with millisecond precision |
| update_timestamp | TIMESTAMP_NTZ | UTC timestamp of last modification with change tracking capabilities |
| source_system | STRING | Validated source system identifier with lineage tracking |

### 1.8 Si_Feature_Usage
**Description:** Silver layer table containing standardized platform feature utilization analytics

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| feature_name | STRING | Standardized feature name with controlled vocabulary and validation |
| usage_date | DATE | Validated usage date with temporal consistency and business rule compliance |
| usage_count | NUMBER | Validated usage frequency with range validation and outlier detection |
| load_timestamp | TIMESTAMP_NTZ | UTC timestamp when record was processed into silver layer with millisecond precision |
| update_timestamp | TIMESTAMP_NTZ | UTC timestamp of last modification with change tracking capabilities |
| source_system | STRING | Validated source system identifier with lineage tracking |

### 1.9 Si_Data_Quality_Errors
**Description:** Silver layer table for capturing and tracking data validation errors and quality issues

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| source_table_name | STRING | Name of the source table where the data quality issue was detected |
| error_type | STRING | Classification of data quality error (Missing Value, Format Error, Business Rule Violation, Duplicate Record) |
| error_description | STRING | Detailed description of the specific data quality issue encountered |
| error_severity | STRING | Severity level of the error (Critical, High, Medium, Low) |
| affected_column | STRING | Name of the column where the data quality issue was identified |
| error_value | STRING | The actual value that caused the data quality violation |
| expected_format | STRING | Expected format or value range for the affected field |
| error_timestamp | TIMESTAMP_NTZ | UTC timestamp when the data quality error was detected |
| resolution_status | STRING | Current status of error resolution (New, In Progress, Resolved, Ignored) |
| resolution_timestamp | TIMESTAMP_NTZ | UTC timestamp when the error was resolved or addressed |
| load_timestamp | TIMESTAMP_NTZ | UTC timestamp when the error record was created in silver layer |
| update_timestamp | TIMESTAMP_NTZ | UTC timestamp of last modification to the error record |
| source_system | STRING | Source system where the original data quality issue originated |

### 1.10 Si_Process_Audit
**Description:** Silver layer table for comprehensive audit trail of data pipeline execution and processing activities

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| pipeline_name | STRING | Name of the data pipeline or process that was executed |
| execution_id | STRING | Unique identifier for each pipeline execution instance |
| process_type | STRING | Type of data processing operation (Extract, Transform, Load, Validate, Cleanse) |
| process_status | STRING | Final status of the pipeline execution (Success, Failed, Partial Success, Warning) |
| start_timestamp | TIMESTAMP_NTZ | UTC timestamp when the pipeline execution began |
| end_timestamp | TIMESTAMP_NTZ | UTC timestamp when the pipeline execution completed |
| execution_duration_seconds | NUMBER | Total execution time in seconds with millisecond precision |
| records_processed | NUMBER | Total number of records processed during the execution |
| records_successful | NUMBER | Number of records successfully processed without errors |
| records_failed | NUMBER | Number of records that failed processing due to errors |
| records_skipped | NUMBER | Number of records skipped due to business rules or filters |
| error_summary | STRING | Summary of errors encountered during pipeline execution |
| performance_metrics | STRING | JSON formatted performance metrics and resource utilization data |
| executed_by | STRING | Identifier of the system, service, or user that initiated the pipeline |
| configuration_version | STRING | Version of the pipeline configuration used for execution |
| data_lineage_info | STRING | JSON formatted data lineage and dependency information |
| load_timestamp | TIMESTAMP_NTZ | UTC timestamp when the audit record was created in silver layer |
| update_timestamp | TIMESTAMP_NTZ | UTC timestamp of last modification to the audit record |
| source_system | STRING | Source system or component that generated the audit information |

## 2. Conceptual Data Model Diagram

### 2.1 Silver Layer Entity Relationships (Block Diagram Format)

```
┌─────────────────────┐    ┌─────────────────────┐    ┌─────────────────────┐
│     Si_Users        │────│    Si_Meetings      │────│   Si_Participants   │
│                     │    │                     │    │                     │
│ • email             │    │ • meeting_topic     │    │ • join_time         │
│ • user_name         │    │ • duration_minutes  │    │ • leave_time        │
│ • plan_type         │    │ • start_time        │    │ • load_timestamp    │
│ • company           │    │ • end_time          │    │ • update_timestamp  │
│ • load_timestamp    │    │ • load_timestamp    │    │ • source_system     │
│ • update_timestamp  │    │ • update_timestamp  │    │                     │
│ • source_system     │    │ • source_system     │    │                     │
└─────────────────────┘    └─────────────────────┘    └─────────────────────┘
         │                           │                           │
         │                           │                           │
         ▼                           ▼                           ▼
┌─────────────────────┐    ┌─────────────────────┐    ┌─────────────────────┐
│    Si_Licenses      │    │    Si_Webinars      │    │  Si_Feature_Usage   │
│                     │    │                     │    │                     │
│ • license_type      │    │ • webinar_topic     │    │ • feature_name      │
│ • start_date        │    │ • start_time        │    │ • usage_date        │
│ • end_date          │    │ • end_time          │    │ • usage_count       │
│ • load_timestamp    │    │ • registrants       │    │ • load_timestamp    │
│ • update_timestamp  │    │ • load_timestamp    │    │ • update_timestamp  │
│ • source_system     │    │ • update_timestamp  │    │ • source_system     │
│                     │    │ • source_system     │    │                     │
└─────────────────────┘    └─────────────────────┘    └─────────────────────┘
         │                           │
         │                           │
         ▼                           ▼
┌─────────────────────┐    ┌─────────────────────┐
│ Si_Support_Tickets  │    │  Si_Billing_Events  │
│                     │    │                     │
│ • resolution_status │    │ • amount            │
│ • open_date         │    │ • event_type        │
│ • ticket_type       │    │ • event_date        │
│ • load_timestamp    │    │ • load_timestamp    │
│ • update_timestamp  │    │ • update_timestamp  │
│ • source_system     │    │ • source_system     │
└─────────────────────┘    └─────────────────────┘

                    ┌─────────────────────────┐
                    │ Si_Data_Quality_Errors  │
                    │                         │
                    │ • source_table_name     │
                    │ • error_type            │
                    │ • error_description     │
                    │ • error_severity        │
                    │ • affected_column       │
                    │ • error_value           │
                    │ • expected_format       │
                    │ • error_timestamp       │
                    │ • resolution_status     │
                    │ • resolution_timestamp  │
                    └─────────────────────────┘
                                │
                                │
                                ▼
                    ┌─────────────────────────┐
                    │   Si_Process_Audit      │
                    │                         │
                    │ • pipeline_name         │
                    │ • execution_id          │
                    │ • process_type          │
                    │ • process_status        │
                    │ • start_timestamp       │
                    │ • end_timestamp         │
                    │ • execution_duration    │
                    │ • records_processed     │
                    │ • records_successful    │
                    │ • records_failed        │
                    │ • error_summary         │
                    │ • performance_metrics   │
                    └─────────────────────────┘
```

### 2.2 Cross-Layer Relationships

| Silver Table | Bronze Source Table | Connection Key Field | Relationship Type | Business Rule |
|--------------|-------------------|---------------------|-------------------|---------------|
| Si_Users | Bz_Users | email | One-to-One | Direct transformation with data cleansing and validation |
| Si_Meetings | Bz_Meetings | meeting_topic | One-to-One | Direct transformation with temporal validation and standardization |
| Si_Licenses | Bz_Licenses | license_type + start_date | One-to-One | Direct transformation with date validation and type standardization |
| Si_Support_Tickets | Bz_Support_Tickets | ticket_type + open_date | One-to-One | Direct transformation with status standardization |
| Si_Billing_Events | Bz_Billing_Events | event_type + event_date | One-to-One | Direct transformation with amount validation |
| Si_Participants | Bz_Participants | join_time + leave_time | One-to-One | Direct transformation with temporal consistency validation |
| Si_Webinars | Bz_Webinars | webinar_topic | One-to-One | Direct transformation with registration count validation |
| Si_Feature_Usage | Bz_Feature_Usage | feature_name + usage_date | One-to-One | Direct transformation with usage count validation |
| Si_Data_Quality_Errors | All Bronze Tables | source_table_name | One-to-Many | Captures validation errors from all bronze table transformations |
| Si_Process_Audit | All Silver Tables | pipeline_name | One-to-Many | Tracks processing activities for all silver layer operations |

## 3. Data Transformation Rules and Design Decisions

### 3.1 Key Design Decisions

1. **ID Field Removal**: All primary keys, foreign keys, and unique identifier fields have been removed from Bronze tables as per requirements, maintaining only business attributes and metadata.

2. **Naming Convention**: Consistent 'Si_' prefix applied to all Silver layer table names for clear layer identification and governance.

3. **Data Type Standardization**: 
   - All timestamp fields standardized to TIMESTAMP_NTZ with UTC timezone normalization
   - Text fields standardized to STRING data type with UTF-8 encoding
   - Numeric fields standardized to NUMBER with appropriate precision
   - Date fields standardized to DATE type with ISO 8601 format

4. **Data Quality Enhancement**:
   - Email validation with RFC 5322 compliance
   - Controlled vocabularies for categorical fields
   - Range validation for numeric fields
   - Temporal consistency checks for date/time fields
   - Duplicate detection and resolution

5. **Audit and Error Handling**:
   - Comprehensive error tracking table (Si_Data_Quality_Errors)
   - Detailed process audit table (Si_Process_Audit)
   - Complete data lineage tracking
   - Performance metrics collection

### 3.2 Data Validation Rules Applied

1. **Email Validation**: Email addresses validated against RFC 5322 standards with domain verification
2. **Timestamp Standardization**: All timestamps converted to UTC with millisecond precision
3. **Duration Validation**: Meeting and webinar durations validated within business acceptable ranges (0-2880 minutes)
4. **Status Standardization**: All status fields mapped to controlled vocabularies
5. **Numeric Range Validation**: Amount and count fields validated within acceptable business ranges
6. **Temporal Consistency**: Start/end time relationships validated for logical consistency
7. **Text Cleansing**: Standardized formatting, trimming, and encoding for all text fields

### 3.3 Business Rule Implementation

1. **Meeting Duration Logic**: Calculated duration must equal (end_time - start_time) with validation
2. **Participant Time Logic**: Leave time must be greater than or equal to join time
3. **License Date Logic**: End date must be greater than start date
4. **Quality Thresholds**: Data quality scores maintained above 95% completeness threshold
5. **Retention Compliance**: All data retention policies enforced through metadata tracking

### 3.4 Performance Optimization

1. **Indexing Strategy**: Optimized for analytical queries on timestamp and categorical fields
2. **Partitioning**: Date-based partitioning for large tables (meetings, participants, feature usage)
3. **Compression**: Appropriate compression algorithms for storage optimization
4. **Caching**: Frequently accessed reference data cached for performance

### 3.5 Security and Compliance

1. **PII Handling**: Personal identifiable information encrypted and access-controlled
2. **Audit Logging**: Complete audit trail for all data modifications and access
3. **Data Classification**: All fields classified by sensitivity level
4. **Retention Policies**: Automated data retention and archival processes
5. **Access Control**: Role-based access control with principle of least privilege

This Silver Layer Logical Data Model provides a robust foundation for analytical processing while maintaining data quality, governance, and compliance requirements for the Zoom Platform Analytics System.