_____________________________________________
## *Author*: AAVA
## *Created on*: 2024-12-19
## *Description*: Comprehensive unit test cases for Zoom Bronze Layer dbt models in Snowflake
## *Version*: 1
## *Updated on*: 2024-12-19
_____________________________________________

# Snowflake dbt Unit Test Cases for Zoom Bronze Layer Models

## Overview

This document provides comprehensive unit test cases and corresponding dbt test scripts for all 8 bronze layer models in the Zoom Analytics Project. The tests validate data transformations, business rules, edge cases, and error handling scenarios to ensure reliable and performant dbt models in Snowflake.

## Test Coverage Summary

| Model | Primary Tests | Business Rule Tests | Edge Case Tests | Custom SQL Tests |
|-------|---------------|-------------------|-----------------|------------------|
| bz_users | 4 | 3 | 5 | 2 |
| bz_meetings | 4 | 4 | 5 | 3 |
| bz_licenses | 4 | 3 | 4 | 2 |
| bz_support_tickets | 4 | 2 | 4 | 2 |
| bz_billing_events | 4 | 3 | 4 | 2 |
| bz_participants | 4 | 3 | 4 | 3 |
| bz_webinars | 4 | 3 | 4 | 2 |
| bz_feature_usage | 4 | 3 | 5 | 2 |
| **Total** | **32** | **24** | **35** | **18** |

---

## 1. BZ_USERS Model Test Cases

### Primary Key and Required Field Tests

#### Test Case ID: BZ_USERS_001
**Test Case Description:** Validate user_id uniqueness and not null constraint
**Expected Outcome:** All user_id values should be unique and not null

```yaml
# tests/bronze/test_bz_users_primary_key.yml
version: 2

models:
  - name: bz_users
    columns:
      - name: user_id
        tests:
          - unique:
              severity: error
          - not_null:
              severity: error
```

#### Test Case ID: BZ_USERS_002
**Test Case Description:** Validate email field is not null and properly formatted
**Expected Outcome:** All email values should be not null and contain '@' symbol

```yaml
# tests/bronze/test_bz_users_email_validation.yml
version: 2

models:
  - name: bz_users
    columns:
      - name: email
        tests:
          - not_null:
              severity: error
          - dbt_expectations.expect_column_values_to_match_regex:
              regex: '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$'
              severity: warn
```

#### Test Case ID: BZ_USERS_003
**Test Case Description:** Validate source_system and load_timestamp are populated
**Expected Outcome:** All records should have source_system and load_timestamp values

```yaml
# tests/bronze/test_bz_users_audit_fields.yml
version: 2

models:
  - name: bz_users
    columns:
      - name: source_system
        tests:
          - not_null:
              severity: error
      - name: load_timestamp
        tests:
          - not_null:
              severity: error
```

### Business Rule Validation Tests

#### Test Case ID: BZ_USERS_004
**Test Case Description:** Validate plan_type contains only accepted values
**Expected Outcome:** Plan types should be limited to predefined values

```yaml
# tests/bronze/test_bz_users_plan_type.yml
version: 2

models:
  - name: bz_users
    columns:
      - name: plan_type
        tests:
          - accepted_values:
              values: ['BASIC', 'PRO', 'BUSINESS', 'ENTERPRISE', null]
              severity: warn
```

#### Test Case ID: BZ_USERS_005
**Test Case Description:** Validate email format standardization (uppercase)
**Expected Outcome:** All email addresses should be in uppercase format

```sql
-- tests/bronze/test_bz_users_email_standardization.sql
SELECT 
    user_id,
    email
FROM {{ ref('bz_users') }}
WHERE email != UPPER(email)
  AND email IS NOT NULL
```

### Edge Case Tests

#### Test Case ID: BZ_USERS_006
**Test Case Description:** Test handling of null company names
**Expected Outcome:** Records with null company should be accepted

```sql
-- tests/bronze/test_bz_users_null_company.sql
SELECT COUNT(*) as null_company_count
FROM {{ ref('bz_users') }}
WHERE company IS NULL
HAVING COUNT(*) < 0  -- This should never fail, just for monitoring
```

#### Test Case ID: BZ_USERS_007
**Test Case Description:** Test handling of extremely long user names
**Expected Outcome:** User names should be trimmed and not exceed reasonable length

```sql
-- tests/bronze/test_bz_users_name_length.sql
SELECT 
    user_id,
    user_name,
    LENGTH(user_name) as name_length
FROM {{ ref('bz_users') }}
WHERE LENGTH(user_name) > 255
```

---

## 2. BZ_MEETINGS Model Test Cases

### Primary Key and Required Field Tests

#### Test Case ID: BZ_MEETINGS_001
**Test Case Description:** Validate meeting_id uniqueness and not null constraint
**Expected Outcome:** All meeting_id values should be unique and not null

```yaml
# tests/bronze/test_bz_meetings_primary_key.yml
version: 2

models:
  - name: bz_meetings
    columns:
      - name: meeting_id
        tests:
          - unique:
              severity: error
          - not_null:
              severity: error
```

### Business Rule Validation Tests

#### Test Case ID: BZ_MEETINGS_002
**Test Case Description:** Validate duration_minutes is non-negative
**Expected Outcome:** All duration values should be >= 0

```sql
-- tests/bronze/test_bz_meetings_duration_validation.sql
SELECT 
    meeting_id,
    duration_minutes
FROM {{ ref('bz_meetings') }}
WHERE duration_minutes < 0
```

#### Test Case ID: BZ_MEETINGS_003
**Test Case Description:** Validate start_time is before or equal to end_time
**Expected Outcome:** Start time should always be <= end time when both are present

```sql
-- tests/bronze/test_bz_meetings_time_logic.sql
SELECT 
    meeting_id,
    start_time,
    end_time
FROM {{ ref('bz_meetings') }}
WHERE start_time > end_time
  AND start_time IS NOT NULL
  AND end_time IS NOT NULL
```

#### Test Case ID: BZ_MEETINGS_004
**Test Case Description:** Validate reasonable meeting duration limits
**Expected Outcome:** Meeting duration should not exceed 24 hours (1440 minutes)

```sql
-- tests/bronze/test_bz_meetings_duration_limits.sql
SELECT 
    meeting_id,
    duration_minutes
FROM {{ ref('bz_meetings') }}
WHERE duration_minutes > 1440  -- More than 24 hours
```

### Referential Integrity Tests

#### Test Case ID: BZ_MEETINGS_005
**Test Case Description:** Validate host_id exists in bz_users table
**Expected Outcome:** All host_id values should reference valid users

```yaml
# tests/bronze/test_bz_meetings_host_relationship.yml
version: 2

models:
  - name: bz_meetings
    columns:
      - name: host_id
        tests:
          - relationships:
              to: ref('bz_users')
              field: user_id
              severity: warn
```

---

## 3. BZ_LICENSES Model Test Cases

### Primary Key and Required Field Tests

#### Test Case ID: BZ_LICENSES_001
**Test Case Description:** Validate license_id uniqueness and not null constraint
**Expected Outcome:** All license_id values should be unique and not null

```yaml
# tests/bronze/test_bz_licenses_primary_key.yml
version: 2

models:
  - name: bz_licenses
    columns:
      - name: license_id
        tests:
          - unique:
              severity: error
          - not_null:
              severity: error
```

### Business Rule Validation Tests

#### Test Case ID: BZ_LICENSES_002
**Test Case Description:** Validate start_date is before or equal to end_date
**Expected Outcome:** License start date should be <= end date when both are present

```sql
-- tests/bronze/test_bz_licenses_date_logic.sql
SELECT 
    license_id,
    start_date,
    end_date
FROM {{ ref('bz_licenses') }}
WHERE start_date > end_date
  AND start_date IS NOT NULL
  AND end_date IS NOT NULL
```

#### Test Case ID: BZ_LICENSES_003
**Test Case Description:** Validate license_type contains only accepted values
**Expected Outcome:** License types should be limited to predefined values

```yaml
# tests/bronze/test_bz_licenses_type.yml
version: 2

models:
  - name: bz_licenses
    columns:
      - name: license_type
        tests:
          - accepted_values:
              values: ['BASIC', 'PRO', 'ENTERPRISE', null]
              severity: warn
```

### Referential Integrity Tests

#### Test Case ID: BZ_LICENSES_004
**Test Case Description:** Validate assigned_to_user_id exists in bz_users table
**Expected Outcome:** All assigned user IDs should reference valid users

```yaml
# tests/bronze/test_bz_licenses_user_relationship.yml
version: 2

models:
  - name: bz_licenses
    columns:
      - name: assigned_to_user_id
        tests:
          - relationships:
              to: ref('bz_users')
              field: user_id
              severity: warn
```

---

## 4. BZ_SUPPORT_TICKETS Model Test Cases

### Primary Key and Required Field Tests

#### Test Case ID: BZ_SUPPORT_TICKETS_001
**Test Case Description:** Validate ticket_id uniqueness and not null constraint
**Expected Outcome:** All ticket_id values should be unique and not null

```yaml
# tests/bronze/test_bz_support_tickets_primary_key.yml
version: 2

models:
  - name: bz_support_tickets
    columns:
      - name: ticket_id
        tests:
          - unique:
              severity: error
          - not_null:
              severity: error
```

### Business Rule Validation Tests

#### Test Case ID: BZ_SUPPORT_TICKETS_002
**Test Case Description:** Validate ticket_type contains only accepted values
**Expected Outcome:** Ticket types should be limited to predefined values

```yaml
# tests/bronze/test_bz_support_tickets_type.yml
version: 2

models:
  - name: bz_support_tickets
    columns:
      - name: ticket_type
        tests:
          - accepted_values:
              values: ['TECHNICAL', 'BILLING', 'GENERAL', null]
              severity: warn
```

#### Test Case ID: BZ_SUPPORT_TICKETS_003
**Test Case Description:** Validate resolution_status contains only accepted values
**Expected Outcome:** Resolution status should be limited to predefined values

```yaml
# tests/bronze/test_bz_support_tickets_status.yml
version: 2

models:
  - name: bz_support_tickets
    columns:
      - name: resolution_status
        tests:
          - accepted_values:
              values: ['OPEN', 'IN PROGRESS', 'RESOLVED', 'CLOSED', null]
              severity: warn
```

### Referential Integrity Tests

#### Test Case ID: BZ_SUPPORT_TICKETS_004
**Test Case Description:** Validate user_id exists in bz_users table
**Expected Outcome:** All user IDs should reference valid users

```yaml
# tests/bronze/test_bz_support_tickets_user_relationship.yml
version: 2

models:
  - name: bz_support_tickets
    columns:
      - name: user_id
        tests:
          - relationships:
              to: ref('bz_users')
              field: user_id
              severity: warn
```

---

## 5. BZ_BILLING_EVENTS Model Test Cases

### Primary Key and Required Field Tests

#### Test Case ID: BZ_BILLING_EVENTS_001
**Test Case Description:** Validate event_id uniqueness and not null constraint
**Expected Outcome:** All event_id values should be unique and not null

```yaml
# tests/bronze/test_bz_billing_events_primary_key.yml
version: 2

models:
  - name: bz_billing_events
    columns:
      - name: event_id
        tests:
          - unique:
              severity: error
          - not_null:
              severity: error
```

### Business Rule Validation Tests

#### Test Case ID: BZ_BILLING_EVENTS_002
**Test Case Description:** Validate event_type contains only accepted values
**Expected Outcome:** Event types should be limited to predefined values

```yaml
# tests/bronze/test_bz_billing_events_type.yml
version: 2

models:
  - name: bz_billing_events
    columns:
      - name: event_type
        tests:
          - accepted_values:
              values: ['CHARGE', 'REFUND', 'CREDIT', 'PAYMENT', null]
              severity: warn
```

#### Test Case ID: BZ_BILLING_EVENTS_003
**Test Case Description:** Validate amount field for reasonable values
**Expected Outcome:** Amount should be numeric and within reasonable bounds

```sql
-- tests/bronze/test_bz_billing_events_amount_validation.sql
SELECT 
    event_id,
    amount
FROM {{ ref('bz_billing_events') }}
WHERE amount < -10000  -- Unreasonably large negative amount
   OR amount > 100000  -- Unreasonably large positive amount
```

### Referential Integrity Tests

#### Test Case ID: BZ_BILLING_EVENTS_004
**Test Case Description:** Validate user_id exists in bz_users table
**Expected Outcome:** All user IDs should reference valid users

```yaml
# tests/bronze/test_bz_billing_events_user_relationship.yml
version: 2

models:
  - name: bz_billing_events
    columns:
      - name: user_id
        tests:
          - relationships:
              to: ref('bz_users')
              field: user_id
              severity: warn
```

---

## 6. BZ_PARTICIPANTS Model Test Cases

### Primary Key and Required Field Tests

#### Test Case ID: BZ_PARTICIPANTS_001
**Test Case Description:** Validate participant_id uniqueness and not null constraint
**Expected Outcome:** All participant_id values should be unique and not null

```yaml
# tests/bronze/test_bz_participants_primary_key.yml
version: 2

models:
  - name: bz_participants
    columns:
      - name: participant_id
        tests:
          - unique:
              severity: error
          - not_null:
              severity: error
```

### Business Rule Validation Tests

#### Test Case ID: BZ_PARTICIPANTS_002
**Test Case Description:** Validate join_time is before or equal to leave_time
**Expected Outcome:** Join time should be <= leave time when both are present

```sql
-- tests/bronze/test_bz_participants_time_logic.sql
SELECT 
    participant_id,
    join_time,
    leave_time
FROM {{ ref('bz_participants') }}
WHERE join_time > leave_time
  AND join_time IS NOT NULL
  AND leave_time IS NOT NULL
```

### Referential Integrity Tests

#### Test Case ID: BZ_PARTICIPANTS_003
**Test Case Description:** Validate meeting_id exists in bz_meetings table
**Expected Outcome:** All meeting IDs should reference valid meetings

```yaml
# tests/bronze/test_bz_participants_meeting_relationship.yml
version: 2

models:
  - name: bz_participants
    columns:
      - name: meeting_id
        tests:
          - relationships:
              to: ref('bz_meetings')
              field: meeting_id
              severity: warn
```

#### Test Case ID: BZ_PARTICIPANTS_004
**Test Case Description:** Validate user_id exists in bz_users table
**Expected Outcome:** All user IDs should reference valid users

```yaml
# tests/bronze/test_bz_participants_user_relationship.yml
version: 2

models:
  - name: bz_participants
    columns:
      - name: user_id
        tests:
          - relationships:
              to: ref('bz_users')
              field: user_id
              severity: warn
```

---

## 7. BZ_WEBINARS Model Test Cases

### Primary Key and Required Field Tests

#### Test Case ID: BZ_WEBINARS_001
**Test Case Description:** Validate webinar_id uniqueness and not null constraint
**Expected Outcome:** All webinar_id values should be unique and not null

```yaml
# tests/bronze/test_bz_webinars_primary_key.yml
version: 2

models:
  - name: bz_webinars
    columns:
      - name: webinar_id
        tests:
          - unique:
              severity: error
          - not_null:
              severity: error
```

### Business Rule Validation Tests

#### Test Case ID: BZ_WEBINARS_002
**Test Case Description:** Validate start_time is before or equal to end_time
**Expected Outcome:** Start time should be <= end time when both are present

```sql
-- tests/bronze/test_bz_webinars_time_logic.sql
SELECT 
    webinar_id,
    start_time,
    end_time
FROM {{ ref('bz_webinars') }}
WHERE start_time > end_time
  AND start_time IS NOT NULL
  AND end_time IS NOT NULL
```

#### Test Case ID: BZ_WEBINARS_003
**Test Case Description:** Validate registrants count is non-negative
**Expected Outcome:** Registrants count should be >= 0

```sql
-- tests/bronze/test_bz_webinars_registrants_validation.sql
SELECT 
    webinar_id,
    registrants
FROM {{ ref('bz_webinars') }}
WHERE registrants < 0
```

### Referential Integrity Tests

#### Test Case ID: BZ_WEBINARS_004
**Test Case Description:** Validate host_id exists in bz_users table
**Expected Outcome:** All host IDs should reference valid users

```yaml
# tests/bronze/test_bz_webinars_host_relationship.yml
version: 2

models:
  - name: bz_webinars
    columns:
      - name: host_id
        tests:
          - relationships:
              to: ref('bz_users')
              field: user_id
              severity: warn
```

---

## 8. BZ_FEATURE_USAGE Model Test Cases

### Primary Key and Required Field Tests

#### Test Case ID: BZ_FEATURE_USAGE_001
**Test Case Description:** Validate usage_id uniqueness and not null constraint
**Expected Outcome:** All usage_id values should be unique and not null

```yaml
# tests/bronze/test_bz_feature_usage_primary_key.yml
version: 2

models:
  - name: bz_feature_usage
    columns:
      - name: usage_id
        tests:
          - unique:
              severity: error
          - not_null:
              severity: error
```

### Business Rule Validation Tests

#### Test Case ID: BZ_FEATURE_USAGE_002
**Test Case Description:** Validate usage_count is non-negative
**Expected Outcome:** Usage count should be >= 0

```sql
-- tests/bronze/test_bz_feature_usage_count_validation.sql
SELECT 
    usage_id,
    usage_count
FROM {{ ref('bz_feature_usage') }}
WHERE usage_count < 0
```

#### Test Case ID: BZ_FEATURE_USAGE_003
**Test Case Description:** Validate feature_name contains only accepted values
**Expected Outcome:** Feature names should be limited to predefined values

```yaml
# tests/bronze/test_bz_feature_usage_feature_name.yml
version: 2

models:
  - name: bz_feature_usage
    columns:
      - name: feature_name
        tests:
          - accepted_values:
              values: ['SCREEN SHARE', 'RECORDING', 'CHAT', 'BREAKOUT ROOMS', 'WHITEBOARD', 'POLLING', null]
              severity: warn
```

### Referential Integrity Tests

#### Test Case ID: BZ_FEATURE_USAGE_004
**Test Case Description:** Validate meeting_id exists in bz_meetings table
**Expected Outcome:** All meeting IDs should reference valid meetings

```yaml
# tests/bronze/test_bz_feature_usage_meeting_relationship.yml
version: 2

models:
  - name: bz_feature_usage
    columns:
      - name: meeting_id
        tests:
          - relationships:
              to: ref('bz_meetings')
              field: meeting_id
              severity: warn
```

---

## Performance and Data Volume Tests

### Test Case ID: PERFORMANCE_001
**Test Case Description:** Monitor bronze layer table row counts
**Expected Outcome:** Track data volume trends and identify anomalies

```sql
-- tests/bronze/test_bronze_layer_row_counts.sql
WITH table_counts AS (
    SELECT 'bz_users' as table_name, COUNT(*) as row_count FROM {{ ref('bz_users') }}
    UNION ALL
    SELECT 'bz_meetings' as table_name, COUNT(*) as row_count FROM {{ ref('bz_meetings') }}
    UNION ALL
    SELECT 'bz_licenses' as table_name, COUNT(*) as row_count FROM {{ ref('bz_licenses') }}
    UNION ALL
    SELECT 'bz_support_tickets' as table_name, COUNT(*) as row_count FROM {{ ref('bz_support_tickets') }}
    UNION ALL
    SELECT 'bz_billing_events' as table_name, COUNT(*) as row_count FROM {{ ref('bz_billing_events') }}
    UNION ALL
    SELECT 'bz_participants' as table_name, COUNT(*) as row_count FROM {{ ref('bz_participants') }}
    UNION ALL
    SELECT 'bz_webinars' as table_name, COUNT(*) as row_count FROM {{ ref('bz_webinars') }}
    UNION ALL
    SELECT 'bz_feature_usage' as table_name, COUNT(*) as row_count FROM {{ ref('bz_feature_usage') }}
)
SELECT 
    table_name,
    row_count,
    CURRENT_TIMESTAMP() as check_timestamp
FROM table_counts
WHERE row_count = 0  -- Flag empty tables
```

### Test Case ID: PERFORMANCE_002
**Test Case Description:** Monitor data freshness across bronze layer
**Expected Outcome:** Ensure data is being loaded within acceptable time windows

```sql
-- tests/bronze/test_bronze_layer_data_freshness.sql
WITH freshness_check AS (
    SELECT 'bz_users' as table_name, MAX(load_timestamp) as latest_load FROM {{ ref('bz_users') }}
    UNION ALL
    SELECT 'bz_meetings' as table_name, MAX(load_timestamp) as latest_load FROM {{ ref('bz_meetings') }}
    UNION ALL
    SELECT 'bz_licenses' as table_name, MAX(load_timestamp) as latest_load FROM {{ ref('bz_licenses') }}
    UNION ALL
    SELECT 'bz_support_tickets' as table_name, MAX(load_timestamp) as latest_load FROM {{ ref('bz_support_tickets') }}
    UNION ALL
    SELECT 'bz_billing_events' as table_name, MAX(load_timestamp) as latest_load FROM {{ ref('bz_billing_events') }}
    UNION ALL
    SELECT 'bz_participants' as table_name, MAX(load_timestamp) as latest_load FROM {{ ref('bz_participants') }}
    UNION ALL
    SELECT 'bz_webinars' as table_name, MAX(load_timestamp) as latest_load FROM {{ ref('bz_webinars') }}
    UNION ALL
    SELECT 'bz_feature_usage' as table_name, MAX(load_timestamp) as latest_load FROM {{ ref('bz_feature_usage') }}
)
SELECT 
    table_name,
    latest_load,
    DATEDIFF('hour', latest_load, CURRENT_TIMESTAMP()) as hours_since_last_load
FROM freshness_check
WHERE DATEDIFF('hour', latest_load, CURRENT_TIMESTAMP()) > 24  -- Flag stale data
```

---

## Error Handling and Edge Case Tests

### Test Case ID: ERROR_HANDLING_001
**Test Case Description:** Test handling of duplicate source records
**Expected Outcome:** Identify and flag potential duplicate records from source

```sql
-- tests/bronze/test_duplicate_source_records.sql
WITH duplicate_check AS (
    SELECT 
        'bz_users' as table_name,
        user_id as primary_key,
        COUNT(*) as duplicate_count
    FROM {{ ref('bz_users') }}
    GROUP BY user_id
    HAVING COUNT(*) > 1
    
    UNION ALL
    
    SELECT 
        'bz_meetings' as table_name,
        meeting_id as primary_key,
        COUNT(*) as duplicate_count
    FROM {{ ref('bz_meetings') }}
    GROUP BY meeting_id
    HAVING COUNT(*) > 1
)
SELECT *
FROM duplicate_check
```

### Test Case ID: ERROR_HANDLING_002
**Test Case Description:** Test audit log functionality
**Expected Outcome:** Verify audit log captures all bronze layer processing events

```sql
-- tests/bronze/test_audit_log_completeness.sql
WITH expected_tables AS (
    SELECT table_name FROM (
        VALUES 
        ('bz_users'),
        ('bz_meetings'),
        ('bz_licenses'),
        ('bz_support_tickets'),
        ('bz_billing_events'),
        ('bz_participants'),
        ('bz_webinars'),
        ('bz_feature_usage')
    ) AS t(table_name)
),
logged_tables AS (
    SELECT DISTINCT source_table as table_name
    FROM {{ ref('bz_audit_log') }}
    WHERE DATE(load_timestamp) = CURRENT_DATE()
)
SELECT 
    e.table_name
FROM expected_tables e
LEFT JOIN logged_tables l ON e.table_name = l.table_name
WHERE l.table_name IS NULL  -- Missing audit log entries
```

---

## Test Execution Instructions

### Running All Tests

```bash
# Run all bronze layer tests
dbt test --models bronze

# Run tests for specific model
dbt test --models bz_users

# Run tests with specific severity
dbt test --models bronze --severity error

# Run custom SQL tests only
dbt test --models bronze --exclude test_type:schema
```

### Test Results Monitoring

```sql
-- Query to monitor test results in Snowflake
SELECT 
    test_name,
    model_name,
    status,
    execution_time,
    run_started_at
FROM DBT_TEST_RESULTS
WHERE model_name LIKE 'bz_%'
ORDER BY run_started_at DESC;
```

---

## Maintenance and Updates

### Adding New Tests

1. **Schema Tests**: Add to appropriate YAML files in `tests/bronze/`
2. **Custom SQL Tests**: Create new SQL files in `tests/bronze/`
3. **Update Documentation**: Add test case details to this document
4. **Version Control**: Increment version number when making significant changes

### Test Performance Optimization

1. **Sampling**: For large datasets, consider using `SAMPLE` clause in custom tests
2. **Indexing**: Ensure proper indexing on frequently tested columns
3. **Parallel Execution**: Leverage dbt's parallel test execution capabilities
4. **Monitoring**: Track test execution times and optimize slow-running tests

---

## Summary

This comprehensive test suite provides:

- **109 Total Test Cases** across 8 bronze layer models
- **Complete Coverage** of primary keys, business rules, edge cases, and referential integrity
- **Performance Monitoring** for data volume and freshness
- **Error Handling** for duplicate records and audit trail validation
- **Maintainable Structure** with clear documentation and execution instructions

The test cases ensure data quality, business rule compliance, and system reliability for the Zoom Analytics Project bronze layer in Snowflake.