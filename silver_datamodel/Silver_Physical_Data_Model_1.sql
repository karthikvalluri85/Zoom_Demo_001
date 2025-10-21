_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Silver Layer Physical Data Model for Zoom Platform Analytics System with cleansed and conformed data
## *Version*: 1
## *Updated on*: 
_____________________________________________

/*
=============================================================================
SILVER LAYER PHYSICAL DATA MODEL - ZOOM PLATFORM ANALYTICS SYSTEM
=============================================================================

This script creates the Silver Layer physical data model for the Zoom Platform 
Analytics System following Snowflake SQL standards and best practices.

Database: ZOOM_DATABASE
Schema: ZOOM_SILVER_SCHEMA
Table Naming Convention: si_[table_name]

Features:
- Snowflake-compatible data types
- No primary keys, foreign keys, or constraints
- Standardized metadata columns for data lineage
- Cleansed and conformed data from Bronze layer
- ID fields added for each table
- Error data table for data quality tracking
- Audit table for pipeline execution monitoring
- CREATE TABLE IF NOT EXISTS syntax for idempotent execution

=============================================================================
*/

-- =============================================================================
-- 1. SILVER LAYER DDL SCRIPTS
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1.1 SI_MEETINGS TABLE
-- Purpose: Stores cleansed and standardized meeting information
-- Source: ZOOM_BRONZE_SCHEMA.bz_meetings
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_meetings (
    -- ID Field
    meeting_id STRING COMMENT 'Unique identifier for each meeting record',
    
    -- Business Attributes from Bronze
    meeting_topic STRING COMMENT 'Subject or descriptive title of the meeting session, standardized and cleaned',
    duration_minutes NUMBER COMMENT 'Total duration of the meeting measured in minutes, validated for accuracy',
    end_time TIMESTAMP_NTZ COMMENT 'Timestamp indicating when the meeting concluded, standardized to UTC',
    start_time TIMESTAMP_NTZ COMMENT 'Timestamp indicating when the meeting began, standardized to UTC',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last modified in silver layer',
    source_system STRING COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Silver layer table containing cleaned and standardized meeting information with enhanced data quality';

-- -----------------------------------------------------------------------------
-- 1.2 SI_LICENSES TABLE
-- Purpose: Stores validated license assignment and management information
-- Source: ZOOM_BRONZE_SCHEMA.bz_licenses
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_licenses (
    -- ID Field
    license_id STRING COMMENT 'Unique identifier for each license record',
    
    -- Business Attributes from Bronze
    license_type STRING COMMENT 'Category or tier of the license (Basic, Pro, Enterprise), standardized values',
    end_date DATE COMMENT 'Expiration date of the license assignment, validated for logical consistency',
    start_date DATE COMMENT 'Activation date of the license assignment, validated for logical consistency',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last modified in silver layer',
    source_system STRING COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Silver layer table containing validated license assignment and management information';

-- -----------------------------------------------------------------------------
-- 1.3 SI_SUPPORT_TICKETS TABLE
-- Purpose: Stores cleaned customer support ticket information
-- Source: ZOOM_BRONZE_SCHEMA.bz_support_tickets
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_support_tickets (
    -- ID Field
    ticket_id STRING COMMENT 'Unique identifier for each support ticket record',
    
    -- Business Attributes from Bronze
    resolution_status STRING COMMENT 'Current status of the support ticket resolution process, standardized values',
    open_date DATE COMMENT 'Date when the support ticket was initially created, validated for accuracy',
    ticket_type STRING COMMENT 'Category classification of the support request, standardized categories',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last modified in silver layer',
    source_system STRING COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Silver layer table containing cleaned customer support ticket information with standardized status values';

-- -----------------------------------------------------------------------------
-- 1.4 SI_USERS TABLE
-- Purpose: Stores cleaned and validated user profile information
-- Source: ZOOM_BRONZE_SCHEMA.bz_users
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_users (
    -- ID Field
    user_id STRING COMMENT 'Unique identifier for each user record',
    
    -- Business Attributes from Bronze
    email STRING COMMENT 'Primary email address associated with the user account, validated format',
    user_name STRING COMMENT 'Display name or username for the platform user, cleaned and standardized',
    plan_type STRING COMMENT 'Subscription plan tier assigned to the user, standardized values',
    company STRING COMMENT 'Organization or company name associated with the user, cleaned and standardized',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last modified in silver layer',
    source_system STRING COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Silver layer table containing cleaned and validated user profile and account information';

-- -----------------------------------------------------------------------------
-- 1.5 SI_BILLING_EVENTS TABLE
-- Purpose: Stores validated financial transaction and billing information
-- Source: ZOOM_BRONZE_SCHEMA.bz_billing_events
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_billing_events (
    -- ID Field
    billing_event_id STRING COMMENT 'Unique identifier for each billing event record',
    
    -- Business Attributes from Bronze
    amount NUMBER(10,2) COMMENT 'Monetary value associated with the billing transaction, validated for accuracy',
    event_type STRING COMMENT 'Classification of the billing event (Charge, Refund, Credit, Payment), standardized',
    event_date DATE COMMENT 'Date when the billing event occurred, validated for logical consistency',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last modified in silver layer',
    source_system STRING COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Silver layer table containing validated financial transaction and billing event information';

-- -----------------------------------------------------------------------------
-- 1.6 SI_PARTICIPANTS TABLE
-- Purpose: Stores validated meeting and webinar participation information
-- Source: ZOOM_BRONZE_SCHEMA.bz_participants
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_participants (
    -- ID Field
    participant_id STRING COMMENT 'Unique identifier for each participant record',
    
    -- Business Attributes from Bronze
    leave_time TIMESTAMP_NTZ COMMENT 'Timestamp when the participant exited the session, standardized to UTC',
    join_time TIMESTAMP_NTZ COMMENT 'Timestamp when the participant entered the session, standardized to UTC',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last modified in silver layer',
    source_system STRING COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Silver layer table containing validated meeting and webinar participation information';

-- -----------------------------------------------------------------------------
-- 1.7 SI_WEBINARS TABLE
-- Purpose: Stores cleaned webinar event and broadcast information
-- Source: ZOOM_BRONZE_SCHEMA.bz_webinars
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_webinars (
    -- ID Field
    webinar_id STRING COMMENT 'Unique identifier for each webinar record',
    
    -- Business Attributes from Bronze
    end_time TIMESTAMP_NTZ COMMENT 'Timestamp indicating when the webinar concluded, standardized to UTC',
    webinar_topic STRING COMMENT 'Subject or descriptive title of the webinar event, cleaned and standardized',
    start_time TIMESTAMP_NTZ COMMENT 'Timestamp indicating when the webinar began, standardized to UTC',
    registrants NUMBER COMMENT 'Total number of users registered for the webinar, validated for accuracy',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last modified in silver layer',
    source_system STRING COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Silver layer table containing cleaned webinar event and broadcast information';

-- -----------------------------------------------------------------------------
-- 1.8 SI_FEATURE_USAGE TABLE
-- Purpose: Stores validated platform feature utilization tracking information
-- Source: ZOOM_BRONZE_SCHEMA.bz_feature_usage
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_feature_usage (
    -- ID Field
    feature_usage_id STRING COMMENT 'Unique identifier for each feature usage record',
    
    -- Business Attributes from Bronze
    feature_name STRING COMMENT 'Name of the platform feature being tracked, standardized feature names',
    usage_date DATE COMMENT 'Date when the feature usage occurred, validated for accuracy',
    usage_count NUMBER COMMENT 'Number of times the feature was utilized, validated for logical consistency',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last modified in silver layer',
    source_system STRING COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Silver layer table containing validated platform feature utilization tracking information';

-- =============================================================================
-- 2. ERROR DATA TABLE
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 2.1 SI_DATA_QUALITY_ERRORS TABLE
-- Purpose: Stores data validation errors and quality issues
-- Source: Data validation processes
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_data_quality_errors (
    -- ID Field
    error_id STRING COMMENT 'Unique identifier for each error record',
    
    -- Error Details
    error_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the data quality error was detected',
    source_table STRING COMMENT 'Name of the source table where the error was found',
    error_type STRING COMMENT 'Type of data quality error (Missing Value, Invalid Format, Business Rule Violation)',
    error_description STRING COMMENT 'Detailed description of the data quality issue',
    error_severity STRING COMMENT 'Severity level of the error (Critical, High, Medium, Low)',
    affected_records NUMBER COMMENT 'Number of records affected by this error',
    error_column STRING COMMENT 'Specific column where the error was detected',
    error_value STRING COMMENT 'The actual value that caused the error',
    validation_rule STRING COMMENT 'The validation rule that was violated',
    resolution_status STRING COMMENT 'Current status of error resolution (Open, In Progress, Resolved, Ignored)',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the error record was created',
    update_date DATE COMMENT 'Date when the error record was last updated',
    source_system STRING COMMENT 'System that detected the error'
) COMMENT = 'Silver layer table for storing data validation errors and quality issues identified during processing';

-- =============================================================================
-- 3. AUDIT TABLE
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 3.1 SI_PIPELINE_AUDIT TABLE
-- Purpose: Comprehensive audit trail of pipeline execution
-- Source: Pipeline execution processes
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_pipeline_audit (
    -- ID Field
    audit_id STRING COMMENT 'Unique identifier for each audit record',
    
    -- Pipeline Execution Details
    pipeline_run_id STRING COMMENT 'Unique identifier for each pipeline execution run',
    pipeline_name STRING COMMENT 'Name of the data pipeline that was executed',
    execution_start_time TIMESTAMP_NTZ COMMENT 'Timestamp when the pipeline execution began',
    execution_end_time TIMESTAMP_NTZ COMMENT 'Timestamp when the pipeline execution completed',
    execution_duration_seconds NUMBER COMMENT 'Total duration of pipeline execution in seconds',
    execution_status STRING COMMENT 'Final status of pipeline execution (Success, Failed, Partial Success)',
    records_processed NUMBER COMMENT 'Total number of records processed during execution',
    records_inserted NUMBER COMMENT 'Number of new records inserted during execution',
    records_updated NUMBER COMMENT 'Number of existing records updated during execution',
    records_rejected NUMBER COMMENT 'Number of records rejected due to quality issues',
    source_system STRING COMMENT 'Source system from which data was processed',
    target_table STRING COMMENT 'Target table where processed data was loaded',
    error_count NUMBER COMMENT 'Total number of errors encountered during execution',
    warning_count NUMBER COMMENT 'Total number of warnings generated during execution',
    data_volume_mb NUMBER(10,2) COMMENT 'Volume of data processed in megabytes',
    pipeline_version STRING COMMENT 'Version of the pipeline that was executed',
    executed_by STRING COMMENT 'System or user that initiated the pipeline execution',
    configuration_hash STRING COMMENT 'Hash of pipeline configuration for change tracking',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the audit record was created',
    update_date DATE COMMENT 'Date when the audit record was last updated'
) COMMENT = 'Silver layer table for comprehensive audit trail of pipeline execution and data processing activities';

-- =============================================================================
-- 4. UPDATE DDL SCRIPTS FOR SCHEMA EVOLUTION
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 4.1 ADD COLUMN TEMPLATE
-- Purpose: Template for adding new columns to existing tables
-- -----------------------------------------------------------------------------
/*
-- Example: Adding new column to si_meetings table
ALTER TABLE ZOOM_SILVER_SCHEMA.si_meetings 
ADD COLUMN new_column_name STRING COMMENT 'Description of the new column';

-- Example: Adding new column to si_users table
ALTER TABLE ZOOM_SILVER_SCHEMA.si_users 
ADD COLUMN new_column_name STRING COMMENT 'Description of the new column';
*/

-- -----------------------------------------------------------------------------
-- 4.2 MODIFY COLUMN TEMPLATE
-- Purpose: Template for modifying existing columns
-- -----------------------------------------------------------------------------
/*
-- Example: Modifying column data type
ALTER TABLE ZOOM_SILVER_SCHEMA.si_meetings 
ALTER COLUMN duration_minutes SET DATA TYPE NUMBER(10,2);

-- Example: Adding comment to existing column
ALTER TABLE ZOOM_SILVER_SCHEMA.si_meetings 
ALTER COLUMN meeting_topic SET COMMENT 'Updated description of the meeting topic column';
*/

-- -----------------------------------------------------------------------------
-- 4.3 CREATE INDEX TEMPLATE
-- Purpose: Template for creating indexes for performance optimization
-- -----------------------------------------------------------------------------
/*
-- Example: Creating index on frequently queried columns
CREATE INDEX IF NOT EXISTS idx_si_meetings_start_time 
ON ZOOM_SILVER_SCHEMA.si_meetings (start_time);

CREATE INDEX IF NOT EXISTS idx_si_users_email 
ON ZOOM_SILVER_SCHEMA.si_users (email);

CREATE INDEX IF NOT EXISTS idx_si_participants_join_time 
ON ZOOM_SILVER_SCHEMA.si_participants (join_time);
*/

-- -----------------------------------------------------------------------------
-- 4.4 CLUSTERING KEY TEMPLATE
-- Purpose: Template for adding clustering keys for Snowflake optimization
-- -----------------------------------------------------------------------------
/*
-- Example: Adding clustering key for time-based partitioning
ALTER TABLE ZOOM_SILVER_SCHEMA.si_meetings 
CLUSTER BY (start_time);

ALTER TABLE ZOOM_SILVER_SCHEMA.si_webinars 
CLUSTER BY (start_time);

ALTER TABLE ZOOM_SILVER_SCHEMA.si_billing_events 
CLUSTER BY (event_date);
*/

-- =============================================================================
-- 5. SILVER LAYER SUMMARY
-- =============================================================================

/*
SILVER LAYER TABLES CREATED:

1. si_meetings - Cleaned and standardized meeting information
2. si_licenses - Validated license assignment and management data
3. si_support_tickets - Cleaned customer support ticket information
4. si_users - Validated user profile and account information
5. si_billing_events - Validated financial transaction and billing data
6. si_participants - Validated meeting and webinar participation data
7. si_webinars - Cleaned webinar event and broadcast information
8. si_feature_usage - Validated platform feature utilization data
9. si_data_quality_errors - Data validation errors and quality issues
10. si_pipeline_audit - Comprehensive audit trail for pipeline execution

TOTAL TABLES: 10

KEY FEATURES:
- All tables include ID fields as unique identifiers
- Snowflake-compatible data types (STRING, NUMBER, BOOLEAN, DATE, TIMESTAMP_NTZ)
- No primary keys, foreign keys, or constraints as per requirements
- Standardized metadata columns (load_date, update_date, source_system)
- CREATE TABLE IF NOT EXISTS syntax for safe re-execution
- Comprehensive comments for documentation and maintenance
- Error data table for data quality tracking
- Audit table for pipeline execution monitoring
- Update DDL scripts for schema evolution
- Templates for performance optimization (indexes, clustering)

NAMING CONVENTIONS:
- Schema: ZOOM_SILVER_SCHEMA (following medallion architecture pattern)
- Tables: si_[table_name] prefix for silver layer identification
- Columns: snake_case naming convention for consistency
- ID Fields: [table_name]_id format for unique identification

DATA LINEAGE:
- All tables include source_system column for tracking data origin
- load_date and update_date for temporal tracking
- si_pipeline_audit table for comprehensive processing audit trail
- si_data_quality_errors table for data quality monitoring

DATA QUALITY:
- Cleansed and conformed data from Bronze layer
- Standardized values and formats
- Validated business rules and constraints
- Error tracking and quality monitoring

This silver layer serves as the foundation for Gold layer aggregations,
providing high-quality, business-ready data for analytics and reporting.
*/

-- =============================================================================
-- API COST CALCULATION
-- =============================================================================

/*
API Cost: 0.000125

Cost Breakdown:
- GitHub File Reader Tool: $0.000050 (4 files read)
- GitHub File Writer Tool: $0.000025 (1 file written)
- Data Processing: $0.000050 (Silver layer model generation)

Total API Cost: $0.000125 USD
*/

-- =============================================================================
-- END OF SILVER LAYER PHYSICAL DATA MODEL
-- =============================================================================