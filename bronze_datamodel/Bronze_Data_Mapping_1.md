_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Bronze Layer Data Mapping for Zoom Platform Analytics System
## *Version*: 1
## *Updated on*: 
_____________________________________________

# Bronze Layer Data Mapping Document
## Medallion Architecture Implementation - Snowflake

### Overview
This document provides comprehensive data mapping for the Bronze layer in the Medallion architecture implementation for the Zoom Platform Analytics System. The Bronze layer serves as the raw data ingestion layer, preserving the original structure and metadata from source systems while ensuring data lineage and audit capabilities.

### Architecture Details
- **Source Schema**: ZOOM_RAW_SCHEMA
- **Target Schema**: ZOOM_BRONZE_SCHEMA
- **Database**: ZOOM_DATABASE
- **Mapping Type**: 1-1 Direct Mapping (No Transformations)

---

## Table 1: USERS Mapping

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

---

## Table 2: MEETINGS Mapping

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

---

## Table 3: LICENSES Mapping

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

---

## Table 4: SUPPORT_TICKETS Mapping

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

---

## Table 5: BILLING_EVENTS Mapping

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

---

## Table 6: PARTICIPANTS Mapping

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

---

## Table 7: WEBINARS Mapping

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

---

## Table 8: FEATURE_USAGE Mapping

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

---

## Data Type Mapping Standards

### Snowflake Data Type Assignments

| Source Data Type | Bronze Layer Data Type | Justification |
|------------------|------------------------|--------------|
| TEXT | VARCHAR(16777216) | Maximum flexibility for string data |
| NUMBER | NUMBER(38,0) | Preserves precision for integers |
| NUMBER (with decimals) | NUMBER(38,10) | Preserves precision for decimal values |
| TIMESTAMP_NTZ | TIMESTAMP_NTZ | Direct mapping without timezone |
| DATE | DATE | Direct mapping for date values |
| BOOLEAN | BOOLEAN | Direct mapping for boolean values |

---

## Metadata Management

### Standard Metadata Fields
All Bronze layer tables include the following metadata fields for data governance:

1. **SOURCE_SYSTEM** - Identifies the originating system
2. **LOAD_TIMESTAMP** - Records when data was loaded into Bronze layer
3. **UPDATE_TIMESTAMP** - Tracks last modification timestamp from source

### Data Lineage Tracking
- Source system identification preserved in SOURCE_SYSTEM field
- Load timestamps maintained for audit trail
- Original update timestamps preserved for change tracking

---

## Summary

### Mapping Statistics
- **Total Source Tables**: 8
- **Total Bronze Tables**: 8
- **Total Field Mappings**: 64
- **Mapping Type**: 100% Direct 1-1 Mapping
- **Data Transformation**: None (Raw data preservation)

### Key Benefits
1. **Data Lineage**: Complete traceability from source to Bronze
2. **Audit Trail**: Comprehensive timestamp tracking
3. **Data Governance**: Standardized metadata management
4. **Scalability**: Flexible schema design for future enhancements
5. **Performance**: Optimized for high-volume data ingestion

---

*Document Version: 1.0*  
*Last Updated: [To be filled during implementation]*  
*Next Review Date: [To be scheduled]*