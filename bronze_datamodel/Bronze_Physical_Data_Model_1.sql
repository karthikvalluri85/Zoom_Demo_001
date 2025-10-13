_____________________________________________
## *Author*: AAVA
## *Created on*:   
## *Description*: Bronze Layer Physical Data Model for Zoom enterprise data platform
## *Version*: 1 
## *Updated on*: 
_____________________________________________

# Bronze Layer Physical Data Model

## 1. Bronze Layer DDL Script

This section contains the Data Definition Language (DDL) scripts for all Bronze layer tables in the Medallion architecture, designed for Snowflake compatibility.

### 1.1 Bronze Layer Tables

#### 1.1.1 Meetings Table
```sql
CREATE TABLE IF NOT EXISTS Bronze.bz_meetings (
    MEETING_ID STRING,
    MEETING_TOPIC STRING,
    HOST_ID STRING,
    START_TIME TIMESTAMP_NTZ,
    END_TIME TIMESTAMP_NTZ,
    DURATION_MINUTES NUMBER,
    LOAD_TIMESTAMP TIMESTAMP_NTZ,
    UPDATE_TIMESTAMP TIMESTAMP_NTZ,
    SOURCE_SYSTEM STRING
);
```

#### 1.1.2 Licenses Table
```sql
CREATE TABLE IF NOT EXISTS Bronze.bz_licenses (
    LICENSE_ID STRING,
    LICENSE_TYPE STRING,
    ASSIGNED_TO_USER_ID STRING,
    START_DATE DATE,
    END_DATE DATE,
    LOAD_TIMESTAMP TIMESTAMP_NTZ,
    UPDATE_TIMESTAMP TIMESTAMP_NTZ,
    SOURCE_SYSTEM STRING
);
```

#### 1.1.3 Support Tickets Table
```sql
CREATE TABLE IF NOT EXISTS Bronze.bz_support_tickets (
    TICKET_ID STRING,
    USER_ID STRING,
    TICKET_TYPE STRING,
    RESOLUTION_STATUS STRING,
    OPEN_DATE DATE,
    LOAD_TIMESTAMP TIMESTAMP_NTZ,
    UPDATE_TIMESTAMP TIMESTAMP_NTZ,
    SOURCE_SYSTEM STRING
);
```

#### 1.1.4 Users Table
```sql
CREATE TABLE IF NOT EXISTS Bronze.bz_users (
    USER_ID STRING,
    USER_NAME STRING,
    EMAIL STRING,
    COMPANY STRING,
    PLAN_TYPE STRING,
    LOAD_TIMESTAMP TIMESTAMP_NTZ,
    UPDATE_TIMESTAMP TIMESTAMP_NTZ,
    SOURCE_SYSTEM STRING
);
```

#### 1.1.5 Billing Events Table
```sql
CREATE TABLE IF NOT EXISTS Bronze.bz_billing_events (
    EVENT_ID STRING,
    USER_ID STRING,
    EVENT_TYPE STRING,
    EVENT_DATE DATE,
    AMOUNT NUMBER,
    LOAD_TIMESTAMP TIMESTAMP_NTZ,
    UPDATE_TIMESTAMP TIMESTAMP_NTZ,
    SOURCE_SYSTEM STRING
);
```

#### 1.1.6 Participants Table
```sql
CREATE TABLE IF NOT EXISTS Bronze.bz_participants (
    PARTICIPANT_ID STRING,
    MEETING_ID STRING,
    USER_ID STRING,
    JOIN_TIME TIMESTAMP_NTZ,
    LEAVE_TIME TIMESTAMP_NTZ,
    LOAD_TIMESTAMP TIMESTAMP_NTZ,
    UPDATE_TIMESTAMP TIMESTAMP_NTZ,
    SOURCE_SYSTEM STRING
);
```

#### 1.1.7 Webinars Table
```sql
CREATE TABLE IF NOT EXISTS Bronze.bz_webinars (
    WEBINAR_ID STRING,
    WEBINAR_TOPIC STRING,
    HOST_ID STRING,
    START_TIME TIMESTAMP_NTZ,
    END_TIME TIMESTAMP_NTZ,
    REGISTRANTS NUMBER,
    LOAD_TIMESTAMP TIMESTAMP_NTZ,
    UPDATE_TIMESTAMP TIMESTAMP_NTZ,
    SOURCE_SYSTEM STRING
);
```

#### 1.1.8 Feature Usage Table
```sql
CREATE TABLE IF NOT EXISTS Bronze.bz_feature_usage (
    USAGE_ID STRING,
    MEETING_ID STRING,
    FEATURE_NAME STRING,
    USAGE_DATE DATE,
    USAGE_COUNT NUMBER,
    LOAD_TIMESTAMP TIMESTAMP_NTZ,
    UPDATE_TIMESTAMP TIMESTAMP_NTZ,
    SOURCE_SYSTEM STRING
);
```

### 1.2 Audit Table

#### 1.2.1 Bronze Layer Audit Table
```sql
CREATE TABLE IF NOT EXISTS Bronze.bz_audit (
    record_id NUMBER AUTOINCREMENT,
    source_table STRING,
    load_timestamp TIMESTAMP_NTZ,
    processed_by STRING,
    processing_time NUMBER,
    status STRING
);
```

## 2. Data Type Mappings

### 2.1 Snowflake Data Type Conversions
1. **TEXT** → **STRING**: All text fields converted to Snowflake STRING data type
2. **TIMESTAMP_NTZ** → **TIMESTAMP_NTZ**: Maintained as-is for timestamp fields
3. **NUMBER** → **NUMBER**: Maintained as-is for numeric fields
4. **DATE** → **DATE**: Maintained as-is for date fields

### 2.2 Metadata Columns
1. **load_timestamp** (TIMESTAMP_NTZ): Records when data was initially loaded
2. **update_timestamp** (TIMESTAMP_NTZ): Records when data was last updated
3. **source_system** (STRING): Identifies the source system of the data

## 3. Bronze Layer Design Principles

### 3.1 Snowflake Compatibility
1. **No Constraints**: No primary keys, foreign keys, or other constraints as per Snowflake Bronze layer best practices
2. **No Indexes**: Snowflake uses micro-partitioned storage, eliminating need for traditional indexes
3. **CREATE TABLE IF NOT EXISTS**: Ensures idempotent table creation
4. **Proper Schema Naming**: Uses Bronze.bz_tablename format for clear identification

### 3.2 Data Storage Format
1. **Micro-partitioned Storage**: Leverages Snowflake's default storage format
2. **Raw Data Preservation**: Stores data as-is from source systems
3. **Audit Trail**: Comprehensive audit table for tracking data processing

### 3.3 Table Naming Convention
1. **Schema**: Bronze (dedicated schema for Bronze layer)
2. **Prefix**: bz_ (identifies Bronze layer tables)
3. **Table Names**: Descriptive names matching source entities

## 4. Implementation Notes

### 4.1 Data Loading Considerations
1. All columns are nullable to accommodate varying data quality from source systems
2. Metadata columns support data lineage and audit requirements
3. AUTOINCREMENT on audit table record_id ensures unique audit records

### 4.2 Performance Optimization
1. Snowflake's automatic clustering handles data organization
2. Micro-partitioned storage provides optimal query performance
3. No manual partitioning or indexing required

### 4.3 Security and Compliance
1. PII fields (EMAIL, USER_NAME, COMPANY) identified for potential masking policies
2. Audit table supports compliance and monitoring requirements
3. Source system tracking enables data governance

## 5. Table Summary

### 5.1 Bronze Layer Tables Count
1. **bz_meetings**: 9 columns (including metadata)
2. **bz_licenses**: 8 columns (including metadata)
3. **bz_support_tickets**: 8 columns (including metadata)
4. **bz_users**: 8 columns (including metadata)
5. **bz_billing_events**: 8 columns (including metadata)
6. **bz_participants**: 8 columns (including metadata)
7. **bz_webinars**: 9 columns (including metadata)
8. **bz_feature_usage**: 8 columns (including metadata)
9. **bz_audit**: 6 columns (audit and control)

### 5.2 Total Column Count
- **Business Columns**: 58 columns across 8 business tables
- **Metadata Columns**: 24 columns (3 per business table)
- **Audit Columns**: 6 columns in audit table
- **Grand Total**: 88 columns across 9 tables