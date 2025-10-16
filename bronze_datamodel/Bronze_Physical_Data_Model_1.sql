_____________________________________________
## *Author*: AAVA
## *Created on*:   
## *Description*: Bronze Layer Physical Data Model for Zoom Platform Analytics System based on source raw schema and logical data model
## *Version*: 1 
## *Updated on*: 
_____________________________________________

# Bronze Layer Physical Data Model for Zoom Platform Analytics System

---

## 1. Bronze Layer DDL Script

### 1.1 Table: bz_meetings
```sql
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_meetings (
    -- Source columns from raw schema
    MEETING_ID STRING,
    MEETING_TOPIC STRING,
    HOST_ID STRING,
    START_TIME TIMESTAMP_NTZ,
    END_TIME TIMESTAMP_NTZ,
    DURATION_MINUTES NUMBER,
    
    -- Bronze layer metadata columns
    load_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    update_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    source_system STRING DEFAULT 'ZOOM_RAW_SCHEMA'
);
```

### 1.2 Table: bz_users
```sql
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_users (
    -- Source columns from raw schema
    USER_ID STRING,
    USER_NAME STRING,
    EMAIL STRING,
    COMPANY STRING,
    PLAN_TYPE STRING,
    
    -- Bronze layer metadata columns
    load_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    update_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    source_system STRING DEFAULT 'ZOOM_RAW_SCHEMA'
);
```

### 1.3 Table: bz_participants
```sql
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_participants (
    -- Source columns from raw schema
    PARTICIPANT_ID STRING,
    MEETING_ID STRING,
    USER_ID STRING,
    JOIN_TIME TIMESTAMP_NTZ,
    LEAVE_TIME TIMESTAMP_NTZ,
    
    -- Bronze layer metadata columns
    load_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    update_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    source_system STRING DEFAULT 'ZOOM_RAW_SCHEMA'
);
```

### 1.4 Table: bz_webinars
```sql
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_webinars (
    -- Source columns from raw schema
    WEBINAR_ID STRING,
    WEBINAR_TOPIC STRING,
    HOST_ID STRING,
    START_TIME TIMESTAMP_NTZ,
    END_TIME TIMESTAMP_NTZ,
    REGISTRANTS NUMBER,
    
    -- Bronze layer metadata columns
    load_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    update_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    source_system STRING DEFAULT 'ZOOM_RAW_SCHEMA'
);
```

### 1.5 Table: bz_licenses
```sql
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_licenses (
    -- Source columns from raw schema
    LICENSE_ID STRING,
    LICENSE_TYPE STRING,
    ASSIGNED_TO_USER_ID STRING,
    START_DATE DATE,
    END_DATE DATE,
    
    -- Bronze layer metadata columns
    load_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    update_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    source_system STRING DEFAULT 'ZOOM_RAW_SCHEMA'
);
```

### 1.6 Table: bz_billing_events
```sql
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_billing_events (
    -- Source columns from raw schema
    EVENT_ID STRING,
    USER_ID STRING,
    EVENT_TYPE STRING,
    EVENT_DATE DATE,
    AMOUNT NUMBER,
    
    -- Bronze layer metadata columns
    load_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    update_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    source_system STRING DEFAULT 'ZOOM_RAW_SCHEMA'
);
```

### 1.7 Table: bz_support_tickets
```sql
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_support_tickets (
    -- Source columns from raw schema
    TICKET_ID STRING,
    USER_ID STRING,
    TICKET_TYPE STRING,
    OPEN_DATE DATE,
    RESOLUTION_STATUS STRING,
    
    -- Bronze layer metadata columns
    load_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    update_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    source_system STRING DEFAULT 'ZOOM_RAW_SCHEMA'
);
```

### 1.8 Table: bz_feature_usage
```sql
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_feature_usage (
    -- Source columns from raw schema
    USAGE_ID STRING,
    MEETING_ID STRING,
    FEATURE_NAME STRING,
    USAGE_DATE DATE,
    USAGE_COUNT NUMBER,
    
    -- Bronze layer metadata columns
    load_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    update_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    source_system STRING DEFAULT 'ZOOM_RAW_SCHEMA'
);
```

### 1.9 Audit Table: bz_audit
```sql
CREATE TABLE IF NOT EXISTS ZOOM_BRONZE_SCHEMA.bz_audit (
    -- Audit columns as specified
    record_id NUMBER AUTOINCREMENT,
    source_table STRING,
    load_timestamp TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    processed_by STRING,
    processing_time NUMBER,
    status STRING
);
```

---

## 2. Implementation Guidelines

• **Data Types**: All tables use Snowflake-compatible data types (STRING, NUMBER, TIMESTAMP_NTZ, DATE, BOOLEAN)
• **No Constraints**: No primary keys, foreign keys, or other constraints as per Bronze layer requirements
• **Metadata Columns**: All tables include load_timestamp, update_timestamp, and source_system
• **Table Naming**: All tables use 'bz_' prefix and are qualified with ZOOM_BRONZE_SCHEMA
• **DDL Syntax**: Uses CREATE TABLE IF NOT EXISTS for safe deployment
• **Audit Table**: Includes AUTOINCREMENT for record_id as specified
• **Snowflake Compliance**: Follows Snowflake SQL best practices and standards

---

## 3. Data Loading Notes

• **Source System**: All tables reference ZOOM_RAW_SCHEMA as the source
• **Schema Naming**: Bronze schema follows naming convention (ZOOM_RAW_SCHEMA → ZOOM_BRONZE_SCHEMA)
• **Raw Data Preservation**: All source columns preserved with original data types
• **Incremental Loading**: Timestamp columns support incremental loading patterns
• **Quality Tracking**: Audit table tracks all data processing activities

---

## 4. Table Relationships

• **bz_meetings** ← **bz_participants** (via MEETING_ID)
• **bz_users** ← **bz_participants** (via USER_ID)
• **bz_users** ← **bz_licenses** (via ASSIGNED_TO_USER_ID)
• **bz_users** ← **bz_support_tickets** (via USER_ID)
• **bz_users** ← **bz_billing_events** (via USER_ID)
• **bz_meetings** ← **bz_feature_usage** (via MEETING_ID)
• **bz_webinars** ← **bz_participants** (via HOST_ID)

---

## 5. Next Steps

• Deploy DDL scripts to Snowflake ZOOM_BRONZE_SCHEMA
• Configure data ingestion pipelines from ZOOM_RAW_SCHEMA
• Implement data quality checks and monitoring
• Set up incremental loading processes
• Configure audit logging and alerting

---

This Bronze Physical Data Model provides the foundation for the Medallion architecture implementation, storing raw Zoom platform data with minimal transformation while maintaining data lineage and audit capabilities.