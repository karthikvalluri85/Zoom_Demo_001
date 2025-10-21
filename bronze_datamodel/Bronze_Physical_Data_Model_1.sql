_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Bronze Layer Physical Data Model for Zoom Platform Analytics System with Snowflake DDL scripts
## *Version*: 1
## *Updated on*: 
_____________________________________________

/*
=============================================================================
BRONZE LAYER PHYSICAL DATA MODEL - ZOOM PLATFORM ANALYTICS SYSTEM
=============================================================================

This script creates the Bronze Layer physical data model for the Zoom Platform 
Analytics System following Snowflake SQL standards and best practices.

Database: ZOOM_DATABASE
Schema: ZOOM_BRONZE_SCHEMA
Table Naming Convention: bz_[table_name]

Features:
- Snowflake-compatible data types
- No primary keys, foreign keys, or constraints
- Standardized metadata columns for data lineage
- Audit logging capabilities
- CREATE TABLE IF NOT EXISTS syntax for idempotent execution

=============================================================================
*/

-- =============================================================================
-- 1. BRONZE LAYER DDL SCRIPTS
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1.1 BZ_USERS TABLE
-- Purpose: Stores user profile information and account details
-- Source: ZOOM_RAW_SCHEMA.USERS
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_users (
    -- Business Attributes
    email STRING COMMENT 'User primary email address for authentication and communication',
    user_name STRING COMMENT 'Display name of the user',
    plan_type STRING COMMENT 'Subscription plan type (Basic, Pro, Business, Enterprise)',
    company STRING COMMENT 'Company or organization name',
    
    -- Metadata Columns
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated',
    source_system STRING COMMENT 'Source system identifier (e.g., ZOOM_RAW_SCHEMA)'
) COMMENT = 'Bronze layer table containing user profile information and account details from Zoom platform';

-- -----------------------------------------------------------------------------
-- 1.2 BZ_MEETINGS TABLE
-- Purpose: Stores meeting session data and performance metrics
-- Source: ZOOM_RAW_SCHEMA.MEETINGS
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_meetings (
    -- Business Attributes
    meeting_topic STRING COMMENT 'Subject or descriptive title of the meeting',
    duration_minutes NUMBER COMMENT 'Total meeting duration in minutes',
    end_time TIMESTAMP_NTZ COMMENT 'Meeting end timestamp',
    start_time TIMESTAMP_NTZ COMMENT 'Meeting start timestamp',
    
    -- Metadata Columns
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated',
    source_system STRING COMMENT 'Source system identifier (e.g., ZOOM_RAW_SCHEMA)'
) COMMENT = 'Bronze layer table containing meeting session data and performance metrics';

-- -----------------------------------------------------------------------------
-- 1.3 BZ_LICENSES TABLE
-- Purpose: Stores license allocation and subscription information
-- Source: ZOOM_RAW_SCHEMA.LICENSES
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_licenses (
    -- Business Attributes
    license_type STRING COMMENT 'Type or category of the license (Basic, Pro, Enterprise)',
    end_date DATE COMMENT 'License expiration date',
    start_date DATE COMMENT 'License activation date',
    
    -- Metadata Columns
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated',
    source_system STRING COMMENT 'Source system identifier (e.g., ZOOM_RAW_SCHEMA)'
) COMMENT = 'Bronze layer table containing license allocation and subscription information';

-- -----------------------------------------------------------------------------
-- 1.4 BZ_SUPPORT_TICKETS TABLE
-- Purpose: Stores customer support ticket information and resolution tracking
-- Source: ZOOM_RAW_SCHEMA.SUPPORT_TICKETS
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_support_tickets (
    -- Business Attributes
    resolution_status STRING COMMENT 'Current status of the support ticket (Open, In Progress, Resolved, Closed)',
    open_date DATE COMMENT 'Date when the support ticket was opened',
    ticket_type STRING COMMENT 'Category or type of the support ticket (Technical, Billing, General)',
    
    -- Metadata Columns
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated',
    source_system STRING COMMENT 'Source system identifier (e.g., ZOOM_RAW_SCHEMA)'
) COMMENT = 'Bronze layer table containing customer support ticket information and resolution tracking';

-- -----------------------------------------------------------------------------
-- 1.5 BZ_BILLING_EVENTS TABLE
-- Purpose: Stores financial transaction and billing event data
-- Source: ZOOM_RAW_SCHEMA.BILLING_EVENTS
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_billing_events (
    -- Business Attributes
    amount NUMBER COMMENT 'Monetary amount associated with the billing event',
    event_type STRING COMMENT 'Type of billing event (Charge, Refund, Credit, Payment)',
    event_date DATE COMMENT 'Date when the billing event occurred',
    
    -- Metadata Columns
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated',
    source_system STRING COMMENT 'Source system identifier (e.g., ZOOM_RAW_SCHEMA)'
) COMMENT = 'Bronze layer table containing financial transaction and billing event data';

-- -----------------------------------------------------------------------------
-- 1.6 BZ_PARTICIPANTS TABLE
-- Purpose: Stores participant engagement and session attendance data
-- Source: ZOOM_RAW_SCHEMA.PARTICIPANTS
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_participants (
    -- Business Attributes
    leave_time TIMESTAMP_NTZ COMMENT 'Timestamp when the participant left the meeting or webinar',
    join_time TIMESTAMP_NTZ COMMENT 'Timestamp when the participant joined the meeting or webinar',
    
    -- Metadata Columns
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated',
    source_system STRING COMMENT 'Source system identifier (e.g., ZOOM_RAW_SCHEMA)'
) COMMENT = 'Bronze layer table containing participant engagement and session attendance data';

-- -----------------------------------------------------------------------------
-- 1.7 BZ_WEBINARS TABLE
-- Purpose: Stores webinar event information and registration metrics
-- Source: ZOOM_RAW_SCHEMA.WEBINARS
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_webinars (
    -- Business Attributes
    end_time TIMESTAMP_NTZ COMMENT 'Webinar end timestamp',
    webinar_topic STRING COMMENT 'Subject or descriptive title of the webinar',
    start_time TIMESTAMP_NTZ COMMENT 'Webinar start timestamp',
    registrants NUMBER COMMENT 'Number of registered participants for the webinar',
    
    -- Metadata Columns
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated',
    source_system STRING COMMENT 'Source system identifier (e.g., ZOOM_RAW_SCHEMA)'
) COMMENT = 'Bronze layer table containing webinar event information and registration metrics';

-- -----------------------------------------------------------------------------
-- 1.8 BZ_FEATURE_USAGE TABLE
-- Purpose: Stores platform feature utilization and usage analytics
-- Source: ZOOM_RAW_SCHEMA.FEATURE_USAGE
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_feature_usage (
    -- Business Attributes
    feature_name STRING COMMENT 'Name of the platform feature being tracked (Screen Share, Recording, Chat, Breakout Rooms)',
    usage_date DATE COMMENT 'Date when the feature was used',
    usage_count NUMBER COMMENT 'Number of times the feature was used during the specified date',
    
    -- Metadata Columns
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded into bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated',
    source_system STRING COMMENT 'Source system identifier (e.g., ZOOM_RAW_SCHEMA)'
) COMMENT = 'Bronze layer table containing platform feature utilization and usage analytics';

-- -----------------------------------------------------------------------------
-- 1.9 BZ_AUDIT_LOG TABLE
-- Purpose: Provides comprehensive audit trail for bronze layer data processing
-- Source: System Generated
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_audit_log (
    -- Audit Attributes
    record_id NUMBER AUTOINCREMENT COMMENT 'Auto-incrementing unique identifier for each audit record',
    source_table STRING COMMENT 'Name of the source table being processed',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the data processing operation occurred',
    processed_by STRING COMMENT 'Identifier of the process or user that performed the operation',
    processing_time NUMBER COMMENT 'Time taken to complete the processing operation in milliseconds',
    status STRING COMMENT 'Status of the processing operation (SUCCESS, FAILED, WARNING)'
) COMMENT = 'Audit log table for tracking all bronze layer data processing operations and maintaining data lineage';

-- =============================================================================
-- 2. BRONZE LAYER SUMMARY
-- =============================================================================

/*
BRONZE LAYER TABLES CREATED:

1. bz_users - User profile and account information
2. bz_meetings - Meeting session data and metrics
3. bz_licenses - License allocation and subscription data
4. bz_support_tickets - Customer support and resolution tracking
5. bz_billing_events - Financial transactions and billing data
6. bz_participants - Participant engagement and attendance
7. bz_webinars - Webinar events and registration metrics
8. bz_feature_usage - Platform feature utilization analytics
9. bz_audit_log - Comprehensive audit trail for data processing

TOTAL TABLES: 9

KEY FEATURES:
- Snowflake-compatible data types (STRING, NUMBER, BOOLEAN, DATE, TIMESTAMP_NTZ)
- No primary keys, foreign keys, or constraints as per requirements
- Standardized metadata columns (load_timestamp, update_timestamp, source_system)
- CREATE TABLE IF NOT EXISTS syntax for safe re-execution
- Comprehensive comments for documentation and maintenance
- Audit logging capabilities for data governance

NAMING CONVENTIONS:
- Schema: ZOOM_BRONZE_SCHEMA (following raw schema naming pattern)
- Tables: bz_[table_name] prefix for bronze layer identification
- Columns: snake_case naming convention for consistency

DATA LINEAGE:
- All tables include source_system column for tracking data origin
- load_timestamp and update_timestamp for temporal tracking
- bz_audit_log table for comprehensive processing audit trail

This bronze layer serves as the foundation for the Medallion architecture,
providing cleaned and standardized data for silver layer transformations.
*/

-- =============================================================================
-- END OF BRONZE LAYER PHYSICAL DATA MODEL
-- =============================================================================