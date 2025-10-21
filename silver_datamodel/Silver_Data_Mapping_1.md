_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Silver Layer Data Mapping for Zoom Platform Analytics System in Snowflake Medallion Architecture
## *Version*: 1
## *Updated on*: 
_____________________________________________

# Silver Layer Data Mapping - Zoom Platform Analytics System

## 1. Overview

This document defines the comprehensive data mapping for the Silver Layer in the Zoom Platform Analytics System's Medallion architecture implementation in Snowflake. The Silver Layer serves as the cleansed, validated, and business-rule-applied layer that transforms raw Bronze Layer data into high-quality, analytics-ready datasets.

The mapping incorporates necessary cleansing, validations, and business rules at the attribute level, ensuring data integrity, consistency, and compliance with organizational and regulatory requirements. All transformations are designed to be compatible with Snowflake SQL and follow the established data quality framework.

## 2. Data Mapping for the Silver Layer

### 2.1 Meeting Entity Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Validation Rule | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-----------------|--------------------|
| Silver | MEETINGS | MEETING_ID | Bronze | RAW_MEETINGS | MEETING_ID | NOT NULL, UNIQUE, ALPHANUMERIC | UPPER(TRIM(MEETING_ID)) |
| Silver | MEETINGS | ACCOUNT_ID | Bronze | RAW_MEETINGS | ACCOUNT_ID | NOT NULL, FOREIGN KEY | UPPER(TRIM(ACCOUNT_ID)) |
| Silver | MEETINGS | HOST_USER_ID | Bronze | RAW_MEETINGS | HOST_USER_ID | NOT NULL, FOREIGN KEY | UPPER(TRIM(HOST_USER_ID)) |
| Silver | MEETINGS | MEETING_START_TIME | Bronze | RAW_MEETINGS | START_TIME | NOT NULL, ISO 8601 FORMAT | TO_TIMESTAMP_NTZ(START_TIME, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | MEETINGS | MEETING_END_TIME | Bronze | RAW_MEETINGS | END_TIME | NOT NULL, ISO 8601 FORMAT, > START_TIME | TO_TIMESTAMP_NTZ(END_TIME, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | MEETINGS | MEETING_DURATION | Bronze | RAW_MEETINGS | DURATION | RANGE 0-2880, INTEGER | CASE WHEN DURATION IS NULL THEN DATEDIFF('MINUTE', MEETING_START_TIME, MEETING_END_TIME) ELSE DURATION END |
| Silver | MEETINGS | MEETING_TYPE | Bronze | RAW_MEETINGS | MEETING_TYPE | NOT NULL, VALID VALUES | UPPER(TRIM(MEETING_TYPE)) |
| Silver | MEETINGS | MEETING_STATUS | Bronze | RAW_MEETINGS | STATUS | NOT NULL, VALID STATUS VALUES | UPPER(TRIM(STATUS)) |
| Silver | MEETINGS | PLATFORM_VERSION | Bronze | RAW_MEETINGS | PLATFORM_VERSION | NOT NULL, VERSION FORMAT | TRIM(PLATFORM_VERSION) |
| Silver | MEETINGS | SECURITY_SETTINGS | Bronze | RAW_MEETINGS | SECURITY_SETTINGS | JSON FORMAT | PARSE_JSON(SECURITY_SETTINGS) |
| Silver | MEETINGS | PARTICIPANT_COUNT | Bronze | RAW_MEETINGS | PARTICIPANT_COUNT | RANGE 1-10000, INTEGER | COALESCE(PARTICIPANT_COUNT, 0) |
| Silver | MEETINGS | CREATED_DATE | Bronze | RAW_MEETINGS | CREATED_DATE | NOT NULL, ISO 8601 FORMAT | TO_TIMESTAMP_NTZ(CREATED_DATE, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | MEETINGS | UPDATED_DATE | Bronze | RAW_MEETINGS | UPDATED_DATE | ISO 8601 FORMAT | TO_TIMESTAMP_NTZ(UPDATED_DATE, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |

### 2.2 Webinar Entity Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Validation Rule | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-----------------|--------------------|
| Silver | WEBINARS | WEBINAR_ID | Bronze | RAW_WEBINARS | WEBINAR_ID | NOT NULL, UNIQUE, ALPHANUMERIC | UPPER(TRIM(WEBINAR_ID)) |
| Silver | WEBINARS | ACCOUNT_ID | Bronze | RAW_WEBINARS | ACCOUNT_ID | NOT NULL, FOREIGN KEY | UPPER(TRIM(ACCOUNT_ID)) |
| Silver | WEBINARS | HOST_USER_ID | Bronze | RAW_WEBINARS | HOST_USER_ID | NOT NULL, FOREIGN KEY | UPPER(TRIM(HOST_USER_ID)) |
| Silver | WEBINARS | WEBINAR_START_TIME | Bronze | RAW_WEBINARS | START_TIME | NOT NULL, ISO 8601 FORMAT | TO_TIMESTAMP_NTZ(START_TIME, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | WEBINARS | WEBINAR_END_TIME | Bronze | RAW_WEBINARS | END_TIME | NOT NULL, ISO 8601 FORMAT, > START_TIME | TO_TIMESTAMP_NTZ(END_TIME, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | WEBINARS | WEBINAR_DURATION | Bronze | RAW_WEBINARS | DURATION | RANGE 0-1440, INTEGER | CASE WHEN DURATION IS NULL THEN DATEDIFF('MINUTE', WEBINAR_START_TIME, WEBINAR_END_TIME) ELSE DURATION END |
| Silver | WEBINARS | REGISTRATION_REQUIRED | Bronze | RAW_WEBINARS | REGISTRATION_REQUIRED | BOOLEAN | CASE WHEN UPPER(REGISTRATION_REQUIRED) IN ('TRUE', '1', 'YES') THEN TRUE ELSE FALSE END |
| Silver | WEBINARS | MAX_ATTENDEES | Bronze | RAW_WEBINARS | MAX_ATTENDEES | RANGE 1-10000, INTEGER | COALESCE(MAX_ATTENDEES, 100) |
| Silver | WEBINARS | ACTUAL_ATTENDEES | Bronze | RAW_WEBINARS | ACTUAL_ATTENDEES | RANGE 0-10000, INTEGER | COALESCE(ACTUAL_ATTENDEES, 0) |
| Silver | WEBINARS | QNA_ENABLED | Bronze | RAW_WEBINARS | QNA_ENABLED | BOOLEAN | CASE WHEN UPPER(QNA_ENABLED) IN ('TRUE', '1', 'YES') THEN TRUE ELSE FALSE END |
| Silver | WEBINARS | RECORDING_STATUS | Bronze | RAW_WEBINARS | RECORDING_STATUS | VALID STATUS VALUES | UPPER(TRIM(RECORDING_STATUS)) |
| Silver | WEBINARS | REGISTRATION_COUNT | Bronze | RAW_WEBINARS | REGISTRATION_COUNT | INTEGER, >= 0 | COALESCE(REGISTRATION_COUNT, 0) |

### 2.3 User Entity Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Validation Rule | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-----------------|--------------------|
| Silver | USERS | USER_ID | Bronze | RAW_USERS | USER_ID | NOT NULL, UNIQUE, ALPHANUMERIC | UPPER(TRIM(USER_ID)) |
| Silver | USERS | ACCOUNT_ID | Bronze | RAW_USERS | ACCOUNT_ID | NOT NULL, FOREIGN KEY | UPPER(TRIM(ACCOUNT_ID)) |
| Silver | USERS | EMAIL_ADDRESS | Bronze | RAW_USERS | EMAIL | NOT NULL, UNIQUE WITHIN ACCOUNT, RFC 5322 FORMAT | LOWER(TRIM(EMAIL)) |
| Silver | USERS | USER_STATUS | Bronze | RAW_USERS | STATUS | NOT NULL, VALID STATUS VALUES | UPPER(TRIM(STATUS)) |
| Silver | USERS | CREATED_DATE | Bronze | RAW_USERS | CREATED_DATE | NOT NULL, ISO 8601 FORMAT | TO_TIMESTAMP_NTZ(CREATED_DATE, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | USERS | LAST_LOGIN_DATE | Bronze | RAW_USERS | LAST_LOGIN | ISO 8601 FORMAT, >= CREATED_DATE | TO_TIMESTAMP_NTZ(LAST_LOGIN, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | USERS | LICENSE_TYPE | Bronze | RAW_USERS | LICENSE_TYPE | NOT NULL, VALID LICENSE VALUES | UPPER(TRIM(LICENSE_TYPE)) |
| Silver | USERS | SECURITY_PROFILE | Bronze | RAW_USERS | SECURITY_PROFILE | NOT NULL, VALID PROFILE VALUES | UPPER(TRIM(SECURITY_PROFILE)) |
| Silver | USERS | FIRST_NAME | Bronze | RAW_USERS | FIRST_NAME | UTF-8 ENCODING | TRIM(FIRST_NAME) |
| Silver | USERS | LAST_NAME | Bronze | RAW_USERS | LAST_NAME | UTF-8 ENCODING | TRIM(LAST_NAME) |
| Silver | USERS | PHONE_NUMBER | Bronze | RAW_USERS | PHONE | E.164 FORMAT | REGEXP_REPLACE(PHONE, '[^0-9+]', '') |
| Silver | USERS | TIME_ZONE | Bronze | RAW_USERS | TIME_ZONE | VALID IANA TIME ZONE | TRIM(TIME_ZONE) |

### 2.4 Participant Entity Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Validation Rule | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-----------------|--------------------|
| Silver | PARTICIPANTS | PARTICIPANT_ID | Bronze | RAW_PARTICIPANTS | PARTICIPANT_ID | NOT NULL, UNIQUE | UPPER(TRIM(PARTICIPANT_ID)) |
| Silver | PARTICIPANTS | MEETING_ID | Bronze | RAW_PARTICIPANTS | MEETING_ID | NOT NULL, FOREIGN KEY | UPPER(TRIM(MEETING_ID)) |
| Silver | PARTICIPANTS | USER_ID | Bronze | RAW_PARTICIPANTS | USER_ID | NOT NULL, FOREIGN KEY | UPPER(TRIM(USER_ID)) |
| Silver | PARTICIPANTS | JOIN_TIME | Bronze | RAW_PARTICIPANTS | JOIN_TIME | NOT NULL, ISO 8601 FORMAT | TO_TIMESTAMP_NTZ(JOIN_TIME, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | PARTICIPANTS | LEAVE_TIME | Bronze | RAW_PARTICIPANTS | LEAVE_TIME | ISO 8601 FORMAT, >= JOIN_TIME | TO_TIMESTAMP_NTZ(LEAVE_TIME, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | PARTICIPANTS | PARTICIPANT_ROLE | Bronze | RAW_PARTICIPANTS | ROLE | NOT NULL, VALID ROLE VALUES | UPPER(TRIM(ROLE)) |
| Silver | PARTICIPANTS | CONNECTION_TYPE | Bronze | RAW_PARTICIPANTS | CONNECTION_TYPE | NOT NULL, VALID CONNECTION VALUES | UPPER(TRIM(CONNECTION_TYPE)) |
| Silver | PARTICIPANTS | DEVICE_INFORMATION | Bronze | RAW_PARTICIPANTS | DEVICE_INFO | JSON FORMAT | PARSE_JSON(DEVICE_INFO) |
| Silver | PARTICIPANTS | ENGAGEMENT_SCORE | Bronze | RAW_PARTICIPANTS | ENGAGEMENT_SCORE | DECIMAL 0.0000-1.0000, 4 DECIMAL PLACES | ROUND(COALESCE(ENGAGEMENT_SCORE, 0), 4) |
| Silver | PARTICIPANTS | DURATION_MINUTES | Bronze | RAW_PARTICIPANTS | DURATION | INTEGER, >= 0 | CASE WHEN DURATION IS NULL AND LEAVE_TIME IS NOT NULL THEN DATEDIFF('MINUTE', JOIN_TIME, LEAVE_TIME) ELSE COALESCE(DURATION, 0) END |
| Silver | PARTICIPANTS | AUDIO_QUALITY | Bronze | RAW_PARTICIPANTS | AUDIO_QUALITY | DECIMAL 0.000-100.000, 3 DECIMAL PLACES | ROUND(COALESCE(AUDIO_QUALITY, 0), 3) |
| Silver | PARTICIPANTS | VIDEO_QUALITY | Bronze | RAW_PARTICIPANTS | VIDEO_QUALITY | DECIMAL 0.000-100.000, 3 DECIMAL PLACES | ROUND(COALESCE(VIDEO_QUALITY, 0), 3) |

### 2.5 Recording Entity Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Validation Rule | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-----------------|--------------------|
| Silver | RECORDINGS | RECORDING_ID | Bronze | RAW_RECORDINGS | RECORDING_ID | NOT NULL, UNIQUE | UPPER(TRIM(RECORDING_ID)) |
| Silver | RECORDINGS | MEETING_ID | Bronze | RAW_RECORDINGS | MEETING_ID | NOT NULL, FOREIGN KEY | UPPER(TRIM(MEETING_ID)) |
| Silver | RECORDINGS | FILE_NAME | Bronze | RAW_RECORDINGS | FILE_NAME | NOT NULL, VALID FILE FORMAT | TRIM(FILE_NAME) |
| Silver | RECORDINGS | FILE_SIZE_BYTES | Bronze | RAW_RECORDINGS | FILE_SIZE | NOT NULL, BIGINT, > 0 | COALESCE(FILE_SIZE, 0) |
| Silver | RECORDINGS | DURATION_SECONDS | Bronze | RAW_RECORDINGS | DURATION | NOT NULL, INTEGER, > 0 | COALESCE(DURATION, 0) |
| Silver | RECORDINGS | STORAGE_LOCATION | Bronze | RAW_RECORDINGS | STORAGE_PATH | NOT NULL, VALID URL FORMAT | TRIM(STORAGE_PATH) |
| Silver | RECORDINGS | ACCESS_LEVEL | Bronze | RAW_RECORDINGS | ACCESS_LEVEL | NOT NULL, VALID ACCESS VALUES | UPPER(TRIM(ACCESS_LEVEL)) |
| Silver | RECORDINGS | ENCRYPTION_STATUS | Bronze | RAW_RECORDINGS | ENCRYPTION_STATUS | NOT NULL, BOOLEAN | CASE WHEN UPPER(ENCRYPTION_STATUS) IN ('TRUE', '1', 'YES', 'ENCRYPTED') THEN TRUE ELSE FALSE END |
| Silver | RECORDINGS | RETENTION_DATE | Bronze | RAW_RECORDINGS | RETENTION_DATE | ISO 8601 FORMAT, > CREATED_DATE | TO_TIMESTAMP_NTZ(RETENTION_DATE, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | RECORDINGS | CREATED_DATE | Bronze | RAW_RECORDINGS | CREATED_DATE | NOT NULL, ISO 8601 FORMAT | TO_TIMESTAMP_NTZ(CREATED_DATE, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | RECORDINGS | FILE_TYPE | Bronze | RAW_RECORDINGS | FILE_TYPE | NOT NULL, VALID FILE TYPES | UPPER(TRIM(FILE_TYPE)) |

### 2.6 Chat Message Entity Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Validation Rule | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-----------------|--------------------|
| Silver | CHAT_MESSAGES | MESSAGE_ID | Bronze | RAW_CHAT_MESSAGES | MESSAGE_ID | NOT NULL, UNIQUE | UPPER(TRIM(MESSAGE_ID)) |
| Silver | CHAT_MESSAGES | MEETING_ID | Bronze | RAW_CHAT_MESSAGES | MEETING_ID | NOT NULL, FOREIGN KEY | UPPER(TRIM(MEETING_ID)) |
| Silver | CHAT_MESSAGES | SENDER_ID | Bronze | RAW_CHAT_MESSAGES | SENDER_ID | NOT NULL, FOREIGN KEY | UPPER(TRIM(SENDER_ID)) |
| Silver | CHAT_MESSAGES | MESSAGE_TIMESTAMP | Bronze | RAW_CHAT_MESSAGES | TIMESTAMP | NOT NULL, ISO 8601 FORMAT | TO_TIMESTAMP_NTZ(TIMESTAMP, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | CHAT_MESSAGES | MESSAGE_TYPE | Bronze | RAW_CHAT_MESSAGES | MESSAGE_TYPE | NOT NULL, VALID MESSAGE TYPES | UPPER(TRIM(MESSAGE_TYPE)) |
| Silver | CHAT_MESSAGES | CONTENT_HASH | Bronze | RAW_CHAT_MESSAGES | CONTENT_HASH | NOT NULL, HASH FORMAT | TRIM(CONTENT_HASH) |
| Silver | CHAT_MESSAGES | DELIVERY_STATUS | Bronze | RAW_CHAT_MESSAGES | DELIVERY_STATUS | NOT NULL, VALID STATUS VALUES | UPPER(TRIM(DELIVERY_STATUS)) |
| Silver | CHAT_MESSAGES | ENCRYPTION_LEVEL | Bronze | RAW_CHAT_MESSAGES | ENCRYPTION_LEVEL | NOT NULL, VALID ENCRYPTION LEVELS | UPPER(TRIM(ENCRYPTION_LEVEL)) |
| Silver | CHAT_MESSAGES | MESSAGE_LENGTH | Bronze | RAW_CHAT_MESSAGES | MESSAGE_LENGTH | INTEGER, RANGE 0-4096 | COALESCE(MESSAGE_LENGTH, 0) |
| Silver | CHAT_MESSAGES | IS_PRIVATE | Bronze | RAW_CHAT_MESSAGES | IS_PRIVATE | BOOLEAN | CASE WHEN UPPER(IS_PRIVATE) IN ('TRUE', '1', 'YES') THEN TRUE ELSE FALSE END |

### 2.7 Breakout Room Entity Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Validation Rule | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-----------------|--------------------|
| Silver | BREAKOUT_ROOMS | ROOM_ID | Bronze | RAW_BREAKOUT_ROOMS | ROOM_ID | NOT NULL, UNIQUE | UPPER(TRIM(ROOM_ID)) |
| Silver | BREAKOUT_ROOMS | MEETING_ID | Bronze | RAW_BREAKOUT_ROOMS | MEETING_ID | NOT NULL, FOREIGN KEY | UPPER(TRIM(MEETING_ID)) |
| Silver | BREAKOUT_ROOMS | ROOM_NAME | Bronze | RAW_BREAKOUT_ROOMS | ROOM_NAME | NOT NULL, UTF-8 ENCODING | TRIM(ROOM_NAME) |
| Silver | BREAKOUT_ROOMS | CREATED_TIME | Bronze | RAW_BREAKOUT_ROOMS | CREATED_TIME | NOT NULL, ISO 8601 FORMAT | TO_TIMESTAMP_NTZ(CREATED_TIME, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | BREAKOUT_ROOMS | CLOSED_TIME | Bronze | RAW_BREAKOUT_ROOMS | CLOSED_TIME | ISO 8601 FORMAT, >= CREATED_TIME | TO_TIMESTAMP_NTZ(CLOSED_TIME, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | BREAKOUT_ROOMS | ASSIGNED_HOST | Bronze | RAW_BREAKOUT_ROOMS | ASSIGNED_HOST | FOREIGN KEY | UPPER(TRIM(ASSIGNED_HOST)) |
| Silver | BREAKOUT_ROOMS | MAX_PARTICIPANTS | Bronze | RAW_BREAKOUT_ROOMS | MAX_PARTICIPANTS | INTEGER, RANGE 1-50 | COALESCE(MAX_PARTICIPANTS, 10) |
| Silver | BREAKOUT_ROOMS | ACTUAL_PARTICIPANTS | Bronze | RAW_BREAKOUT_ROOMS | ACTUAL_PARTICIPANTS | INTEGER, RANGE 0-50, <= MAX_PARTICIPANTS | COALESCE(ACTUAL_PARTICIPANTS, 0) |
| Silver | BREAKOUT_ROOMS | DURATION_MINUTES | Bronze | RAW_BREAKOUT_ROOMS | DURATION | INTEGER, >= 0 | CASE WHEN DURATION IS NULL AND CLOSED_TIME IS NOT NULL THEN DATEDIFF('MINUTE', CREATED_TIME, CLOSED_TIME) ELSE COALESCE(DURATION, 0) END |

### 2.8 Poll Entity Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Validation Rule | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-----------------|--------------------|
| Silver | POLLS | POLL_ID | Bronze | RAW_POLLS | POLL_ID | NOT NULL, UNIQUE | UPPER(TRIM(POLL_ID)) |
| Silver | POLLS | MEETING_ID | Bronze | RAW_POLLS | MEETING_ID | NOT NULL, FOREIGN KEY | UPPER(TRIM(MEETING_ID)) |
| Silver | POLLS | CREATOR_ID | Bronze | RAW_POLLS | CREATOR_ID | NOT NULL, FOREIGN KEY | UPPER(TRIM(CREATOR_ID)) |
| Silver | POLLS | POLL_TITLE | Bronze | RAW_POLLS | POLL_TITLE | NOT NULL, UTF-8 ENCODING | TRIM(POLL_TITLE) |
| Silver | POLLS | CREATED_TIME | Bronze | RAW_POLLS | CREATED_TIME | NOT NULL, ISO 8601 FORMAT | TO_TIMESTAMP_NTZ(CREATED_TIME, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | POLLS | LAUNCH_TIME | Bronze | RAW_POLLS | LAUNCH_TIME | ISO 8601 FORMAT, >= CREATED_TIME | TO_TIMESTAMP_NTZ(LAUNCH_TIME, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | POLLS | END_TIME | Bronze | RAW_POLLS | END_TIME | ISO 8601 FORMAT, >= LAUNCH_TIME | TO_TIMESTAMP_NTZ(END_TIME, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | POLLS | POLL_TYPE | Bronze | RAW_POLLS | POLL_TYPE | NOT NULL, VALID POLL TYPES | UPPER(TRIM(POLL_TYPE)) |
| Silver | POLLS | RESPONSE_COUNT | Bronze | RAW_POLLS | RESPONSE_COUNT | INTEGER, RANGE 0-10000 | COALESCE(RESPONSE_COUNT, 0) |
| Silver | POLLS | QUESTIONS_JSON | Bronze | RAW_POLLS | QUESTIONS | JSON FORMAT | PARSE_JSON(QUESTIONS) |
| Silver | POLLS | RESULTS_JSON | Bronze | RAW_POLLS | RESULTS | JSON FORMAT | PARSE_JSON(RESULTS) |

### 2.9 Integration Entity Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Validation Rule | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-----------------|--------------------|
| Silver | INTEGRATIONS | INTEGRATION_ID | Bronze | RAW_INTEGRATIONS | INTEGRATION_ID | NOT NULL, UNIQUE | UPPER(TRIM(INTEGRATION_ID)) |
| Silver | INTEGRATIONS | ACCOUNT_ID | Bronze | RAW_INTEGRATIONS | ACCOUNT_ID | NOT NULL, FOREIGN KEY | UPPER(TRIM(ACCOUNT_ID)) |
| Silver | INTEGRATIONS | INTEGRATION_TYPE | Bronze | RAW_INTEGRATIONS | INTEGRATION_TYPE | NOT NULL, VALID INTEGRATION TYPES | UPPER(TRIM(INTEGRATION_TYPE)) |
| Silver | INTEGRATIONS | PROVIDER_NAME | Bronze | RAW_INTEGRATIONS | PROVIDER_NAME | NOT NULL | TRIM(PROVIDER_NAME) |
| Silver | INTEGRATIONS | STATUS | Bronze | RAW_INTEGRATIONS | STATUS | NOT NULL, VALID STATUS VALUES | UPPER(TRIM(STATUS)) |
| Silver | INTEGRATIONS | CONFIGURATION_HASH | Bronze | RAW_INTEGRATIONS | CONFIG_HASH | NOT NULL, HASH FORMAT | TRIM(CONFIG_HASH) |
| Silver | INTEGRATIONS | LAST_SYNC_TIME | Bronze | RAW_INTEGRATIONS | LAST_SYNC | ISO 8601 FORMAT | TO_TIMESTAMP_NTZ(LAST_SYNC, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | INTEGRATIONS | ERROR_COUNT | Bronze | RAW_INTEGRATIONS | ERROR_COUNT | INTEGER, >= 0 | COALESCE(ERROR_COUNT, 0) |
| Silver | INTEGRATIONS | DATA_VOLUME_MB | Bronze | RAW_INTEGRATIONS | DATA_VOLUME | DECIMAL, >= 0 | ROUND(COALESCE(DATA_VOLUME, 0), 2) |
| Silver | INTEGRATIONS | SUCCESS_RATE | Bronze | RAW_INTEGRATIONS | SUCCESS_RATE | DECIMAL 0.000-100.000, 3 DECIMAL PLACES | ROUND(COALESCE(SUCCESS_RATE, 0), 3) |

### 2.10 Account Entity Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Validation Rule | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-----------------|--------------------|
| Silver | ACCOUNTS | ACCOUNT_ID | Bronze | RAW_ACCOUNTS | ACCOUNT_ID | NOT NULL, UNIQUE | UPPER(TRIM(ACCOUNT_ID)) |
| Silver | ACCOUNTS | ACCOUNT_NAME | Bronze | RAW_ACCOUNTS | ACCOUNT_NAME | NOT NULL, UNIQUE | TRIM(ACCOUNT_NAME) |
| Silver | ACCOUNTS | ACCOUNT_TYPE | Bronze | RAW_ACCOUNTS | ACCOUNT_TYPE | NOT NULL, VALID ACCOUNT TYPES | UPPER(TRIM(ACCOUNT_TYPE)) |
| Silver | ACCOUNTS | SUBSCRIPTION_PLAN | Bronze | RAW_ACCOUNTS | SUBSCRIPTION_PLAN | NOT NULL, VALID PLAN VALUES | UPPER(TRIM(SUBSCRIPTION_PLAN)) |
| Silver | ACCOUNTS | CREATED_DATE | Bronze | RAW_ACCOUNTS | CREATED_DATE | NOT NULL, ISO 8601 FORMAT | TO_TIMESTAMP_NTZ(CREATED_DATE, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | ACCOUNTS | STATUS | Bronze | RAW_ACCOUNTS | STATUS | NOT NULL, VALID STATUS VALUES | UPPER(TRIM(STATUS)) |
| Silver | ACCOUNTS | COMPLIANCE_LEVEL | Bronze | RAW_ACCOUNTS | COMPLIANCE_LEVEL | NOT NULL, VALID COMPLIANCE LEVELS | UPPER(TRIM(COMPLIANCE_LEVEL)) |
| Silver | ACCOUNTS | SECURITY_TIER | Bronze | RAW_ACCOUNTS | SECURITY_TIER | NOT NULL, VALID SECURITY TIERS | UPPER(TRIM(SECURITY_TIER)) |
| Silver | ACCOUNTS | LICENSE_COUNT | Bronze | RAW_ACCOUNTS | LICENSE_COUNT | INTEGER, > 0 | COALESCE(LICENSE_COUNT, 1) |
| Silver | ACCOUNTS | STORAGE_LIMIT_GB | Bronze | RAW_ACCOUNTS | STORAGE_LIMIT | DECIMAL, > 0 | ROUND(COALESCE(STORAGE_LIMIT, 100), 2) |

### 2.11 Quality Metrics Entity Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Validation Rule | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-----------------|--------------------|
| Silver | QUALITY_METRICS | METRIC_ID | Bronze | RAW_QUALITY_METRICS | METRIC_ID | NOT NULL, UNIQUE | UPPER(TRIM(METRIC_ID)) |
| Silver | QUALITY_METRICS | MEETING_ID | Bronze | RAW_QUALITY_METRICS | MEETING_ID | NOT NULL, FOREIGN KEY | UPPER(TRIM(MEETING_ID)) |
| Silver | QUALITY_METRICS | PARTICIPANT_ID | Bronze | RAW_QUALITY_METRICS | PARTICIPANT_ID | NOT NULL, FOREIGN KEY | UPPER(TRIM(PARTICIPANT_ID)) |
| Silver | QUALITY_METRICS | MEASUREMENT_TIME | Bronze | RAW_QUALITY_METRICS | MEASUREMENT_TIME | NOT NULL, ISO 8601 FORMAT | TO_TIMESTAMP_NTZ(MEASUREMENT_TIME, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | QUALITY_METRICS | AUDIO_QUALITY_SCORE | Bronze | RAW_QUALITY_METRICS | AUDIO_QUALITY | DECIMAL 0.000-100.000, 3 DECIMAL PLACES | ROUND(COALESCE(AUDIO_QUALITY, 0), 3) |
| Silver | QUALITY_METRICS | VIDEO_QUALITY_SCORE | Bronze | RAW_QUALITY_METRICS | VIDEO_QUALITY | DECIMAL 0.000-100.000, 3 DECIMAL PLACES | ROUND(COALESCE(VIDEO_QUALITY, 0), 3) |
| Silver | QUALITY_METRICS | NETWORK_LATENCY_MS | Bronze | RAW_QUALITY_METRICS | NETWORK_LATENCY | INTEGER, RANGE 0-10000 | COALESCE(NETWORK_LATENCY, 0) |
| Silver | QUALITY_METRICS | PACKET_LOSS_PERCENT | Bronze | RAW_QUALITY_METRICS | PACKET_LOSS | DECIMAL 0.000-100.000, 3 DECIMAL PLACES | ROUND(COALESCE(PACKET_LOSS, 0), 3) |
| Silver | QUALITY_METRICS | AUDIO_BITRATE_KBPS | Bronze | RAW_QUALITY_METRICS | AUDIO_BITRATE | INTEGER, RANGE 0-50000 | COALESCE(AUDIO_BITRATE, 0) |
| Silver | QUALITY_METRICS | VIDEO_BITRATE_KBPS | Bronze | RAW_QUALITY_METRICS | VIDEO_BITRATE | INTEGER, RANGE 0-50000 | COALESCE(VIDEO_BITRATE, 0) |
| Silver | QUALITY_METRICS | CPU_USAGE_PERCENT | Bronze | RAW_QUALITY_METRICS | CPU_USAGE | DECIMAL 0.000-100.000, 3 DECIMAL PLACES | ROUND(COALESCE(CPU_USAGE, 0), 3) |

### 2.12 Error Data Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Validation Rule | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-----------------|--------------------|
| Silver | ERROR_DATA | ERROR_ID | Bronze | RAW_ERROR_DATA | ERROR_ID | NOT NULL, UNIQUE | UPPER(TRIM(ERROR_ID)) |
| Silver | ERROR_DATA | SOURCE_TABLE | Bronze | RAW_ERROR_DATA | SOURCE_TABLE | NOT NULL | UPPER(TRIM(SOURCE_TABLE)) |
| Silver | ERROR_DATA | SOURCE_RECORD_ID | Bronze | RAW_ERROR_DATA | SOURCE_RECORD_ID | NOT NULL | TRIM(SOURCE_RECORD_ID) |
| Silver | ERROR_DATA | ERROR_TYPE | Bronze | RAW_ERROR_DATA | ERROR_TYPE | NOT NULL, VALID ERROR TYPES | UPPER(TRIM(ERROR_TYPE)) |
| Silver | ERROR_DATA | ERROR_DESCRIPTION | Bronze | RAW_ERROR_DATA | ERROR_DESCRIPTION | NOT NULL | TRIM(ERROR_DESCRIPTION) |
| Silver | ERROR_DATA | ERROR_TIMESTAMP | Bronze | RAW_ERROR_DATA | ERROR_TIMESTAMP | NOT NULL, ISO 8601 FORMAT | TO_TIMESTAMP_NTZ(ERROR_TIMESTAMP, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | ERROR_DATA | VALIDATION_RULE_FAILED | Bronze | RAW_ERROR_DATA | VALIDATION_RULE | NOT NULL | TRIM(VALIDATION_RULE) |
| Silver | ERROR_DATA | RAW_DATA_JSON | Bronze | RAW_ERROR_DATA | RAW_DATA | JSON FORMAT | PARSE_JSON(RAW_DATA) |
| Silver | ERROR_DATA | RETRY_COUNT | Bronze | RAW_ERROR_DATA | RETRY_COUNT | INTEGER, >= 0 | COALESCE(RETRY_COUNT, 0) |
| Silver | ERROR_DATA | RESOLUTION_STATUS | Bronze | RAW_ERROR_DATA | RESOLUTION_STATUS | VALID STATUS VALUES | UPPER(TRIM(RESOLUTION_STATUS)) |

### 2.13 Audit Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Validation Rule | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-----------------|--------------------|
| Silver | AUDIT_LOG | AUDIT_ID | Bronze | RAW_AUDIT_LOG | AUDIT_ID | NOT NULL, UNIQUE | UPPER(TRIM(AUDIT_ID)) |
| Silver | AUDIT_LOG | TABLE_NAME | Bronze | RAW_AUDIT_LOG | TABLE_NAME | NOT NULL | UPPER(TRIM(TABLE_NAME)) |
| Silver | AUDIT_LOG | RECORD_ID | Bronze | RAW_AUDIT_LOG | RECORD_ID | NOT NULL | TRIM(RECORD_ID) |
| Silver | AUDIT_LOG | OPERATION_TYPE | Bronze | RAW_AUDIT_LOG | OPERATION_TYPE | NOT NULL, VALID OPERATIONS | UPPER(TRIM(OPERATION_TYPE)) |
| Silver | AUDIT_LOG | USER_ID | Bronze | RAW_AUDIT_LOG | USER_ID | FOREIGN KEY | UPPER(TRIM(USER_ID)) |
| Silver | AUDIT_LOG | OPERATION_TIMESTAMP | Bronze | RAW_AUDIT_LOG | OPERATION_TIMESTAMP | NOT NULL, ISO 8601 FORMAT | TO_TIMESTAMP_NTZ(OPERATION_TIMESTAMP, 'YYYY-MM-DDTHH24:MI:SS.FF3Z') |
| Silver | AUDIT_LOG | OLD_VALUES_JSON | Bronze | RAW_AUDIT_LOG | OLD_VALUES | JSON FORMAT | PARSE_JSON(OLD_VALUES) |
| Silver | AUDIT_LOG | NEW_VALUES_JSON | Bronze | RAW_AUDIT_LOG | NEW_VALUES | JSON FORMAT | PARSE_JSON(NEW_VALUES) |
| Silver | AUDIT_LOG | SESSION_ID | Bronze | RAW_AUDIT_LOG | SESSION_ID | NOT NULL | TRIM(SESSION_ID) |
| Silver | AUDIT_LOG | IP_ADDRESS | Bronze | RAW_AUDIT_LOG | IP_ADDRESS | VALID IP FORMAT | TRIM(IP_ADDRESS) |
| Silver | AUDIT_LOG | USER_AGENT | Bronze | RAW_AUDIT_LOG | USER_AGENT | NOT NULL | TRIM(USER_AGENT) |

## 3. Data Quality and Validation Framework

### 3.1 Validation Rules Implementation

1. **NOT NULL Constraints**: Implemented using CASE statements to handle null values with appropriate defaults or error logging
2. **UNIQUE Constraints**: Enforced through primary key definitions and unique indexes in Snowflake
3. **Foreign Key Validation**: Implemented through JOIN operations with parent tables during data loading
4. **Range Validations**: Implemented using CASE statements with boundary checks
5. **Format Validations**: Implemented using REGEXP functions for pattern matching
6. **Business Rule Validations**: Implemented through complex CASE statements and conditional logic

### 3.2 Error Handling Mechanisms

1. **Data Quality Checks**: Pre-transformation validation to identify data quality issues
2. **Error Logging**: Failed records logged to ERROR_DATA table with detailed error information
3. **Retry Logic**: Automated retry mechanisms for transient errors
4. **Alert Generation**: Real-time alerts for critical data quality violations
5. **Data Quarantine**: Invalid records quarantined for manual review and correction

### 3.3 Performance Optimization

1. **Incremental Loading**: Delta processing for changed records only
2. **Parallel Processing**: Multi-threaded processing for large data volumes
3. **Clustering Keys**: Appropriate clustering keys for optimal query performance
4. **Materialized Views**: Pre-computed aggregations for frequently accessed metrics
5. **Caching Strategy**: Intelligent caching for reference data and lookup tables

### 3.4 Monitoring and Alerting

1. **Data Quality Metrics**: Real-time monitoring of data quality scores
2. **Processing Performance**: Monitoring of transformation processing times
3. **Error Rate Tracking**: Continuous monitoring of error rates and trends
4. **Compliance Monitoring**: Automated compliance checking and reporting
5. **Resource Utilization**: Monitoring of system resource usage and optimization

## 4. Implementation Recommendations

### 4.1 Phased Implementation Approach

1. **Phase 1**: Core entities (Meetings, Users, Participants, Accounts)
2. **Phase 2**: Extended entities (Webinars, Recordings, Chat Messages)
3. **Phase 3**: Advanced features (Breakout Rooms, Polls, Integrations)
4. **Phase 4**: Quality metrics and comprehensive monitoring
5. **Phase 5**: Advanced analytics and machine learning features

### 4.2 Data Governance Integration

1. **Data Lineage**: Complete tracking from Bronze to Silver layer transformations
2. **Data Catalog**: Comprehensive metadata management and documentation
3. **Access Control**: Role-based access control implementation
4. **Audit Trail**: Complete audit logging for all data operations
5. **Compliance Framework**: Automated compliance checking and reporting

### 4.3 Security Considerations

1. **Encryption**: End-to-end encryption for sensitive data fields
2. **Masking**: Data masking for non-production environments
3. **Access Logging**: Comprehensive access logging and monitoring
4. **Key Management**: Secure key management for encryption operations
5. **Network Security**: Secure network configurations and VPN access

---

*This Silver Layer Data Mapping document provides the foundation for implementing a robust, scalable, and compliant data transformation layer in the Zoom Platform Analytics System's Medallion architecture.*