_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Bronze Layer Physical Data Model for Zoom Platform Analytics System following Medallion Architecture principles
## *Version*: 1
## *Updated on*: 
_____________________________________________

# **Bronze Layer DDL Script**

## 1. **Schema Creation**

```sql
-- Create Bronze Schema if not exists
CREATE SCHEMA IF NOT EXISTS Bronze
    COMMENT = 'Bronze layer schema for raw data ingestion in Medallion architecture';
```

## 2. **Bronze Layer Tables**

### 2.1 **Bronze Meetings Table**

```sql
CREATE TABLE IF NOT EXISTS Bronze.bz_meetings (
    meeting_id STRING COMMENT 'Unique identifier for the meeting',
    meeting_topic STRING COMMENT 'Subject or title of the meeting',
    host_id STRING COMMENT 'Identifier of the meeting host',
    start_time TIMESTAMP_NTZ COMMENT 'Meeting start timestamp',
    end_time TIMESTAMP_NTZ COMMENT 'Meeting end timestamp',
    duration_minutes NUMBER COMMENT 'Meeting duration in minutes',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when record was loaded into Bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when record was last updated in source system',
    source_system STRING COMMENT 'Source system identifier'
)
COMMENT = 'Bronze layer table storing raw meeting data from Zoom platform';
```

### 2.2 **Bronze Licenses Table**

```sql
CREATE TABLE IF NOT EXISTS Bronze.bz_licenses (
    license_id STRING COMMENT 'Unique identifier for the license',
    license_type STRING COMMENT 'Type of Zoom license (Basic, Pro, Business, Enterprise)',
    assigned_to_user_id STRING COMMENT 'User ID to whom license is assigned',
    start_date DATE COMMENT 'License validity start date',
    end_date DATE COMMENT 'License validity end date',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when record was loaded into Bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when record was last updated in source system',
    source_system STRING COMMENT 'Source system identifier'
)
COMMENT = 'Bronze layer table storing raw license data from Zoom platform';
```

### 2.3 **Bronze Support Tickets Table**

```sql
CREATE TABLE IF NOT EXISTS Bronze.bz_support_tickets (
    ticket_id STRING COMMENT 'Unique identifier for the support ticket',
    user_id STRING COMMENT 'User ID who created the ticket',
    ticket_type STRING COMMENT 'Type/category of the support ticket',
    resolution_status STRING COMMENT 'Current status of ticket resolution',
    open_date DATE COMMENT 'Date when ticket was opened',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when record was loaded into Bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when record was last updated in source system',
    source_system STRING COMMENT 'Source system identifier'
)
COMMENT = 'Bronze layer table storing raw support ticket data from Zoom platform';
```

### 2.4 **Bronze Users Table**

```sql
CREATE TABLE IF NOT EXISTS Bronze.bz_users (
    user_id STRING COMMENT 'Unique identifier for the user',
    user_name STRING COMMENT 'Full name of the user',
    email STRING COMMENT 'Email address of the user',
    company STRING COMMENT 'Company/organization name',
    plan_type STRING COMMENT 'Zoom plan type for the user',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when record was loaded into Bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when record was last updated in source system',
    source_system STRING COMMENT 'Source system identifier'
)
COMMENT = 'Bronze layer table storing raw user data from Zoom platform';
```

### 2.5 **Bronze Billing Events Table**

```sql
CREATE TABLE IF NOT EXISTS Bronze.bz_billing_events (
    event_id STRING COMMENT 'Unique identifier for the billing event',
    user_id STRING COMMENT 'User ID associated with the billing event',
    event_type STRING COMMENT 'Type of billing event (charge, refund, etc.)',
    event_date DATE COMMENT 'Date when billing event occurred',
    amount NUMBER COMMENT 'Billing amount',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when record was loaded into Bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when record was last updated in source system',
    source_system STRING COMMENT 'Source system identifier'
)
COMMENT = 'Bronze layer table storing raw billing event data from Zoom platform';
```

### 2.6 **Bronze Participants Table**

```sql
CREATE TABLE IF NOT EXISTS Bronze.bz_participants (
    participant_id STRING COMMENT 'Unique identifier for the participant',
    meeting_id STRING COMMENT 'Meeting ID that participant joined',
    user_id STRING COMMENT 'User ID of the participant',
    join_time TIMESTAMP_NTZ COMMENT 'Timestamp when participant joined',
    leave_time TIMESTAMP_NTZ COMMENT 'Timestamp when participant left',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when record was loaded into Bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when record was last updated in source system',
    source_system STRING COMMENT 'Source system identifier'
)
COMMENT = 'Bronze layer table storing raw participant data from Zoom platform';
```

### 2.7 **Bronze Webinars Table**

```sql
CREATE TABLE IF NOT EXISTS Bronze.bz_webinars (
    webinar_id STRING COMMENT 'Unique identifier for the webinar',
    webinar_topic STRING COMMENT 'Subject or title of the webinar',
    host_id STRING COMMENT 'Identifier of the webinar host',
    start_time TIMESTAMP_NTZ COMMENT 'Webinar start timestamp',
    end_time TIMESTAMP_NTZ COMMENT 'Webinar end timestamp',
    registrants NUMBER COMMENT 'Number of registered participants',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when record was loaded into Bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when record was last updated in source system',
    source_system STRING COMMENT 'Source system identifier'
)
COMMENT = 'Bronze layer table storing raw webinar data from Zoom platform';
```

### 2.8 **Bronze Feature Usage Table**

```sql
CREATE TABLE IF NOT EXISTS Bronze.bz_feature_usage (
    usage_id STRING COMMENT 'Unique identifier for the usage record',
    meeting_id STRING COMMENT 'Meeting ID where feature was used',
    feature_name STRING COMMENT 'Name of the Zoom feature used',
    usage_date DATE COMMENT 'Date when feature was used',
    usage_count NUMBER COMMENT 'Number of times feature was used',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when record was loaded into Bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when record was last updated in source system',
    source_system STRING COMMENT 'Source system identifier'
)
COMMENT = 'Bronze layer table storing raw feature usage data from Zoom platform';
```

## 3. **Audit Table**

### 3.1 **Bronze Audit Table**

```sql
CREATE TABLE IF NOT EXISTS Bronze.bz_audit_table (
    record_id NUMBER AUTOINCREMENT COMMENT 'Auto-incrementing unique record identifier',
    source_table STRING COMMENT 'Name of the source table being audited',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when record was processed',
    processed_by STRING COMMENT 'User or process that handled the record',
    processing_time NUMBER COMMENT 'Time taken to process in seconds',
    status STRING COMMENT 'Processing status (SUCCESS, FAILED, WARNING)'
)
COMMENT = 'Audit table for tracking all Bronze layer data processing activities';
```

## 4. **Bronze Layer Design Principles**

### 4.1 **Key Design Features**

• **Raw Data Storage**: All tables store data in its raw format without transformations
• **No Constraints**: No primary keys, foreign keys, or check constraints as per Bronze layer principles
• **Metadata Columns**: All tables include load_timestamp, update_timestamp, and source_system
• **Snowflake Compatibility**: Uses Snowflake-native data types (STRING, NUMBER, DATE, TIMESTAMP_NTZ)
• **Audit Capability**: Dedicated audit table for tracking data processing activities
• **Naming Convention**: Consistent bz_ prefix for all Bronze layer tables
• **Schema Organization**: All tables organized under Bronze schema
• **Documentation**: Comprehensive comments for tables and columns
• **Scalability**: Designed to handle large volumes of raw data ingestion
• **Flexibility**: Structure allows for easy addition of new source systems and data types

### 4.2 **Data Types Used**

• **STRING**: For all text fields (converted from TEXT for Snowflake compatibility)
• **NUMBER**: For numeric values including amounts and counts
• **DATE**: For date-only fields
• **TIMESTAMP_NTZ**: For timestamp fields without timezone
• **NUMBER AUTOINCREMENT**: For auto-incrementing audit record IDs

### 4.3 **Metadata Fields**

Each Bronze layer table includes the following metadata fields:
• **load_timestamp**: When the record was loaded into the Bronze layer
• **update_timestamp**: When the record was last updated in the source system
• **source_system**: Identifier of the origin system from which the data was extracted

### 4.4 **PII Classification**

The following fields have been identified as containing Personally Identifiable Information (PII):
• **email** (bz_users): Personal email addresses
• **user_name** (bz_users): Personal names
• **company** (bz_users): Employer information
• **host_id** (bz_meetings, bz_webinars): User identifiers for hosts
• **user_id** (multiple tables): User identifiers
• **assigned_to_user_id** (bz_licenses): User assignment identifiers
• **participant_id** (bz_participants): Participant identifiers