_____________________________________________
## *Author*: AAVA
## *Created on*:   
## *Description*: Bronze Layer Data Mapping for Zoom enterprise data platform
## *Version*: 1 
## *Updated on*: 
_____________________________________________

# Bronze Layer Data Mapping Document

## Overview
This document provides a comprehensive data mapping specification for the Bronze layer in the Medallion architecture implementation for Zoom enterprise data platform in Snowflake. The Bronze layer serves as the raw data ingestion layer, preserving the original structure and format of source data with minimal transformation.

## Architecture Context
- **Source Database**: ZOOM_DATABASE
- **Source Schema**: ZOOM_RAW_SCHEMA
- **Target Layer**: Bronze
- **Target Platform**: Snowflake
- **Mapping Type**: 1-1 Direct Mapping (No Transformations)

## Data Mapping Tables

### 1. MEETINGS Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|---------------------|
| Bronze | bz_meetings | UPDATE_TIMESTAMP | Source | MEETINGS | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_meetings | MEETING_TOPIC | Source | MEETINGS | MEETING_TOPIC | 1-1 Mapping |
| Bronze | bz_meetings | DURATION_MINUTES | Source | MEETINGS | DURATION_MINUTES | 1-1 Mapping |
| Bronze | bz_meetings | LOAD_TIMESTAMP | Source | MEETINGS | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_meetings | MEETING_ID | Source | MEETINGS | MEETING_ID | 1-1 Mapping |
| Bronze | bz_meetings | SOURCE_SYSTEM | Source | MEETINGS | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | bz_meetings | END_TIME | Source | MEETINGS | END_TIME | 1-1 Mapping |
| Bronze | bz_meetings | HOST_ID | Source | MEETINGS | HOST_ID | 1-1 Mapping |
| Bronze | bz_meetings | START_TIME | Source | MEETINGS | START_TIME | 1-1 Mapping |

### 2. LICENSES Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|---------------------|
| Bronze | bz_licenses | LOAD_TIMESTAMP | Source | LICENSES | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_licenses | LICENSE_TYPE | Source | LICENSES | LICENSE_TYPE | 1-1 Mapping |
| Bronze | bz_licenses | END_DATE | Source | LICENSES | END_DATE | 1-1 Mapping |
| Bronze | bz_licenses | ASSIGNED_TO_USER_ID | Source | LICENSES | ASSIGNED_TO_USER_ID | 1-1 Mapping |
| Bronze | bz_licenses | LICENSE_ID | Source | LICENSES | LICENSE_ID | 1-1 Mapping |
| Bronze | bz_licenses | SOURCE_SYSTEM | Source | LICENSES | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | bz_licenses | UPDATE_TIMESTAMP | Source | LICENSES | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_licenses | START_DATE | Source | LICENSES | START_DATE | 1-1 Mapping |

### 3. SUPPORT_TICKETS Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|---------------------|
| Bronze | bz_support_tickets | RESOLUTION_STATUS | Source | SUPPORT_TICKETS | RESOLUTION_STATUS | 1-1 Mapping |
| Bronze | bz_support_tickets | UPDATE_TIMESTAMP | Source | SUPPORT_TICKETS | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_support_tickets | TICKET_ID | Source | SUPPORT_TICKETS | TICKET_ID | 1-1 Mapping |
| Bronze | bz_support_tickets | LOAD_TIMESTAMP | Source | SUPPORT_TICKETS | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_support_tickets | OPEN_DATE | Source | SUPPORT_TICKETS | OPEN_DATE | 1-1 Mapping |
| Bronze | bz_support_tickets | USER_ID | Source | SUPPORT_TICKETS | USER_ID | 1-1 Mapping |
| Bronze | bz_support_tickets | SOURCE_SYSTEM | Source | SUPPORT_TICKETS | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | bz_support_tickets | TICKET_TYPE | Source | SUPPORT_TICKETS | TICKET_TYPE | 1-1 Mapping |

### 4. USERS Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|---------------------|
| Bronze | bz_users | EMAIL | Source | USERS | EMAIL | 1-1 Mapping |
| Bronze | bz_users | SOURCE_SYSTEM | Source | USERS | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | bz_users | USER_NAME | Source | USERS | USER_NAME | 1-1 Mapping |
| Bronze | bz_users | LOAD_TIMESTAMP | Source | USERS | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_users | UPDATE_TIMESTAMP | Source | USERS | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_users | USER_ID | Source | USERS | USER_ID | 1-1 Mapping |
| Bronze | bz_users | PLAN_TYPE | Source | USERS | PLAN_TYPE | 1-1 Mapping |
| Bronze | bz_users | COMPANY | Source | USERS | COMPANY | 1-1 Mapping |

### 5. BILLING_EVENTS Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|---------------------|
| Bronze | bz_billing_events | SOURCE_SYSTEM | Source | BILLING_EVENTS | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | bz_billing_events | EVENT_ID | Source | BILLING_EVENTS | EVENT_ID | 1-1 Mapping |
| Bronze | bz_billing_events | UPDATE_TIMESTAMP | Source | BILLING_EVENTS | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_billing_events | AMOUNT | Source | BILLING_EVENTS | AMOUNT | 1-1 Mapping |
| Bronze | bz_billing_events | EVENT_TYPE | Source | BILLING_EVENTS | EVENT_TYPE | 1-1 Mapping |
| Bronze | bz_billing_events | LOAD_TIMESTAMP | Source | BILLING_EVENTS | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_billing_events | EVENT_DATE | Source | BILLING_EVENTS | EVENT_DATE | 1-1 Mapping |
| Bronze | bz_billing_events | USER_ID | Source | BILLING_EVENTS | USER_ID | 1-1 Mapping |

### 6. PARTICIPANTS Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|---------------------|
| Bronze | bz_participants | UPDATE_TIMESTAMP | Source | PARTICIPANTS | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_participants | MEETING_ID | Source | PARTICIPANTS | MEETING_ID | 1-1 Mapping |
| Bronze | bz_participants | SOURCE_SYSTEM | Source | PARTICIPANTS | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | bz_participants | LOAD_TIMESTAMP | Source | PARTICIPANTS | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_participants | LEAVE_TIME | Source | PARTICIPANTS | LEAVE_TIME | 1-1 Mapping |
| Bronze | bz_participants | JOIN_TIME | Source | PARTICIPANTS | JOIN_TIME | 1-1 Mapping |
| Bronze | bz_participants | USER_ID | Source | PARTICIPANTS | USER_ID | 1-1 Mapping |
| Bronze | bz_participants | PARTICIPANT_ID | Source | PARTICIPANTS | PARTICIPANT_ID | 1-1 Mapping |

### 7. WEBINARS Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|---------------------|
| Bronze | bz_webinars | END_TIME | Source | WEBINARS | END_TIME | 1-1 Mapping |
| Bronze | bz_webinars | SOURCE_SYSTEM | Source | WEBINARS | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | bz_webinars | WEBINAR_TOPIC | Source | WEBINARS | WEBINAR_TOPIC | 1-1 Mapping |
| Bronze | bz_webinars | START_TIME | Source | WEBINARS | START_TIME | 1-1 Mapping |
| Bronze | bz_webinars | WEBINAR_ID | Source | WEBINARS | WEBINAR_ID | 1-1 Mapping |
| Bronze | bz_webinars | LOAD_TIMESTAMP | Source | WEBINARS | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_webinars | REGISTRANTS | Source | WEBINARS | REGISTRANTS | 1-1 Mapping |
| Bronze | bz_webinars | HOST_ID | Source | WEBINARS | HOST_ID | 1-1 Mapping |
| Bronze | bz_webinars | UPDATE_TIMESTAMP | Source | WEBINARS | UPDATE_TIMESTAMP | 1-1 Mapping |

### 8. FEATURE_USAGE Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|---------------------|
| Bronze | bz_feature_usage | FEATURE_NAME | Source | FEATURE_USAGE | FEATURE_NAME | 1-1 Mapping |
| Bronze | bz_feature_usage | MEETING_ID | Source | FEATURE_USAGE | MEETING_ID | 1-1 Mapping |
| Bronze | bz_feature_usage | USAGE_DATE | Source | FEATURE_USAGE | USAGE_DATE | 1-1 Mapping |
| Bronze | bz_feature_usage | UPDATE_TIMESTAMP | Source | FEATURE_USAGE | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_feature_usage | SOURCE_SYSTEM | Source | FEATURE_USAGE | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | bz_feature_usage | USAGE_ID | Source | FEATURE_USAGE | USAGE_ID | 1-1 Mapping |
| Bronze | bz_feature_usage | LOAD_TIMESTAMP | Source | FEATURE_USAGE | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_feature_usage | USAGE_COUNT | Source | FEATURE_USAGE | USAGE_COUNT | 1-1 Mapping |

## Data Type Compatibility Matrix

| Source Data Type | Target Data Type (Snowflake) | Compatibility | Notes |
|------------------|------------------------------|---------------|-------|
| TEXT | VARCHAR/STRING | ✓ Compatible | Direct mapping, no conversion needed |
| TIMESTAMP_NTZ | TIMESTAMP_NTZ | ✓ Compatible | Direct mapping, timezone-naive timestamps |
| NUMBER | NUMBER | ✓ Compatible | Direct mapping, preserves precision and scale |
| DATE | DATE | ✓ Compatible | Direct mapping, no conversion needed |

## Metadata Management

### Audit Columns
All Bronze layer tables include the following audit columns for data lineage and governance:
- **LOAD_TIMESTAMP**: Timestamp when the record was loaded into the Bronze layer
- **UPDATE_TIMESTAMP**: Timestamp when the record was last updated in the source system
- **SOURCE_SYSTEM**: Identifier of the source system (Zoom platform)

### Data Lineage Tracking
- Source Database: ZOOM_DATABASE.ZOOM_RAW_SCHEMA
- Target Database: [BRONZE_DATABASE].[BRONZE_SCHEMA]
- Ingestion Method: Batch/Streaming (to be defined based on requirements)
- Data Retention: As per organizational data retention policies

## Initial Data Validation Rules

### 1. Data Quality Checks
- **Null Value Validation**: Monitor null percentages for critical identifier fields
- **Data Type Validation**: Ensure source data types match expected Snowflake data types
- **Record Count Validation**: Verify record counts between source and Bronze layer

### 2. Business Rule Validations
- **Timestamp Consistency**: Ensure LOAD_TIMESTAMP >= UPDATE_TIMESTAMP
- **Identifier Uniqueness**: Monitor for duplicate primary key values
- **Referential Integrity**: Basic checks for foreign key relationships

### 3. Data Freshness Monitoring
- **Ingestion Lag**: Monitor time difference between source update and Bronze layer load
- **Data Completeness**: Ensure all expected source records are present in Bronze layer
- **Schema Drift Detection**: Monitor for changes in source schema structure

## Implementation Guidelines

### 1. Ingestion Process
- Use Snowflake's COPY INTO command for bulk data loading
- Implement incremental loading based on UPDATE_TIMESTAMP and LOAD_TIMESTAMP
- Configure appropriate file formats (JSON, Parquet, CSV) based on source data format

### 2. Error Handling
- Implement dead letter queues for failed records
- Log all data quality violations for monitoring and alerting
- Maintain error tables for troubleshooting and data recovery

### 3. Performance Optimization
- Partition Bronze tables by LOAD_TIMESTAMP for efficient querying
- Implement appropriate clustering keys based on query patterns
- Use Snowflake's automatic clustering for large tables

## Assumptions and Constraints

### Assumptions
1. Source data is available in ZOOM_DATABASE.ZOOM_RAW_SCHEMA
2. All source tables have consistent audit column patterns
3. Data types in source system are compatible with Snowflake
4. No data transformations or business logic applied in Bronze layer

### Constraints
1. Bronze layer maintains exact replica of source data structure
2. No data cleansing or validation beyond basic format checks
3. All columns are nullable to accommodate source data variations
4. Preserve all source data, including potentially invalid records

## Summary Statistics

- **Total Source Tables**: 8
- **Total Bronze Tables**: 8
- **Total Column Mappings**: 66
- **Data Types Used**: 4 (TEXT, TIMESTAMP_NTZ, NUMBER, DATE)
- **Mapping Complexity**: Simple 1-1 direct mapping
- **Transformation Rules**: None (raw data preservation)

---

*This document serves as the foundation for Bronze layer implementation in the Medallion architecture and should be reviewed and updated as source systems evolve.*