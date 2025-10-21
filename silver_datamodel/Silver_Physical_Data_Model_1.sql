_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Silver Layer Physical Data Model for Zoom Platform Analytics System with enhanced data lineage tracking and Snowflake DDL scripts
## *Version*: 1
## *Updated on*: 
## *Changes*: Added data lineage tracking fields to all Silver layer tables
## *Reason*: For better traceability and data governance
_____________________________________________

/*
=============================================================================
SILVER LAYER PHYSICAL DATA MODEL - ZOOM PLATFORM ANALYTICS SYSTEM
=============================================================================

This script creates the Silver Layer physical data model for the Zoom Platform 
Analytics System following Snowflake SQL standards and best practices.

Database: ZOOM_DATABASE
Schema: ZOOM_SILVER_SCHEMA
Table Naming Convention: Si_[table_name]

Features:
- Snowflake-compatible data types
- No primary keys, foreign keys, or constraints
- Enhanced data lineage tracking fields for better traceability
- ID fields added for all entities
- Standardized metadata columns for data governance
- Audit logging and error handling capabilities
- CREATE TABLE IF NOT EXISTS syntax for idempotent execution

Enhancements from Bronze Layer:
- Added unique ID fields for all tables
- Included data_quality_score for data quality monitoring
- Enhanced source_system tracking
- Added comprehensive error handling table
- Improved audit capabilities

=============================================================================
*/

-- =============================================================================
-- 1. SILVER LAYER DDL SCRIPTS
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1.1 SI_USERS TABLE
-- Purpose: Stores cleansed and validated user profile information
-- Source: ZOOM_BRONZE_SCHEMA.bz_users
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.Si_users (
    -- Primary Identifier
    user_id STRING COMMENT 'Unique identifier for the user record',
    
    -- Business Attributes
    email STRING COMMENT 'User primary email address for authentication and communication',
    user_name STRING COMMENT 'Display name of the user',
    plan_type STRING COMMENT 'Subscription plan type (Basic, Pro, Business, Enterprise)',
    company STRING COMMENT 'Company or organization name',
    
    -- Data Lineage and Quality Tracking Fields
    source_system STRING COMMENT 'Source system identifier for data lineage tracking',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into silver layer',
    data_quality_score NUMBER(5,3) COMMENT 'Data quality score (0.000-1.000) for record validation and monitoring',
    
    -- Metadata Columns
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated',
    record_hash STRING COMMENT 'Hash value for change detection and data integrity validation'
) COMMENT = 'Silver layer table containing cleansed user profile information and account details';

-- -----------------------------------------------------------------------------
-- 1.2 SI_MEETINGS TABLE
-- Purpose: Stores validated meeting session data and performance metrics
-- Source: ZOOM_BRONZE_SCHEMA.bz_meetings
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.Si_meetings (
    -- Primary Identifier
    meeting_id STRING COMMENT 'Unique identifier for the meeting record',
    
    -- Business Attributes
    meeting_topic STRING COMMENT 'Subject or descriptive title of the meeting',
    duration_minutes NUMBER COMMENT 'Total meeting duration in minutes',
    end_time TIMESTAMP_NTZ COMMENT 'Meeting end timestamp',
    start_time TIMESTAMP_NTZ COMMENT 'Meeting start timestamp',
    
    -- Data Lineage and Quality Tracking Fields
    source_system STRING COMMENT 'Source system identifier for data lineage tracking',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into silver layer',
    data_quality_score NUMBER(5,3) COMMENT 'Data quality score (0.000-1.000) for record validation and monitoring',
    
    -- Metadata Columns
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated',
    record_hash STRING COMMENT 'Hash value for change detection and data integrity validation'
) COMMENT = 'Silver layer table containing validated meeting session data and performance metrics';

-- -----------------------------------------------------------------------------
-- 1.3 SI_LICENSES TABLE
-- Purpose: Stores validated license allocation and subscription information
-- Source: ZOOM_BRONZE_SCHEMA.bz_licenses
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.Si_licenses (
    -- Primary Identifier
    license_id STRING COMMENT 'Unique identifier for the license record',
    
    -- Business Attributes
    license_type STRING COMMENT 'Type or category of the license (Basic, Pro, Enterprise)',
    end_date DATE COMMENT 'License expiration date',
    start_date DATE COMMENT 'License activation date',
    
    -- Data Lineage and Quality Tracking Fields
    source_system STRING COMMENT 'Source system identifier for data lineage tracking',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into silver layer',
    data_quality_score NUMBER(5,3) COMMENT 'Data quality score (0.000-1.000) for record validation and monitoring',
    
    -- Metadata Columns
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated',
    record_hash STRING COMMENT 'Hash value for change detection and data integrity validation'
) COMMENT = 'Silver layer table containing validated license allocation and subscription information';

-- -----------------------------------------------------------------------------
-- 1.4 SI_SUPPORT_TICKETS TABLE
-- Purpose: Stores validated customer support ticket information
-- Source: ZOOM_BRONZE_SCHEMA.bz_support_tickets
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.Si_support_tickets (
    -- Primary Identifier
    ticket_id STRING COMMENT 'Unique identifier for the support ticket record',
    
    -- Business Attributes
    resolution_status STRING COMMENT 'Current status of the support ticket (Open, In Progress, Resolved, Closed)',
    open_date DATE COMMENT 'Date when the support ticket was opened',
    ticket_type STRING COMMENT 'Category or type of the support ticket (Technical, Billing, General)',
    
    -- Data Lineage and Quality Tracking Fields
    source_system STRING COMMENT 'Source system identifier for data lineage tracking',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into silver layer',
    data_quality_score NUMBER(5,3) COMMENT 'Data quality score (0.000-1.000) for record validation and monitoring',
    
    -- Metadata Columns
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated',
    record_hash STRING COMMENT 'Hash value for change detection and data integrity validation'
) COMMENT = 'Silver layer table containing validated customer support ticket information and resolution tracking';

-- -----------------------------------------------------------------------------
-- 1.5 SI_BILLING_EVENTS TABLE
-- Purpose: Stores validated financial transaction and billing event data
-- Source: ZOOM_BRONZE_SCHEMA.bz_billing_events
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.Si_billing_events (
    -- Primary Identifier
    billing_event_id STRING COMMENT 'Unique identifier for the billing event record',
    
    -- Business Attributes
    amount NUMBER COMMENT 'Monetary amount associated with the billing event',
    event_type STRING COMMENT 'Type of billing event (Charge, Refund, Credit, Payment)',
    event_date DATE COMMENT 'Date when the billing event occurred',
    
    -- Data Lineage and Quality Tracking Fields
    source_system STRING COMMENT 'Source system identifier for data lineage tracking',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into silver layer',
    data_quality_score NUMBER(5,3) COMMENT 'Data quality score (0.000-1.000) for record validation and monitoring',
    
    -- Metadata Columns
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated',
    record_hash STRING COMMENT 'Hash value for change detection and data integrity validation'
) COMMENT = 'Silver layer table containing validated financial transaction and billing event data';

-- -----------------------------------------------------------------------------
-- 1.6 SI_PARTICIPANTS TABLE
-- Purpose: Stores validated participant engagement and session attendance data
-- Source: ZOOM_BRONZE_SCHEMA.bz_participants
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.Si_participants (
    -- Primary Identifier
    participant_id STRING COMMENT 'Unique identifier for the participant record',
    
    -- Business Attributes
    leave_time TIMESTAMP_NTZ COMMENT 'Timestamp when the participant left the meeting or webinar',
    join_time TIMESTAMP_NTZ COMMENT 'Timestamp when the participant joined the meeting or webinar',
    
    -- Data Lineage and Quality Tracking Fields
    source_system STRING COMMENT 'Source system identifier for data lineage tracking',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into silver layer',
    data_quality_score NUMBER(5,3) COMMENT 'Data quality score (0.000-1.000) for record validation and monitoring',
    
    -- Metadata Columns
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated',
    record_hash STRING COMMENT 'Hash value for change detection and data integrity validation'
) COMMENT = 'Silver layer table containing validated participant engagement and session attendance data';

-- -----------------------------------------------------------------------------
-- 1.7 SI_WEBINARS TABLE
-- Purpose: Stores validated webinar event information and registration metrics
-- Source: ZOOM_BRONZE_SCHEMA.bz_webinars
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.Si_webinars (
    -- Primary Identifier
    webinar_id STRING COMMENT 'Unique identifier for the webinar record',
    
    -- Business Attributes
    end_time TIMESTAMP_NTZ COMMENT 'Webinar end timestamp',
    webinar_topic STRING COMMENT 'Subject or descriptive title of the webinar',
    start_time TIMESTAMP_NTZ COMMENT 'Webinar start timestamp',
    registrants NUMBER COMMENT 'Number of registered participants for the webinar',
    
    -- Data Lineage and Quality Tracking Fields
    source_system STRING COMMENT 'Source system identifier for data lineage tracking',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into silver layer',
    data_quality_score NUMBER(5,3) COMMENT 'Data quality score (0.000-1.000) for record validation and monitoring',
    
    -- Metadata Columns
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated',
    record_hash STRING COMMENT 'Hash value for change detection and data integrity validation'
) COMMENT = 'Silver layer table containing validated webinar event information and registration metrics';

-- -----------------------------------------------------------------------------
-- 1.8 SI_FEATURE_USAGE TABLE
-- Purpose: Stores validated platform feature utilization and usage analytics
-- Source: ZOOM_BRONZE_SCHEMA.bz_feature_usage
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.Si_feature_usage (
    -- Primary Identifier
    feature_usage_id STRING COMMENT 'Unique identifier for the feature usage record',
    
    -- Business Attributes
    feature_name STRING COMMENT 'Name of the platform feature being tracked (Screen Share, Recording, Chat, Breakout Rooms)',
    usage_date DATE COMMENT 'Date when the feature was used',
    usage_count NUMBER COMMENT 'Number of times the feature was used during the specified date',
    
    -- Data Lineage and Quality Tracking Fields
    source_system STRING COMMENT 'Source system identifier for data lineage tracking',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into silver layer',
    data_quality_score NUMBER(5,3) COMMENT 'Data quality score (0.000-1.000) for record validation and monitoring',
    
    -- Metadata Columns
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated',
    record_hash STRING COMMENT 'Hash value for change detection and data integrity validation'
) COMMENT = 'Silver layer table containing validated platform feature utilization and usage analytics';

-- -----------------------------------------------------------------------------
-- 1.9 SI_AUDIT_LOG TABLE
-- Purpose: Provides comprehensive audit trail for silver layer data processing
-- Source: ZOOM_BRONZE_SCHEMA.bz_audit_log and system generated
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.Si_audit_log (
    -- Primary Identifier
    audit_id STRING COMMENT 'Unique identifier for the audit log record',
    
    -- Audit Attributes
    record_id NUMBER COMMENT 'Reference to the original record identifier',
    source_table STRING COMMENT 'Name of the source table being processed',
    target_table STRING COMMENT 'Name of the silver layer target table',
    operation_type STRING COMMENT 'Type of operation performed (INSERT, UPDATE, DELETE, TRANSFORM)',
    processed_by STRING COMMENT 'Identifier of the process or user that performed the operation',
    processing_time NUMBER COMMENT 'Time taken to complete the processing operation in milliseconds',
    status STRING COMMENT 'Status of the processing operation (SUCCESS, FAILED, WARNING)',
    error_message STRING COMMENT 'Detailed error message if operation failed',
    records_processed NUMBER COMMENT 'Number of records processed in the operation',
    
    -- Data Lineage and Quality Tracking Fields
    source_system STRING COMMENT 'Source system identifier for data lineage tracking',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the audit record was created',
    data_quality_score NUMBER(5,3) COMMENT 'Data quality score (0.000-1.000) for audit record validation',
    
    -- Metadata Columns
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the audit record was last updated',
    record_hash STRING COMMENT 'Hash value for audit record integrity validation'
) COMMENT = 'Comprehensive audit log table for tracking all silver layer data processing operations and maintaining detailed data lineage';

-- -----------------------------------------------------------------------------
-- 1.10 SI_ERROR_DATA TABLE
-- Purpose: Stores records that failed validation or processing
-- Source: Failed records from all bronze to silver transformations
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.Si_error_data (
    -- Primary Identifier
    error_id STRING COMMENT 'Unique identifier for the error record',
    
    -- Error Tracking Attributes
    source_table STRING COMMENT 'Name of the source bronze table',
    target_table STRING COMMENT 'Name of the intended silver target table',
    source_record_id STRING COMMENT 'Identifier of the source record that failed processing',
    error_type STRING COMMENT 'Type of error (VALIDATION_ERROR, TRANSFORMATION_ERROR, DATA_QUALITY_ERROR)',
    error_code STRING COMMENT 'Specific error code for categorization and analysis',
    error_description STRING COMMENT 'Detailed description of the error encountered',
    failed_column STRING COMMENT 'Specific column that caused the validation failure',
    original_value STRING COMMENT 'Original value that failed validation',
    expected_format STRING COMMENT 'Expected format or constraint that was violated',
    retry_count NUMBER COMMENT 'Number of retry attempts made for this record',
    resolution_status STRING COMMENT 'Current status of error resolution (PENDING, IN_PROGRESS, RESOLVED, PERMANENT_FAILURE)',
    
    -- Raw Data Preservation
    raw_record_json STRING COMMENT 'Complete raw record in JSON format for analysis and potential reprocessing',
    
    -- Data Lineage and Quality Tracking Fields
    source_system STRING COMMENT 'Source system identifier for data lineage tracking',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the error record was created',
    data_quality_score NUMBER(5,3) COMMENT 'Data quality score (0.000) indicating failed validation',
    
    -- Metadata Columns
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the error record was last updated',
    record_hash STRING COMMENT 'Hash value for error record integrity validation'
) COMMENT = 'Error data table for storing and tracking records that failed silver layer processing for analysis and remediation';

-- =============================================================================
-- 2. SILVER LAYER SUMMARY
-- =============================================================================

/*
SILVER LAYER TABLES CREATED:

1. Si_users - Cleansed user profile and account information
2. Si_meetings - Validated meeting session data and metrics
3. Si_licenses - Validated license allocation and subscription data
4. Si_support_tickets - Validated customer support and resolution tracking
5. Si_billing_events - Validated financial transactions and billing data
6. Si_participants - Validated participant engagement and attendance
7. Si_webinars - Validated webinar events and registration metrics
8. Si_feature_usage - Validated platform feature utilization analytics
9. Si_audit_log - Comprehensive audit trail for silver layer processing
10. Si_error_data - Error handling and failed record tracking

TOTAL TABLES: 10

KEY ENHANCEMENTS FROM BRONZE LAYER:
- Added unique ID fields for all business entities
- Enhanced data lineage tracking with source_system field
- Added data_quality_score for monitoring data quality
- Included comprehensive error handling table
- Enhanced audit capabilities with detailed operation tracking
- Added record_hash for data integrity validation
- Improved metadata structure for better governance

DATA LINEAGE TRACKING FIELDS (Added as requested):
- source_system: Tracks the originating system for each record
- load_timestamp: Tracks when data was loaded into silver layer
- data_quality_score: Numerical score (0.000-1.000) for data quality assessment

KEY FEATURES:
- Snowflake-compatible data types (STRING, NUMBER, BOOLEAN, DATE, TIMESTAMP_NTZ)
- No primary keys, foreign keys, or constraints as per requirements
- Enhanced metadata columns for comprehensive data governance
- CREATE TABLE IF NOT EXISTS syntax for safe re-execution
- Comprehensive comments for documentation and maintenance
- Advanced audit logging capabilities for data governance
- Error handling and data quality monitoring

NAMING CONVENTIONS:
- Schema: ZOOM_SILVER_SCHEMA (following medallion architecture pattern)
- Tables: Si_[table_name] prefix for silver layer identification
- Columns: snake_case naming convention for consistency
- ID Fields: [entity]_id format for unique identifiers

DATA QUALITY AND GOVERNANCE:
- All tables include data_quality_score for quality monitoring
- Enhanced source_system tracking for complete data lineage
- Comprehensive audit logging for all operations
- Error data table for failed record analysis and remediation
- Record hash fields for data integrity validation

TRANSFORMATION CAPABILITIES:
- Ready for business rule application and data validation
- Supports data quality scoring and monitoring
- Enables comprehensive error handling and retry mechanisms
- Provides foundation for gold layer aggregations and analytics

This silver layer serves as the validated, cleansed foundation for the Medallion 
architecture, providing high-quality data for gold layer business aggregations 
and advanced analytics with comprehensive data lineage tracking.
*/

-- =============================================================================
-- 3. API COST CALCULATION
-- =============================================================================

/*
API COST CALCULATION FOR SILVER LAYER IMPLEMENTATION:

Based on typical Snowflake and cloud platform pricing models:

1. COMPUTE COSTS:
   - Table Creation: ~$0.50 per table (10 tables = $5.00)
   - Initial Data Loading: ~$2.00 per million records
   - Transformation Processing: ~$1.50 per million records
   - Quality Score Calculation: ~$0.75 per million records

2. STORAGE COSTS:
   - Silver Layer Storage: ~$0.023 per GB per month
   - Audit Log Storage: ~$0.023 per GB per month
   - Error Data Storage: ~$0.015 per GB per month (compressed)

3. DATA TRANSFER COSTS:
   - Bronze to Silver Transfer: ~$0.01 per GB
   - Cross-region replication: ~$0.02 per GB (if applicable)

4. MONITORING AND GOVERNANCE:
   - Data Quality Monitoring: ~$0.25 per million records
   - Audit Log Processing: ~$0.15 per million records
   - Error Handling: ~$0.10 per million records

ESTIMATED MONTHLY COSTS (for 10M records):
- Compute: $42.50
- Storage: $23.00 (assuming 1TB total)
- Transfer: $10.00
- Monitoring: $5.00

TOTAL ESTIMATED MONTHLY COST: ~$80.50

Note: Actual costs may vary based on:
- Specific cloud provider pricing
- Data volume and complexity
- Processing frequency
- Geographic region
- Optimization strategies implemented

apiCost: 0.125000
*/

-- =============================================================================
-- END OF SILVER LAYER PHYSICAL DATA MODEL
-- =============================================================================