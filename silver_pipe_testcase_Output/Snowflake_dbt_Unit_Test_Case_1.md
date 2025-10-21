_____________________________________________
## *Author*: AAVA
## *Created on*: 2024-12-19
## *Description*: Comprehensive unit test cases for Zoom Platform Analytics Silver Layer dbt models in Snowflake
## *Version*: 1
## *Updated on*: 2024-12-19
_____________________________________________

# Snowflake dbt Unit Test Cases for Zoom Silver Layer Models

## Overview

This document provides comprehensive unit test cases and dbt test scripts for the Zoom Platform Analytics Silver Layer transformation models. The tests validate data transformations, business rules, edge cases, and error handling across 9 silver layer models that transform data from ZOOM_BRONZE_SCHEMA to ZOOM_SILVER_SCHEMA.

## Models Under Test

1. **si_audit_log** - Process audit and monitoring
2. **si_meetings** - Meeting session data with duration validation
3. **si_users** - User profiles with email validation and deduplication
4. **si_licenses** - License management with date validation
5. **si_support_tickets** - Support ticket tracking with status standardization
6. **si_billing_events** - Financial transactions with amount validation
7. **si_participants** - Meeting participation with time validation
8. **si_webinars** - Webinar events with registration tracking
9. **si_feature_usage** - Platform feature utilization analytics

## Test Case Categories

### 1. Data Quality Tests
### 2. Business Rule Validation Tests
### 3. Edge Case Tests
### 4. Performance and Incremental Tests
### 5. Integration Tests

---

## Test Case List

| Test Case ID | Model | Test Case Description | Test Type | Expected Outcome |
|--------------|-------|----------------------|-----------|------------------|
| TC_001 | si_meetings | Validate meeting duration calculation | Business Rule | Duration = end_time - start_time, range 0-2880 minutes |
| TC_002 | si_meetings | Test null meeting_id handling | Data Quality | Records with null meeting_id are rejected |
| TC_003 | si_meetings | Validate end_time > start_time | Business Rule | Records where end_time <= start_time are flagged |
| TC_004 | si_meetings | Test duplicate meeting records | Data Quality | Only latest record per meeting_id is retained |
| TC_005 | si_meetings | Incremental load validation | Performance | Only new/updated records processed |
| TC_006 | si_users | Email format validation | Data Quality | Invalid email formats are flagged |
| TC_007 | si_users | User deduplication by email | Data Quality | One record per unique email address |
| TC_008 | si_users | Null user_id validation | Data Quality | Records with null user_id are rejected |
| TC_009 | si_users | User status standardization | Business Rule | Status values standardized to UPPER case |
| TC_010 | si_users | Incremental user updates | Performance | Only changed user records processed |
| TC_011 | si_licenses | License date validation | Business Rule | License end_date >= start_date |
| TC_012 | si_licenses | License count validation | Data Quality | License count >= 0 |
| TC_013 | si_licenses | Null license_id handling | Data Quality | Records with null license_id rejected |
| TC_014 | si_licenses | License type standardization | Business Rule | License types standardized |
| TC_015 | si_support_tickets | Ticket status validation | Business Rule | Status in accepted values list |
| TC_016 | si_support_tickets | Priority level validation | Data Quality | Priority in range 1-5 |
| TC_017 | si_support_tickets | Ticket resolution time | Business Rule | Resolution time >= creation time |
| TC_018 | si_support_tickets | Null ticket_id handling | Data Quality | Records with null ticket_id rejected |
| TC_019 | si_billing_events | Amount validation | Business Rule | Billing amounts >= 0 |
| TC_020 | si_billing_events | Currency code validation | Data Quality | Valid 3-character currency codes |
| TC_021 | si_billing_events | Transaction date validation | Business Rule | Transaction dates within valid range |
| TC_022 | si_billing_events | Null transaction_id handling | Data Quality | Records with null transaction_id rejected |
| TC_023 | si_participants | Join/leave time validation | Business Rule | Leave time >= join time |
| TC_024 | si_participants | Participant count validation | Data Quality | Participant counts >= 0 |
| TC_025 | si_participants | Meeting participant relationship | Integration | All participants linked to valid meetings |
| TC_026 | si_webinars | Registration validation | Business Rule | Registration date <= webinar date |
| TC_027 | si_webinars | Attendee count validation | Data Quality | Attendee count >= 0 and <= registered count |
| TC_028 | si_webinars | Webinar duration validation | Business Rule | Duration > 0 and <= 480 minutes |
| TC_029 | si_feature_usage | Usage count validation | Data Quality | Usage counts >= 0 |
| TC_030 | si_feature_usage | Feature name standardization | Business Rule | Feature names standardized |
| TC_031 | si_audit_log | Process tracking validation | Integration | All silver processes logged |
| TC_032 | si_audit_log | Record count accuracy | Data Quality | Audit counts match actual processed records |
| TC_033 | All Models | Surrogate key uniqueness | Data Quality | All surrogate keys are unique |
| TC_034 | All Models | Incremental processing | Performance | Incremental logic works correctly |
| TC_035 | All Models | Schema evolution handling | Integration | Schema changes handled gracefully |

---

## dbt Test Scripts

### Schema Tests (schema.yml)

```yaml
version: 2

models:
  # SI_MEETINGS Tests
  - name: si_meetings
    description: "Silver layer meetings data with quality validations"
    columns:
      - name: meeting_surrogate_key
        description: "Unique surrogate key for meetings"
        tests:
          - unique
          - not_null
      - name: meeting_id
        description: "Original meeting identifier"
        tests:
          - not_null
          - unique
      - name: start_time
        description: "Meeting start timestamp"
        tests:
          - not_null
      - name: end_time
        description: "Meeting end timestamp"
        tests:
          - not_null
      - name: duration_minutes
        description: "Meeting duration in minutes"
        tests:
          - not_null
          - dbt_utils.accepted_range:
              min_value: 0
              max_value: 2880
      - name: participant_count
        description: "Number of participants"
        tests:
          - dbt_utils.accepted_range:
              min_value: 0
              max_value: 10000

  # SI_USERS Tests
  - name: si_users
    description: "Silver layer users data with email validation"
    columns:
      - name: user_surrogate_key
        description: "Unique surrogate key for users"
        tests:
          - unique
          - not_null
      - name: user_id
        description: "Original user identifier"
        tests:
          - not_null
          - unique
      - name: email
        description: "User email address"
        tests:
          - not_null
          - unique
      - name: user_status
        description: "User account status"
        tests:
          - accepted_values:
              values: ['ACTIVE', 'INACTIVE', 'SUSPENDED', 'PENDING']
      - name: created_date
        description: "User creation date"
        tests:
          - not_null

  # SI_LICENSES Tests
  - name: si_licenses
    description: "Silver layer license data with date validation"
    columns:
      - name: license_surrogate_key
        description: "Unique surrogate key for licenses"
        tests:
          - unique
          - not_null
      - name: license_id
        description: "Original license identifier"
        tests:
          - not_null
          - unique
      - name: license_count
        description: "Number of licenses"
        tests:
          - not_null
          - dbt_utils.accepted_range:
              min_value: 0
              max_value: 100000
      - name: start_date
        description: "License start date"
        tests:
          - not_null
      - name: end_date
        description: "License end date"
        tests:
          - not_null

  # SI_SUPPORT_TICKETS Tests
  - name: si_support_tickets
    description: "Silver layer support tickets with status validation"
    columns:
      - name: ticket_surrogate_key
        description: "Unique surrogate key for tickets"
        tests:
          - unique
          - not_null
      - name: ticket_id
        description: "Original ticket identifier"
        tests:
          - not_null
          - unique
      - name: priority_level
        description: "Ticket priority level"
        tests:
          - accepted_values:
              values: [1, 2, 3, 4, 5]
      - name: status
        description: "Ticket status"
        tests:
          - accepted_values:
              values: ['OPEN', 'IN_PROGRESS', 'RESOLVED', 'CLOSED', 'CANCELLED']
      - name: created_date
        description: "Ticket creation date"
        tests:
          - not_null

  # SI_BILLING_EVENTS Tests
  - name: si_billing_events
    description: "Silver layer billing events with amount validation"
    columns:
      - name: billing_surrogate_key
        description: "Unique surrogate key for billing events"
        tests:
          - unique
          - not_null
      - name: transaction_id
        description: "Original transaction identifier"
        tests:
          - not_null
          - unique
      - name: amount
        description: "Transaction amount"
        tests:
          - not_null
          - dbt_utils.accepted_range:
              min_value: 0
              max_value: 1000000
      - name: currency_code
        description: "Currency code"
        tests:
          - not_null
          - dbt_utils.accepted_range:
              min_value: 3
              max_value: 3
              quote: false
      - name: transaction_date
        description: "Transaction date"
        tests:
          - not_null

  # SI_PARTICIPANTS Tests
  - name: si_participants
    description: "Silver layer participants with time validation"
    columns:
      - name: participant_surrogate_key
        description: "Unique surrogate key for participants"
        tests:
          - unique
          - not_null
      - name: meeting_id
        description: "Meeting identifier"
        tests:
          - not_null
          - relationships:
              to: ref('si_meetings')
              field: meeting_id
      - name: user_id
        description: "User identifier"
        tests:
          - not_null
          - relationships:
              to: ref('si_users')
              field: user_id
      - name: join_time
        description: "Participant join time"
        tests:
          - not_null
      - name: leave_time
        description: "Participant leave time"

  # SI_WEBINARS Tests
  - name: si_webinars
    description: "Silver layer webinars with registration validation"
    columns:
      - name: webinar_surrogate_key
        description: "Unique surrogate key for webinars"
        tests:
          - unique
          - not_null
      - name: webinar_id
        description: "Original webinar identifier"
        tests:
          - not_null
          - unique
      - name: registered_count
        description: "Number of registered attendees"
        tests:
          - not_null
          - dbt_utils.accepted_range:
              min_value: 0
              max_value: 100000
      - name: actual_attendees
        description: "Number of actual attendees"
        tests:
          - not_null
          - dbt_utils.accepted_range:
              min_value: 0
              max_value: 100000
      - name: duration_minutes
        description: "Webinar duration in minutes"
        tests:
          - dbt_utils.accepted_range:
              min_value: 1
              max_value: 480

  # SI_FEATURE_USAGE Tests
  - name: si_feature_usage
    description: "Silver layer feature usage analytics"
    columns:
      - name: usage_surrogate_key
        description: "Unique surrogate key for usage records"
        tests:
          - unique
          - not_null
      - name: user_id
        description: "User identifier"
        tests:
          - not_null
          - relationships:
              to: ref('si_users')
              field: user_id
      - name: feature_name
        description: "Feature name"
        tests:
          - not_null
      - name: usage_count
        description: "Usage count"
        tests:
          - not_null
          - dbt_utils.accepted_range:
              min_value: 0
              max_value: 1000000
      - name: usage_date
        description: "Usage date"
        tests:
          - not_null

  # SI_AUDIT_LOG Tests
  - name: si_audit_log
    description: "Silver layer audit log for process tracking"
    columns:
      - name: audit_surrogate_key
        description: "Unique surrogate key for audit records"
        tests:
          - unique
          - not_null
      - name: process_name
        description: "Process name"
        tests:
          - not_null
      - name: start_timestamp
        description: "Process start time"
        tests:
          - not_null
      - name: end_timestamp
        description: "Process end time"
      - name: records_processed
        description: "Number of records processed"
        tests:
          - dbt_utils.accepted_range:
              min_value: 0
              max_value: 10000000
      - name: status
        description: "Process status"
        tests:
          - accepted_values:
              values: ['SUCCESS', 'FAILED', 'RUNNING', 'CANCELLED']
```

### Custom SQL-Based Tests

#### Test 1: Meeting Duration Business Rule
```sql
-- tests/meeting_duration_validation.sql
SELECT 
    meeting_id,
    start_time,
    end_time,
    duration_minutes,
    DATEDIFF('minute', start_time, end_time) as calculated_duration
FROM {{ ref('si_meetings') }}
WHERE 
    duration_minutes != DATEDIFF('minute', start_time, end_time)
    OR end_time <= start_time
    OR duration_minutes < 0
    OR duration_minutes > 2880
```

#### Test 2: Email Format Validation
```sql
-- tests/email_format_validation.sql
SELECT 
    user_id,
    email
FROM {{ ref('si_users') }}
WHERE 
    email IS NULL
    OR email = ''
    OR email NOT RLIKE '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'
```

#### Test 3: License Date Logic Validation
```sql
-- tests/license_date_validation.sql
SELECT 
    license_id,
    start_date,
    end_date
FROM {{ ref('si_licenses') }}
WHERE 
    end_date < start_date
    OR start_date IS NULL
    OR end_date IS NULL
```

#### Test 4: Participant Time Logic Validation
```sql
-- tests/participant_time_validation.sql
SELECT 
    meeting_id,
    user_id,
    join_time,
    leave_time
FROM {{ ref('si_participants') }}
WHERE 
    leave_time IS NOT NULL 
    AND leave_time < join_time
```

#### Test 5: Billing Amount Validation
```sql
-- tests/billing_amount_validation.sql
SELECT 
    transaction_id,
    amount,
    currency_code
FROM {{ ref('si_billing_events') }}
WHERE 
    amount < 0
    OR amount IS NULL
    OR currency_code IS NULL
    OR LENGTH(currency_code) != 3
```

#### Test 6: Webinar Attendance Logic
```sql
-- tests/webinar_attendance_validation.sql
SELECT 
    webinar_id,
    registered_count,
    actual_attendees
FROM {{ ref('si_webinars') }}
WHERE 
    actual_attendees > registered_count
    OR actual_attendees < 0
    OR registered_count < 0
```

#### Test 7: Incremental Processing Validation
```sql
-- tests/incremental_processing_validation.sql
WITH current_run AS (
    SELECT COUNT(*) as current_count
    FROM {{ ref('si_meetings') }}
    WHERE load_date = CURRENT_DATE
),
audit_count AS (
    SELECT records_processed
    FROM {{ ref('si_audit_log') }}
    WHERE process_name = 'si_meetings'
    AND DATE(start_timestamp) = CURRENT_DATE
    ORDER BY start_timestamp DESC
    LIMIT 1
)
SELECT 
    c.current_count,
    a.records_processed
FROM current_run c
CROSS JOIN audit_count a
WHERE c.current_count != a.records_processed
```

#### Test 8: Data Freshness Validation
```sql
-- tests/data_freshness_validation.sql
SELECT 
    'si_meetings' as table_name,
    MAX(update_date) as last_update,
    DATEDIFF('hour', MAX(update_date), CURRENT_TIMESTAMP) as hours_since_update
FROM {{ ref('si_meetings') }}
WHERE DATEDIFF('hour', MAX(update_date), CURRENT_TIMESTAMP) > 24

UNION ALL

SELECT 
    'si_users' as table_name,
    MAX(update_date) as last_update,
    DATEDIFF('hour', MAX(update_date), CURRENT_TIMESTAMP) as hours_since_update
FROM {{ ref('si_users') }}
WHERE DATEDIFF('hour', MAX(update_date), CURRENT_TIMESTAMP) > 24
```

#### Test 9: Referential Integrity Validation
```sql
-- tests/referential_integrity_validation.sql
-- Check participants reference valid meetings and users
SELECT 
    p.meeting_id,
    p.user_id
FROM {{ ref('si_participants') }} p
LEFT JOIN {{ ref('si_meetings') }} m ON p.meeting_id = m.meeting_id
LEFT JOIN {{ ref('si_users') }} u ON p.user_id = u.user_id
WHERE m.meeting_id IS NULL OR u.user_id IS NULL
```

#### Test 10: Duplicate Detection
```sql
-- tests/duplicate_detection.sql
WITH duplicate_check AS (
    SELECT 
        meeting_id,
        COUNT(*) as record_count
    FROM {{ ref('si_meetings') }}
    GROUP BY meeting_id
    HAVING COUNT(*) > 1
)
SELECT * FROM duplicate_check
```

### Parameterized Tests

#### Generic Test for Positive Values
```sql
-- macros/test_positive_values.sql
{% macro test_positive_values(model, column_name) %}
    SELECT *
    FROM {{ model }}
    WHERE {{ column_name }} < 0 OR {{ column_name }} IS NULL
{% endmacro %}
```

#### Generic Test for Date Range Validation
```sql
-- macros/test_date_range.sql
{% macro test_date_range(model, start_date_column, end_date_column) %}
    SELECT *
    FROM {{ model }}
    WHERE {{ end_date_column }} < {{ start_date_column }}
       OR {{ start_date_column }} IS NULL
       OR {{ end_date_column }} IS NULL
{% endmacro %}
```

## Test Execution Strategy

### 1. Pre-deployment Testing
- Run all schema tests before deployment
- Execute custom SQL tests in development environment
- Validate incremental logic with sample data

### 2. Post-deployment Validation
- Monitor audit log for process completion
- Validate record counts match expectations
- Check data freshness and quality metrics

### 3. Continuous Monitoring
- Schedule daily test runs
- Set up alerts for test failures
- Monitor performance metrics

### 4. Test Data Management
- Maintain test datasets for edge cases
- Create mock data for unit testing
- Implement data fixtures for consistent testing

## Expected Test Results

### Success Criteria
- All schema tests pass (100% success rate)
- Custom SQL tests return 0 rows (no violations)
- Incremental processing works correctly
- Data quality metrics meet thresholds
- Performance benchmarks are met

### Failure Handling
- Log all test failures with detailed error messages
- Implement retry logic for transient failures
- Set up notifications for critical test failures
- Maintain test result history for trend analysis

## Performance Benchmarks

| Model | Expected Runtime | Max Records/Min | Memory Usage |
|-------|------------------|-----------------|---------------|
| si_meetings | < 5 minutes | 10,000 | < 2GB |
| si_users | < 3 minutes | 5,000 | < 1GB |
| si_licenses | < 2 minutes | 1,000 | < 500MB |
| si_support_tickets | < 4 minutes | 8,000 | < 1.5GB |
| si_billing_events | < 6 minutes | 15,000 | < 3GB |
| si_participants | < 8 minutes | 50,000 | < 4GB |
| si_webinars | < 3 minutes | 2,000 | < 800MB |
| si_feature_usage | < 10 minutes | 100,000 | < 5GB |
| si_audit_log | < 1 minute | 100 | < 100MB |

## Maintenance and Updates

### Regular Review Schedule
- Weekly: Review test results and performance metrics
- Monthly: Update test cases based on new requirements
- Quarterly: Comprehensive test suite review and optimization

### Version Control
- All test scripts maintained in Git repository
- Test changes require code review and approval
- Automated testing in CI/CD pipeline

### Documentation Updates
- Keep test documentation current with model changes
- Document any test exceptions or known issues
- Maintain test result history and trends

---

## Conclusion

This comprehensive test suite ensures the reliability, performance, and data quality of the Zoom Platform Analytics Silver Layer dbt models in Snowflake. The combination of schema tests, custom SQL tests, and parameterized tests provides thorough coverage of all transformation logic, business rules, and edge cases.

Regular execution of these tests will help maintain high data quality standards, catch issues early in the development cycle, and ensure consistent performance of the data pipeline in production environments.