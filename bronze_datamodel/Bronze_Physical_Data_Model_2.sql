_____________________________________________
## *Author*: AAVA
## *Created on*: 2024-01-15
## *Description*: Bronze Layer Physical Data Model for Zoom Platform Analytics System following Medallion Architecture principles with aligned schema naming conventions
## *Version*: 2
## *Changes*: Updated schema naming convention from 'Bronze.bz_' to 'ZOOM_BRONZE_SCHEMA.bz_' to align with raw schema naming pattern (ZOOM_RAW_SCHEMA → ZOOM_BRONZE_SCHEMA)
## *Reason*: Alignment with raw schema naming conventions ensures consistency across data layers and improves data governance
## *Updated on*: 2024-01-15
_____________________________________________

# Bronze Layer Physical Data Model - Version 2
## Zoom Platform Analytics System - Medallion Architecture

### 1. Overview
This document defines the physical data model for the Bronze layer of the Zoom Platform Analytics System, implementing the Medallion Architecture pattern. The Bronze layer serves as the raw data ingestion layer, storing data in its original format with minimal transformation while adding essential metadata for data lineage and processing tracking.

### 2. Design Principles

#### 2.1 Bronze Layer Characteristics
• **Raw Data Preservation**: Store data in its original format with minimal transformation
• **Schema-on-Read**: Flexible schema design to accommodate source system changes
• **Audit Trail**: Complete lineage tracking with load timestamps and source system identification
• **Idempotent Loading**: Support for reprocessing and data recovery scenarios
• **Snowflake Optimization**: Leveraging Snowflake-specific features for performance and scalability

#### 2.2 Naming Conventions
• **Schema**: ZOOM_BRONZE_SCHEMA
• **Tables**: bz_[table_name] (Bronze prefix)
• **Columns**: snake_case naming convention
• **Metadata Columns**: Standardized across all tables (load_timestamp, update_timestamp, source_system)

#### 2.3 Data Types Strategy
• **Snowflake Native Types**: Using STRING, NUMBER, DATE, TIMESTAMP_NTZ, BOOLEAN
• **Flexible Sizing**: Generous column sizes to accommodate source system variations
• **No Constraints**: No primary keys, foreign keys, or check constraints in Bronze layer
• **Null Handling**: All columns nullable to handle incomplete source data

### 3. Schema Creation

```sql
-- Create Bronze Schema
CREATE SCHEMA IF NOT EXISTS ZOOM_BRONZE_SCHEMA
COMMENT = 'Bronze layer schema for Zoom Platform Analytics - Raw data ingestion with minimal transformation';

-- Set schema context
USE SCHEMA ZOOM_BRONZE_SCHEMA;
```

### 4. Bronze Layer Tables

#### 4.1 Meetings Table
```sql
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_meetings (
    -- Business Columns
    meeting_id STRING COMMENT 'Unique identifier for the meeting',
    meeting_topic STRING COMMENT 'Topic or title of the meeting',
    host_id STRING COMMENT 'Identifier of the meeting host',
    start_time TIMESTAMP_NTZ COMMENT 'Meeting start timestamp',
    end_time TIMESTAMP_NTZ COMMENT 'Meeting end timestamp',
    duration_minutes NUMBER COMMENT 'Meeting duration in minutes',
    
    -- Metadata Columns
    load_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was loaded into Bronze layer',
    update_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was last updated',
    source_system STRING DEFAULT 'ZOOM_API' COMMENT 'Source system identifier'
)
COMMENT = 'Bronze layer table storing raw meeting data from Zoom platform';
```

#### 4.2 Licenses Table
```sql
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_licenses (
    -- Business Columns
    license_id STRING COMMENT 'Unique identifier for the license',
    license_type STRING COMMENT 'Type of license (Basic, Pro, Business, Enterprise)',
    assigned_to_user_id STRING COMMENT 'User ID to whom the license is assigned',
    start_date DATE COMMENT 'License start date',
    end_date DATE COMMENT 'License end date',
    
    -- Metadata Columns
    load_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was loaded into Bronze layer',
    update_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was last updated',
    source_system STRING DEFAULT 'ZOOM_API' COMMENT 'Source system identifier'
)
COMMENT = 'Bronze layer table storing raw license data from Zoom platform';
```

#### 4.3 Support Tickets Table
```sql
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_support_tickets (
    -- Business Columns
    ticket_id STRING COMMENT 'Unique identifier for the support ticket',
    user_id STRING COMMENT 'User ID who created the ticket',
    ticket_type STRING COMMENT 'Type of support ticket',
    open_date DATE COMMENT 'Date when ticket was opened',
    resolution_status STRING COMMENT 'Current status of the ticket',
    
    -- Metadata Columns
    load_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was loaded into Bronze layer',
    update_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was last updated',
    source_system STRING DEFAULT 'ZOOM_SUPPORT' COMMENT 'Source system identifier'
)
COMMENT = 'Bronze layer table storing raw support ticket data from Zoom support system';
```

#### 4.4 Users Table
```sql
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_users (
    -- Business Columns
    user_id STRING COMMENT 'Unique identifier for the user',
    user_name STRING COMMENT 'User display name',
    email STRING COMMENT 'User email address',
    company STRING COMMENT 'Company name',
    plan_type STRING COMMENT 'User plan type',
    
    -- Metadata Columns
    load_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was loaded into Bronze layer',
    update_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was last updated',
    source_system STRING DEFAULT 'ZOOM_API' COMMENT 'Source system identifier'
)
COMMENT = 'Bronze layer table storing raw user data from Zoom platform';
```

#### 4.5 Billing Events Table
```sql
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_billing_events (
    -- Business Columns
    event_id STRING COMMENT 'Unique identifier for the billing event',
    user_id STRING COMMENT 'User ID associated with the billing event',
    event_type STRING COMMENT 'Type of billing event',
    event_date DATE COMMENT 'Date of the billing event',
    amount NUMBER(10,2) COMMENT 'Billing amount',
    
    -- Metadata Columns
    load_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was loaded into Bronze layer',
    update_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was last updated',
    source_system STRING DEFAULT 'ZOOM_BILLING' COMMENT 'Source system identifier'
)
COMMENT = 'Bronze layer table storing raw billing event data from Zoom billing system';
```

#### 4.6 Participants Table
```sql
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_participants (
    -- Business Columns
    participant_id STRING COMMENT 'Unique identifier for the participant',
    meeting_id STRING COMMENT 'Meeting ID where participant joined',
    user_id STRING COMMENT 'User ID of the participant',
    join_time TIMESTAMP_NTZ COMMENT 'Timestamp when participant joined',
    leave_time TIMESTAMP_NTZ COMMENT 'Timestamp when participant left',
    
    -- Metadata Columns
    load_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was loaded into Bronze layer',
    update_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was last updated',
    source_system STRING DEFAULT 'ZOOM_API' COMMENT 'Source system identifier'
)
COMMENT = 'Bronze layer table storing raw participant data from Zoom meetings';
```

#### 4.7 Webinars Table
```sql
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_webinars (
    -- Business Columns
    webinar_id STRING COMMENT 'Unique identifier for the webinar',
    webinar_topic STRING COMMENT 'Topic or title of the webinar',
    host_id STRING COMMENT 'Identifier of the webinar host',
    start_time TIMESTAMP_NTZ COMMENT 'Webinar start timestamp',
    end_time TIMESTAMP_NTZ COMMENT 'Webinar end timestamp',
    registrants NUMBER COMMENT 'Number of registrants',
    
    -- Metadata Columns
    load_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was loaded into Bronze layer',
    update_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was last updated',
    source_system STRING DEFAULT 'ZOOM_API' COMMENT 'Source system identifier'
)
COMMENT = 'Bronze layer table storing raw webinar data from Zoom platform';
```

#### 4.8 Feature Usage Table
```sql
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_feature_usage (
    -- Business Columns
    usage_id STRING COMMENT 'Unique identifier for the usage record',
    meeting_id STRING COMMENT 'Meeting ID where feature was used',
    feature_name STRING COMMENT 'Name of the feature used',
    usage_date DATE COMMENT 'Date of feature usage',
    usage_count NUMBER COMMENT 'Number of times feature was used',
    
    -- Metadata Columns
    load_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was loaded into Bronze layer',
    update_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was last updated',
    source_system STRING DEFAULT 'ZOOM_API' COMMENT 'Source system identifier'
)
COMMENT = 'Bronze layer table storing raw feature usage data from Zoom platform';
```

### 5. Audit Table

#### 5.1 Bronze Layer Audit Table
```sql
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_audit_table (
    -- Audit Columns
    record_id NUMBER AUTOINCREMENT COMMENT 'Auto-incrementing unique identifier for audit record',
    source_table STRING COMMENT 'Name of the source table being audited',
    load_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when audit record was created',
    processed_by STRING COMMENT 'Process or user that performed the operation',
    processing_time NUMBER COMMENT 'Time taken to process in milliseconds',
    status STRING COMMENT 'Status of the processing (SUCCESS, FAILED, WARNING)',
    record_count NUMBER COMMENT 'Number of records processed',
    error_message STRING COMMENT 'Error message if processing failed',
    
    -- Metadata Columns
    created_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when audit record was created'
)
COMMENT = 'Audit table for tracking all Bronze layer data processing activities';
```

### 6. Data Loading Patterns

#### 6.1 Incremental Loading Template
```sql
-- Example incremental loading pattern for meetings table
MERGE INTO ZOOM_BRONZE_SCHEMA.bz_meetings AS target
USING (
    SELECT 
        meeting_id,
        meeting_topic,
        host_id,
        start_time,
        end_time,
        duration_minutes,
        CURRENT_TIMESTAMP() AS load_timestamp,
        CURRENT_TIMESTAMP() AS update_timestamp,
        'ZOOM_API' AS source_system
    FROM ZOOM_RAW_SCHEMA.meetings
    WHERE update_timestamp > (
        SELECT COALESCE(MAX(update_timestamp), '1900-01-01'::TIMESTAMP_NTZ)
        FROM ZOOM_BRONZE_SCHEMA.bz_meetings
    )
) AS source
ON target.meeting_id = source.meeting_id
WHEN MATCHED THEN
    UPDATE SET
        meeting_topic = source.meeting_topic,
        host_id = source.host_id,
        start_time = source.start_time,
        end_time = source.end_time,
        duration_minutes = source.duration_minutes,
        update_timestamp = source.update_timestamp
WHEN NOT MATCHED THEN
    INSERT (
        meeting_id, meeting_topic, host_id, start_time, end_time, 
        duration_minutes, load_timestamp, update_timestamp, source_system
    )
    VALUES (
        source.meeting_id, source.meeting_topic, source.host_id, 
        source.start_time, source.end_time, source.duration_minutes,
        source.load_timestamp, source.update_timestamp, source.source_system
    );
```

#### 6.2 Audit Logging Template
```sql
-- Example audit logging for data processing
INSERT INTO ZOOM_BRONZE_SCHEMA.bz_audit_table (
    source_table,
    processed_by,
    processing_time,
    status,
    record_count,
    error_message
)
VALUES (
    'bz_meetings',
    'ETL_PROCESS_MEETINGS',
    :processing_time_ms,
    'SUCCESS',
    :records_processed,
    NULL
);
```

### 7. Performance Optimization

#### 7.1 Clustering Recommendations
```sql
-- Cluster large tables by frequently filtered columns
ALTER TABLE ZOOM_BRONZE_SCHEMA.bz_meetings 
CLUSTER BY (DATE(start_time), host_id);

ALTER TABLE ZOOM_BRONZE_SCHEMA.bz_participants 
CLUSTER BY (DATE(join_time), meeting_id);

ALTER TABLE ZOOM_BRONZE_SCHEMA.bz_feature_usage 
CLUSTER BY (usage_date, feature_name);
```

#### 7.2 Table Maintenance
```sql
-- Monitor table statistics
SELECT 
    table_name,
    row_count,
    bytes,
    clustering_key,
    SYSTEM$CLUSTERING_INFORMATION(table_name, clustering_key) as clustering_info
FROM information_schema.tables 
WHERE table_schema = 'ZOOM_BRONZE_SCHEMA'
AND table_type = 'BASE TABLE';
```

### 8. Data Quality Checks

#### 8.1 Data Validation Queries
```sql
-- Check for duplicate records
SELECT 
    'bz_meetings' as table_name,
    COUNT(*) as total_records,
    COUNT(DISTINCT meeting_id) as unique_records,
    COUNT(*) - COUNT(DISTINCT meeting_id) as duplicates
FROM ZOOM_BRONZE_SCHEMA.bz_meetings

UNION ALL

SELECT 
    'bz_users' as table_name,
    COUNT(*) as total_records,
    COUNT(DISTINCT user_id) as unique_records,
    COUNT(*) - COUNT(DISTINCT user_id) as duplicates
FROM ZOOM_BRONZE_SCHEMA.bz_users;

-- Check for null values in key columns
SELECT 
    'bz_meetings' as table_name,
    'meeting_id' as column_name,
    COUNT(*) as total_records,
    SUM(CASE WHEN meeting_id IS NULL THEN 1 ELSE 0 END) as null_count
FROM ZOOM_BRONZE_SCHEMA.bz_meetings

UNION ALL

SELECT 
    'bz_users' as table_name,
    'user_id' as column_name,
    COUNT(*) as total_records,
    SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) as null_count
FROM ZOOM_BRONZE_SCHEMA.bz_users;
```

### 9. Security and Access Control

#### 9.1 Role-Based Access
```sql
-- Create roles for Bronze layer access
CREATE ROLE IF NOT EXISTS BRONZE_READ_ROLE;
CREATE ROLE IF NOT EXISTS BRONZE_WRITE_ROLE;

-- Grant permissions
GRANT USAGE ON SCHEMA ZOOM_BRONZE_SCHEMA TO ROLE BRONZE_READ_ROLE;
GRANT SELECT ON ALL TABLES IN SCHEMA ZOOM_BRONZE_SCHEMA TO ROLE BRONZE_READ_ROLE;

GRANT USAGE ON SCHEMA ZOOM_BRONZE_SCHEMA TO ROLE BRONZE_WRITE_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA ZOOM_BRONZE_SCHEMA TO ROLE BRONZE_WRITE_ROLE;
```

### 10. Monitoring and Alerting

#### 10.1 Data Freshness Monitoring
```sql
-- Monitor data freshness across Bronze tables
SELECT 
    table_name,
    MAX(load_timestamp) as last_load_time,
    DATEDIFF('hour', MAX(load_timestamp), CURRENT_TIMESTAMP()) as hours_since_last_load
FROM (
    SELECT 'bz_meetings' as table_name, load_timestamp FROM ZOOM_BRONZE_SCHEMA.bz_meetings
    UNION ALL
    SELECT 'bz_users' as table_name, load_timestamp FROM ZOOM_BRONZE_SCHEMA.bz_users
    UNION ALL
    SELECT 'bz_licenses' as table_name, load_timestamp FROM ZOOM_BRONZE_SCHEMA.bz_licenses
    UNION ALL
    SELECT 'bz_support_tickets' as table_name, load_timestamp FROM ZOOM_BRONZE_SCHEMA.bz_support_tickets
    UNION ALL
    SELECT 'bz_billing_events' as table_name, load_timestamp FROM ZOOM_BRONZE_SCHEMA.bz_billing_events
    UNION ALL
    SELECT 'bz_participants' as table_name, load_timestamp FROM ZOOM_BRONZE_SCHEMA.bz_participants
    UNION ALL
    SELECT 'bz_webinars' as table_name, load_timestamp FROM ZOOM_BRONZE_SCHEMA.bz_webinars
    UNION ALL
    SELECT 'bz_feature_usage' as table_name, load_timestamp FROM ZOOM_BRONZE_SCHEMA.bz_feature_usage
)
GROUP BY table_name
ORDER BY hours_since_last_load DESC;
```

### 11. Implementation Guidelines

#### 11.1 Deployment Sequence
1. **Schema Creation**: Create ZOOM_BRONZE_SCHEMA
2. **Table Creation**: Deploy all Bronze layer tables in dependency order
3. **Audit Table**: Create audit table for process tracking
4. **Security Setup**: Configure roles and permissions
5. **Clustering**: Apply clustering keys to large tables
6. **Monitoring**: Implement data quality and freshness checks

#### 11.2 Best Practices
• **Idempotent Scripts**: All DDL scripts should use IF NOT EXISTS
• **Error Handling**: Implement comprehensive error handling in ETL processes
• **Documentation**: Maintain up-to-date documentation for all schema changes
• **Version Control**: Track all schema changes through version control
• **Testing**: Validate all changes in development environment before production deployment

### 12. Change Management

#### 12.1 Schema Evolution
• **Additive Changes**: New columns can be added without impact
• **Column Modifications**: Use ALTER TABLE statements for data type changes
• **Table Restructuring**: Plan for data migration when major changes are required
• **Backward Compatibility**: Maintain compatibility with existing ETL processes

#### 12.2 Version Control
• **Schema Versioning**: Track schema versions in metadata
• **Migration Scripts**: Maintain scripts for version upgrades
• **Rollback Plans**: Prepare rollback procedures for each deployment

---

**Document Control:**
- Version: 2.0
- Last Updated: 2024-01-15
- Next Review: 2024-04-15
- Approved By: Data Architecture Team

**Related Documents:**
- Raw Layer Physical Data Model
- Silver Layer Logical Data Model
- Data Governance Standards
- Snowflake Best Practices Guide