_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Silver Layer Physical Data Model for Zoom Platform Analytics System with enhanced business logic, data quality features, and comprehensive audit capabilities
## *Version*: 1
## *Updated on*: 
_____________________________________________

/*
=============================================================================
SILVER LAYER PHYSICAL DATA MODEL - ZOOM PLATFORM ANALYTICS SYSTEM
=============================================================================

This script creates the Silver Layer physical data model for the Zoom Platform 
Analytics System following Snowflake SQL standards and Medallion architecture 
best practices.

Database: ZOOM_DATABASE
Schema: ZOOM_SILVER_SCHEMA
Table Naming Convention: si_[table_name]

Features:
- Enhanced business logic and calculated fields
- Data quality scoring and validation
- Comprehensive audit and error tracking
- Snowflake-compatible data types with performance optimization
- No primary keys, foreign keys, or constraints
- Standardized metadata columns for data lineage
- CREATE TABLE IF NOT EXISTS syntax for idempotent execution

API Cost: 0.000125

=============================================================================
*/

-- =============================================================================
-- 1. SILVER LAYER DDL SCRIPTS - MAIN TABLES
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1.1 SI_USERS TABLE
-- Purpose: Enhanced user profile information with data quality metrics
-- Source: ZOOM_BRONZE_SCHEMA.bz_users
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_users (
    -- Primary Identifier
    id NUMBER AUTOINCREMENT COMMENT 'Auto-incrementing unique identifier for each user record',
    
    -- Business Attributes from Bronze Layer
    email STRING COMMENT 'User primary email address for authentication and communication',
    user_name STRING COMMENT 'Display name of the user',
    plan_type STRING COMMENT 'Subscription plan type (Basic, Pro, Business, Enterprise)',
    company STRING COMMENT 'Company or organization name',
    
    -- Enhanced Silver Layer Attributes
    data_quality_score NUMBER(5,3) COMMENT 'Data quality score ranging from 0.000 to 1.000 based on completeness and accuracy',
    is_active BOOLEAN COMMENT 'Flag indicating whether the user account is currently active',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last updated in silver layer',
    source_system STRING COMMENT 'Source system identifier (ZOOM_BRONZE_SCHEMA)',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded from bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated from bronze layer'
) COMMENT = 'Silver layer table containing enhanced user profile information with data quality metrics and business logic';

-- -----------------------------------------------------------------------------
-- 1.2 SI_MEETINGS TABLE
-- Purpose: Enhanced meeting session data with performance analytics
-- Source: ZOOM_BRONZE_SCHEMA.bz_meetings
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_meetings (
    -- Primary Identifier
    id NUMBER AUTOINCREMENT COMMENT 'Auto-incrementing unique identifier for each meeting record',
    
    -- Business Attributes from Bronze Layer
    meeting_topic STRING COMMENT 'Subject or descriptive title of the meeting',
    duration_minutes NUMBER COMMENT 'Total meeting duration in minutes',
    end_time TIMESTAMP_NTZ COMMENT 'Meeting end timestamp',
    start_time TIMESTAMP_NTZ COMMENT 'Meeting start timestamp',
    
    -- Enhanced Silver Layer Attributes
    meeting_duration_category STRING COMMENT 'Categorized meeting duration (Short: <30min, Medium: 30-60min, Long: >60min)',
    is_valid_meeting BOOLEAN COMMENT 'Flag indicating whether the meeting has valid start/end times and duration',
    time_zone_offset NUMBER COMMENT 'Time zone offset in hours from UTC for meeting scheduling analysis',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last updated in silver layer',
    source_system STRING COMMENT 'Source system identifier (ZOOM_BRONZE_SCHEMA)',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded from bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated from bronze layer'
) COMMENT = 'Silver layer table containing enhanced meeting session data with performance analytics and categorization';

-- -----------------------------------------------------------------------------
-- 1.3 SI_LICENSES TABLE
-- Purpose: Enhanced license allocation with business intelligence
-- Source: ZOOM_BRONZE_SCHEMA.bz_licenses
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_licenses (
    -- Primary Identifier
    id NUMBER AUTOINCREMENT COMMENT 'Auto-incrementing unique identifier for each license record',
    
    -- Business Attributes from Bronze Layer
    license_type STRING COMMENT 'Type or category of the license (Basic, Pro, Enterprise)',
    end_date DATE COMMENT 'License expiration date',
    start_date DATE COMMENT 'License activation date',
    
    -- Enhanced Silver Layer Attributes
    license_duration_days NUMBER COMMENT 'Total duration of the license in days calculated from start_date to end_date',
    is_active_license BOOLEAN COMMENT 'Flag indicating whether the license is currently active based on current date',
    license_tier_rank NUMBER COMMENT 'Numerical ranking of license tier (1=Basic, 2=Pro, 3=Business, 4=Enterprise)',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last updated in silver layer',
    source_system STRING COMMENT 'Source system identifier (ZOOM_BRONZE_SCHEMA)',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded from bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated from bronze layer'
) COMMENT = 'Silver layer table containing enhanced license allocation with business intelligence and tier analysis';

-- -----------------------------------------------------------------------------
-- 1.4 SI_SUPPORT_TICKETS TABLE
-- Purpose: Enhanced support ticket tracking with SLA monitoring
-- Source: ZOOM_BRONZE_SCHEMA.bz_support_tickets
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_support_tickets (
    -- Primary Identifier
    id NUMBER AUTOINCREMENT COMMENT 'Auto-incrementing unique identifier for each support ticket record',
    
    -- Business Attributes from Bronze Layer
    resolution_status STRING COMMENT 'Current status of the support ticket (Open, In Progress, Resolved, Closed)',
    open_date DATE COMMENT 'Date when the support ticket was opened',
    ticket_type STRING COMMENT 'Category or type of the support ticket (Technical, Billing, General)',
    
    -- Enhanced Silver Layer Attributes
    days_since_opened NUMBER COMMENT 'Number of days since the ticket was opened calculated from open_date to current date',
    is_overdue BOOLEAN COMMENT 'Flag indicating whether the ticket has exceeded standard resolution timeframes',
    priority_level STRING COMMENT 'Calculated priority level based on ticket type and age (Low, Medium, High, Critical)',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last updated in silver layer',
    source_system STRING COMMENT 'Source system identifier (ZOOM_BRONZE_SCHEMA)',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded from bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated from bronze layer'
) COMMENT = 'Silver layer table containing enhanced support ticket tracking with SLA monitoring and priority analysis';

-- -----------------------------------------------------------------------------
-- 1.5 SI_BILLING_EVENTS TABLE
-- Purpose: Enhanced billing events with financial analytics
-- Source: ZOOM_BRONZE_SCHEMA.bz_billing_events
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_billing_events (
    -- Primary Identifier
    id NUMBER AUTOINCREMENT COMMENT 'Auto-incrementing unique identifier for each billing event record',
    
    -- Business Attributes from Bronze Layer
    amount NUMBER COMMENT 'Monetary amount associated with the billing event',
    event_type STRING COMMENT 'Type of billing event (Charge, Refund, Credit, Payment)',
    event_date DATE COMMENT 'Date when the billing event occurred',
    
    -- Enhanced Silver Layer Attributes
    amount_category STRING COMMENT 'Categorized amount ranges (Small: <$100, Medium: $100-$1000, Large: >$1000)',
    is_revenue_event BOOLEAN COMMENT 'Flag indicating whether the event contributes to revenue (Charges and Payments)',
    fiscal_quarter STRING COMMENT 'Fiscal quarter of the event date (Q1, Q2, Q3, Q4) with year',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last updated in silver layer',
    source_system STRING COMMENT 'Source system identifier (ZOOM_BRONZE_SCHEMA)',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded from bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated from bronze layer'
) COMMENT = 'Silver layer table containing enhanced billing events with financial analytics and revenue categorization';

-- -----------------------------------------------------------------------------
-- 1.6 SI_PARTICIPANTS TABLE
-- Purpose: Enhanced participant engagement with analytics
-- Source: ZOOM_BRONZE_SCHEMA.bz_participants
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_participants (
    -- Primary Identifier
    id NUMBER AUTOINCREMENT COMMENT 'Auto-incrementing unique identifier for each participant record',
    
    -- Business Attributes from Bronze Layer
    leave_time TIMESTAMP_NTZ COMMENT 'Timestamp when the participant left the meeting or webinar',
    join_time TIMESTAMP_NTZ COMMENT 'Timestamp when the participant joined the meeting or webinar',
    
    -- Enhanced Silver Layer Attributes
    participation_duration_minutes NUMBER COMMENT 'Total participation duration in minutes calculated from join_time to leave_time',
    engagement_level STRING COMMENT 'Categorized engagement level based on duration (Low: <15min, Medium: 15-45min, High: >45min)',
    is_valid_participation BOOLEAN COMMENT 'Flag indicating whether the participation has valid join/leave times',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last updated in silver layer',
    source_system STRING COMMENT 'Source system identifier (ZOOM_BRONZE_SCHEMA)',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded from bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated from bronze layer'
) COMMENT = 'Silver layer table containing enhanced participant engagement with analytics and duration categorization';

-- -----------------------------------------------------------------------------
-- 1.7 SI_WEBINARS TABLE
-- Purpose: Enhanced webinar events with performance metrics
-- Source: ZOOM_BRONZE_SCHEMA.bz_webinars
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_webinars (
    -- Primary Identifier
    id NUMBER AUTOINCREMENT COMMENT 'Auto-incrementing unique identifier for each webinar record',
    
    -- Business Attributes from Bronze Layer
    end_time TIMESTAMP_NTZ COMMENT 'Webinar end timestamp',
    webinar_topic STRING COMMENT 'Subject or descriptive title of the webinar',
    start_time TIMESTAMP_NTZ COMMENT 'Webinar start timestamp',
    registrants NUMBER COMMENT 'Number of registered participants for the webinar',
    
    -- Enhanced Silver Layer Attributes
    webinar_duration_minutes NUMBER COMMENT 'Total webinar duration in minutes calculated from start_time to end_time',
    registration_category STRING COMMENT 'Categorized registration levels (Small: <50, Medium: 50-200, Large: >200)',
    is_successful_webinar BOOLEAN COMMENT 'Flag indicating webinar success based on duration and registration criteria',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last updated in silver layer',
    source_system STRING COMMENT 'Source system identifier (ZOOM_BRONZE_SCHEMA)',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded from bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated from bronze layer'
) COMMENT = 'Silver layer table containing enhanced webinar events with performance metrics and success indicators';

-- -----------------------------------------------------------------------------
-- 1.8 SI_FEATURE_USAGE TABLE
-- Purpose: Enhanced feature usage analytics with intelligence
-- Source: ZOOM_BRONZE_SCHEMA.bz_feature_usage
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_feature_usage (
    -- Primary Identifier
    id NUMBER AUTOINCREMENT COMMENT 'Auto-incrementing unique identifier for each feature usage record',
    
    -- Business Attributes from Bronze Layer
    feature_name STRING COMMENT 'Name of the platform feature being tracked (Screen Share, Recording, Chat, Breakout Rooms)',
    usage_date DATE COMMENT 'Date when the feature was used',
    usage_count NUMBER COMMENT 'Number of times the feature was used during the specified date',
    
    -- Enhanced Silver Layer Attributes
    usage_intensity STRING COMMENT 'Categorized usage intensity based on count (Low: 1-10, Medium: 11-50, High: >50)',
    is_peak_usage BOOLEAN COMMENT 'Flag indicating whether usage occurred during peak hours or high-usage periods',
    feature_category STRING COMMENT 'Grouped feature category (Communication, Collaboration, Recording, Security)',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into silver layer',
    update_date DATE COMMENT 'Date when the record was last updated in silver layer',
    source_system STRING COMMENT 'Source system identifier (ZOOM_BRONZE_SCHEMA)',
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was loaded from bronze layer',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the record was last updated from bronze layer'
) COMMENT = 'Silver layer table containing enhanced feature usage analytics with intelligence and categorization';

-- =============================================================================
-- 2. SILVER LAYER ERROR DATA TABLE
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 2.1 SI_DATA_QUALITY_ERRORS TABLE
-- Purpose: Comprehensive data quality error tracking and monitoring
-- Source: Data Quality Validation Processes
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_data_quality_errors (
    -- Error Identification
    source_table STRING COMMENT 'Name of the source table where the data quality error was detected',
    error_type STRING COMMENT 'Type of data quality error (Missing Value, Invalid Format, Constraint Violation, Duplicate)',
    error_description STRING COMMENT 'Detailed description of the specific data quality error encountered',
    error_severity STRING COMMENT 'Severity level of the error (Low, Medium, High, Critical)',
    affected_column STRING COMMENT 'Name of the column that contains the data quality error',
    error_value STRING COMMENT 'Actual value that caused the data quality error',
    
    -- Error Tracking
    detection_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the data quality error was first detected',
    resolution_status STRING COMMENT 'Current status of error resolution (Open, In Progress, Resolved, Ignored)',
    resolution_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the error was resolved or addressed',
    
    -- Metadata Columns
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the error record was created',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the error record was last updated'
) COMMENT = 'Silver layer table for comprehensive tracking and monitoring of data quality errors across all entities';

-- =============================================================================
-- 3. SILVER LAYER AUDIT TABLE
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 3.1 SI_PROCESS_AUDIT TABLE
-- Purpose: Comprehensive process execution audit and performance monitoring
-- Source: ETL Process Monitoring
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_process_audit (
    -- Process Identification
    process_name STRING COMMENT 'Name of the ETL or data processing operation being audited',
    
    -- Execution Timing
    execution_start_time TIMESTAMP_NTZ COMMENT 'Timestamp when the process execution began',
    execution_end_time TIMESTAMP_NTZ COMMENT 'Timestamp when the process execution completed',
    execution_duration_seconds NUMBER COMMENT 'Total execution time in seconds calculated from start to end time',
    
    -- Processing Statistics
    records_processed NUMBER COMMENT 'Total number of records processed during the execution',
    records_successful NUMBER COMMENT 'Number of records successfully processed without errors',
    records_failed NUMBER COMMENT 'Number of records that failed processing due to errors',
    success_rate_percentage NUMBER(5,2) COMMENT 'Percentage of successfully processed records (records_successful/records_processed * 100)',
    
    -- Process Status and Errors
    process_status STRING COMMENT 'Final status of the process execution (Success, Failed, Partial Success, Warning)',
    error_message STRING COMMENT 'Detailed error message if the process encountered failures or issues',
    
    -- Resource Utilization
    resource_usage_cpu NUMBER(5,2) COMMENT 'CPU utilization percentage during process execution',
    resource_usage_memory NUMBER(10,2) COMMENT 'Memory usage in megabytes during process execution',
    data_volume_mb NUMBER(12,2) COMMENT 'Total volume of data processed in megabytes',
    
    -- Metadata Columns
    load_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the audit record was created',
    update_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the audit record was last updated'
) COMMENT = 'Silver layer table for comprehensive audit and performance monitoring of all ETL and data processing operations';

-- =============================================================================
-- 4. UPDATE DDL SCRIPT SECTION FOR SCHEMA EVOLUTION
-- =============================================================================

/*
-----------------------------------------------------------------------------
SCHEMA EVOLUTION AND UPDATE SCRIPTS
-----------------------------------------------------------------------------

This section contains DDL scripts for future schema evolution and updates.
These scripts can be executed to modify existing tables without data loss.

IMPORTANT: Always backup data before executing schema modification scripts.
-----------------------------------------------------------------------------
*/

-- Example: Add new column to existing table
-- ALTER TABLE ZOOM_SILVER_SCHEMA.si_users ADD COLUMN user_region STRING COMMENT 'Geographic region of the user';

-- Example: Modify column data type (requires table recreation in Snowflake)
-- CREATE OR REPLACE TABLE ZOOM_SILVER_SCHEMA.si_users_new AS SELECT * FROM ZOOM_SILVER_SCHEMA.si_users;
-- DROP TABLE ZOOM_SILVER_SCHEMA.si_users;
-- ALTER TABLE ZOOM_SILVER_SCHEMA.si_users_new RENAME TO si_users;

-- Example: Add new table for additional functionality
-- CREATE TABLE IF NOT EXISTS ZOOM_SILVER_SCHEMA.si_user_preferences (
--     id NUMBER AUTOINCREMENT COMMENT 'Auto-incrementing unique identifier',
--     user_id NUMBER COMMENT 'Reference to si_users.id',
--     preference_name STRING COMMENT 'Name of the user preference',
--     preference_value STRING COMMENT 'Value of the user preference',
--     load_date DATE COMMENT 'Date when the record was loaded',
--     update_date DATE COMMENT 'Date when the record was last updated',
--     source_system STRING COMMENT 'Source system identifier'
-- ) COMMENT = 'Silver layer table for user preferences and settings';

-- =============================================================================
-- 5. SILVER LAYER SUMMARY AND DOCUMENTATION
-- =============================================================================

/*
SILVER LAYER TABLES CREATED:

1. si_users - Enhanced user profile with data quality metrics
2. si_meetings - Enhanced meeting data with performance analytics
3. si_licenses - Enhanced license allocation with business intelligence
4. si_support_tickets - Enhanced support tracking with SLA monitoring
5. si_billing_events - Enhanced billing events with financial analytics
6. si_participants - Enhanced participant engagement with analytics
7. si_webinars - Enhanced webinar events with performance metrics
8. si_feature_usage - Enhanced feature usage analytics with intelligence
9. si_data_quality_errors - Comprehensive data quality error tracking
10. si_process_audit - Comprehensive process execution audit

TOTAL TABLES: 10

KEY ENHANCEMENTS FROM BRONZE TO SILVER:

1. ID FIELDS: All main tables include auto-incrementing ID fields for unique identification
2. BUSINESS LOGIC: Enhanced calculated fields for business intelligence and analytics
3. DATA QUALITY: Quality scoring and validation flags for data reliability
4. CATEGORIZATION: Intelligent categorization of amounts, durations, and usage patterns
5. PERFORMANCE METRICS: Success indicators and performance measurements
6. ERROR TRACKING: Comprehensive error detection and resolution tracking
7. AUDIT CAPABILITIES: Detailed process monitoring and resource utilization tracking

DATA TRANSFORMATIONS APPLIED:

- Duration calculations (meeting_duration_minutes, participation_duration_minutes, etc.)
- Categorization logic (amount_category, usage_intensity, engagement_level, etc.)
- Boolean flags for business rules (is_active, is_valid_meeting, is_revenue_event, etc.)
- Date-based calculations (days_since_opened, fiscal_quarter, etc.)
- Quality scoring algorithms (data_quality_score)
- Performance indicators (success_rate_percentage, resource utilization)

SNOWFLAKE OPTIMIZATIONS:

- Native micro-partitioned storage for optimal query performance
- Appropriate data types for Snowflake compatibility
- Clustering considerations for large tables
- Efficient timestamp handling with TIMESTAMP_NTZ
- Optimized NUMBER precision for calculations

COMPLIANCE AND GOVERNANCE:

- Comprehensive audit trail through si_process_audit table
- Data quality monitoring through si_data_quality_errors table
- Metadata columns for data lineage and tracking
- Error handling and resolution workflows
- Performance monitoring and resource optimization

API COST CALCULATION: 0.000125

This Silver layer provides a robust foundation for advanced analytics, 
business intelligence, and data science workflows while maintaining 
high data quality standards and comprehensive audit capabilities.
*/

-- =============================================================================
-- END OF SILVER LAYER PHYSICAL DATA MODEL
-- =============================================================================