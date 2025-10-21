# Snowflake Raw Layer Metadata Documentation

## Database: ZOOM_DATABASE
## Schema: ZOOM_RAW_SCHEMA

This document contains metadata for all tables and views in the Snowflake raw layer.

---

## Table: MEETINGS
**Type:** TABLE

| Column Name | Business Description | Data Type | Constraints | Domain Values |
|-------------|---------------------|-----------|-------------|---------------|
| UPDATE_TIMESTAMP | Timestamp when the meeting record was last updated | TIMESTAMP_NTZ | - | - |
| MEETING_TOPIC | Subject or topic of the meeting | TEXT | - | - |
| DURATION_MINUTES | Duration of the meeting in minutes | NUMBER | - | Positive integers |
| LOAD_TIMESTAMP | Timestamp when the record was loaded into the system | TIMESTAMP_NTZ | - | - |
| MEETING_ID | Unique identifier for the meeting | TEXT | Primary Key | - |
| SOURCE_SYSTEM | System from which the meeting data originated | TEXT | - | - |
| END_TIME | Meeting end timestamp | TIMESTAMP_NTZ | - | - |
| HOST_ID | Identifier of the meeting host | TEXT | Foreign Key | - |
| START_TIME | Meeting start timestamp | TIMESTAMP_NTZ | - | - |

---

## Table: LICENSES
**Type:** TABLE

| Column Name | Business Description | Data Type | Constraints | Domain Values |
|-------------|---------------------|-----------|-------------|---------------|
| LOAD_TIMESTAMP | Timestamp when the license record was loaded | TIMESTAMP_NTZ | - | - |
| LICENSE_TYPE | Type or category of the license | TEXT | - | Basic, Pro, Enterprise |
| END_DATE | License expiration date | DATE | - | - |
| ASSIGNED_TO_USER_ID | User ID to whom the license is assigned | TEXT | Foreign Key | - |
| LICENSE_ID | Unique identifier for the license | TEXT | Primary Key | - |
| SOURCE_SYSTEM | System from which the license data originated | TEXT | - | - |
| UPDATE_TIMESTAMP | Timestamp when the license record was last updated | TIMESTAMP_NTZ | - | - |
| START_DATE | License activation date | DATE | - | - |

---

## Table: SUPPORT_TICKETS
**Type:** TABLE

| Column Name | Business Description | Data Type | Constraints | Domain Values |
|-------------|---------------------|-----------|-------------|---------------|
| RESOLUTION_STATUS | Current status of the support ticket | TEXT | - | Open, In Progress, Resolved, Closed |
| UPDATE_TIMESTAMP | Timestamp when the ticket was last updated | TIMESTAMP_NTZ | - | - |
| TICKET_ID | Unique identifier for the support ticket | TEXT | Primary Key | - |
| LOAD_TIMESTAMP | Timestamp when the ticket record was loaded | TIMESTAMP_NTZ | - | - |
| OPEN_DATE | Date when the ticket was opened | DATE | - | - |
| USER_ID | Identifier of the user who created the ticket | TEXT | Foreign Key | - |
| SOURCE_SYSTEM | System from which the ticket data originated | TEXT | - | - |
| TICKET_TYPE | Category or type of the support ticket | TEXT | - | Technical, Billing, General |

---

## Table: USERS
**Type:** TABLE

| Column Name | Business Description | Data Type | Constraints | Domain Values |
|-------------|---------------------|-----------|-------------|---------------|
| EMAIL | User's email address | TEXT | Unique | Valid email format |
| SOURCE_SYSTEM | System from which the user data originated | TEXT | - | - |
| USER_NAME | Display name of the user | TEXT | - | - |
| LOAD_TIMESTAMP | Timestamp when the user record was loaded | TIMESTAMP_NTZ | - | - |
| UPDATE_TIMESTAMP | Timestamp when the user record was last updated | TIMESTAMP_NTZ | - | - |
| USER_ID | Unique identifier for the user | TEXT | Primary Key | - |
| PLAN_TYPE | Subscription plan type of the user | TEXT | - | Basic, Pro, Business, Enterprise |
| COMPANY | Company or organization name | TEXT | - | - |

---

## Table: BILLING_EVENTS
**Type:** TABLE

| Column Name | Business Description | Data Type | Constraints | Domain Values |
|-------------|---------------------|-----------|-------------|---------------|
| SOURCE_SYSTEM | System from which the billing event originated | TEXT | - | - |
| EVENT_ID | Unique identifier for the billing event | TEXT | Primary Key | - |
| UPDATE_TIMESTAMP | Timestamp when the billing event was last updated | TIMESTAMP_NTZ | - | - |
| AMOUNT | Monetary amount associated with the billing event | NUMBER | - | Positive numbers |
| EVENT_TYPE | Type of billing event | TEXT | - | Charge, Refund, Credit, Payment |
| LOAD_TIMESTAMP | Timestamp when the billing event was loaded | TIMESTAMP_NTZ | - | - |
| EVENT_DATE | Date when the billing event occurred | DATE | - | - |
| USER_ID | Identifier of the user associated with the billing event | TEXT | Foreign Key | - |

---

## Table: PARTICIPANTS
**Type:** TABLE

| Column Name | Business Description | Data Type | Constraints | Domain Values |
|-------------|---------------------|-----------|-------------|---------------|
| UPDATE_TIMESTAMP | Timestamp when the participant record was last updated | TIMESTAMP_NTZ | - | - |
| MEETING_ID | Identifier of the meeting the participant joined | TEXT | Foreign Key | - |
| SOURCE_SYSTEM | System from which the participant data originated | TEXT | - | - |
| LOAD_TIMESTAMP | Timestamp when the participant record was loaded | TIMESTAMP_NTZ | - | - |
| LEAVE_TIME | Timestamp when the participant left the meeting | TIMESTAMP_NTZ | - | - |
| JOIN_TIME | Timestamp when the participant joined the meeting | TIMESTAMP_NTZ | - | - |
| USER_ID | Identifier of the participating user | TEXT | Foreign Key | - |
| PARTICIPANT_ID | Unique identifier for the participant session | TEXT | Primary Key | - |

---

## Table: WEBINARS
**Type:** TABLE

| Column Name | Business Description | Data Type | Constraints | Domain Values |
|-------------|---------------------|-----------|-------------|---------------|
| END_TIME | Webinar end timestamp | TIMESTAMP_NTZ | - | - |
| SOURCE_SYSTEM | System from which the webinar data originated | TEXT | - | - |
| WEBINAR_TOPIC | Subject or topic of the webinar | TEXT | - | - |
| START_TIME | Webinar start timestamp | TIMESTAMP_NTZ | - | - |
| WEBINAR_ID | Unique identifier for the webinar | TEXT | Primary Key | - |
| LOAD_TIMESTAMP | Timestamp when the webinar record was loaded | TIMESTAMP_NTZ | - | - |
| REGISTRANTS | Number of registered participants | NUMBER | - | Non-negative integers |
| HOST_ID | Identifier of the webinar host | TEXT | Foreign Key | - |
| UPDATE_TIMESTAMP | Timestamp when the webinar record was last updated | TIMESTAMP_NTZ | - | - |

---

## Table: FEATURE_USAGE
**Type:** TABLE

| Column Name | Business Description | Data Type | Constraints | Domain Values |
|-------------|---------------------|-----------|-------------|---------------|
| FEATURE_NAME | Name of the feature being tracked | TEXT | - | Screen Share, Recording, Chat, Breakout Rooms |
| MEETING_ID | Identifier of the meeting where feature was used | TEXT | Foreign Key | - |
| USAGE_DATE | Date when the feature was used | DATE | - | - |
| UPDATE_TIMESTAMP | Timestamp when the usage record was last updated | TIMESTAMP_NTZ | - | - |
| SOURCE_SYSTEM | System from which the feature usage data originated | TEXT | - | - |
| USAGE_ID | Unique identifier for the feature usage record | TEXT | Primary Key | - |
| LOAD_TIMESTAMP | Timestamp when the usage record was loaded | TIMESTAMP_NTZ | - | - |
| USAGE_COUNT | Number of times the feature was used | NUMBER | - | Non-negative integers |

---

## Summary

**Total Tables:** 8
**Total Views:** 0

### Table Relationships:
- MEETINGS.HOST_ID → USERS.USER_ID
- PARTICIPANTS.USER_ID → USERS.USER_ID
- PARTICIPANTS.MEETING_ID → MEETINGS.MEETING_ID
- SUPPORT_TICKETS.USER_ID → USERS.USER_ID
- LICENSES.ASSIGNED_TO_USER_ID → USERS.USER_ID
- BILLING_EVENTS.USER_ID → USERS.USER_ID
- WEBINARS.HOST_ID → USERS.USER_ID
- FEATURE_USAGE.MEETING_ID → MEETINGS.MEETING_ID

### Common Patterns:
- All tables include SOURCE_SYSTEM, LOAD_TIMESTAMP, and UPDATE_TIMESTAMP for data lineage and audit purposes
- Primary keys are typically TEXT type identifiers
- Timestamps are stored as TIMESTAMP_NTZ (without timezone)
- Amounts and counts are stored as NUMBER type

---

*Generated on: $(date)*
*Schema: ZOOM_RAW_SCHEMA*
*Database: ZOOM_DATABASE*