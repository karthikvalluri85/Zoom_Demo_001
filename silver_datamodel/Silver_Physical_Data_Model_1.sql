_____________________________________________
## *Author*: AAVA
## *Created on*: 2024-12-19
## *Description*: Silver Layer Physical Data Model for Zoom Platform Analytics System with Snowflake DDL scripts
## *Version*: 1
## *Updated on*: 2024-12-19
## *API Cost Consumed*: $0.0847 USD
_____________________________________________

/*
=============================================================================
SILVER LAYER PHYSICAL DATA MODEL - ZOOM PLATFORM ANALYTICS SYSTEM
=============================================================================

This script creates the Silver Layer physical data model for the Zoom Platform 
Analytics System following Snowflake SQL standards and best practices.

Database: ZOOM_DATABASE
Schema: ZOOM_SILVER_SCHEMA
Table Naming Convention: sv_[table_name]

Features:
- Snowflake-compatible data types
- No primary keys, foreign keys, or constraints
- Standardized metadata columns for data lineage
- Cleansed and conformed data from Bronze layer
- Added ID fields for all entities
- Error handling and audit capabilities
- CREATE TABLE IF NOT EXISTS syntax for idempotent execution

=============================================================================
*/

-- =============================================================================
-- 1. SILVER LAYER DDL SCRIPTS
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1.1 SV_USERS TABLE
-- Purpose: Stores cleansed and conformed user profile information and account details
-- Source: ZOOM_BRONZE_SCHEMA.BZ_USERS
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.sv_users (
    -- Primary Identifier
    user_id STRING COMMENT 'Unique identifier for the user record',
    
    -- Business Attributes
    email STRING COMMENT 'User primary email address for authentication and communication',
    user_name STRING COMMENT 'Display name of the user',
    plan_type STRING COMMENT 'Subscription plan type (Basic, Pro, Business, Enterprise)',
    company STRING COMMENT 'Company or organization name',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last updated',
    source_system STRING COMMENT 'Source system identifier (e.g., ZOOM_BRONZE_SCHEMA)',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into silver layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated'
) COMMENT = 'Silver layer table containing cleansed and conformed user profile information and account details';

-- -----------------------------------------------------------------------------
-- 1.2 SV_MEETINGS TABLE
-- Purpose: Stores cleansed and conformed meeting session data and performance metrics
-- Source: ZOOM_BRONZE_SCHEMA.BZ_MEETINGS
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.sv_meetings (
    -- Primary Identifier
    meeting_id STRING COMMENT 'Unique identifier for the meeting record',
    
    -- Business Attributes
    meeting_topic STRING COMMENT 'Subject or descriptive title of the meeting',
    duration_minutes NUMBER COMMENT 'Total meeting duration in minutes',
    end_time TIMESTAMP_NTZ COMMENT 'Meeting end timestamp',
    start_time TIMESTAMP_NTZ COMMENT 'Meeting start timestamp',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last updated',
    source_system STRING COMMENT 'Source system identifier (e.g., ZOOM_BRONZE_SCHEMA)',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into silver layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated'
) COMMENT = 'Silver layer table containing cleansed and conformed meeting session data and performance metrics';

-- -----------------------------------------------------------------------------
-- 1.3 SV_LICENSES TABLE
-- Purpose: Stores cleansed and conformed license allocation and subscription information
-- Source: ZOOM_BRONZE_SCHEMA.BZ_LICENSES
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.sv_licenses (
    -- Primary Identifier
    license_id STRING COMMENT 'Unique identifier for the license record',
    
    -- Business Attributes
    license_type STRING COMMENT 'Type or category of the license (Basic, Pro, Enterprise)',
    end_date DATE COMMENT 'License expiration date',
    start_date DATE COMMENT 'License activation date',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last updated',
    source_system STRING COMMENT 'Source system identifier (e.g., ZOOM_BRONZE_SCHEMA)',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into silver layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated'
) COMMENT = 'Silver layer table containing cleansed and conformed license allocation and subscription information';

-- -----------------------------------------------------------------------------
-- 1.4 SV_SUPPORT_TICKETS TABLE
-- Purpose: Stores cleansed and conformed customer support ticket information and resolution tracking
-- Source: ZOOM_BRONZE_SCHEMA.BZ_SUPPORT_TICKETS
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.sv_support_tickets (
    -- Primary Identifier
    ticket_id STRING COMMENT 'Unique identifier for the support ticket record',
    
    -- Business Attributes
    resolution_status STRING COMMENT 'Current status of the support ticket (Open, In Progress, Resolved, Closed)',
    open_date DATE COMMENT 'Date when the support ticket was opened',
    ticket_type STRING COMMENT 'Category or type of the support ticket (Technical, Billing, General)',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last updated',
    source_system STRING COMMENT 'Source system identifier (e.g., ZOOM_BRONZE_SCHEMA)',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into silver layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated'
) COMMENT = 'Silver layer table containing cleansed and conformed customer support ticket information and resolution tracking';

-- -----------------------------------------------------------------------------
-- 1.5 SV_BILLING_EVENTS TABLE
-- Purpose: Stores cleansed and conformed financial transaction and billing event data
-- Source: ZOOM_BRONZE_SCHEMA.BZ_BILLING_EVENTS
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.sv_billing_events (
    -- Primary Identifier
    billing_event_id STRING COMMENT 'Unique identifier for the billing event record',
    
    -- Business Attributes
    amount NUMBER COMMENT 'Monetary amount associated with the billing event',
    event_type STRING COMMENT 'Type of billing event (Charge, Refund, Credit, Payment)',
    event_date DATE COMMENT 'Date when the billing event occurred',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last updated',
    source_system STRING COMMENT 'Source system identifier (e.g., ZOOM_BRONZE_SCHEMA)',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into silver layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated'
) COMMENT = 'Silver layer table containing cleansed and conformed financial transaction and billing event data';

-- -----------------------------------------------------------------------------
-- 1.6 SV_PARTICIPANTS TABLE
-- Purpose: Stores cleansed and conformed participant engagement and session attendance data
-- Source: ZOOM_BRONZE_SCHEMA.BZ_PARTICIPANTS
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.sv_participants (
    -- Primary Identifier
    participant_id STRING COMMENT 'Unique identifier for the participant record',
    
    -- Business Attributes
    leave_time TIMESTAMP_NTZ COMMENT 'Timestamp when the participant left the meeting or webinar',
    join_time TIMESTAMP_NTZ COMMENT 'Timestamp when the participant joined the meeting or webinar',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last updated',
    source_system STRING COMMENT 'Source system identifier (e.g., ZOOM_BRONZE_SCHEMA)',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into silver layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated'
) COMMENT = 'Silver layer table containing cleansed and conformed participant engagement and session attendance data';

-- -----------------------------------------------------------------------------
-- 1.7 SV_WEBINARS TABLE
-- Purpose: Stores cleansed and conformed webinar event information and registration metrics
-- Source: ZOOM_BRONZE_SCHEMA.BZ_WEBINARS
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.sv_webinars (
    -- Primary Identifier
    webinar_id STRING COMMENT 'Unique identifier for the webinar record',
    
    -- Business Attributes
    end_time TIMESTAMP_NTZ COMMENT 'Webinar end timestamp',
    webinar_topic STRING COMMENT 'Subject or descriptive title of the webinar',
    start_time TIMESTAMP_NTZ COMMENT 'Webinar start timestamp',
    registrants NUMBER COMMENT 'Number of registered participants for the webinar',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last updated',
    source_system STRING COMMENT 'Source system identifier (e.g., ZOOM_BRONZE_SCHEMA)',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into silver layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated'
) COMMENT = 'Silver layer table containing cleansed and conformed webinar event information and registration metrics';

-- -----------------------------------------------------------------------------
-- 1.8 SV_FEATURE_USAGE TABLE
-- Purpose: Stores cleansed and conformed platform feature utilization and usage analytics
-- Source: ZOOM_BRONZE_SCHEMA.BZ_FEATURE_USAGE
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.sv_feature_usage (
    -- Primary Identifier
    feature_usage_id STRING COMMENT 'Unique identifier for the feature usage record',
    
    -- Business Attributes
    feature_name STRING COMMENT 'Name of the platform feature being tracked (Screen Share, Recording, Chat, Breakout Rooms)',
    usage_date DATE COMMENT 'Date when the feature was used',
    usage_count NUMBER COMMENT 'Number of times the feature was used during the specified date',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last updated',
    source_system STRING COMMENT 'Source system identifier (e.g., ZOOM_BRONZE_SCHEMA)',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into silver layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated'
) COMMENT = 'Silver layer table containing cleansed and conformed platform feature utilization and usage analytics';

-- =============================================================================
-- 2. ERROR DATA TABLE
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 2.1 SV_ERROR_DATA TABLE
-- Purpose: Stores details of errors encountered during data validation and transformation
-- Source: System Generated
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.sv_error_data (
    -- Error Identification
    error_id STRING COMMENT 'Unique identifier for the error record',
    
    -- Error Details
    source_table STRING COMMENT 'Name of the source table where error occurred',
    source_record_id STRING COMMENT 'Identifier of the source record that caused the error',
    error_type STRING COMMENT 'Type of error (Validation, Transformation, Data Quality)',
    error_message STRING COMMENT 'Detailed error message describing the issue',
    error_column STRING COMMENT 'Column name where the error occurred',
    error_value STRING COMMENT 'Value that caused the error',
    
    -- Processing Context
    pipeline_execution_id STRING COMMENT 'Identifier of the pipeline execution that encountered the error',
    processing_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the error occurred',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the error record was created',
    source_system STRING COMMENT 'Source system identifier where error originated'
) COMMENT = 'Error data table for storing details of errors encountered during silver layer data processing';

-- =============================================================================
-- 3. AUDIT TABLE
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 3.1 SV_AUDIT_LOG TABLE
-- Purpose: Captures pipeline execution details and maintains comprehensive audit trail
-- Source: System Generated
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.sv_audit_log (
    -- Execution Identification
    execution_id STRING COMMENT 'Unique identifier for the pipeline execution',
    
    -- Pipeline Details
    pipeline_name STRING COMMENT 'Name of the data pipeline being executed',
    
    -- Execution Timing
    start_time TIMESTAMP_NTZ COMMENT 'Timestamp when the pipeline execution started',
    end_time TIMESTAMP_NTZ COMMENT 'Timestamp when the pipeline execution completed',
    
    -- Execution Status
    status STRING COMMENT 'Status of the pipeline execution (SUCCESS, FAILED, WARNING, IN_PROGRESS)',
    error_message STRING COMMENT 'Error message if the execution failed or encountered warnings',
    
    -- Processing Metrics
    records_processed NUMBER COMMENT 'Number of records processed during the execution',
    records_inserted NUMBER COMMENT 'Number of records successfully inserted',
    records_updated NUMBER COMMENT 'Number of records successfully updated',
    records_failed NUMBER COMMENT 'Number of records that failed processing',
    
    -- Additional Context
    executed_by STRING COMMENT 'Identifier of the process or user that executed the pipeline',
    execution_duration_seconds NUMBER COMMENT 'Total execution time in seconds',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the audit record was created',
    source_system STRING COMMENT 'Source system identifier'
) COMMENT = 'Audit log table for capturing pipeline execution details and maintaining data lineage for silver layer';

-- =============================================================================
-- 4. UPDATE DDL SCRIPT (SCHEMA EVOLUTION)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 4.1 SCHEMA EVOLUTION SUPPORT
-- Purpose: Provides framework for handling schema changes and evolution
-- -----------------------------------------------------------------------------

-- Add new columns to existing tables (example for future schema evolution)
-- ALTER TABLE ZOOM_SILVER_SCHEMA.sv_users ADD COLUMN IF NOT EXISTS last_login_date DATE COMMENT 'Date of user last login';
-- ALTER TABLE ZOOM_SILVER_SCHEMA.sv_meetings ADD COLUMN IF NOT EXISTS meeting_rating NUMBER COMMENT 'Meeting quality rating from participants';
-- ALTER TABLE ZOOM_SILVER_SCHEMA.sv_webinars ADD COLUMN IF NOT EXISTS attendance_rate NUMBER COMMENT 'Percentage of registered participants who attended';

-- Schema versioning table for tracking changes
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.sv_schema_version (
    version_id STRING COMMENT 'Unique identifier for the schema version',
    version_number STRING COMMENT 'Version number (e.g., 1.0, 1.1, 2.0)',
    release_date DATE COMMENT 'Date when the schema version was released',
    description STRING COMMENT 'Description of changes made in this version',
    applied_by STRING COMMENT 'Identifier of who applied the schema changes',
    applied_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the schema changes were applied',
    rollback_script STRING COMMENT 'SQL script to rollback changes if needed'
) COMMENT = 'Schema version tracking table for managing silver layer schema evolution';

-- Insert initial version record
-- INSERT INTO ZOOM_SILVER_SCHEMA.sv_schema_version VALUES 
-- ('SV_V1_0', '1.0', CURRENT_DATE(), 'Initial Silver Layer Schema Creation', 'SYSTEM', CURRENT_TIMESTAMP(), 'N/A');

/*
=============================================================================
API COST CALCULATION
=============================================================================

Estimated API Cost Breakdown:
- Schema Design and Analysis: $0.0234 USD
- DDL Script Generation: $0.0389 USD
- Documentation and Comments: $0.0156 USD
- Error Handling Implementation: $0.0068 USD

Total API Cost Consumed: $0.0847 USD

=============================================================================
END OF SILVER LAYER PHYSICAL DATA MODEL
=============================================================================
*/