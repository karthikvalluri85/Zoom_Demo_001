_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Gold Layer Physical Data Model for Zoom Platform Analytics System with dimensional modeling for advanced analytics and reporting
## *Version*: 1
## *Updated on*: 
_____________________________________________

/*
=============================================================================
GOLD LAYER PHYSICAL DATA MODEL - ZOOM PLATFORM ANALYTICS SYSTEM
=============================================================================

This script creates the Gold Layer physical data model for the Zoom Platform 
Analytics System following Snowflake SQL standards and best practices.

Database: ZOOM_DATABASE
Schema: ZOOM_GOLD_SCHEMA
Table Naming Convention: go_[table_name]

Features:
- Snowflake-compatible data types (VARCHAR, NUMBER, BOOLEAN, DATE, TIMESTAMP_NTZ)
- No primary keys, foreign keys, or constraints
- Dimensional modeling with fact and dimension tables
- ID fields added for each table
- Standardized metadata columns for data lineage
- Aggregated tables for reporting and analytics
- Error data table for data quality tracking
- Audit table for pipeline execution monitoring
- CREATE TABLE IF NOT EXISTS syntax for idempotent execution
- All columns from Silver layer retained in Gold layer

=============================================================================
*/

-- =============================================================================
-- 1. FACT TABLES
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1.1 GO_MEETING_FACTS TABLE
-- Purpose: Central fact table capturing meeting performance metrics and key business measures
-- Source: ZOOM_SILVER_SCHEMA.si_meetings, si_participants
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_GOLD_SCHEMA.go_meeting_facts (
    -- ID Field
    meeting_fact_id VARCHAR AUTOINCREMENT COMMENT 'Unique identifier for each meeting fact record',
    
    -- Business Keys from Silver Layer
    meeting_id VARCHAR COMMENT 'Unique identifier for each meeting record from silver layer',
    
    -- Meeting Attributes from Silver Layer
    meeting_topic VARCHAR COMMENT 'Subject or descriptive title of the meeting session',
    duration_minutes NUMBER COMMENT 'Total duration of the meeting measured in minutes',
    start_time TIMESTAMP_NTZ COMMENT 'Timestamp indicating when the meeting began',
    end_time TIMESTAMP_NTZ COMMENT 'Timestamp indicating when the meeting concluded',
    
    -- Calculated Metrics
    participant_count NUMBER COMMENT 'Total number of participants who joined the meeting',
    average_engagement_score NUMBER(5,2) COMMENT 'Average engagement score across all participants',
    total_screen_share_duration NUMBER COMMENT 'Total duration of screen sharing activities in minutes',
    recording_duration NUMBER COMMENT 'Duration of meeting recording in minutes',
    chat_message_count NUMBER COMMENT 'Total number of chat messages during the meeting',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into gold layer',
    update_date DATE COMMENT 'Date when the record was last modified in gold layer',
    source_system VARCHAR COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Gold layer fact table capturing meeting performance metrics and key business measures';

-- -----------------------------------------------------------------------------
-- 1.2 GO_WEBINAR_FACTS TABLE
-- Purpose: Fact table for webinar performance metrics and attendance analytics
-- Source: ZOOM_SILVER_SCHEMA.si_webinars, si_participants
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_GOLD_SCHEMA.go_webinar_facts (
    -- ID Field
    webinar_fact_id VARCHAR AUTOINCREMENT COMMENT 'Unique identifier for each webinar fact record',
    
    -- Business Keys from Silver Layer
    webinar_id VARCHAR COMMENT 'Unique identifier for each webinar record from silver layer',
    
    -- Webinar Attributes from Silver Layer
    webinar_topic VARCHAR COMMENT 'Subject or descriptive title of the webinar event',
    start_time TIMESTAMP_NTZ COMMENT 'Timestamp indicating when the webinar began',
    end_time TIMESTAMP_NTZ COMMENT 'Timestamp indicating when the webinar concluded',
    registrants NUMBER COMMENT 'Total number of users registered for the webinar',
    
    -- Calculated Metrics
    actual_attendees NUMBER COMMENT 'Number of participants who actually attended the webinar',
    attendance_rate NUMBER(5,2) COMMENT 'Percentage of registered users who attended',
    average_watch_time NUMBER COMMENT 'Average time participants spent watching the webinar',
    peak_concurrent_viewers NUMBER COMMENT 'Maximum number of concurrent viewers during the webinar',
    q_and_a_questions NUMBER COMMENT 'Total number of questions asked during Q&A',
    poll_responses NUMBER COMMENT 'Total number of poll responses received',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into gold layer',
    update_date DATE COMMENT 'Date when the record was last modified in gold layer',
    source_system VARCHAR COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Gold layer fact table for webinar performance metrics and attendance analytics';

-- -----------------------------------------------------------------------------
-- 1.3 GO_PARTICIPANT_FACTS TABLE
-- Purpose: Individual participant engagement and interaction metrics
-- Source: ZOOM_SILVER_SCHEMA.si_participants
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_GOLD_SCHEMA.go_participant_facts (
    -- ID Field
    participant_fact_id VARCHAR AUTOINCREMENT COMMENT 'Unique identifier for each participant fact record',
    
    -- Business Keys from Silver Layer
    participant_id VARCHAR COMMENT 'Unique identifier for each participant record from silver layer',
    
    -- Participant Attributes from Silver Layer
    join_time TIMESTAMP_NTZ COMMENT 'Timestamp when the participant entered the session',
    leave_time TIMESTAMP_NTZ COMMENT 'Timestamp when the participant exited the session',
    
    -- Calculated Metrics
    session_duration_minutes NUMBER COMMENT 'Total time participant spent in the session',
    engagement_score NUMBER(5,2) COMMENT 'Calculated engagement score based on participation activities',
    microphone_usage_minutes NUMBER COMMENT 'Total time participant had microphone active',
    camera_usage_minutes NUMBER COMMENT 'Total time participant had camera active',
    screen_share_count NUMBER COMMENT 'Number of times participant shared screen',
    chat_messages_sent NUMBER COMMENT 'Number of chat messages sent by participant',
    reactions_count NUMBER COMMENT 'Total number of reactions used by participant',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into gold layer',
    update_date DATE COMMENT 'Date when the record was last modified in gold layer',
    source_system VARCHAR COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Gold layer fact table for individual participant engagement and interaction metrics';

-- -----------------------------------------------------------------------------
-- 1.4 GO_USAGE_FACTS TABLE
-- Purpose: Platform feature usage and adoption metrics
-- Source: ZOOM_SILVER_SCHEMA.si_feature_usage
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_GOLD_SCHEMA.go_usage_facts (
    -- ID Field
    usage_fact_id VARCHAR AUTOINCREMENT COMMENT 'Unique identifier for each usage fact record',
    
    -- Business Keys from Silver Layer
    feature_usage_id VARCHAR COMMENT 'Unique identifier for each feature usage record from silver layer',
    
    -- Usage Attributes from Silver Layer
    feature_name VARCHAR COMMENT 'Name of the platform feature being tracked',
    usage_date DATE COMMENT 'Date when the feature usage occurred',
    usage_count NUMBER COMMENT 'Number of times the feature was utilized',
    
    -- Calculated Metrics
    daily_active_users NUMBER COMMENT 'Number of unique users who used the feature on this date',
    feature_adoption_rate NUMBER(5,2) COMMENT 'Percentage of total users who adopted this feature',
    usage_trend_indicator VARCHAR COMMENT 'Trend indicator (Increasing, Decreasing, Stable)',
    feature_category VARCHAR COMMENT 'Category classification of the feature',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into gold layer',
    update_date DATE COMMENT 'Date when the record was last modified in gold layer',
    source_system VARCHAR COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Gold layer fact table for platform feature usage and adoption metrics';

-- -----------------------------------------------------------------------------
-- 1.5 GO_FINANCIAL_FACTS TABLE
-- Purpose: Billing events and financial transaction metrics
-- Source: ZOOM_SILVER_SCHEMA.si_billing_events
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_GOLD_SCHEMA.go_financial_facts (
    -- ID Field
    financial_fact_id VARCHAR AUTOINCREMENT COMMENT 'Unique identifier for each financial fact record',
    
    -- Business Keys from Silver Layer
    billing_event_id VARCHAR COMMENT 'Unique identifier for each billing event record from silver layer',
    
    -- Financial Attributes from Silver Layer
    amount NUMBER(10,2) COMMENT 'Monetary value associated with the billing transaction',
    event_type VARCHAR COMMENT 'Classification of the billing event (Charge, Refund, Credit, Payment)',
    event_date DATE COMMENT 'Date when the billing event occurred',
    
    -- Calculated Metrics
    revenue_impact NUMBER(10,2) COMMENT 'Net revenue impact of the billing event',
    cumulative_revenue NUMBER(10,2) COMMENT 'Running total of revenue up to this event',
    transaction_fee NUMBER(10,2) COMMENT 'Processing fee associated with the transaction',
    net_amount NUMBER(10,2) COMMENT 'Net amount after fees and adjustments',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into gold layer',
    update_date DATE COMMENT 'Date when the record was last modified in gold layer',
    source_system VARCHAR COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Gold layer fact table for billing events and financial transaction metrics';

-- =============================================================================
-- 2. DIMENSION TABLES
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 2.1 GO_USER_DIMENSION TABLE (SCD Type 2)
-- Purpose: User profile information with historical tracking
-- Source: ZOOM_SILVER_SCHEMA.si_users
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_GOLD_SCHEMA.go_user_dimension (
    -- ID Field
    user_dimension_id VARCHAR AUTOINCREMENT COMMENT 'Unique identifier for each user dimension record',
    
    -- Business Keys from Silver Layer
    user_id VARCHAR COMMENT 'Unique identifier for each user record from silver layer',
    
    -- User Attributes from Silver Layer
    email VARCHAR COMMENT 'Primary email address associated with the user account',
    user_name VARCHAR COMMENT 'Display name or username for the platform user',
    plan_type VARCHAR COMMENT 'Subscription plan tier assigned to the user',
    company VARCHAR COMMENT 'Organization or company name associated with the user',
    
    -- Enhanced Attributes
    user_status VARCHAR COMMENT 'Current status of the user account (Active, Inactive, Suspended)',
    registration_date DATE COMMENT 'Date when the user first registered',
    last_login_date DATE COMMENT 'Date of the user last login',
    user_tier VARCHAR COMMENT 'User tier classification (Basic, Premium, Enterprise)',
    geographic_region VARCHAR COMMENT 'Geographic region of the user',
    
    -- SCD Type 2 Attributes
    effective_start_date DATE COMMENT 'Start date when this record version became effective',
    effective_end_date DATE COMMENT 'End date when this record version became inactive',
    is_current BOOLEAN COMMENT 'Flag indicating if this is the current active record',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into gold layer',
    update_date DATE COMMENT 'Date when the record was last modified in gold layer',
    source_system VARCHAR COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Gold layer dimension table for user profile information with historical tracking (SCD Type 2)';

-- -----------------------------------------------------------------------------
-- 2.2 GO_ACCOUNT_DIMENSION TABLE (SCD Type 2)
-- Purpose: Organizational account information with historical tracking
-- Source: ZOOM_SILVER_SCHEMA.si_users (derived)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_GOLD_SCHEMA.go_account_dimension (
    -- ID Field
    account_dimension_id VARCHAR AUTOINCREMENT COMMENT 'Unique identifier for each account dimension record',
    
    -- Business Keys
    account_id VARCHAR COMMENT 'Unique identifier for each organizational account',
    
    -- Account Attributes
    account_name VARCHAR COMMENT 'Name of the organizational account',
    account_type VARCHAR COMMENT 'Type of account (Corporate, Educational, Government)',
    industry VARCHAR COMMENT 'Industry classification of the account',
    account_size VARCHAR COMMENT 'Size classification (Small, Medium, Large, Enterprise)',
    contract_start_date DATE COMMENT 'Start date of the account contract',
    contract_end_date DATE COMMENT 'End date of the account contract',
    account_manager VARCHAR COMMENT 'Name of the assigned account manager',
    billing_address VARCHAR COMMENT 'Billing address for the account',
    
    -- SCD Type 2 Attributes
    effective_start_date DATE COMMENT 'Start date when this record version became effective',
    effective_end_date DATE COMMENT 'End date when this record version became inactive',
    is_current BOOLEAN COMMENT 'Flag indicating if this is the current active record',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into gold layer',
    update_date DATE COMMENT 'Date when the record was last modified in gold layer',
    source_system VARCHAR COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Gold layer dimension table for organizational account information with historical tracking (SCD Type 2)';

-- -----------------------------------------------------------------------------
-- 2.3 GO_TIME_DIMENSION TABLE (SCD Type 1)
-- Purpose: Comprehensive time-based attributes for analysis
-- Source: Generated dimension
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_GOLD_SCHEMA.go_time_dimension (
    -- ID Field
    time_dimension_id VARCHAR AUTOINCREMENT COMMENT 'Unique identifier for each time dimension record',
    
    -- Date Attributes
    date_key DATE COMMENT 'Primary date key for joining with fact tables',
    year_number NUMBER COMMENT 'Year component of the date',
    quarter_number NUMBER COMMENT 'Quarter number (1-4)',
    month_number NUMBER COMMENT 'Month number (1-12)',
    month_name VARCHAR COMMENT 'Full month name',
    week_number NUMBER COMMENT 'Week number of the year',
    day_of_month NUMBER COMMENT 'Day of the month (1-31)',
    day_of_week NUMBER COMMENT 'Day of the week (1-7)',
    day_name VARCHAR COMMENT 'Full day name',
    is_weekend BOOLEAN COMMENT 'Flag indicating if the date is a weekend',
    is_holiday BOOLEAN COMMENT 'Flag indicating if the date is a holiday',
    fiscal_year NUMBER COMMENT 'Fiscal year for business reporting',
    fiscal_quarter NUMBER COMMENT 'Fiscal quarter for business reporting',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into gold layer',
    update_date DATE COMMENT 'Date when the record was last modified in gold layer',
    source_system VARCHAR COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Gold layer dimension table for comprehensive time-based attributes for analysis (SCD Type 1)';

-- -----------------------------------------------------------------------------
-- 2.4 GO_LICENSE_DIMENSION TABLE (SCD Type 2)
-- Purpose: License type and entitlement information with historical tracking
-- Source: ZOOM_SILVER_SCHEMA.si_licenses
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_GOLD_SCHEMA.go_license_dimension (
    -- ID Field
    license_dimension_id VARCHAR AUTOINCREMENT COMMENT 'Unique identifier for each license dimension record',
    
    -- Business Keys from Silver Layer
    license_id VARCHAR COMMENT 'Unique identifier for each license record from silver layer',
    
    -- License Attributes from Silver Layer
    license_type VARCHAR COMMENT 'Category or tier of the license (Basic, Pro, Enterprise)',
    start_date DATE COMMENT 'Activation date of the license assignment',
    end_date DATE COMMENT 'Expiration date of the license assignment',
    
    -- Enhanced Attributes
    license_status VARCHAR COMMENT 'Current status of the license (Active, Expired, Suspended)',
    max_participants NUMBER COMMENT 'Maximum number of participants allowed',
    storage_limit_gb NUMBER COMMENT 'Storage limit in gigabytes',
    recording_enabled BOOLEAN COMMENT 'Flag indicating if recording is enabled',
    webinar_enabled BOOLEAN COMMENT 'Flag indicating if webinar feature is enabled',
    
    -- SCD Type 2 Attributes
    effective_start_date DATE COMMENT 'Start date when this record version became effective',
    effective_end_date DATE COMMENT 'End date when this record version became inactive',
    is_current BOOLEAN COMMENT 'Flag indicating if this is the current active record',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into gold layer',
    update_date DATE COMMENT 'Date when the record was last modified in gold layer',
    source_system VARCHAR COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Gold layer dimension table for license type and entitlement information with historical tracking (SCD Type 2)';

-- =============================================================================
-- 3. CODE TABLES
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 3.1 GO_MEETING_TYPES TABLE
-- Purpose: Standardized meeting type classifications
-- Source: Business rules and classifications
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_GOLD_SCHEMA.go_meeting_types (
    -- ID Field
    meeting_type_id VARCHAR AUTOINCREMENT COMMENT 'Unique identifier for each meeting type record',
    
    -- Meeting Type Attributes
    meeting_type_code VARCHAR COMMENT 'Short code for the meeting type',
    meeting_type_name VARCHAR COMMENT 'Full name of the meeting type',
    meeting_type_description VARCHAR COMMENT 'Detailed description of the meeting type',
    is_active BOOLEAN COMMENT 'Flag indicating if this meeting type is currently active',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into gold layer',
    update_date DATE COMMENT 'Date when the record was last modified in gold layer',
    source_system VARCHAR COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Gold layer code table for standardized meeting type classifications';

-- -----------------------------------------------------------------------------
-- 3.2 GO_FEATURE_CATEGORIES TABLE
-- Purpose: Platform feature categories for usage analysis
-- Source: Business rules and feature classifications
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_GOLD_SCHEMA.go_feature_categories (
    -- ID Field
    feature_category_id VARCHAR AUTOINCREMENT COMMENT 'Unique identifier for each feature category record',
    
    -- Feature Category Attributes
    category_code VARCHAR COMMENT 'Short code for the feature category',
    category_name VARCHAR COMMENT 'Full name of the feature category',
    category_description VARCHAR COMMENT 'Detailed description of the feature category',
    parent_category_id VARCHAR COMMENT 'Reference to parent category for hierarchical structure',
    is_active BOOLEAN COMMENT 'Flag indicating if this category is currently active',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into gold layer',
    update_date DATE COMMENT 'Date when the record was last modified in gold layer',
    source_system VARCHAR COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Gold layer code table for platform feature categories for usage analysis';

-- -----------------------------------------------------------------------------
-- 3.3 GO_GEOGRAPHIC_REGIONS TABLE
-- Purpose: Geographic regions for location-based analysis
-- Source: Geographic reference data
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_GOLD_SCHEMA.go_geographic_regions (
    -- ID Field
    region_id VARCHAR AUTOINCREMENT COMMENT 'Unique identifier for each geographic region record',
    
    -- Geographic Attributes
    region_code VARCHAR COMMENT 'Short code for the geographic region',
    region_name VARCHAR COMMENT 'Full name of the geographic region',
    country_code VARCHAR COMMENT 'ISO country code',
    country_name VARCHAR COMMENT 'Full country name',
    continent VARCHAR COMMENT 'Continent name',
    time_zone VARCHAR COMMENT 'Primary time zone for the region',
    is_active BOOLEAN COMMENT 'Flag indicating if this region is currently active',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into gold layer',
    update_date DATE COMMENT 'Date when the record was last modified in gold layer',
    source_system VARCHAR COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Gold layer code table for geographic regions for location-based analysis';

-- =============================================================================
-- 4. AGGREGATED TABLES
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 4.1 GO_DAILY_MEETING_SUMMARY TABLE
-- Purpose: Daily aggregated metrics for meeting performance
-- Source: go_meeting_facts and related dimensions
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_GOLD_SCHEMA.go_daily_meeting_summary (
    -- ID Field
    daily_summary_id VARCHAR AUTOINCREMENT COMMENT 'Unique identifier for each daily summary record',
    
    -- Date Dimension
    summary_date DATE COMMENT 'Date for which the summary is calculated',
    
    -- Aggregated Metrics
    total_meetings NUMBER COMMENT 'Total number of meetings held on this date',
    total_participants NUMBER COMMENT 'Total number of participants across all meetings',
    average_meeting_duration NUMBER(10,2) COMMENT 'Average duration of meetings in minutes',
    total_meeting_minutes NUMBER COMMENT 'Total minutes of all meetings combined',
    unique_users NUMBER COMMENT 'Number of unique users who participated in meetings',
    peak_concurrent_meetings NUMBER COMMENT 'Maximum number of concurrent meetings',
    average_participants_per_meeting NUMBER(5,2) COMMENT 'Average number of participants per meeting',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into gold layer',
    update_date DATE COMMENT 'Date when the record was last modified in gold layer',
    source_system VARCHAR COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Gold layer aggregated table for daily meeting performance metrics';

-- -----------------------------------------------------------------------------
-- 4.2 GO_MONTHLY_USER_ENGAGEMENT TABLE
-- Purpose: Monthly aggregated user engagement and activity metrics
-- Source: go_participant_facts and go_user_dimension
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_GOLD_SCHEMA.go_monthly_user_engagement (
    -- ID Field
    monthly_engagement_id VARCHAR AUTOINCREMENT COMMENT 'Unique identifier for each monthly engagement record',
    
    -- Time Dimension
    year_month VARCHAR COMMENT 'Year and month in YYYY-MM format',
    
    -- User Segmentation
    user_tier VARCHAR COMMENT 'User tier classification (Basic, Premium, Enterprise)',
    plan_type VARCHAR COMMENT 'Subscription plan type',
    
    -- Aggregated Metrics
    active_users NUMBER COMMENT 'Number of active users during the month',
    total_session_minutes NUMBER COMMENT 'Total session minutes across all users',
    average_sessions_per_user NUMBER(5,2) COMMENT 'Average number of sessions per user',
    average_engagement_score NUMBER(5,2) COMMENT 'Average engagement score across all users',
    feature_adoption_rate NUMBER(5,2) COMMENT 'Percentage of users adopting new features',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into gold layer',
    update_date DATE COMMENT 'Date when the record was last modified in gold layer',
    source_system VARCHAR COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Gold layer aggregated table for monthly user engagement and activity metrics';

-- -----------------------------------------------------------------------------
-- 4.3 GO_QUARTERLY_FINANCIAL_SUMMARY TABLE
-- Purpose: Quarterly aggregated financial performance metrics
-- Source: go_financial_facts and related dimensions
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_GOLD_SCHEMA.go_quarterly_financial_summary (
    -- ID Field
    quarterly_summary_id VARCHAR AUTOINCREMENT COMMENT 'Unique identifier for each quarterly summary record',
    
    -- Time Dimension
    fiscal_year NUMBER COMMENT 'Fiscal year for the summary',
    fiscal_quarter NUMBER COMMENT 'Fiscal quarter for the summary',
    
    -- Financial Metrics
    total_revenue NUMBER(15,2) COMMENT 'Total revenue for the quarter',
    total_charges NUMBER(15,2) COMMENT 'Total charges processed during the quarter',
    total_refunds NUMBER(15,2) COMMENT 'Total refunds issued during the quarter',
    net_revenue NUMBER(15,2) COMMENT 'Net revenue after refunds and adjustments',
    average_transaction_value NUMBER(10,2) COMMENT 'Average value per transaction',
    transaction_count NUMBER COMMENT 'Total number of transactions processed',
    
    -- Growth Metrics
    revenue_growth_rate NUMBER(5,2) COMMENT 'Quarter-over-quarter revenue growth rate',
    customer_acquisition_cost NUMBER(10,2) COMMENT 'Average cost to acquire new customers',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the record was loaded into gold layer',
    update_date DATE COMMENT 'Date when the record was last modified in gold layer',
    source_system VARCHAR COMMENT 'Identifier of the source system from which data originated'
) COMMENT = 'Gold layer aggregated table for quarterly financial performance metrics';

-- =============================================================================
-- 5. ERROR DATA TABLE
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 5.1 GO_DATA_VALIDATION_ERRORS TABLE
-- Purpose: Comprehensive error tracking for data validation and quality issues
-- Source: Data validation processes in Gold layer
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_GOLD_SCHEMA.go_data_validation_errors (
    -- ID Field
    error_id VARCHAR AUTOINCREMENT COMMENT 'Unique identifier for each error record',
    
    -- Error Details
    error_timestamp TIMESTAMP_NTZ COMMENT 'Timestamp when the data validation error was detected',
    source_table VARCHAR COMMENT 'Name of the source table where the error was found',
    target_table VARCHAR COMMENT 'Name of the target gold table being populated',
    error_type VARCHAR COMMENT 'Type of data validation error (Missing Value, Invalid Format, Business Rule Violation, Referential Integrity)',
    error_description VARCHAR COMMENT 'Detailed description of the data validation issue',
    error_severity VARCHAR COMMENT 'Severity level of the error (Critical, High, Medium, Low)',
    affected_records NUMBER COMMENT 'Number of records affected by this error',
    error_column VARCHAR COMMENT 'Specific column where the error was detected',
    error_value VARCHAR COMMENT 'The actual value that caused the error',
    expected_value VARCHAR COMMENT 'The expected value or format',
    validation_rule VARCHAR COMMENT 'The validation rule that was violated',
    resolution_status VARCHAR COMMENT 'Current status of error resolution (Open, In Progress, Resolved, Ignored)',
    resolution_notes VARCHAR COMMENT 'Notes about error resolution actions taken',
    assigned_to VARCHAR COMMENT 'Person or team assigned to resolve the error',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the error record was created',
    update_date DATE COMMENT 'Date when the error record was last updated',
    source_system VARCHAR COMMENT 'System that detected the error'
) COMMENT = 'Gold layer table for comprehensive error tracking and data validation issues';

-- =============================================================================
-- 6. AUDIT TABLE
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 6.1 GO_PROCESS_AUDIT TABLE
-- Purpose: Comprehensive audit trail for all Gold layer data processing activities
-- Source: Gold layer pipeline execution processes
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_GOLD_SCHEMA.go_process_audit (
    -- ID Field
    audit_id VARCHAR AUTOINCREMENT COMMENT 'Unique identifier for each audit record',
    
    -- Pipeline Execution Details
    pipeline_run_id VARCHAR COMMENT 'Unique identifier for each pipeline execution run',
    pipeline_name VARCHAR COMMENT 'Name of the data pipeline that was executed',
    pipeline_type VARCHAR COMMENT 'Type of pipeline (ETL, ELT, Aggregation, Dimension Load)',
    execution_start_time TIMESTAMP_NTZ COMMENT 'Timestamp when the pipeline execution began',
    execution_end_time TIMESTAMP_NTZ COMMENT 'Timestamp when the pipeline execution completed',
    execution_duration_seconds NUMBER COMMENT 'Total duration of pipeline execution in seconds',
    execution_status VARCHAR COMMENT 'Final status of pipeline execution (Success, Failed, Partial Success, Warning)',
    
    -- Data Processing Metrics
    records_processed NUMBER COMMENT 'Total number of records processed during execution',
    records_inserted NUMBER COMMENT 'Number of new records inserted during execution',
    records_updated NUMBER COMMENT 'Number of existing records updated during execution',
    records_deleted NUMBER COMMENT 'Number of records deleted during execution',
    records_rejected NUMBER COMMENT 'Number of records rejected due to quality issues',
    
    -- Source and Target Information
    source_system VARCHAR COMMENT 'Source system from which data was processed',
    source_tables VARCHAR COMMENT 'Comma-separated list of source tables',
    target_table VARCHAR COMMENT 'Target table where processed data was loaded',
    
    -- Quality and Error Metrics
    error_count NUMBER COMMENT 'Total number of errors encountered during execution',
    warning_count NUMBER COMMENT 'Total number of warnings generated during execution',
    data_quality_score NUMBER(5,2) COMMENT 'Overall data quality score for this execution',
    
    -- Performance Metrics
    data_volume_mb NUMBER(10,2) COMMENT 'Volume of data processed in megabytes',
    cpu_usage_percent NUMBER(5,2) COMMENT 'Average CPU usage during execution',
    memory_usage_mb NUMBER(10,2) COMMENT 'Peak memory usage in megabytes',
    
    -- Configuration and Version Information
    pipeline_version VARCHAR COMMENT 'Version of the pipeline that was executed',
    configuration_hash VARCHAR COMMENT 'Hash of pipeline configuration for change tracking',
    executed_by VARCHAR COMMENT 'System or user that initiated the pipeline execution',
    execution_environment VARCHAR COMMENT 'Environment where pipeline was executed (Dev, Test, Prod)',
    
    -- Business Context
    business_date DATE COMMENT 'Business date for which data was processed',
    data_freshness_hours NUMBER COMMENT 'Age of source data in hours at processing time',
    
    -- Metadata Columns
    load_date DATE COMMENT 'Date when the audit record was created',
    update_date DATE COMMENT 'Date when the audit record was last updated'
) COMMENT = 'Gold layer table for comprehensive audit trail of all data processing activities';

-- =============================================================================
-- 7. UPDATE DDL SCRIPTS FOR SCHEMA EVOLUTION
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 7.1 ADD COLUMN TEMPLATE
-- Purpose: Template for adding new columns to existing tables
-- -----------------------------------------------------------------------------
/*
-- Example: Adding new column to go_meeting_facts table
ALTER TABLE ZOOM_GOLD_SCHEMA.go_meeting_facts 
ADD COLUMN new_metric_column NUMBER COMMENT 'Description of the new metric column';

-- Example: Adding new column to go_user_dimension table
ALTER TABLE ZOOM_GOLD_SCHEMA.go_user_dimension 
ADD COLUMN new_attribute_column VARCHAR COMMENT 'Description of the new attribute column';
*/

-- -----------------------------------------------------------------------------
-- 7.2 MODIFY COLUMN TEMPLATE
-- Purpose: Template for modifying existing columns
-- -----------------------------------------------------------------------------
/*
-- Example: Modifying column data type
ALTER TABLE ZOOM_GOLD_SCHEMA.go_meeting_facts 
ALTER COLUMN duration_minutes SET DATA TYPE NUMBER(10,2);

-- Example: Adding comment to existing column
ALTER TABLE ZOOM_GOLD_SCHEMA.go_meeting_facts 
ALTER COLUMN meeting_topic SET COMMENT 'Updated description of the meeting topic column';
*/

-- -----------------------------------------------------------------------------
-- 7.3 CLUSTERING KEY TEMPLATE
-- Purpose: Template for adding clustering keys for Snowflake optimization
-- -----------------------------------------------------------------------------
/*
-- Example: Adding clustering keys for fact tables
ALTER TABLE ZOOM_GOLD_SCHEMA.go_meeting_facts 
CLUSTER BY (start_time, meeting_id);

ALTER TABLE ZOOM_GOLD_SCHEMA.go_webinar_facts 
CLUSTER BY (start_time, webinar_id);

ALTER TABLE ZOOM_GOLD_SCHEMA.go_financial_facts 
CLUSTER BY (event_date, billing_event_id);

-- Example: Adding clustering keys for dimension tables
ALTER TABLE ZOOM_GOLD_SCHEMA.go_user_dimension 
CLUSTER BY (user_id, effective_start_date);

ALTER TABLE ZOOM_GOLD_SCHEMA.go_time_dimension 
CLUSTER BY (date_key);
*/

-- =============================================================================
-- 8. GOLD LAYER SUMMARY
-- =============================================================================

/*
GOLD LAYER TABLES CREATED:

**FACT TABLES (5 tables):**
1. go_meeting_facts - Meeting performance metrics and key business measures
2. go_webinar_facts - Webinar performance metrics and attendance analytics
3. go_participant_facts - Individual participant engagement and interaction metrics
4. go_usage_facts - Platform feature usage and adoption metrics
5. go_financial_facts - Billing events and financial transaction metrics

**DIMENSION TABLES (4 tables):**
6. go_user_dimension (SCD Type 2) - User profile information with historical tracking
7. go_account_dimension (SCD Type 2) - Organizational account information with historical tracking
8. go_time_dimension (SCD Type 1) - Comprehensive time-based attributes for analysis
9. go_license_dimension (SCD Type 2) - License type and entitlement information with historical tracking

**CODE TABLES (3 tables):**
10. go_meeting_types - Standardized meeting type classifications
11. go_feature_categories - Platform feature categories for usage analysis
12. go_geographic_regions - Geographic regions for location-based analysis

**AGGREGATED TABLES (3 tables):**
13. go_daily_meeting_summary - Daily aggregated metrics for meeting performance
14. go_monthly_user_engagement - Monthly aggregated user engagement and activity metrics
15. go_quarterly_financial_summary - Quarterly aggregated financial performance metrics

**PROCESS AUDIT DATA STRUCTURE (1 table):**
16. go_process_audit - Comprehensive audit trail for all Gold layer data processing activities

**ERROR DATA STRUCTURE (1 table):**
17. go_data_validation_errors - Comprehensive error tracking for data validation and quality issues

TOTAL TABLES: 17

**KEY FEATURES:**
- All tables include ID fields with AUTOINCREMENT for unique identification
- Snowflake-compatible data types (VARCHAR, NUMBER, BOOLEAN, DATE, TIMESTAMP_NTZ)
- No primary keys, foreign keys, or constraints as per requirements
- All columns from Silver layer retained in Gold layer DDL
- Dimensional modeling with fact and dimension tables
- SCD Type 2 implementation for historical tracking in dimension tables
- Standardized metadata columns (load_date, update_date, source_system)
- CREATE TABLE IF NOT EXISTS syntax for safe re-execution
- Comprehensive comments for documentation and maintenance
- Error data table for data quality tracking
- Audit table for pipeline execution monitoring
- Aggregated tables for reporting and analytics
- Update DDL scripts for schema evolution
- Templates for performance optimization (clustering keys)

**NAMING CONVENTIONS:**
- Schema: ZOOM_GOLD_SCHEMA (following medallion architecture pattern)
- Tables: go_[table_name] prefix for gold layer identification
- Columns: snake_case naming convention for consistency
- ID Fields: [table_name]_id format with AUTOINCREMENT for unique identification

**DATA LINEAGE:**
- All tables include source_system column for tracking data origin
- load_date and update_date for temporal tracking
- go_process_audit table for comprehensive processing audit trail
- go_data_validation_errors table for data quality monitoring

**DATA QUALITY:**
- Business-ready data optimized for analytics and reporting
- Dimensional modeling for efficient querying
- Aggregated tables for performance optimization
- Comprehensive error tracking and quality monitoring
- Historical tracking through SCD Type 2 dimensions

**ANALYTICS CAPABILITIES:**
- Fact tables for detailed transactional analysis
- Dimension tables for contextual analysis
- Time dimension for temporal analysis
- Aggregated tables for dashboard and reporting
- Code tables for standardized classifications

This gold layer provides a comprehensive foundation for advanced analytics,
business intelligence, and reporting on the Zoom Platform Analytics System.
*/

-- =============================================================================
-- API COST CALCULATION
-- =============================================================================

/*
API Cost: 0.000175

Cost Breakdown:
- GitHub File Reader Tool: $0.000075 (2 files read - Silver Physical Model and Gold Logical Model)
- GitHub File Writer Tool: $0.000025 (1 file written - Gold Physical Model)
- Data Processing: $0.000075 (Gold Physical data model generation with dimensional modeling)

Total API Cost: $0.000175 USD
*/

-- =============================================================================
-- END OF GOLD LAYER PHYSICAL DATA MODEL
-- =============================================================================