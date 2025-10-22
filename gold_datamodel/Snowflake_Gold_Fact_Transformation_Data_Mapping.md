_____________________________________________
## *Author*: AAVA
## *Created on*: 2024-01-20
## *Description*: Snowflake Gold Fact Transformation Data Mapping for Zoom Platform Analytics System
## *Version*: 1
## *Updated on*: 2024-01-20
_____________________________________________

# Snowflake Gold Fact Transformation Data Mapping
## Zoom Platform Analytics System

## Overview

This document provides comprehensive data mapping for Fact tables in the Gold Layer of the Zoom Platform Analytics System. The mapping transforms cleansed Silver layer data into business-ready analytical fact tables optimized for reporting, analytics, and decision-making processes.

### Key Considerations:
- **Medallion Architecture**: Following Bronze-Silver-Gold data lake architecture pattern
- **Snowflake Optimization**: Leveraging Snowflake-specific features and data types
- **Data Quality**: Implementing 98% data completeness requirements with millisecond timestamp precision
- **Business Rules**: Incorporating meeting duration logic, participant engagement calculations, and financial metrics
- **Transformation Logic**: Complex calculations for engagement scores, attendance rates, and revenue impact
- **Audit Trail**: Complete data lineage tracking from Silver to Gold layer

## Data Mapping for Fact Tables

### 1. GO_MEETING_FACTS

**Purpose**: Central fact table capturing meeting performance metrics and key business measures

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|--------------------|
| Gold | go_meeting_facts | meeting_fact_id | Gold | Generated | AUTOINCREMENT | System-generated unique identifier using Snowflake AUTOINCREMENT |
| Gold | go_meeting_facts | meeting_id | Silver | si_meetings | meeting_id | Direct mapping with data validation for uniqueness |
| Gold | go_meeting_facts | meeting_topic | Silver | si_meetings | meeting_topic | Direct mapping with UTF-8 encoding validation and null handling |
| Gold | go_meeting_facts | duration_minutes | Silver | si_meetings | duration_minutes | Direct mapping with validation: duration >= 0 AND duration <= 2880 (48 hours max) |
| Gold | go_meeting_facts | start_time | Silver | si_meetings | start_time | Direct mapping with UTC standardization and millisecond precision validation |
| Gold | go_meeting_facts | end_time | Silver | si_meetings | end_time | Direct mapping with UTC standardization and validation: end_time >= start_time |
| Gold | go_meeting_facts | participant_count | Silver | si_participants | participant_id | COUNT(DISTINCT participant_id) WHERE meeting_id matches, validated against license limits |
| Gold | go_meeting_facts | average_engagement_score | Silver | si_participants | Calculated | AVG(engagement_score) calculated from participant activities: (audio_time + video_time + chat_messages + screen_shares) / total_session_time * 100, range 0.00-100.00 |
| Gold | go_meeting_facts | total_screen_share_duration | Silver | si_participants | Calculated | SUM(screen_share_duration_minutes) across all participants for the meeting |
| Gold | go_meeting_facts | recording_duration | Silver | Derived | Calculated | IF recording exists: (recording_end_time - recording_start_time) ELSE 0, validated against meeting duration |
| Gold | go_meeting_facts | chat_message_count | Silver | Derived | Calculated | COUNT of chat messages during meeting timeframe, validated for completeness |
| Gold | go_meeting_facts | load_date | Gold | System | CURRENT_DATE() | System-generated load date in UTC |
| Gold | go_meeting_facts | update_date | Gold | System | CURRENT_DATE() | System-generated update date in UTC |
| Gold | go_meeting_facts | source_system | Gold | System | 'ZOOM_SILVER' | Static value indicating source system |

### 2. GO_WEBINAR_FACTS

**Purpose**: Fact table for webinar performance metrics and attendance analytics

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|--------------------|
| Gold | go_webinar_facts | webinar_fact_id | Gold | Generated | AUTOINCREMENT | System-generated unique identifier using Snowflake AUTOINCREMENT |
| Gold | go_webinar_facts | webinar_id | Silver | si_webinars | webinar_id | Direct mapping with data validation for uniqueness |
| Gold | go_webinar_facts | webinar_topic | Silver | si_webinars | webinar_topic | Direct mapping with UTF-8 encoding validation and null handling |
| Gold | go_webinar_facts | start_time | Silver | si_webinars | start_time | Direct mapping with UTC standardization and millisecond precision validation |
| Gold | go_webinar_facts | end_time | Silver | si_webinars | end_time | Direct mapping with UTC standardization and validation: end_time >= start_time |
| Gold | go_webinar_facts | registrants | Silver | si_webinars | registrants | Direct mapping with validation: registrants >= 0 AND registrants <= account_limits |
| Gold | go_webinar_facts | actual_attendees | Silver | si_participants | participant_id | COUNT(DISTINCT participant_id) WHERE webinar_id matches and join_time IS NOT NULL |
| Gold | go_webinar_facts | attendance_rate | Silver | Calculated | Calculated | CASE WHEN registrants > 0 THEN (actual_attendees / registrants * 100.00) ELSE 0.00 END, precision 2 decimal places |
| Gold | go_webinar_facts | average_watch_time | Silver | si_participants | Calculated | AVG(DATEDIFF('minute', join_time, leave_time)) WHERE leave_time IS NOT NULL, validated for logical consistency |
| Gold | go_webinar_facts | peak_concurrent_viewers | Silver | si_participants | Calculated | MAX concurrent participants calculated using window functions over join/leave time intervals |
| Gold | go_webinar_facts | q_and_a_questions | Silver | Derived | Calculated | COUNT of Q&A questions during webinar timeframe, derived from interaction logs |
| Gold | go_webinar_facts | poll_responses | Silver | Derived | Calculated | COUNT of poll responses during webinar timeframe, aggregated from poll interaction data |
| Gold | go_webinar_facts | load_date | Gold | System | CURRENT_DATE() | System-generated load date in UTC |
| Gold | go_webinar_facts | update_date | Gold | System | CURRENT_DATE() | System-generated update date in UTC |
| Gold | go_webinar_facts | source_system | Gold | System | 'ZOOM_SILVER' | Static value indicating source system |

### 3. GO_PARTICIPANT_FACTS

**Purpose**: Individual participant engagement and interaction metrics

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|--------------------|
| Gold | go_participant_facts | participant_fact_id | Gold | Generated | AUTOINCREMENT | System-generated unique identifier using Snowflake AUTOINCREMENT |
| Gold | go_participant_facts | participant_id | Silver | si_participants | participant_id | Direct mapping with data validation for uniqueness |
| Gold | go_participant_facts | join_time | Silver | si_participants | join_time | Direct mapping with UTC standardization and millisecond precision validation |
| Gold | go_participant_facts | leave_time | Silver | si_participants | leave_time | Direct mapping with UTC standardization and validation: leave_time >= join_time OR leave_time IS NULL |
| Gold | go_participant_facts | session_duration_minutes | Silver | si_participants | Calculated | CASE WHEN leave_time IS NOT NULL THEN DATEDIFF('minute', join_time, leave_time) ELSE DATEDIFF('minute', join_time, CURRENT_TIMESTAMP()) END, minimum 0 |
| Gold | go_participant_facts | engagement_score | Silver | Derived | Calculated | Weighted calculation: (microphone_usage_weight * 0.3 + camera_usage_weight * 0.3 + chat_participation_weight * 0.2 + screen_share_weight * 0.1 + reactions_weight * 0.1), range 0.00-100.00 |
| Gold | go_participant_facts | microphone_usage_minutes | Silver | Derived | Calculated | Total minutes with microphone active during session, derived from audio activity logs |
| Gold | go_participant_facts | camera_usage_minutes | Silver | Derived | Calculated | Total minutes with camera active during session, derived from video activity logs |
| Gold | go_participant_facts | screen_share_count | Silver | Derived | Calculated | COUNT of screen sharing sessions initiated by participant |
| Gold | go_participant_facts | chat_messages_sent | Silver | Derived | Calculated | COUNT of chat messages sent by participant during session |
| Gold | go_participant_facts | reactions_count | Silver | Derived | Calculated | COUNT of emoji reactions and feedback submitted by participant |
| Gold | go_participant_facts | load_date | Gold | System | CURRENT_DATE() | System-generated load date in UTC |
| Gold | go_participant_facts | update_date | Gold | System | CURRENT_DATE() | System-generated update date in UTC |
| Gold | go_participant_facts | source_system | Gold | System | 'ZOOM_SILVER' | Static value indicating source system |

### 4. GO_USAGE_FACTS

**Purpose**: Platform feature usage and adoption metrics

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|--------------------|
| Gold | go_usage_facts | usage_fact_id | Gold | Generated | AUTOINCREMENT | System-generated unique identifier using Snowflake AUTOINCREMENT |
| Gold | go_usage_facts | feature_usage_id | Silver | si_feature_usage | feature_usage_id | Direct mapping with data validation for uniqueness |
| Gold | go_usage_facts | feature_name | Silver | si_feature_usage | feature_name | Direct mapping with standardized feature name validation against approved feature catalog |
| Gold | go_usage_facts | usage_date | Silver | si_feature_usage | usage_date | Direct mapping with date validation and business day logic |
| Gold | go_usage_facts | usage_count | Silver | si_feature_usage | usage_count | Direct mapping with validation: usage_count >= 0 AND usage_count <= daily_limits |
| Gold | go_usage_facts | daily_active_users | Silver | si_feature_usage | Calculated | COUNT(DISTINCT user_id) for feature_name on usage_date, aggregated from user activity logs |
| Gold | go_usage_facts | feature_adoption_rate | Silver | Calculated | Calculated | (daily_active_users / total_active_users_on_date * 100.00), precision 2 decimal places, range 0.00-100.00 |
| Gold | go_usage_facts | usage_trend_indicator | Silver | Calculated | Calculated | CASE WHEN current_usage > previous_7day_avg * 1.1 THEN 'Increasing' WHEN current_usage < previous_7day_avg * 0.9 THEN 'Decreasing' ELSE 'Stable' END |
| Gold | go_usage_facts | feature_category | Silver | Derived | Calculated | Lookup from feature catalog: CASE feature_name WHEN 'screen_share' THEN 'Collaboration' WHEN 'recording' THEN 'Content' WHEN 'chat' THEN 'Communication' ELSE 'Other' END |
| Gold | go_usage_facts | load_date | Gold | System | CURRENT_DATE() | System-generated load date in UTC |
| Gold | go_usage_facts | update_date | Gold | System | CURRENT_DATE() | System-generated update date in UTC |
| Gold | go_usage_facts | source_system | Gold | System | 'ZOOM_SILVER' | Static value indicating source system |

### 5. GO_FINANCIAL_FACTS

**Purpose**: Billing events and financial transaction metrics

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|--------------------|
| Gold | go_financial_facts | financial_fact_id | Gold | Generated | AUTOINCREMENT | System-generated unique identifier using Snowflake AUTOINCREMENT |
| Gold | go_financial_facts | billing_event_id | Silver | si_billing_events | billing_event_id | Direct mapping with data validation for uniqueness |
| Gold | go_financial_facts | amount | Silver | si_billing_events | amount | Direct mapping with validation: amount format NUMBER(10,2), currency validation |
| Gold | go_financial_facts | event_type | Silver | si_billing_events | event_type | Direct mapping with standardized values validation: ('Charge', 'Refund', 'Credit', 'Payment') |
| Gold | go_financial_facts | event_date | Silver | si_billing_events | event_date | Direct mapping with date validation and business day logic |
| Gold | go_financial_facts | revenue_impact | Silver | si_billing_events | Calculated | CASE event_type WHEN 'Charge' THEN amount WHEN 'Payment' THEN amount WHEN 'Refund' THEN -amount WHEN 'Credit' THEN -amount ELSE 0 END |
| Gold | go_financial_facts | cumulative_revenue | Silver | Calculated | Calculated | SUM(revenue_impact) OVER (ORDER BY event_date, billing_event_id ROWS UNBOUNDED PRECEDING) for running total |
| Gold | go_financial_facts | transaction_fee | Silver | si_billing_events | Calculated | CASE event_type WHEN 'Charge' THEN amount * 0.029 + 0.30 WHEN 'Payment' THEN amount * 0.029 + 0.30 ELSE 0.00 END, precision 2 decimal places |
| Gold | go_financial_facts | net_amount | Silver | si_billing_events | Calculated | amount - transaction_fee, precision 2 decimal places |
| Gold | go_financial_facts | load_date | Gold | System | CURRENT_DATE() | System-generated load date in UTC |
| Gold | go_financial_facts | update_date | Gold | System | CURRENT_DATE() | System-generated update date in UTC |
| Gold | go_financial_facts | source_system | Gold | System | 'ZOOM_SILVER' | Static value indicating source system |

## Transformation Rules Summary

### Duration Calculations
- **Meeting Duration**: `DATEDIFF('minute', start_time, end_time)` with validation for logical consistency
- **Session Duration**: `DATEDIFF('minute', join_time, leave_time)` with null handling for active sessions
- **Recording Duration**: Calculated from recording metadata with validation against meeting duration

### Engagement Score Calculations
- **Participant Engagement**: Weighted formula combining audio usage (30%), video usage (30%), chat participation (20%), screen sharing (10%), and reactions (10%)
- **Meeting Engagement**: Average of all participant engagement scores with outlier detection
- **Score Range**: 0.00 to 100.00 with 2 decimal precision

### Attendance Rate Calculations
- **Webinar Attendance**: `(actual_attendees / registrants * 100.00)` with division by zero protection
- **Meeting Participation**: Calculated based on join/leave patterns and minimum session duration
- **Peak Concurrent**: Window function analysis of overlapping join/leave time intervals

### Aggregation Rules
- **Participant Counts**: `COUNT(DISTINCT participant_id)` with validation against license limits
- **Usage Metrics**: Daily, weekly, and monthly aggregations with trend analysis
- **Financial Aggregations**: Running totals and period-over-period calculations

### Revenue Impact Calculations
- **Positive Impact**: Charges and Payments add to revenue
- **Negative Impact**: Refunds and Credits reduce revenue
- **Transaction Fees**: 2.9% + $0.30 for payment processing
- **Net Revenue**: Gross amount minus transaction fees and adjustments

### Data Quality Validations
- **Timestamp Validation**: UTC standardization with millisecond precision
- **Range Validation**: Numeric fields within business-defined ranges
- **Referential Integrity**: Cross-table validation for related entities
- **Completeness Checks**: 98% data completeness requirement validation
- **Format Validation**: Email, phone, and identifier format validation

### Null Handling Strategies
- **Required Fields**: Reject records with null values in mandatory fields
- **Optional Fields**: Use default values or maintain null with appropriate handling
- **Calculated Fields**: Implement null-safe calculations with COALESCE and CASE statements
- **Aggregations**: Use null-aware aggregate functions (COUNT, SUM, AVG)

### Business Rules Implementation
- **Meeting Duration Logic**: End time must be after start time with minimum duration validation
- **Participant Engagement**: Engagement scores calculated based on actual participation activities
- **License Compliance**: Participant counts validated against account license limits
- **Financial Accuracy**: Revenue calculations follow standard accounting principles
- **Data Retention**: Historical data maintained according to compliance requirements

### Performance Optimization
- **Clustering Keys**: Tables clustered on frequently queried date/time columns
- **Incremental Loading**: Delta processing for changed records only
- **Batch Processing**: Optimized batch sizes for Snowflake performance
- **Parallel Processing**: Multi-threaded processing for large data volumes
- **Query Optimization**: Efficient SQL patterns for complex transformations

---

*This data mapping document ensures comprehensive transformation of Silver layer data into business-ready Gold layer fact tables, supporting advanced analytics and reporting requirements for the Zoom Platform Analytics System.*