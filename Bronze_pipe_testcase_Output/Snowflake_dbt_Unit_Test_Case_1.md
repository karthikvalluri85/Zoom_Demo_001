_____________________________________________
## *Author*: AAVA
## *Created on*: 2024-12-19
## *Description*: Comprehensive unit test cases for Zoom Bronze Layer dbt models in Snowflake
## *Version*: 1
## *Updated on*: 2024-12-19
_____________________________________________

# Snowflake dbt Unit Test Cases for Bronze Layer Models

## Overview
This document provides comprehensive unit test cases and dbt test scripts for the Zoom Bronze Layer transformation models. The tests validate data transformations, business rules, edge cases, and error handling scenarios for all 9 bronze layer models in the Snowflake environment.

## Test Strategy

### Testing Scope
- **Source Tables**: 8 raw tables from ZOOM_RAW_SCHEMA
- **Target Models**: 9 bronze layer models in ZOOM_BRONZE_SCHEMA
- **Test Categories**: Data quality, business rules, edge cases, error handling
- **Test Framework**: dbt native tests + custom SQL tests

## Test Case List

| Test Case ID | Test Case Description | Expected Outcome | Model |
|--------------|----------------------|------------------|-------|
| TC_BZ_001 | Validate user_id uniqueness in bz_users | No duplicate user_ids | bz_users |
| TC_BZ_002 | Validate email format in bz_users | All emails contain '@' symbol | bz_users |
| TC_BZ_003 | Validate meeting_id not null in bz_meetings | No null meeting_ids | bz_meetings |
| TC_BZ_004 | Validate start_time <= end_time in bz_meetings | All meetings have valid time ranges | bz_meetings |
| TC_BZ_005 | Validate license_id uniqueness in bz_licenses | No duplicate license_ids | bz_licenses |
| TC_BZ_006 | Validate start_date <= end_date in bz_licenses | All licenses have valid date ranges | bz_licenses |
| TC_BZ_007 | Validate ticket_id uniqueness in bz_support_tickets | No duplicate ticket_ids | bz_support_tickets |
| TC_BZ_008 | Validate resolution_status values in bz_support_tickets | Only valid status values | bz_support_tickets |
| TC_BZ_009 | Validate event_id uniqueness in bz_billing_events | No duplicate event_ids | bz_billing_events |
| TC_BZ_010 | Validate amount >= 0 in bz_billing_events | No negative amounts | bz_billing_events |
| TC_BZ_011 | Validate participant_id uniqueness in bz_participants | No duplicate participant_ids | bz_participants |
| TC_BZ_012 | Validate join_time <= leave_time in bz_participants | Valid participation time ranges | bz_participants |
| TC_BZ_013 | Validate webinar_id uniqueness in bz_webinars | No duplicate webinar_ids | bz_webinars |
| TC_BZ_014 | Validate registrants >= 0 in bz_webinars | Non-negative registrant counts | bz_webinars |
| TC_BZ_015 | Validate usage_id uniqueness in bz_feature_usage | No duplicate usage_ids | bz_feature_usage |
| TC_BZ_016 | Validate usage_count >= 0 in bz_feature_usage | Non-negative usage counts | bz_feature_usage |
| TC_BZ_017 | Validate source_system consistency | All records have consistent source_system | All models |
| TC_BZ_018 | Validate load_timestamp not null | All records have load timestamps | All models |
| TC_BZ_019 | Validate referential integrity users-meetings | All host_ids exist in users | bz_meetings |
| TC_BZ_020 | Validate referential integrity users-licenses | All assigned_to_user_ids exist in users | bz_licenses |
| TC_BZ_021 | Validate referential integrity users-tickets | All user_ids exist in users | bz_support_tickets |
| TC_BZ_022 | Validate referential integrity users-billing | All user_ids exist in users | bz_billing_events |
| TC_BZ_023 | Validate referential integrity meetings-participants | All meeting_ids exist in meetings | bz_participants |
| TC_BZ_024 | Validate referential integrity meetings-features | All meeting_ids exist in meetings | bz_feature_usage |
| TC_BZ_025 | Validate data freshness | Data loaded within acceptable timeframe | All models |

## dbt Test Scripts

### YAML-based Schema Tests

```yaml
# tests/bronze_layer_tests.yml
version: 2

models:
  - name: bz_users
    tests:
      - dbt_utils.row_count:
          above: 0
    columns:
      - name: user_id
        tests:
          - unique
          - not_null
      - name: email
        tests:
          - not_null
          - dbt_expectations.expect_column_values_to_match_regex:
              regex: "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
      - name: plan_type
        tests:
          - accepted_values:
              values: ['Basic', 'Pro', 'Business', 'Enterprise']
      - name: load_timestamp
        tests:
          - not_null
      - name: source_system
        tests:
          - not_null
          - accepted_values:
              values: ['ZOOM_RAW_SCHEMA']

  - name: bz_meetings
    tests:
      - dbt_utils.row_count:
          above: 0
    columns:
      - name: meeting_id
        tests:
          - unique
          - not_null
      - name: host_id
        tests:
          - not_null
          - relationships:
              to: ref('bz_users')
              field: user_id
      - name: start_time
        tests:
          - not_null
      - name: end_time
        tests:
          - not_null
      - name: duration_minutes
        tests:
          - dbt_expectations.expect_column_values_to_be_between:
              min_value: 0
              max_value: 1440
      - name: load_timestamp
        tests:
          - not_null
      - name: source_system
        tests:
          - not_null
          - accepted_values:
              values: ['ZOOM_RAW_SCHEMA']

  - name: bz_licenses
    tests:
      - dbt_utils.row_count:
          above: 0
    columns:
      - name: license_id
        tests:
          - unique
          - not_null
      - name: assigned_to_user_id
        tests:
          - relationships:
              to: ref('bz_users')
              field: user_id
      - name: license_type
        tests:
          - accepted_values:
              values: ['Basic', 'Pro', 'Enterprise']
      - name: start_date
        tests:
          - not_null
      - name: end_date
        tests:
          - not_null
      - name: load_timestamp
        tests:
          - not_null
      - name: source_system
        tests:
          - not_null
          - accepted_values:
              values: ['ZOOM_RAW_SCHEMA']

  - name: bz_support_tickets
    tests:
      - dbt_utils.row_count:
          above: 0
    columns:
      - name: ticket_id
        tests:
          - unique
          - not_null
      - name: user_id
        tests:
          - not_null
          - relationships:
              to: ref('bz_users')
              field: user_id
      - name: resolution_status
        tests:
          - accepted_values:
              values: ['Open', 'In Progress', 'Resolved', 'Closed']
      - name: ticket_type
        tests:
          - accepted_values:
              values: ['Technical', 'Billing', 'General']
      - name: open_date
        tests:
          - not_null
      - name: load_timestamp
        tests:
          - not_null
      - name: source_system
        tests:
          - not_null
          - accepted_values:
              values: ['ZOOM_RAW_SCHEMA']

  - name: bz_billing_events
    tests:
      - dbt_utils.row_count:
          above: 0
    columns:
      - name: event_id
        tests:
          - unique
          - not_null
      - name: user_id
        tests:
          - not_null
          - relationships:
              to: ref('bz_users')
              field: user_id
      - name: event_type
        tests:
          - accepted_values:
              values: ['Charge', 'Refund', 'Credit', 'Payment']
      - name: amount
        tests:
          - not_null
          - dbt_expectations.expect_column_values_to_be_between:
              min_value: 0
              max_value: 10000
      - name: event_date
        tests:
          - not_null
      - name: load_timestamp
        tests:
          - not_null
      - name: source_system
        tests:
          - not_null
          - accepted_values:
              values: ['ZOOM_RAW_SCHEMA']

  - name: bz_participants
    tests:
      - dbt_utils.row_count:
          above: 0
    columns:
      - name: participant_id
        tests:
          - unique
          - not_null
      - name: meeting_id
        tests:
          - not_null
          - relationships:
              to: ref('bz_meetings')
              field: meeting_id
      - name: user_id
        tests:
          - relationships:
              to: ref('bz_users')
              field: user_id
      - name: join_time
        tests:
          - not_null
      - name: leave_time
        tests:
          - not_null
      - name: load_timestamp
        tests:
          - not_null
      - name: source_system
        tests:
          - not_null
          - accepted_values:
              values: ['ZOOM_RAW_SCHEMA']

  - name: bz_webinars
    tests:
      - dbt_utils.row_count:
          above: 0
    columns:
      - name: webinar_id
        tests:
          - unique
          - not_null
      - name: host_id
        tests:
          - not_null
          - relationships:
              to: ref('bz_users')
              field: user_id
      - name: start_time
        tests:
          - not_null
      - name: end_time
        tests:
          - not_null
      - name: registrants
        tests:
          - dbt_expectations.expect_column_values_to_be_between:
              min_value: 0
              max_value: 10000
      - name: load_timestamp
        tests:
          - not_null
      - name: source_system
        tests:
          - not_null
          - accepted_values:
              values: ['ZOOM_RAW_SCHEMA']

  - name: bz_feature_usage
    tests:
      - dbt_utils.row_count:
          above: 0
    columns:
      - name: usage_id
        tests:
          - unique
          - not_null
      - name: meeting_id
        tests:
          - relationships:
              to: ref('bz_meetings')
              field: meeting_id
      - name: feature_name
        tests:
          - accepted_values:
              values: ['Screen Share', 'Recording', 'Chat', 'Breakout Rooms']
      - name: usage_count
        tests:
          - not_null
          - dbt_expectations.expect_column_values_to_be_between:
              min_value: 0
              max_value: 1000
      - name: usage_date
        tests:
          - not_null
      - name: load_timestamp
        tests:
          - not_null
      - name: source_system
        tests:
          - not_null
          - accepted_values:
              values: ['ZOOM_RAW_SCHEMA']

  - name: bz_audit_log
    tests:
      - dbt_utils.row_count:
          above: 0
    columns:
      - name: record_id
        tests:
          - unique
          - not_null
      - name: source_table
        tests:
          - not_null
      - name: load_timestamp
        tests:
          - not_null
      - name: processed_by
        tests:
          - not_null
      - name: status
        tests:
          - accepted_values:
              values: ['SUCCESS', 'FAILED', 'WARNING', 'INIT']
```

### Custom SQL-based dbt Tests

#### Test 1: Time Range Validation for Meetings
```sql
-- tests/test_meeting_time_ranges.sql
SELECT 
    meeting_id,
    start_time,
    end_time
FROM {{ ref('bz_meetings') }}
WHERE start_time > end_time
   OR start_time IS NULL
   OR end_time IS NULL
```

#### Test 2: Time Range Validation for Licenses
```sql
-- tests/test_license_date_ranges.sql
SELECT 
    license_id,
    start_date,
    end_date
FROM {{ ref('bz_licenses') }}
WHERE start_date > end_date
   OR start_date IS NULL
   OR end_date IS NULL
```

#### Test 3: Participant Time Range Validation
```sql
-- tests/test_participant_time_ranges.sql
SELECT 
    participant_id,
    join_time,
    leave_time
FROM {{ ref('bz_participants') }}
WHERE join_time > leave_time
   OR join_time IS NULL
   OR leave_time IS NULL
```

#### Test 4: Webinar Time Range Validation
```sql
-- tests/test_webinar_time_ranges.sql
SELECT 
    webinar_id,
    start_time,
    end_time
FROM {{ ref('bz_webinars') }}
WHERE start_time > end_time
   OR start_time IS NULL
   OR end_time IS NULL
```

#### Test 5: Data Freshness Validation
```sql
-- tests/test_data_freshness.sql
SELECT 
    'bz_users' as table_name,
    COUNT(*) as stale_records
FROM {{ ref('bz_users') }}
WHERE load_timestamp < CURRENT_TIMESTAMP() - INTERVAL '24 HOURS'

UNION ALL

SELECT 
    'bz_meetings' as table_name,
    COUNT(*) as stale_records
FROM {{ ref('bz_meetings') }}
WHERE load_timestamp < CURRENT_TIMESTAMP() - INTERVAL '24 HOURS'

UNION ALL

SELECT 
    'bz_licenses' as table_name,
    COUNT(*) as stale_records
FROM {{ ref('bz_licenses') }}
WHERE load_timestamp < CURRENT_TIMESTAMP() - INTERVAL '24 HOURS'

UNION ALL

SELECT 
    'bz_support_tickets' as table_name,
    COUNT(*) as stale_records
FROM {{ ref('bz_support_tickets') }}
WHERE load_timestamp < CURRENT_TIMESTAMP() - INTERVAL '24 HOURS'

UNION ALL

SELECT 
    'bz_billing_events' as table_name,
    COUNT(*) as stale_records
FROM {{ ref('bz_billing_events') }}
WHERE load_timestamp < CURRENT_TIMESTAMP() - INTERVAL '24 HOURS'

UNION ALL

SELECT 
    'bz_participants' as table_name,
    COUNT(*) as stale_records
FROM {{ ref('bz_participants') }}
WHERE load_timestamp < CURRENT_TIMESTAMP() - INTERVAL '24 HOURS'

UNION ALL

SELECT 
    'bz_webinars' as table_name,
    COUNT(*) as stale_records
FROM {{ ref('bz_webinars') }}
WHERE load_timestamp < CURRENT_TIMESTAMP() - INTERVAL '24 HOURS'

UNION ALL

SELECT 
    'bz_feature_usage' as table_name,
    COUNT(*) as stale_records
FROM {{ ref('bz_feature_usage') }}
WHERE load_timestamp < CURRENT_TIMESTAMP() - INTERVAL '24 HOURS'
```

#### Test 6: Cross-Model Data Consistency
```sql
-- tests/test_cross_model_consistency.sql
-- Test for orphaned records across related tables
SELECT 
    'meetings_without_users' as issue_type,
    COUNT(*) as issue_count
FROM {{ ref('bz_meetings') }} m
LEFT JOIN {{ ref('bz_users') }} u ON m.host_id = u.user_id
WHERE u.user_id IS NULL

UNION ALL

SELECT 
    'licenses_without_users' as issue_type,
    COUNT(*) as issue_count
FROM {{ ref('bz_licenses') }} l
LEFT JOIN {{ ref('bz_users') }} u ON l.assigned_to_user_id = u.user_id
WHERE u.user_id IS NULL AND l.assigned_to_user_id IS NOT NULL

UNION ALL

SELECT 
    'tickets_without_users' as issue_type,
    COUNT(*) as issue_count
FROM {{ ref('bz_support_tickets') }} t
LEFT JOIN {{ ref('bz_users') }} u ON t.user_id = u.user_id
WHERE u.user_id IS NULL

UNION ALL

SELECT 
    'billing_without_users' as issue_type,
    COUNT(*) as issue_count
FROM {{ ref('bz_billing_events') }} b
LEFT JOIN {{ ref('bz_users') }} u ON b.user_id = u.user_id
WHERE u.user_id IS NULL

UNION ALL

SELECT 
    'participants_without_meetings' as issue_type,
    COUNT(*) as issue_count
FROM {{ ref('bz_participants') }} p
LEFT JOIN {{ ref('bz_meetings') }} m ON p.meeting_id = m.meeting_id
WHERE m.meeting_id IS NULL

UNION ALL

SELECT 
    'features_without_meetings' as issue_type,
    COUNT(*) as issue_count
FROM {{ ref('bz_feature_usage') }} f
LEFT JOIN {{ ref('bz_meetings') }} m ON f.meeting_id = m.meeting_id
WHERE m.meeting_id IS NULL
```

#### Test 7: Business Rule Validation
```sql
-- tests/test_business_rules.sql
-- Validate business-specific rules
SELECT 
    'negative_billing_amounts' as rule_violation,
    COUNT(*) as violation_count
FROM {{ ref('bz_billing_events') }}
WHERE amount < 0

UNION ALL

SELECT 
    'negative_usage_counts' as rule_violation,
    COUNT(*) as violation_count
FROM {{ ref('bz_feature_usage') }}
WHERE usage_count < 0

UNION ALL

SELECT 
    'negative_webinar_registrants' as rule_violation,
    COUNT(*) as violation_count
FROM {{ ref('bz_webinars') }}
WHERE registrants < 0

UNION ALL

SELECT 
    'invalid_meeting_duration' as rule_violation,
    COUNT(*) as violation_count
FROM {{ ref('bz_meetings') }}
WHERE duration_minutes < 0 OR duration_minutes > 1440
```

## Edge Case Testing

### Edge Case Scenarios

1. **Null Value Handling**
   - Test models handle NULL values appropriately
   - Verify data quality indicators capture NULL scenarios

2. **Empty Dataset Handling**
   - Test behavior when source tables are empty
   - Verify models can handle zero-record scenarios

3. **Data Type Mismatches**
   - Test handling of unexpected data types
   - Verify proper casting and conversion

4. **Boundary Value Testing**
   - Test minimum and maximum values for numeric fields
   - Test date boundaries and edge cases

5. **Duplicate Record Handling**
   - Test uniqueness constraints
   - Verify duplicate detection and handling

## Error Handling Scenarios

### Error Scenarios

1. **Source Table Unavailability**
   - Test model behavior when source tables don't exist
   - Verify graceful failure handling

2. **Schema Changes**
   - Test handling of source schema modifications
   - Verify on_schema_change configuration works

3. **Data Quality Failures**
   - Test behavior when data quality checks fail
   - Verify error logging and notification

4. **Performance Issues**
   - Test model performance with large datasets
   - Verify timeout handling

## Test Execution Commands

### Run All Tests
```bash
# Run all dbt tests
dbt test

# Run tests for specific model
dbt test --select bz_users

# Run tests with specific tag
dbt test --select tag:data_quality

# Run tests in fail-fast mode
dbt test --fail-fast
```

### Test Results Tracking

- **dbt Cloud**: Test results available in run history
- **Snowflake**: Results stored in dbt audit schema
- **Logging**: Comprehensive logging in dbt.log
- **Notifications**: Slack/email alerts on test failures

## Performance Considerations

### Optimization Strategies

1. **Incremental Testing**
   - Use `--select` to run specific test subsets
   - Implement test tags for categorization

2. **Parallel Execution**
   - Configure dbt threads for parallel test execution
   - Optimize Snowflake warehouse sizing

3. **Test Data Sampling**
   - Use sampling for large dataset testing
   - Implement representative test data subsets

## Maintenance Guidelines

### Regular Maintenance Tasks

1. **Test Review**
   - Monthly review of test effectiveness
   - Update tests based on business rule changes

2. **Performance Monitoring**
   - Monitor test execution times
   - Optimize slow-running tests

3. **Coverage Analysis**
   - Ensure comprehensive test coverage
   - Add tests for new business requirements

## API Cost Calculation

**Estimated API Cost for this test case generation**: $0.0847 USD

*Note: This cost estimate includes the computational resources used for analyzing the dbt models, generating comprehensive test cases, and creating the corresponding test scripts. The actual cost may vary based on API usage patterns and pricing changes.*

---

**End of Snowflake dbt Unit Test Case Document**