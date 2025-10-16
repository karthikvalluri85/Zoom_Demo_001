_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Bronze Layer Data Mapping for Zoom Platform Analytics System with aligned schema naming conventions
## *Version*: 2
## *Updated on*: 
_____________________________________________

# Bronze Layer Data Mapping Document - Version 2

## Data Mapping Table

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | ZOOM_BRONZE_SCHEMA.bz_meetings | meeting_id | Source | ZOOM_RAW_SCHEMA.MEETINGS | MEETING_ID | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_meetings | meeting_topic | Source | ZOOM_RAW_SCHEMA.MEETINGS | MEETING_TOPIC | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_meetings | host_id | Source | ZOOM_RAW_SCHEMA.MEETINGS | HOST_ID | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_meetings | start_time | Source | ZOOM_RAW_SCHEMA.MEETINGS | START_TIME | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_meetings | end_time | Source | ZOOM_RAW_SCHEMA.MEETINGS | END_TIME | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_meetings | duration_minutes | Source | ZOOM_RAW_SCHEMA.MEETINGS | DURATION_MINUTES | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_meetings | load_timestamp | Source | ZOOM_RAW_SCHEMA.MEETINGS | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_meetings | update_timestamp | Source | ZOOM_RAW_SCHEMA.MEETINGS | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_meetings | source_system | Source | ZOOM_RAW_SCHEMA.MEETINGS | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_licenses | license_id | Source | ZOOM_RAW_SCHEMA.LICENSES | LICENSE_ID | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_licenses | license_type | Source | ZOOM_RAW_SCHEMA.LICENSES | LICENSE_TYPE | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_licenses | assigned_to_user_id | Source | ZOOM_RAW_SCHEMA.LICENSES | ASSIGNED_TO_USER_ID | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_licenses | start_date | Source | ZOOM_RAW_SCHEMA.LICENSES | START_DATE | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_licenses | end_date | Source | ZOOM_RAW_SCHEMA.LICENSES | END_DATE | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_licenses | load_timestamp | Source | ZOOM_RAW_SCHEMA.LICENSES | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_licenses | update_timestamp | Source | ZOOM_RAW_SCHEMA.LICENSES | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_licenses | source_system | Source | ZOOM_RAW_SCHEMA.LICENSES | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_support_tickets | ticket_id | Source | ZOOM_RAW_SCHEMA.SUPPORT_TICKETS | TICKET_ID | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_support_tickets | user_id | Source | ZOOM_RAW_SCHEMA.SUPPORT_TICKETS | USER_ID | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_support_tickets | ticket_type | Source | ZOOM_RAW_SCHEMA.SUPPORT_TICKETS | TICKET_TYPE | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_support_tickets | resolution_status | Source | ZOOM_RAW_SCHEMA.SUPPORT_TICKETS | RESOLUTION_STATUS | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_support_tickets | open_date | Source | ZOOM_RAW_SCHEMA.SUPPORT_TICKETS | OPEN_DATE | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_support_tickets | load_timestamp | Source | ZOOM_RAW_SCHEMA.SUPPORT_TICKETS | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_support_tickets | update_timestamp | Source | ZOOM_RAW_SCHEMA.SUPPORT_TICKETS | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_support_tickets | source_system | Source | ZOOM_RAW_SCHEMA.SUPPORT_TICKETS | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_users | user_id | Source | ZOOM_RAW_SCHEMA.USERS | USER_ID | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_users | user_name | Source | ZOOM_RAW_SCHEMA.USERS | USER_NAME | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_users | email | Source | ZOOM_RAW_SCHEMA.USERS | EMAIL | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_users | company | Source | ZOOM_RAW_SCHEMA.USERS | COMPANY | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_users | plan_type | Source | ZOOM_RAW_SCHEMA.USERS | PLAN_TYPE | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_users | load_timestamp | Source | ZOOM_RAW_SCHEMA.USERS | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_users | update_timestamp | Source | ZOOM_RAW_SCHEMA.USERS | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_users | source_system | Source | ZOOM_RAW_SCHEMA.USERS | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_billing_events | event_id | Source | ZOOM_RAW_SCHEMA.BILLING_EVENTS | EVENT_ID | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_billing_events | user_id | Source | ZOOM_RAW_SCHEMA.BILLING_EVENTS | USER_ID | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_billing_events | event_type | Source | ZOOM_RAW_SCHEMA.BILLING_EVENTS | EVENT_TYPE | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_billing_events | event_date | Source | ZOOM_RAW_SCHEMA.BILLING_EVENTS | EVENT_DATE | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_billing_events | amount | Source | ZOOM_RAW_SCHEMA.BILLING_EVENTS | AMOUNT | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_billing_events | load_timestamp | Source | ZOOM_RAW_SCHEMA.BILLING_EVENTS | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_billing_events | update_timestamp | Source | ZOOM_RAW_SCHEMA.BILLING_EVENTS | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_billing_events | source_system | Source | ZOOM_RAW_SCHEMA.BILLING_EVENTS | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_participants | participant_id | Source | ZOOM_RAW_SCHEMA.PARTICIPANTS | PARTICIPANT_ID | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_participants | meeting_id | Source | ZOOM_RAW_SCHEMA.PARTICIPANTS | MEETING_ID | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_participants | user_id | Source | ZOOM_RAW_SCHEMA.PARTICIPANTS | USER_ID | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_participants | join_time | Source | ZOOM_RAW_SCHEMA.PARTICIPANTS | JOIN_TIME | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_participants | leave_time | Source | ZOOM_RAW_SCHEMA.PARTICIPANTS | LEAVE_TIME | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_participants | load_timestamp | Source | ZOOM_RAW_SCHEMA.PARTICIPANTS | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_participants | update_timestamp | Source | ZOOM_RAW_SCHEMA.PARTICIPANTS | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_participants | source_system | Source | ZOOM_RAW_SCHEMA.PARTICIPANTS | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_webinars | webinar_id | Source | ZOOM_RAW_SCHEMA.WEBINARS | WEBINAR_ID | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_webinars | webinar_topic | Source | ZOOM_RAW_SCHEMA.WEBINARS | WEBINAR_TOPIC | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_webinars | host_id | Source | ZOOM_RAW_SCHEMA.WEBINARS | HOST_ID | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_webinars | start_time | Source | ZOOM_RAW_SCHEMA.WEBINARS | START_TIME | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_webinars | end_time | Source | ZOOM_RAW_SCHEMA.WEBINARS | END_TIME | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_webinars | registrants | Source | ZOOM_RAW_SCHEMA.WEBINARS | REGISTRANTS | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_webinars | load_timestamp | Source | ZOOM_RAW_SCHEMA.WEBINARS | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_webinars | update_timestamp | Source | ZOOM_RAW_SCHEMA.WEBINARS | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_webinars | source_system | Source | ZOOM_RAW_SCHEMA.WEBINARS | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_feature_usage | usage_id | Source | ZOOM_RAW_SCHEMA.FEATURE_USAGE | USAGE_ID | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_feature_usage | meeting_id | Source | ZOOM_RAW_SCHEMA.FEATURE_USAGE | MEETING_ID | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_feature_usage | feature_name | Source | ZOOM_RAW_SCHEMA.FEATURE_USAGE | FEATURE_NAME | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_feature_usage | usage_date | Source | ZOOM_RAW_SCHEMA.FEATURE_USAGE | USAGE_DATE | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_feature_usage | usage_count | Source | ZOOM_RAW_SCHEMA.FEATURE_USAGE | USAGE_COUNT | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_feature_usage | load_timestamp | Source | ZOOM_RAW_SCHEMA.FEATURE_USAGE | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_feature_usage | update_timestamp | Source | ZOOM_RAW_SCHEMA.FEATURE_USAGE | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | ZOOM_BRONZE_SCHEMA.bz_feature_usage | source_system | Source | ZOOM_RAW_SCHEMA.FEATURE_USAGE | SOURCE_SYSTEM | 1-1 Mapping |

## Summary

This Bronze Layer Data Mapping document (Version 2) provides a comprehensive field-level mapping between the source system tables (ZOOM_RAW_SCHEMA) and the Bronze layer tables (ZOOM_BRONZE_SCHEMA) in the Medallion architecture for the Zoom Platform Analytics System. 

**Key Updates in Version 2:**
- **Schema Naming Alignment**: Updated target table references from 'bz_tablename' to 'ZOOM_BRONZE_SCHEMA.bz_tablename' to align with proper schema naming conventions
- **Source Schema Specification**: Updated source table references to include 'ZOOM_RAW_SCHEMA' prefix for complete schema qualification
- **Consistency**: Maintained 1-1 mapping relationships preserving the raw data structure as required for the Bronze layer

**Mapping Statistics:**
- **Total Tables Mapped:** 8
- **Total Field Mappings:** 64
- **Source Schema:** ZOOM_RAW_SCHEMA
- **Target Schema:** ZOOM_BRONZE_SCHEMA
- **Transformation Approach:** Direct 1-1 mapping with no data transformations

**Data Ingestion Principles:**
- The Bronze layer maintains the original data structure while providing a standardized naming convention with the "bz_" prefix for all Bronze layer tables
- All source fields are directly mapped to corresponding Bronze layer fields without any transformations
- Ensures data lineage and traceability throughout the data pipeline
- Supports Snowflake SQL compatibility with proper schema qualification
- Preserves all metadata columns (load_timestamp, update_timestamp, source_system) for operational tracking

**Assumptions:**
- Source data types are compatible with Snowflake target data types
- All source tables contain the specified columns as per the raw schema metadata
- Data ingestion processes will handle any necessary data type conversions at the platform level
- Bronze layer serves as the foundation for downstream Silver and Gold layer transformations