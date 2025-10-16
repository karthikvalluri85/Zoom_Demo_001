_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Bronze Layer Data Mapping for Zoom Platform Analytics System
## *Version*: 1
## *Updated on*: 
_____________________________________________

# Bronze Layer Data Mapping Document

## Data Mapping Table

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | bz_meetings | meeting_id | Source | MEETINGS | MEETING_ID | 1-1 Mapping |
| Bronze | bz_meetings | meeting_topic | Source | MEETINGS | MEETING_TOPIC | 1-1 Mapping |
| Bronze | bz_meetings | host_id | Source | MEETINGS | HOST_ID | 1-1 Mapping |
| Bronze | bz_meetings | start_time | Source | MEETINGS | START_TIME | 1-1 Mapping |
| Bronze | bz_meetings | end_time | Source | MEETINGS | END_TIME | 1-1 Mapping |
| Bronze | bz_meetings | duration_minutes | Source | MEETINGS | DURATION_MINUTES | 1-1 Mapping |
| Bronze | bz_meetings | load_timestamp | Source | MEETINGS | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_meetings | update_timestamp | Source | MEETINGS | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_meetings | source_system | Source | MEETINGS | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | bz_licenses | license_id | Source | LICENSES | LICENSE_ID | 1-1 Mapping |
| Bronze | bz_licenses | license_type | Source | LICENSES | LICENSE_TYPE | 1-1 Mapping |
| Bronze | bz_licenses | assigned_to_user_id | Source | LICENSES | ASSIGNED_TO_USER_ID | 1-1 Mapping |
| Bronze | bz_licenses | start_date | Source | LICENSES | START_DATE | 1-1 Mapping |
| Bronze | bz_licenses | end_date | Source | LICENSES | END_DATE | 1-1 Mapping |
| Bronze | bz_licenses | load_timestamp | Source | LICENSES | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_licenses | update_timestamp | Source | LICENSES | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_licenses | source_system | Source | LICENSES | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | bz_support_tickets | ticket_id | Source | SUPPORT_TICKETS | TICKET_ID | 1-1 Mapping |
| Bronze | bz_support_tickets | user_id | Source | SUPPORT_TICKETS | USER_ID | 1-1 Mapping |
| Bronze | bz_support_tickets | ticket_type | Source | SUPPORT_TICKETS | TICKET_TYPE | 1-1 Mapping |
| Bronze | bz_support_tickets | resolution_status | Source | SUPPORT_TICKETS | RESOLUTION_STATUS | 1-1 Mapping |
| Bronze | bz_support_tickets | open_date | Source | SUPPORT_TICKETS | OPEN_DATE | 1-1 Mapping |
| Bronze | bz_support_tickets | load_timestamp | Source | SUPPORT_TICKETS | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_support_tickets | update_timestamp | Source | SUPPORT_TICKETS | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_support_tickets | source_system | Source | SUPPORT_TICKETS | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | bz_users | user_id | Source | USERS | USER_ID | 1-1 Mapping |
| Bronze | bz_users | user_name | Source | USERS | USER_NAME | 1-1 Mapping |
| Bronze | bz_users | email | Source | USERS | EMAIL | 1-1 Mapping |
| Bronze | bz_users | company | Source | USERS | COMPANY | 1-1 Mapping |
| Bronze | bz_users | plan_type | Source | USERS | PLAN_TYPE | 1-1 Mapping |
| Bronze | bz_users | load_timestamp | Source | USERS | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_users | update_timestamp | Source | USERS | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_users | source_system | Source | USERS | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | bz_billing_events | event_id | Source | BILLING_EVENTS | EVENT_ID | 1-1 Mapping |
| Bronze | bz_billing_events | user_id | Source | BILLING_EVENTS | USER_ID | 1-1 Mapping |
| Bronze | bz_billing_events | event_type | Source | BILLING_EVENTS | EVENT_TYPE | 1-1 Mapping |
| Bronze | bz_billing_events | event_date | Source | BILLING_EVENTS | EVENT_DATE | 1-1 Mapping |
| Bronze | bz_billing_events | amount | Source | BILLING_EVENTS | AMOUNT | 1-1 Mapping |
| Bronze | bz_billing_events | load_timestamp | Source | BILLING_EVENTS | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_billing_events | update_timestamp | Source | BILLING_EVENTS | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_billing_events | source_system | Source | BILLING_EVENTS | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | bz_participants | participant_id | Source | PARTICIPANTS | PARTICIPANT_ID | 1-1 Mapping |
| Bronze | bz_participants | meeting_id | Source | PARTICIPANTS | MEETING_ID | 1-1 Mapping |
| Bronze | bz_participants | user_id | Source | PARTICIPANTS | USER_ID | 1-1 Mapping |
| Bronze | bz_participants | join_time | Source | PARTICIPANTS | JOIN_TIME | 1-1 Mapping |
| Bronze | bz_participants | leave_time | Source | PARTICIPANTS | LEAVE_TIME | 1-1 Mapping |
| Bronze | bz_participants | load_timestamp | Source | PARTICIPANTS | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_participants | update_timestamp | Source | PARTICIPANTS | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_participants | source_system | Source | PARTICIPANTS | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | bz_webinars | webinar_id | Source | WEBINARS | WEBINAR_ID | 1-1 Mapping |
| Bronze | bz_webinars | webinar_topic | Source | WEBINARS | WEBINAR_TOPIC | 1-1 Mapping |
| Bronze | bz_webinars | host_id | Source | WEBINARS | HOST_ID | 1-1 Mapping |
| Bronze | bz_webinars | start_time | Source | WEBINARS | START_TIME | 1-1 Mapping |
| Bronze | bz_webinars | end_time | Source | WEBINARS | END_TIME | 1-1 Mapping |
| Bronze | bz_webinars | registrants | Source | WEBINARS | REGISTRANTS | 1-1 Mapping |
| Bronze | bz_webinars | load_timestamp | Source | WEBINARS | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_webinars | update_timestamp | Source | WEBINARS | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_webinars | source_system | Source | WEBINARS | SOURCE_SYSTEM | 1-1 Mapping |
| Bronze | bz_feature_usage | usage_id | Source | FEATURE_USAGE | USAGE_ID | 1-1 Mapping |
| Bronze | bz_feature_usage | meeting_id | Source | FEATURE_USAGE | MEETING_ID | 1-1 Mapping |
| Bronze | bz_feature_usage | feature_name | Source | FEATURE_USAGE | FEATURE_NAME | 1-1 Mapping |
| Bronze | bz_feature_usage | usage_date | Source | FEATURE_USAGE | USAGE_DATE | 1-1 Mapping |
| Bronze | bz_feature_usage | usage_count | Source | FEATURE_USAGE | USAGE_COUNT | 1-1 Mapping |
| Bronze | bz_feature_usage | load_timestamp | Source | FEATURE_USAGE | LOAD_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_feature_usage | update_timestamp | Source | FEATURE_USAGE | UPDATE_TIMESTAMP | 1-1 Mapping |
| Bronze | bz_feature_usage | source_system | Source | FEATURE_USAGE | SOURCE_SYSTEM | 1-1 Mapping |

## Summary

This Bronze Layer Data Mapping document provides a comprehensive field-level mapping between the source system tables and the Bronze layer tables in the Medallion architecture for the Zoom Platform Analytics System. The mapping follows a 1-1 relationship preserving the raw data structure as required for the Bronze layer, which serves as the foundation for downstream data transformations and analytics in the Silver and Gold layers.

**Total Tables Mapped:** 8
**Total Field Mappings:** 64

The Bronze layer maintains the original data structure while providing a standardized naming convention with the "bz_" prefix for all Bronze layer tables. All source fields are directly mapped to corresponding Bronze layer fields without any transformations, ensuring data lineage and traceability throughout the data pipeline.