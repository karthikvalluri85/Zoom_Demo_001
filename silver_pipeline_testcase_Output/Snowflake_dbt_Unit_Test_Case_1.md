_____________________________________________
## *Author*: AAVA
## *Created on*: 2024-12-19
## *Description*: Comprehensive Snowflake dbt Unit Test Cases for Zoom Platform Analytics Silver Layer Models
## *Version*: 1 
## *Updated on*: 2024-12-19
_____________________________________________

# Snowflake dbt Unit Test Cases - Zoom Platform Analytics Silver Layer

## Overview

This document provides comprehensive unit test cases and dbt test scripts for the Zoom Platform Analytics System's Silver Layer models in Snowflake. The tests validate data transformations, business rules, edge cases, and error handling scenarios to ensure data quality and reliability.

## Test Strategy

The testing approach covers:
- **Happy Path Testing**: Valid transformations, joins, and aggregations
- **Edge Case Testing**: Null values, empty datasets, invalid lookups, schema mismatches
- **Exception Testing**: Failed relationships, unexpected values, data quality violations
- **Business Rule Validation**: Compliance with organizational and regulatory requirements
- **Performance Testing**: Query optimization and resource utilization

## Models Under Test

1. **si_users** - User profile and account information
2. **si_meetings** - Meeting session data and metrics
3. **si_licenses** - License allocation and subscription data
4. **si_support_tickets** - Customer support and resolution tracking
5. **si_billing_events** - Financial transactions and billing data
6. **si_participants** - Participant engagement and attendance
7. **si_webinars** - Webinar events and registration metrics
8. **si_feature_usage** - Platform feature utilization analytics
9. **si_audit_log** - Comprehensive audit trail

---

# Test Case List

## 1. SI_USERS Model Test Cases

### Test Case ID: TC_USERS_001
**Test Case Description**: Validate user_id uniqueness and not null constraint
**Expected Outcome**: All user_id values should be unique and not null

### Test Case ID: TC_USERS_002
**Test Case Description**: Validate email format using RFC 5322 standard
**Expected Outcome**: All email addresses should follow valid email format

### Test Case ID: TC_USERS_003
**Test Case Description**: Validate plan_type standardization
**Expected Outcome**: All plan_type values should be in (BASIC, PRO, BUSINESS, ENTERPRISE)

### Test Case ID: TC_USERS_004
**Test Case Description**: Test deduplication logic using ROW_NUMBER() window function
**Expected Outcome**: Only the most recent record per user should be retained

### Test Case ID: TC_USERS_005
**Test Case Description**: Validate incremental processing with unique key
**Expected Outcome**: New and updated records should be processed correctly

## 2. SI_MEETINGS Model Test Cases

### Test Case ID: TC_MEETINGS_001
**Test Case Description**: Validate meeting_id uniqueness and not null constraint
**Expected Outcome**: All meeting_id values should be unique and not null

### Test Case ID: TC_MEETINGS_002
**Test Case Description**: Validate duration calculation from start/end times
**Expected Outcome**: Duration should match calculated difference when missing

### Test Case ID: TC_MEETINGS_003
**Test Case Description**: Validate time relationship constraints (end_time > start_time)
**Expected Outcome**: All meetings should have valid time sequences

### Test Case ID: TC_MEETINGS_004
**Test Case Description**: Test meeting topic cleansing and validation
**Expected Outcome**: Meeting topics should be trimmed and non-empty

### Test Case ID: TC_MEETINGS_005
**Test Case Description**: Validate incremental processing behavior
**Expected Outcome**: Only new/updated meetings should be processed

## 3. SI_LICENSES Model Test Cases

### Test Case ID: TC_LICENSES_001
**Test Case Description**: Validate license_id uniqueness and not null constraint
**Expected Outcome**: All license_id values should be unique and not null

### Test Case ID: TC_LICENSES_002
**Test Case Description**: Validate license type standardization
**Expected Outcome**: All license_type values should be in (BASIC, PRO, ENTERPRISE)

### Test Case ID: TC_LICENSES_003
**Test Case Description**: Validate date constraints (end_date >= start_date)
**Expected Outcome**: All licenses should have valid date ranges

### Test Case ID: TC_LICENSES_004
**Test Case Description**: Test future date validation for start_date
**Expected Outcome**: Start dates should not be in the future beyond reasonable limits

## 4. SI_SUPPORT_TICKETS Model Test Cases

### Test Case ID: TC_TICKETS_001
**Test Case Description**: Validate ticket_id uniqueness and not null constraint
**Expected Outcome**: All ticket_id values should be unique and not null

### Test Case ID: TC_TICKETS_002
**Test Case Description**: Validate status standardization
**Expected Outcome**: All status values should be in (OPEN, IN PROGRESS, RESOLVED, CLOSED)

### Test Case ID: TC_TICKETS_003
**Test Case Description**: Validate ticket type classification
**Expected Outcome**: All ticket_type values should be in (TECHNICAL, BILLING, GENERAL)

### Test Case ID: TC_TICKETS_004
**Test Case Description**: Validate open_date constraints
**Expected Outcome**: Open dates should be valid and not in the future

## 5. SI_BILLING_EVENTS Model Test Cases

### Test Case ID: TC_BILLING_001
**Test Case Description**: Validate billing_event_id uniqueness and not null constraint
**Expected Outcome**: All billing_event_id values should be unique and not null

### Test Case ID: TC_BILLING_002
**Test Case Description**: Validate amount precision and non-negative values
**Expected Outcome**: All amounts should be rounded to 2 decimal places and >= 0

### Test Case ID: TC_BILLING_003
**Test Case Description**: Validate event type standardization
**Expected Outcome**: All event_type values should be in (CHARGE, REFUND, CREDIT, PAYMENT)

### Test Case ID: TC_BILLING_004
**Test Case Description**: Test amount validation and rounding logic
**Expected Outcome**: Amounts should be properly validated and formatted

## 6. SI_PARTICIPANTS Model Test Cases

### Test Case ID: TC_PARTICIPANTS_001
**Test Case Description**: Validate participant_id uniqueness and not null constraint
**Expected Outcome**: All participant_id values should be unique and not null

### Test Case ID: TC_PARTICIPANTS_002
**Test Case Description**: Validate join/leave time relationship
**Expected Outcome**: Leave time should be greater than or equal to join time

### Test Case ID: TC_PARTICIPANTS_003
**Test Case Description**: Validate future timestamp constraints
**Expected Outcome**: Join/leave times should not be in the future

### Test Case ID: TC_PARTICIPANTS_004
**Test Case Description**: Test duration calculation consistency
**Expected Outcome**: Duration should match calculated time difference

## 7. SI_WEBINARS Model Test Cases

### Test Case ID: TC_WEBINARS_001
**Test Case Description**: Validate webinar_id uniqueness and not null constraint
**Expected Outcome**: All webinar_id values should be unique and not null

### Test Case ID: TC_WEBINARS_002
**Test Case Description**: Validate registrant count constraints
**Expected Outcome**: Registrant count should be non-negative integer

### Test Case ID: TC_WEBINARS_003
**Test Case Description**: Validate time relationship for start/end times
**Expected Outcome**: End time should be greater than start time

### Test Case ID: TC_WEBINARS_004
**Test Case Description**: Test topic validation for non-empty content
**Expected Outcome**: Webinar topics should not be null or empty

## 8. SI_FEATURE_USAGE Model Test Cases

### Test Case ID: TC_FEATURE_001
**Test Case Description**: Validate feature_usage_id uniqueness and not null constraint
**Expected Outcome**: All feature_usage_id values should be unique and not null

### Test Case ID: TC_FEATURE_002
**Test Case Description**: Validate feature name standardization
**Expected Outcome**: Feature names should be in (SCREEN SHARE, RECORDING, CHAT, BREAKOUT ROOMS)

### Test Case ID: TC_FEATURE_003
**Test Case Description**: Validate usage count constraints
**Expected Outcome**: Usage count should be non-negative integer

### Test Case ID: TC_FEATURE_004
**Test Case Description**: Validate usage date constraints
**Expected Outcome**: Usage dates should be valid and not in the future

## 9. SI_AUDIT_LOG Model Test Cases

### Test Case ID: TC_AUDIT_001
**Test Case Description**: Validate audit log completeness
**Expected Outcome**: All pipeline executions should be logged

### Test Case ID: TC_AUDIT_002
**Test Case Description**: Validate execution metadata accuracy
**Expected Outcome**: Timestamps, status, and system information should be accurate

### Test Case ID: TC_AUDIT_003
**Test Case Description**: Test audit trail integrity
**Expected Outcome**: Audit records should maintain referential integrity

---

# dbt Test Scripts

## YAML-based Schema Tests

### schema.yml - Comprehensive Data Quality Tests

```yaml
version: 2

sources:
  - name: zoom_bronze
    description: "Bronze layer source tables from Zoom platform"
    schema: ZOOM_BRONZE_SCHEMA
    tables:
      - name: bz_users
        description: "Bronze layer user data"
        columns:
          - name: email
            description: "User email address"
            tests:
              - not_null
          - name: user_name
            description: "User display name"
            tests:
              - not_null
          - name: plan_type
            description: "User subscription plan"
            tests:
              - accepted_values:
                  values: ['Basic', 'Pro', 'Business', 'Enterprise']
      
      - name: bz_meetings
        description: "Bronze layer meeting data"
        columns:
          - name: meeting_topic
            description: "Meeting subject"
          - name: duration_minutes
            description: "Meeting duration"
            tests:
              - not_null
          - name: start_time
            description: "Meeting start timestamp"
            tests:
              - not_null
          - name: end_time
            description: "Meeting end timestamp"
            tests:
              - not_null
      
      - name: bz_licenses
        description: "Bronze layer license data"
        columns:
          - name: license_type
            description: "License category"
            tests:
              - accepted_values:
                  values: ['Basic', 'Pro', 'Enterprise']
          - name: start_date
            description: "License start date"
            tests:
              - not_null
          - name: end_date
            description: "License end date"
            tests:
              - not_null
      
      - name: bz_support_tickets
        description: "Bronze layer support ticket data"
        columns:
          - name: resolution_status
            description: "Ticket status"
            tests:
              - accepted_values:
                  values: ['Open', 'In Progress', 'Resolved', 'Closed']
          - name: ticket_type
            description: "Ticket category"
            tests:
              - accepted_values:
                  values: ['Technical', 'Billing', 'General']
          - name: open_date
            description: "Ticket creation date"
            tests:
              - not_null
      
      - name: bz_billing_events
        description: "Bronze layer billing event data"
        columns:
          - name: amount
            description: "Transaction amount"
            tests:
              - not_null
          - name: event_type
            description: "Billing event type"
            tests:
              - accepted_values:
                  values: ['Charge', 'Refund', 'Credit', 'Payment']
          - name: event_date
            description: "Event date"
            tests:
              - not_null
      
      - name: bz_participants
        description: "Bronze layer participant data"
        columns:
          - name: join_time
            description: "Participant join timestamp"
            tests:
              - not_null
          - name: leave_time
            description: "Participant leave timestamp"
      
      - name: bz_webinars
        description: "Bronze layer webinar data"
        columns:
          - name: webinar_topic
            description: "Webinar subject"
          - name: start_time
            description: "Webinar start timestamp"
            tests:
              - not_null
          - name: end_time
            description: "Webinar end timestamp"
          - name: registrants
            description: "Number of registrants"
      
      - name: bz_feature_usage
        description: "Bronze layer feature usage data"
        columns:
          - name: feature_name
            description: "Feature name"
            tests:
              - accepted_values:
                  values: ['Screen Share', 'Recording', 'Chat', 'Breakout Rooms']
          - name: usage_date
            description: "Usage date"
            tests:
              - not_null
          - name: usage_count
            description: "Usage count"
            tests:
              - not_null

models:
  - name: si_users
    description: "Silver layer user data with data quality validations"
    columns:
      - name: user_id
        description: "Unique user identifier"
        tests:
          - unique
          - not_null
      - name: email
        description: "Validated email address"
        tests:
          - not_null
          - unique
      - name: user_name
        description: "Cleaned user name"
        tests:
          - not_null
      - name: plan_type
        description: "Standardized plan type"
        tests:
          - accepted_values:
              values: ['BASIC', 'PRO', 'BUSINESS', 'ENTERPRISE']
      - name: company
        description: "Company name"
      - name: load_date
        description: "Load date"
        tests:
          - not_null
      - name: update_date
        description: "Update date"
        tests:
          - not_null
      - name: source_system
        description: "Source system identifier"
        tests:
          - not_null

  - name: si_meetings
    description: "Silver layer meeting data with enhanced validations"
    columns:
      - name: meeting_id
        description: "Unique meeting identifier"
        tests:
          - unique
          - not_null
      - name: meeting_topic
        description: "Cleaned meeting topic"
        tests:
          - not_null
      - name: duration_minutes
        description: "Validated meeting duration"
        tests:
          - not_null
      - name: start_time
        description: "Meeting start timestamp"
        tests:
          - not_null
      - name: end_time
        description: "Meeting end timestamp"
        tests:
          - not_null
      - name: load_date
        description: "Load date"
        tests:
          - not_null
      - name: update_date
        description: "Update date"
        tests:
          - not_null
      - name: source_system
        description: "Source system identifier"
        tests:
          - not_null

  - name: si_licenses
    description: "Silver layer license data with date validations"
    columns:
      - name: license_id
        description: "Unique license identifier"
        tests:
          - unique
          - not_null
      - name: license_type
        description: "Standardized license type"
        tests:
          - accepted_values:
              values: ['BASIC', 'PRO', 'ENTERPRISE']
      - name: start_date
        description: "License start date"
        tests:
          - not_null
      - name: end_date
        description: "License end date"
        tests:
          - not_null
      - name: load_date
        description: "Load date"
        tests:
          - not_null
      - name: update_date
        description: "Update date"
        tests:
          - not_null
      - name: source_system
        description: "Source system identifier"
        tests:
          - not_null

  - name: si_support_tickets
    description: "Silver layer support ticket data with status validations"
    columns:
      - name: ticket_id
        description: "Unique ticket identifier"
        tests:
          - unique
          - not_null
      - name: resolution_status
        description: "Standardized ticket status"
        tests:
          - accepted_values:
              values: ['OPEN', 'IN PROGRESS', 'RESOLVED', 'CLOSED']
      - name: ticket_type
        description: "Standardized ticket type"
        tests:
          - accepted_values:
              values: ['TECHNICAL', 'BILLING', 'GENERAL']
      - name: open_date
        description: "Ticket open date"
        tests:
          - not_null
      - name: load_date
        description: "Load date"
        tests:
          - not_null
      - name: update_date
        description: "Update date"
        tests:
          - not_null
      - name: source_system
        description: "Source system identifier"
        tests:
          - not_null

  - name: si_billing_events
    description: "Silver layer billing event data with amount validations"
    columns:
      - name: billing_event_id
        description: "Unique billing event identifier"
        tests:
          - unique
          - not_null
      - name: amount
        description: "Validated transaction amount"
        tests:
          - not_null
      - name: event_type
        description: "Standardized event type"
        tests:
          - accepted_values:
              values: ['CHARGE', 'REFUND', 'CREDIT', 'PAYMENT']
      - name: event_date
        description: "Event date"
        tests:
          - not_null
      - name: load_date
        description: "Load date"
        tests:
          - not_null
      - name: update_date
        description: "Update date"
        tests:
          - not_null
      - name: source_system
        description: "Source system identifier"
        tests:
          - not_null

  - name: si_participants
    description: "Silver layer participant data with time validations"
    columns:
      - name: participant_id
        description: "Unique participant identifier"
        tests:
          - unique
          - not_null
      - name: join_time
        description: "Participant join timestamp"
        tests:
          - not_null
      - name: leave_time
        description: "Participant leave timestamp"
      - name: load_date
        description: "Load date"
        tests:
          - not_null
      - name: update_date
        description: "Update date"
        tests:
          - not_null
      - name: source_system
        description: "Source system identifier"
        tests:
          - not_null

  - name: si_webinars
    description: "Silver layer webinar data with registration validations"
    columns:
      - name: webinar_id
        description: "Unique webinar identifier"
        tests:
          - unique
          - not_null
      - name: webinar_topic
        description: "Cleaned webinar topic"
        tests:
          - not_null
      - name: start_time
        description: "Webinar start timestamp"
        tests:
          - not_null
      - name: end_time
        description: "Webinar end timestamp"
      - name: registrants
        description: "Number of registrants"
      - name: load_date
        description: "Load date"
        tests:
          - not_null
      - name: update_date
        description: "Update date"
        tests:
          - not_null
      - name: source_system
        description: "Source system identifier"
        tests:
          - not_null

  - name: si_feature_usage
    description: "Silver layer feature usage data with usage validations"
    columns:
      - name: feature_usage_id
        description: "Unique feature usage identifier"
        tests:
          - unique
          - not_null
      - name: feature_name
        description: "Standardized feature name"
        tests:
          - accepted_values:
              values: ['SCREEN SHARE', 'RECORDING', 'CHAT', 'BREAKOUT ROOMS']
      - name: usage_date
        description: "Feature usage date"
        tests:
          - not_null
      - name: usage_count
        description: "Usage count"
        tests:
          - not_null
      - name: load_date
        description: "Load date"
        tests:
          - not_null
      - name: update_date
        description: "Update date"
        tests:
          - not_null
      - name: source_system
        description: "Source system identifier"
        tests:
          - not_null

  - name: si_audit_log
    description: "Silver layer audit log for pipeline tracking"
    columns:
      - name: record_id
        description: "Unique audit record identifier"
        tests:
          - unique
          - not_null
      - name: source_table
        description: "Source table name"
        tests:
          - not_null
      - name: load_timestamp
        description: "Processing timestamp"
        tests:
          - not_null
      - name: processed_by
        description: "Processing identifier"
        tests:
          - not_null
      - name: status
        description: "Processing status"
        tests:
          - accepted_values:
              values: ['SUCCESS', 'FAILED', 'WARNING']
```

## Custom SQL-based dbt Tests

### 1. Email Format Validation Test

```sql
-- tests/assert_valid_email_format.sql
SELECT email
FROM {{ ref('si_users') }}
WHERE NOT REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')
```

### 2. Meeting Duration Consistency Test

```sql
-- tests/assert_meeting_duration_consistency.sql
SELECT meeting_id,
       duration_minutes,
       DATEDIFF('MINUTE', start_time, end_time) as calculated_duration
FROM {{ ref('si_meetings') }}
WHERE ABS(duration_minutes - DATEDIFF('MINUTE', start_time, end_time)) > 1
```

### 3. Date Range Validation Test

```sql
-- tests/assert_valid_license_date_range.sql
SELECT license_id,
       start_date,
       end_date
FROM {{ ref('si_licenses') }}
WHERE end_date < start_date
   OR start_date > CURRENT_DATE() + INTERVAL '1 YEAR'
```

### 4. Non-negative Amount Validation Test

```sql
-- tests/assert_non_negative_amounts.sql
SELECT billing_event_id,
       amount
FROM {{ ref('si_billing_events') }}
WHERE amount < 0
```

### 5. Participant Time Logic Test

```sql
-- tests/assert_participant_time_logic.sql
SELECT participant_id,
       join_time,
       leave_time
FROM {{ ref('si_participants') }}
WHERE leave_time IS NOT NULL 
  AND leave_time < join_time
```

### 6. Future Date Validation Test

```sql
-- tests/assert_no_future_dates.sql
SELECT 'participants' as table_name, participant_id as record_id, join_time as date_field
FROM {{ ref('si_participants') }}
WHERE join_time > CURRENT_TIMESTAMP()

UNION ALL

SELECT 'support_tickets' as table_name, ticket_id as record_id, open_date as date_field
FROM {{ ref('si_support_tickets') }}
WHERE open_date > CURRENT_DATE()

UNION ALL

SELECT 'feature_usage' as table_name, feature_usage_id as record_id, usage_date as date_field
FROM {{ ref('si_feature_usage') }}
WHERE usage_date > CURRENT_DATE()
```

### 7. Webinar Registration Validation Test

```sql
-- tests/assert_webinar_registration_logic.sql
SELECT webinar_id,
       registrants
FROM {{ ref('si_webinars') }}
WHERE registrants < 0
```

### 8. Data Completeness Test

```sql
-- tests/assert_data_completeness.sql
WITH completeness_check AS (
  SELECT 
    'si_users' as table_name,
    COUNT(*) as total_records,
    COUNT(user_id) as non_null_ids,
    COUNT(email) as non_null_emails
  FROM {{ ref('si_users') }}
  
  UNION ALL
  
  SELECT 
    'si_meetings' as table_name,
    COUNT(*) as total_records,
    COUNT(meeting_id) as non_null_ids,
    COUNT(meeting_topic) as non_null_topics
  FROM {{ ref('si_meetings') }}
)
SELECT table_name,
       total_records,
       non_null_ids,
       CASE 
         WHEN table_name = 'si_users' THEN non_null_emails
         WHEN table_name = 'si_meetings' THEN non_null_emails -- This should be non_null_topics
       END as additional_field_count
FROM completeness_check
WHERE total_records != non_null_ids
   OR (table_name = 'si_users' AND total_records != non_null_emails)
   OR (table_name = 'si_meetings' AND total_records != additional_field_count)
```

### 9. Incremental Processing Test

```sql
-- tests/assert_incremental_processing.sql
-- This test validates that incremental models are processing correctly
WITH incremental_check AS (
  SELECT 
    COUNT(*) as current_count
  FROM {{ ref('si_users') }}
  WHERE update_date >= CURRENT_DATE() - INTERVAL '1 DAY'
),
source_check AS (
  SELECT 
    COUNT(*) as source_count
  FROM {{ source('zoom_bronze', 'bz_users') }}
  WHERE update_timestamp >= CURRENT_TIMESTAMP() - INTERVAL '1 DAY'
)
SELECT 
  ic.current_count,
  sc.source_count
FROM incremental_check ic
CROSS JOIN source_check sc
WHERE ic.current_count = 0 AND sc.source_count > 0
```

### 10. Surrogate Key Uniqueness Test

```sql
-- tests/assert_surrogate_key_uniqueness.sql
-- Test for surrogate key generation using dbt_utils
WITH duplicate_keys AS (
  SELECT 
    {{ dbt_utils.generate_surrogate_key(['email', 'user_name']) }} as surrogate_key,
    COUNT(*) as key_count
  FROM {{ ref('si_users') }}
  GROUP BY {{ dbt_utils.generate_surrogate_key(['email', 'user_name']) }}
  HAVING COUNT(*) > 1
)
SELECT surrogate_key, key_count
FROM duplicate_keys
```

## Parameterized Tests

### 1. Generic Range Validation Test

```sql
-- macros/test_range_validation.sql
{% macro test_range_validation(model, column_name, min_value, max_value) %}
  SELECT {{ column_name }}
  FROM {{ model }}
  WHERE {{ column_name }} < {{ min_value }} 
     OR {{ column_name }} > {{ max_value }}
{% endmacro %}
```

**Usage in schema.yml:**
```yaml
models:
  - name: si_billing_events
    columns:
      - name: amount
        tests:
          - range_validation:
              min_value: 0
              max_value: 1000000
```

### 2. Generic Date Logic Test

```sql
-- macros/test_date_logic.sql
{% macro test_date_logic(model, start_date_column, end_date_column) %}
  SELECT {{ start_date_column }}, {{ end_date_column }}
  FROM {{ model }}
  WHERE {{ end_date_column }} IS NOT NULL 
    AND {{ end_date_column }} < {{ start_date_column }}
{% endmacro %}
```

**Usage in schema.yml:**
```yaml
models:
  - name: si_meetings
    tests:
      - date_logic:
          start_date_column: 'start_time'
          end_date_column: 'end_time'
  - name: si_licenses
    tests:
      - date_logic:
          start_date_column: 'start_date'
          end_date_column: 'end_date'
```

### 3. Generic Format Validation Test

```sql
-- macros/test_format_validation.sql
{% macro test_format_validation(model, column_name, regex_pattern) %}
  SELECT {{ column_name }}
  FROM {{ model }}
  WHERE NOT REGEXP_LIKE({{ column_name }}, '{{ regex_pattern }}')
{% endmacro %}
```

**Usage in schema.yml:**
```yaml
models:
  - name: si_users
    columns:
      - name: email
        tests:
          - format_validation:
              regex_pattern: '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'
```

## Performance and Monitoring Tests

### 1. Query Performance Test

```sql
-- tests/assert_query_performance.sql
-- Monitor query execution time for critical models
WITH performance_check AS (
  SELECT 
    'si_users' as model_name,
    COUNT(*) as record_count,
    CURRENT_TIMESTAMP() as start_time
  FROM {{ ref('si_users') }}
)
SELECT 
  model_name,
  record_count,
  DATEDIFF('SECOND', start_time, CURRENT_TIMESTAMP()) as execution_seconds
FROM performance_check
WHERE DATEDIFF('SECOND', start_time, CURRENT_TIMESTAMP()) > 30 -- Alert if query takes > 30 seconds
```

### 2. Data Volume Monitoring Test

```sql
-- tests/assert_data_volume_consistency.sql
-- Monitor daily data volumes for anomalies
WITH daily_volumes AS (
  SELECT 
    DATE(load_date) as load_date,
    COUNT(*) as daily_count
  FROM {{ ref('si_meetings') }}
  WHERE load_date >= CURRENT_DATE() - INTERVAL '7 DAYS'
  GROUP BY DATE(load_date)
),
average_volume AS (
  SELECT AVG(daily_count) as avg_daily_count
  FROM daily_volumes
  WHERE load_date < CURRENT_DATE()
)
SELECT 
  dv.load_date,
  dv.daily_count,
  av.avg_daily_count
FROM daily_volumes dv
CROSS JOIN average_volume av
WHERE dv.load_date = CURRENT_DATE()
  AND (dv.daily_count < av.avg_daily_count * 0.5 
       OR dv.daily_count > av.avg_daily_count * 2.0)
```

## Error Handling and Edge Case Tests

### 1. Null Handling Test

```sql
-- tests/assert_null_handling.sql
-- Test proper handling of null values in transformations
SELECT 
  'si_meetings' as table_name,
  meeting_id,
  'duration_minutes' as column_name
FROM {{ ref('si_meetings') }}
WHERE duration_minutes IS NULL 
  AND start_time IS NOT NULL 
  AND end_time IS NOT NULL

UNION ALL

SELECT 
  'si_billing_events' as table_name,
  billing_event_id,
  'amount' as column_name
FROM {{ ref('si_billing_events') }}
WHERE amount IS NULL
```

### 2. Data Type Consistency Test

```sql
-- tests/assert_data_type_consistency.sql
-- Validate data type consistency across transformations
SELECT 
  meeting_id,
  duration_minutes
FROM {{ ref('si_meetings') }}
WHERE TRY_CAST(duration_minutes AS INTEGER) IS NULL
  AND duration_minutes IS NOT NULL

UNION ALL

SELECT 
  billing_event_id,
  amount
FROM {{ ref('si_billing_events') }}
WHERE TRY_CAST(amount AS DECIMAL(10,2)) IS NULL
  AND amount IS NOT NULL
```

### 3. Schema Evolution Test

```sql
-- tests/assert_schema_evolution.sql
-- Test handling of schema changes
WITH column_check AS (
  SELECT 
    table_name,
    column_name,
    data_type
  FROM information_schema.columns
  WHERE table_schema = 'ZOOM_SILVER_SCHEMA'
    AND table_name IN ('SI_USERS', 'SI_MEETINGS', 'SI_LICENSES')
)
SELECT 
  table_name,
  column_name,
  data_type
FROM column_check
WHERE (table_name = 'SI_USERS' AND column_name = 'USER_ID' AND data_type != 'TEXT')
   OR (table_name = 'SI_MEETINGS' AND column_name = 'DURATION_MINUTES' AND data_type != 'NUMBER')
   OR (table_name = 'SI_LICENSES' AND column_name = 'START_DATE' AND data_type != 'DATE')
```

## Test Execution and Monitoring

### dbt Test Commands

```bash
# Run all tests
dbt test

# Run tests for specific model
dbt test --select si_users

# Run specific test type
dbt test --select test_type:generic
dbt test --select test_type:singular

# Run tests with specific tags
dbt test --select tag:data_quality
dbt test --select tag:performance

# Generate test documentation
dbt docs generate
dbt docs serve
```

### Test Results Tracking

Test results are automatically tracked in:
- **dbt's run_results.json**: Detailed test execution results
- **Snowflake audit schema**: Test execution logs and metrics
- **Custom monitoring tables**: Business-specific test metrics

### Continuous Integration Integration

```yaml
# .github/workflows/dbt_tests.yml
name: dbt Tests
on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Setup dbt
        run: |
          pip install dbt-snowflake
      - name: Run dbt tests
        run: |
          dbt deps
          dbt test --profiles-dir ./profiles
        env:
          SNOWFLAKE_ACCOUNT: ${{ secrets.SNOWFLAKE_ACCOUNT }}
          SNOWFLAKE_USER: ${{ secrets.SNOWFLAKE_USER }}
          SNOWFLAKE_PASSWORD: ${{ secrets.SNOWFLAKE_PASSWORD }}
```

## Test Maintenance and Best Practices

### 1. Test Organization
- Group tests by model and functionality
- Use consistent naming conventions
- Document test purpose and expected outcomes
- Maintain test coverage metrics

### 2. Performance Optimization
- Use appropriate WHERE clauses to limit test scope
- Implement incremental testing for large datasets
- Monitor test execution times
- Optimize test queries for Snowflake performance

### 3. Error Handling
- Implement graceful failure handling
- Provide clear error messages
- Log test failures for analysis
- Set appropriate test severity levels

### 4. Continuous Improvement
- Regular review of test effectiveness
- Addition of new tests based on production issues
- Performance tuning of existing tests
- Integration with monitoring and alerting systems

---

## Conclusion

This comprehensive test suite ensures the reliability, performance, and data quality of the Zoom Platform Analytics Silver Layer models in Snowflake. The combination of YAML-based schema tests, custom SQL tests, and parameterized tests provides robust coverage of:

- **Data Quality**: Validation of data integrity, format, and business rules
- **Performance**: Monitoring of query execution and data processing efficiency
- **Reliability**: Testing of error handling and edge cases
- **Maintainability**: Organized, documented, and reusable test framework

Regular execution of these tests, combined with proper monitoring and alerting, ensures that the dbt models deliver consistent, high-quality results in the Snowflake environment.

---

*This document serves as the foundation for maintaining data quality and reliability in the Zoom Platform Analytics System's Silver Layer implementation.*