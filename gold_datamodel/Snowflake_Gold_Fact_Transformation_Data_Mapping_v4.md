_____________________________________________
## *Author*: AAVA
## *Created on*: 2024-01-20
## *Description*: Complete Snowflake Gold Fact Transformation Data Mapping for Zoom Platform Analytics System
## *Version*: 4
## *Updated on*: 2024-01-20
_____________________________________________

# Snowflake Gold Fact Transformation Data Mapping
## Zoom Platform Analytics System - Version 4

## Overview

This document provides a comprehensive data mapping specification for transforming Silver layer data into Gold layer Fact tables within the Zoom Platform Analytics System. The Gold layer represents the final, business-ready data optimized for analytics, reporting, and business intelligence applications.

The transformation process involves:
- **Data Aggregation**: Combining multiple Silver layer records into meaningful business metrics
- **Business Logic Application**: Implementing complex calculations for engagement scores, attendance rates, and financial metrics
- **Data Quality Enhancement**: Applying validation rules and data quality checks
- **Performance Optimization**: Structuring data for optimal query performance
- **Standardization**: Ensuring consistent data formats and business rules across all fact tables

### Key Design Principles
1. **Dimensional Modeling**: Fact tables are designed to work seamlessly with dimension tables
2. **Grain Definition**: Each fact table has a clearly defined grain for consistent analysis
3. **Additive Measures**: Metrics are designed to support aggregation across multiple dimensions
4. **Historical Tracking**: All transformations preserve data lineage and temporal context
5. **Business Rule Compliance**: All calculations follow established business rules and validation constraints

---

## Data Mapping for Fact Tables

### 1. GO_MEETING_FACTS Transformation Mapping

**Source Tables**: `si_meetings`, `si_participants`  
**Target Table**: `go_meeting_facts`  
**Grain**: One record per meeting session  
**Update Frequency**: Daily batch processing  

| Target Field | Source Field(s) | Transformation Logic | Data Type | Business Rule |
|--------------|-----------------|---------------------|-----------|---------------|
| meeting_fact_id | System Generated | AUTOINCREMENT | VARCHAR | Unique identifier for each fact record |
| meeting_id | si_meetings.meeting_id | Direct mapping with validation | VARCHAR | Must exist in source, not null |
| meeting_topic | si_meetings.meeting_topic | TRIM(UPPER(meeting_topic)) | VARCHAR | Standardized to uppercase, trimmed |
| duration_minutes | si_meetings.duration_minutes | Direct mapping with range validation | NUMBER | Must be between 0 and 2880 minutes |
| start_time | si_meetings.start_time | CONVERT_TIMEZONE('UTC', start_time) | TIMESTAMP_NTZ | Standardized to UTC timezone |
| end_time | si_meetings.end_time | CONVERT_TIMEZONE('UTC', end_time) | TIMESTAMP_NTZ | Must be >= start_time |
| participant_count | si_participants | COUNT(DISTINCT participant_id) WHERE meeting_id = target.meeting_id | NUMBER | Calculated from participant records |
| average_engagement_score | si_participants | AVG(engagement_score) WHERE meeting_id = target.meeting_id | NUMBER(5,2) | Weighted average of participant engagement |
| total_screen_share_duration | si_participants | SUM(screen_share_duration) WHERE meeting_id = target.meeting_id | NUMBER | Sum of all screen sharing time |
| recording_duration | si_meetings.duration_minutes | CASE WHEN recording_enabled = TRUE THEN duration_minutes ELSE 0 END | NUMBER | Conditional based on recording status |
| chat_message_count | si_participants | SUM(chat_messages_sent) WHERE meeting_id = target.meeting_id | NUMBER | Aggregated chat activity |
| load_date | System Generated | CURRENT_DATE() | DATE | ETL processing date |
| update_date | System Generated | CURRENT_DATE() | DATE | Last modification date |
| source_system | Constant | 'ZOOM_SILVER' | VARCHAR | Data lineage tracking |

### 2. GO_WEBINAR_FACTS Transformation Mapping

**Source Tables**: `si_webinars`, `si_participants`  
**Target Table**: `go_webinar_facts`  
**Grain**: One record per webinar session  
**Update Frequency**: Daily batch processing  

| Target Field | Source Field(s) | Transformation Logic | Data Type | Business Rule |
|--------------|-----------------|---------------------|-----------|---------------|
| webinar_fact_id | System Generated | AUTOINCREMENT | VARCHAR | Unique identifier for each fact record |
| webinar_id | si_webinars.webinar_id | Direct mapping with validation | VARCHAR | Must exist in source, not null |
| webinar_topic | si_webinars.webinar_topic | TRIM(UPPER(webinar_topic)) | VARCHAR | Standardized to uppercase, trimmed |
| start_time | si_webinars.start_time | CONVERT_TIMEZONE('UTC', start_time) | TIMESTAMP_NTZ | Standardized to UTC timezone |
| end_time | si_webinars.end_time | CONVERT_TIMEZONE('UTC', end_time) | TIMESTAMP_NTZ | Must be >= start_time |
| registrants | si_webinars.registrants | Direct mapping with validation | NUMBER | Must be >= 0 |
| actual_attendees | si_participants | COUNT(DISTINCT participant_id) WHERE webinar_id = target.webinar_id | NUMBER | Count of unique attendees |
| attendance_rate | Calculated | (actual_attendees / NULLIF(registrants, 0)) * 100 | NUMBER(5,2) | Percentage calculation with null handling |
| average_watch_time | si_participants | AVG(session_duration_minutes) WHERE webinar_id = target.webinar_id | NUMBER | Average participant session duration |
| peak_concurrent_viewers | si_participants | MAX(concurrent_count) calculated using window functions | NUMBER | Maximum simultaneous viewers |
| q_and_a_questions | si_participants | SUM(qa_questions_asked) WHERE webinar_id = target.webinar_id | NUMBER | Total Q&A interactions |
| poll_responses | si_participants | SUM(poll_responses_count) WHERE webinar_id = target.webinar_id | NUMBER | Total poll participation |
| load_date | System Generated | CURRENT_DATE() | DATE | ETL processing date |
| update_date | System Generated | CURRENT_DATE() | DATE | Last modification date |
| source_system | Constant | 'ZOOM_SILVER' | VARCHAR | Data lineage tracking |

### 3. GO_PARTICIPANT_FACTS Transformation Mapping

**Source Tables**: `si_participants`  
**Target Table**: `go_participant_facts`  
**Grain**: One record per participant per session  
**Update Frequency**: Real-time streaming with daily reconciliation  

| Target Field | Source Field(s) | Transformation Logic | Data Type | Business Rule |
|--------------|-----------------|---------------------|-----------|---------------|
| participant_fact_id | System Generated | AUTOINCREMENT | VARCHAR | Unique identifier for each fact record |
| participant_id | si_participants.participant_id | Direct mapping with validation | VARCHAR | Must exist in source, not null |
| join_time | si_participants.join_time | CONVERT_TIMEZONE('UTC', join_time) | TIMESTAMP_NTZ | Standardized to UTC timezone |
| leave_time | si_participants.leave_time | CONVERT_TIMEZONE('UTC', leave_time) | TIMESTAMP_NTZ | Must be >= join_time |
| session_duration_minutes | Calculated | DATEDIFF('minute', join_time, leave_time) | NUMBER | Calculated duration in minutes |
| engagement_score | Calculated | Weighted formula: (mic_time * 0.3 + camera_time * 0.3 + chat_msgs * 0.2 + reactions * 0.2) / session_duration | NUMBER(5,2) | Normalized engagement metric (0-1) |
| microphone_usage_minutes | si_participants.microphone_usage_minutes | Direct mapping with validation | NUMBER | Must be <= session_duration_minutes |
| camera_usage_minutes | si_participants.camera_usage_minutes | Direct mapping with validation | NUMBER | Must be <= session_duration_minutes |
| screen_share_count | si_participants.screen_share_count | Direct mapping with validation | NUMBER | Must be >= 0 |
| chat_messages_sent | si_participants.chat_messages_sent | Direct mapping with validation | NUMBER | Must be >= 0 |
| reactions_count | si_participants.reactions_count | Direct mapping with validation | NUMBER | Must be >= 0 |
| load_date | System Generated | CURRENT_DATE() | DATE | ETL processing date |
| update_date | System Generated | CURRENT_DATE() | DATE | Last modification date |
| source_system | Constant | 'ZOOM_SILVER' | VARCHAR | Data lineage tracking |

### 4. GO_USAGE_FACTS Transformation Mapping

**Source Tables**: `si_feature_usage`  
**Target Table**: `go_usage_facts`  
**Grain**: One record per feature per day  
**Update Frequency**: Daily batch processing  

| Target Field | Source Field(s) | Transformation Logic | Data Type | Business Rule |
|--------------|-----------------|---------------------|-----------|---------------|
| usage_fact_id | System Generated | AUTOINCREMENT | VARCHAR | Unique identifier for each fact record |
| feature_usage_id | si_feature_usage.feature_usage_id | Direct mapping with validation | VARCHAR | Must exist in source, not null |
| feature_name | si_feature_usage.feature_name | TRIM(UPPER(feature_name)) | VARCHAR | Standardized feature names |
| usage_date | si_feature_usage.usage_date | Direct mapping with validation | DATE | Must be valid date, not future |
| usage_count | si_feature_usage.usage_count | Direct mapping with validation | NUMBER | Must be >= 0 |
| daily_active_users | Calculated | COUNT(DISTINCT user_id) WHERE feature_name = target.feature_name AND usage_date = target.usage_date | NUMBER | Unique users per feature per day |
| feature_adoption_rate | Calculated | (daily_active_users / total_active_users_on_date) * 100 | NUMBER(5,2) | Percentage of users adopting feature |
| usage_trend_indicator | Calculated | CASE WHEN usage_count > LAG(usage_count, 7) THEN 'Increasing' WHEN usage_count < LAG(usage_count, 7) THEN 'Decreasing' ELSE 'Stable' END | VARCHAR | 7-day trend comparison |
| feature_category | Lookup | Map feature_name to predefined categories (Communication, Collaboration, Security, etc.) | VARCHAR | Business categorization |
| load_date | System Generated | CURRENT_DATE() | DATE | ETL processing date |
| update_date | System Generated | CURRENT_DATE() | DATE | Last modification date |
| source_system | Constant | 'ZOOM_SILVER' | VARCHAR | Data lineage tracking |

### 5. GO_FINANCIAL_FACTS Transformation Mapping

**Source Tables**: `si_billing_events`  
**Target Table**: `go_financial_facts`  
**Grain**: One record per billing event  
**Update Frequency**: Real-time streaming with hourly reconciliation  

| Target Field | Source Field(s) | Transformation Logic | Data Type | Business Rule |
|--------------|-----------------|---------------------|-----------|---------------|
| financial_fact_id | System Generated | AUTOINCREMENT | VARCHAR | Unique identifier for each fact record |
| billing_event_id | si_billing_events.billing_event_id | Direct mapping with validation | VARCHAR | Must exist in source, not null |
| amount | si_billing_events.amount | ROUND(amount, 2) | NUMBER(10,2) | Monetary precision to 2 decimal places |
| event_type | si_billing_events.event_type | UPPER(TRIM(event_type)) | VARCHAR | Standardized event types |
| event_date | si_billing_events.event_date | Direct mapping with validation | DATE | Must be valid date |
| revenue_impact | Calculated | CASE WHEN event_type IN ('CHARGE', 'PAYMENT') THEN amount WHEN event_type IN ('REFUND', 'CREDIT') THEN -amount ELSE 0 END | NUMBER(10,2) | Business logic for revenue calculation |
| cumulative_revenue | Calculated | SUM(revenue_impact) OVER (ORDER BY event_date, billing_event_id ROWS UNBOUNDED PRECEDING) | NUMBER(10,2) | Running total of revenue |
| transaction_fee | Calculated | CASE WHEN event_type = 'CHARGE' THEN amount * 0.029 + 0.30 ELSE 0 END | NUMBER(10,2) | Standard processing fee calculation |
| net_amount | Calculated | amount - transaction_fee | NUMBER(10,2) | Amount after fees |
| load_date | System Generated | CURRENT_DATE() | DATE | ETL processing date |
| update_date | System Generated | CURRENT_DATE() | DATE | Last modification date |
| source_system | Constant | 'ZOOM_SILVER' | VARCHAR | Data lineage tracking |

---

## Transformation Rules Summary

### Duration Calculations
- **Meeting Duration**: Calculated as `DATEDIFF('minute', start_time, end_time)`
- **Participant Session Duration**: Calculated as `DATEDIFF('minute', join_time, leave_time)`
- **Validation**: All durations must be non-negative and within reasonable business limits
- **Null Handling**: Missing timestamps result in NULL duration with appropriate error logging

### Engagement Score Calculations
- **Formula**: `(microphone_usage * 0.3 + camera_usage * 0.3 + chat_activity * 0.2 + reactions * 0.2) / session_duration`
- **Normalization**: Scores are normalized to a 0-1 scale
- **Weighting**: Microphone and camera usage weighted higher than passive activities
- **Minimum Threshold**: Sessions under 1 minute receive engagement score of 0

### Attendance Rate Calculations
- **Formula**: `(actual_attendees / registered_attendees) * 100`
- **Null Handling**: When registrants = 0, attendance rate is set to NULL
- **Cap**: Attendance rates capped at 100% (handles over-registration scenarios)
- **Validation**: Actual attendees cannot exceed registered attendees by more than 10%

### Aggregation Rules
- **Participant Counts**: Use `COUNT(DISTINCT participant_id)` to avoid double-counting
- **Time-based Aggregations**: All timestamps converted to UTC before aggregation
- **Null Value Handling**: Exclude NULL values from aggregations unless specifically required
- **Data Quality Checks**: Validate aggregation results against business rules

### Revenue Impact Calculations
- **Positive Impact**: Charges and payments increase revenue
- **Negative Impact**: Refunds and credits decrease revenue
- **Currency Handling**: All amounts standardized to USD with 2 decimal precision
- **Tax Calculations**: Separate tax amounts from base revenue for reporting

### Data Quality Validations
- **Range Checks**: Numeric values validated against business-defined ranges
- **Format Validation**: Text fields validated against standardized formats
- **Referential Integrity**: Foreign key relationships validated during transformation
- **Business Rule Validation**: Custom business rules applied based on entity type

### Null Handling Strategies
- **Required Fields**: Transformation fails if mandatory fields are NULL
- **Optional Fields**: NULL values preserved with appropriate default handling
- **Calculated Fields**: NULL inputs result in NULL outputs with error logging
- **Aggregations**: NULL values excluded from calculations unless business rules specify otherwise

### Business Rules Implementation
- **Meeting Duration Limits**: Meetings cannot exceed 48 hours (2880 minutes)
- **Participant Limits**: Maximum 10,000 participants per session
- **Engagement Thresholds**: Minimum 1-minute session for engagement calculation
- **Financial Limits**: Transaction amounts validated against account limits
- **Date Validations**: All dates must be within valid business date ranges

### Performance Optimization
- **Incremental Loading**: Only process changed records since last successful run
- **Parallel Processing**: Large datasets processed in parallel partitions
- **Indexing Strategy**: Appropriate indexes created on join and filter columns
- **Clustering Keys**: Tables clustered on frequently queried date columns
- **Materialized Views**: Pre-aggregated views for common query patterns

---

## Data Quality and Validation Framework

### Pre-Transformation Validations
1. **Source Data Completeness**: Verify all required source tables and columns exist
2. **Data Freshness**: Ensure source data is within acceptable freshness thresholds
3. **Volume Validation**: Check for unexpected data volume changes (±20% threshold)
4. **Schema Validation**: Verify source schema matches expected structure

### Transformation Validations
1. **Business Rule Compliance**: All calculated fields validated against business rules
2. **Data Type Consistency**: Ensure all transformations maintain appropriate data types
3. **Referential Integrity**: Validate all foreign key relationships
4. **Duplicate Detection**: Identify and handle duplicate records appropriately

### Post-Transformation Validations
1. **Record Count Reconciliation**: Compare source and target record counts
2. **Aggregate Validation**: Validate key aggregations against expected ranges
3. **Data Distribution Analysis**: Check for unusual data distributions
4. **Performance Metrics**: Monitor transformation performance and resource usage

### Error Handling and Recovery
1. **Error Classification**: Categorize errors by severity (Critical, High, Medium, Low)
2. **Automatic Retry**: Implement retry logic for transient errors
3. **Manual Intervention**: Define escalation procedures for critical errors
4. **Data Quarantine**: Isolate problematic records for manual review

---

## Implementation Guidelines

### ETL Pipeline Architecture
- **Batch Processing**: Daily batch loads for historical data
- **Stream Processing**: Real-time processing for critical business events
- **Hybrid Approach**: Combination of batch and stream for optimal performance
- **Monitoring**: Comprehensive monitoring and alerting for all pipeline stages

### Data Lineage and Auditing
- **Source Tracking**: Complete lineage from source systems to Gold layer
- **Transformation Logging**: Detailed logs of all transformation steps
- **Change Detection**: Track all changes to source data and transformation logic
- **Audit Trail**: Maintain complete audit trail for compliance requirements

### Security and Compliance
- **Data Encryption**: All data encrypted in transit and at rest
- **Access Controls**: Role-based access controls for all data assets
- **Privacy Compliance**: GDPR, CCPA, and other privacy regulation compliance
- **Data Retention**: Automated data retention and purging policies

### Performance Monitoring
- **SLA Monitoring**: Track performance against defined SLAs
- **Resource Utilization**: Monitor compute and storage resource usage
- **Query Performance**: Optimize queries based on usage patterns
- **Capacity Planning**: Proactive capacity planning based on growth trends

---

## Conclusion

This comprehensive data mapping document provides the foundation for transforming Silver layer data into business-ready Gold layer Fact tables. The transformations are designed to support advanced analytics, reporting, and business intelligence requirements while maintaining high data quality standards and optimal performance.

Key benefits of this approach:
- **Scalability**: Architecture supports growing data volumes and complexity
- **Maintainability**: Clear documentation and standardized processes
- **Reliability**: Robust error handling and data quality validation
- **Performance**: Optimized for analytical query performance
- **Compliance**: Meets all regulatory and business compliance requirements

Regular review and updates of this mapping document ensure continued alignment with evolving business requirements and technological capabilities.

---

*Document Version: 4*  
*Last Updated: 2024-01-20*  
*Next Review Date: 2024-04-20*