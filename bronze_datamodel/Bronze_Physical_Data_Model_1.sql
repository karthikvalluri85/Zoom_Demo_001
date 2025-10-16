_____________________________________________
-- *Author*: AAVA
-- *Created on*: 
-- *Description*: Bronze Physical Data Model for Zoom Platform Analytics System following Snowflake SQL standards
-- *Version*: 1
-- *Updated on*: 
_____________________________________________

-- =====================================================
-- BRONZE LAYER PHYSICAL DATA MODEL FOR ZOOM PLATFORM ANALYTICS SYSTEM
-- =====================================================

-- 1. Create Bronze Schema
CREATE SCHEMA IF NOT EXISTS ZOOM_BRONZE_SCHEMA;
USE SCHEMA ZOOM_BRONZE_SCHEMA;

-- =====================================================
-- 2. BRONZE LAYER TABLE DEFINITIONS
-- =====================================================

-- 2.1 Bronze Meetings Table
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_meetings (
    meeting_id STRING,
    host_id STRING,
    meeting_topic STRING,
    start_time TIMESTAMP_NTZ,
    end_time TIMESTAMP_NTZ,
    duration_minutes NUMBER,
    load_timestamp TIMESTAMP_NTZ,
    update_timestamp TIMESTAMP_NTZ,
    source_system STRING
);

-- 2.2 Bronze Licenses Table
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_licenses (
    license_id STRING,
    assigned_to_user_id STRING,
    license_type STRING,
    start_date DATE,
    end_date DATE,
    load_timestamp TIMESTAMP_NTZ,
    update_timestamp TIMESTAMP_NTZ,
    source_system STRING
);

-- 2.3 Bronze Support Tickets Table
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_support_tickets (
    ticket_id STRING,
    user_id STRING,
    ticket_type STRING,
    open_date DATE,
    resolution_status STRING,
    load_timestamp TIMESTAMP_NTZ,
    update_timestamp TIMESTAMP_NTZ,
    source_system STRING
);

-- 2.4 Bronze Users Table
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_users (
    user_id STRING,
    user_name STRING,
    email STRING,
    company STRING,
    plan_type STRING,
    load_timestamp TIMESTAMP_NTZ,
    update_timestamp TIMESTAMP_NTZ,
    source_system STRING
);

-- 2.5 Bronze Billing Events Table
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_billing_events (
    event_id STRING,
    user_id STRING,
    event_type STRING,
    event_date DATE,
    amount NUMBER,
    load_timestamp TIMESTAMP_NTZ,
    update_timestamp TIMESTAMP_NTZ,
    source_system STRING
);

-- 2.6 Bronze Participants Table
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_participants (
    participant_id STRING,
    meeting_id STRING,
    user_id STRING,
    join_time TIMESTAMP_NTZ,
    leave_time TIMESTAMP_NTZ,
    load_timestamp TIMESTAMP_NTZ,
    update_timestamp TIMESTAMP_NTZ,
    source_system STRING
);

-- 2.7 Bronze Webinars Table
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_webinars (
    webinar_id STRING,
    host_id STRING,
    webinar_topic STRING,
    start_time TIMESTAMP_NTZ,
    end_time TIMESTAMP_NTZ,
    registrants NUMBER,
    load_timestamp TIMESTAMP_NTZ,
    update_timestamp TIMESTAMP_NTZ,
    source_system STRING
);

-- 2.8 Bronze Feature Usage Table
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_feature_usage (
    usage_id STRING,
    meeting_id STRING,
    feature_name STRING,
    usage_date DATE,
    usage_count NUMBER,
    load_timestamp TIMESTAMP_NTZ,
    update_timestamp TIMESTAMP_NTZ,
    source_system STRING
);

-- =====================================================
-- 3. BRONZE LAYER AUDIT TABLE
-- =====================================================

-- 3.1 Bronze Audit Table for Data Lineage and Processing Tracking
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_audit_table (
    record_id NUMBER AUTOINCREMENT,
    source_table STRING,
    load_timestamp TIMESTAMP_NTZ,
    processed_by STRING,
    processing_time NUMBER,
    status STRING
);

-- =====================================================
-- 4. TABLE COMMENTS FOR DOCUMENTATION
-- =====================================================

-- 4.1 Add comments to tables for documentation
COMMENT ON TABLE ZOOM_BRONZE_SCHEMA.bz_meetings IS 'Bronze layer table containing raw meeting data from Zoom platform';
COMMENT ON TABLE ZOOM_BRONZE_SCHEMA.bz_licenses IS 'Bronze layer table containing license information and assignments';
COMMENT ON TABLE ZOOM_BRONZE_SCHEMA.bz_support_tickets IS 'Bronze layer table containing support ticket data and resolution status';
COMMENT ON TABLE ZOOM_BRONZE_SCHEMA.bz_users IS 'Bronze layer table containing user profile and account information';
COMMENT ON TABLE ZOOM_BRONZE_SCHEMA.bz_billing_events IS 'Bronze layer table containing billing events and financial transactions';
COMMENT ON TABLE ZOOM_BRONZE_SCHEMA.bz_participants IS 'Bronze layer table containing meeting participant data and engagement metrics';
COMMENT ON TABLE ZOOM_BRONZE_SCHEMA.bz_webinars IS 'Bronze layer table containing webinar data and registration information';
COMMENT ON TABLE ZOOM_BRONZE_SCHEMA.bz_feature_usage IS 'Bronze layer table containing feature usage statistics and analytics';
COMMENT ON TABLE ZOOM_BRONZE_SCHEMA.bz_audit_table IS 'Bronze layer audit table for tracking data processing and lineage';

-- =====================================================
-- 5. COLUMN COMMENTS FOR KEY FIELDS
-- =====================================================

-- 5.1 Key column comments for meetings table
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_meetings.meeting_id IS 'Unique identifier for each meeting session';
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_meetings.host_id IS 'Identifier of the meeting host user';
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_meetings.load_timestamp IS 'Timestamp when record was loaded into bronze layer';
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_meetings.update_timestamp IS 'Timestamp when record was last updated';
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_meetings.source_system IS 'Source system identifier for data lineage';

-- 5.2 Key column comments for users table
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_users.user_id IS 'Unique identifier for each user in the system';
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_users.email IS 'Primary email address for user account';
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_users.load_timestamp IS 'Timestamp when record was loaded into bronze layer';
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_users.update_timestamp IS 'Timestamp when record was last updated';
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_users.source_system IS 'Source system identifier for data lineage';

-- 5.3 Key column comments for participants table
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_participants.participant_id IS 'Unique identifier for each participant session';
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_participants.meeting_id IS 'Foreign reference to meeting identifier';
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_participants.user_id IS 'Foreign reference to user identifier';
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_participants.load_timestamp IS 'Timestamp when record was loaded into bronze layer';
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_participants.update_timestamp IS 'Timestamp when record was last updated';
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_participants.source_system IS 'Source system identifier for data lineage';

-- 5.4 Key column comments for audit table
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_audit_table.record_id IS 'Auto-incrementing unique identifier for audit records';
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_audit_table.source_table IS 'Name of the source table being processed';
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_audit_table.load_timestamp IS 'Timestamp when data processing occurred';
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_audit_table.processed_by IS 'Identifier of the process or user that performed the operation';
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_audit_table.processing_time IS 'Time taken to process the data in seconds';
COMMENT ON COLUMN ZOOM_BRONZE_SCHEMA.bz_audit_table.status IS 'Status of the processing operation (SUCCESS, FAILED, IN_PROGRESS)';

-- =====================================================
-- 6. BRONZE LAYER DATA MODEL SUMMARY
-- =====================================================

/*
BRONZE LAYER PHYSICAL DATA MODEL SUMMARY:

• Total Tables Created: 9 (8 business tables + 1 audit table)
• Schema Name: ZOOM_BRONZE_SCHEMA
• Naming Convention: bz_ prefix for all bronze tables
• Data Types: Snowflake-compatible (STRING, NUMBER, DATE, TIMESTAMP_NTZ, BOOLEAN)
• Constraints: No primary keys, foreign keys, or indexes as per Snowflake bronze layer best practices
• Metadata Columns: All tables include load_timestamp, update_timestamp, source_system
• Audit Trail: Dedicated audit table for tracking data processing and lineage
• Documentation: Comprehensive comments on tables and key columns

TABLE LIST:
1. bz_meetings - Meeting session data and metadata
2. bz_licenses - License assignments and types
3. bz_support_tickets - Support ticket tracking and resolution
4. bz_users - User profiles and account information
5. bz_billing_events - Financial transactions and billing data
6. bz_participants - Meeting participation and engagement data
7. bz_webinars - Webinar sessions and registration data
8. bz_feature_usage - Feature utilization statistics
9. bz_audit_table - Data processing audit and lineage tracking

KEY DESIGN PRINCIPLES:
• Raw data preservation with minimal transformation
• Comprehensive metadata tracking for data lineage
• Snowflake-optimized data types and structures
• Scalable design supporting high-volume data ingestion
• Audit capabilities for data governance and compliance
• Flexible schema supporting future enhancements
*/

-- =====================================================
-- END OF BRONZE PHYSICAL DATA MODEL
-- =====================================================