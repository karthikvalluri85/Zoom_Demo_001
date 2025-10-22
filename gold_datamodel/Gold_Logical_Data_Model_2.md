_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Complete Gold Layer Logical Data Model for Zoom Platform Analytics System with dimensional modeling, audit capabilities, and comprehensive analytics structure
## *Version*: 2
## *Updated on*: 
## *Changes*: Created comprehensive Gold layer model with complete fact tables, dimension tables, aggregated tables, process audit tables, error data tables, conceptual diagram, and ER diagram
## *Reason*: User requested to ensure the logical data model is complete and accurate, addressing gaps in previous version
_____________________________________________

# Gold Layer Logical Data Model for Zoom Platform Analytics System

## 1. Gold Layer Logical Model

### 1.1 Fact Tables

#### Go_Meeting_Facts
**Description:** Central fact table capturing meeting performance metrics and key business measures
**Table Type:** Fact
**SCD Type:** N/A (Fact table)

| Column Name | Data Type | Description | PII Classification |
|-------------|-----------|-------------|--------------------|
| meeting_topic | STRING | Subject or descriptive title of the meeting session | Non-PII |
| duration_minutes | INTEGER | Total duration of the meeting measured in minutes | Non-PII |
| start_time | TIMESTAMP | Timestamp indicating when the meeting began | Non-PII |
| end_time | TIMESTAMP | Timestamp indicating when the meeting concluded | Non-PII |
| participant_count | INTEGER | Total number of participants who joined the meeting | Non-PII |
| average_engagement_score | DECIMAL(5,4) | Average engagement score across all participants | Non-PII |
| total_chat_messages | INTEGER | Total number of chat messages during the meeting | Non-PII |
| screen_share_duration_minutes | INTEGER | Total duration of screen sharing activities | Non-PII |
| recording_size_mb | DECIMAL(10,2) | Size of meeting recording in megabytes | Non-PII |
| audio_quality_score | DECIMAL(5,3) | Average audio quality score for the meeting | Non-PII |
| video_quality_score | DECIMAL(5,3) | Average video quality score for the meeting | Non-PII |
| load_date | DATE | Date when the record was loaded into gold layer | Non-PII |
| update_date | DATE | Date when the record was last modified | Non-PII |
| source_system | STRING | Identifier of the source system | Non-PII |

#### Go_Webinar_Facts
**Description:** Fact table capturing webinar performance metrics and attendance data
**Table Type:** Fact
**SCD Type:** N/A (Fact table)

| Column Name | Data Type | Description | PII Classification |
|-------------|-----------|-------------|--------------------|
| webinar_title | STRING | Official name or title of the webinar event | Non-PII |
| scheduled_duration_minutes | INTEGER | Planned duration of the webinar in minutes | Non-PII |
| actual_duration_minutes | INTEGER | Actual duration of the webinar in minutes | Non-PII |
| start_time | TIMESTAMP | Timestamp when the webinar began | Non-PII |
| end_time | TIMESTAMP | Timestamp when the webinar concluded | Non-PII |
| registered_count | INTEGER | Total number of registered attendees | Non-PII |
| actual_attendees_count | INTEGER | Actual number of participants who attended | Non-PII |
| attendance_rate | DECIMAL(5,2) | Percentage of registered attendees who participated | Non-PII |
| average_attendance_duration | INTEGER | Average time attendees spent in the webinar | Non-PII |
| poll_count | INTEGER | Number of interactive polls conducted | Non-PII |
| qa_questions_count | INTEGER | Number of Q&A questions submitted | Non-PII |
| chat_messages_count | INTEGER | Total number of chat messages | Non-PII |
| recording_views | INTEGER | Number of times the webinar recording was viewed | Non-PII |
| load_date | DATE | Date when the record was loaded into gold layer | Non-PII |
| update_date | DATE | Date when the record was last modified | Non-PII |
| source_system | STRING | Identifier of the source system | Non-PII |

#### Go_Participant_Facts
**Description:** Fact table capturing individual participant engagement and interaction metrics
**Table Type:** Fact
**SCD Type:** N/A (Fact table)

| Column Name | Data Type | Description | PII Classification |
|-------------|-----------|-------------|--------------------|
| participant_name | STRING | Name of the session participant | PII |
| participant_email | STRING | Email address of the participant | PII |
| session_type | STRING | Type of session (Meeting, Webinar) | Non-PII |
| join_time | TIMESTAMP | Time when participant entered the session | Non-PII |
| leave_time | TIMESTAMP | Time when participant exited the session | Non-PII |
| total_duration_minutes | INTEGER | Total participation time in minutes | Non-PII |
| audio_enabled_duration | INTEGER | Time with audio enabled in minutes | Non-PII |
| video_enabled_duration | INTEGER | Time with video enabled in minutes | Non-PII |
| screen_share_duration | INTEGER | Time spent sharing screen in minutes | Non-PII |
| chat_messages_sent | INTEGER | Number of chat messages sent by participant | Non-PII |
| poll_responses_count | INTEGER | Number of poll responses submitted | Non-PII |
| engagement_score | DECIMAL(5,4) | Calculated participation engagement rating | Non-PII |
| connection_quality_score | DECIMAL(5,3) | Network and technical performance rating | Non-PII |
| device_type | STRING | Primary device used for session access | Non-PII |
| geographic_location | STRING | Participant's geographic region | PII |
| load_date | DATE | Date when the record was loaded into gold layer | Non-PII |
| update_date | DATE | Date when the record was last modified | Non-PII |
| source_system | STRING | Identifier of the source system | Non-PII |

#### Go_Usage_Facts
**Description:** Fact table capturing platform feature utilization and system usage metrics
**Table Type:** Fact
**SCD Type:** N/A (Fact table)

| Column Name | Data Type | Description | PII Classification |
|-------------|-----------|-------------|--------------------|
| usage_date | DATE | Date when the feature usage occurred | Non-PII |
| feature_name | STRING | Name of the platform feature being tracked | Non-PII |
| feature_category | STRING | Category classification of the feature | Non-PII |
| usage_count | INTEGER | Number of times the feature was utilized | Non-PII |
| unique_users_count | INTEGER | Number of unique users who used the feature | Non-PII |
| total_usage_duration_minutes | INTEGER | Total time spent using the feature | Non-PII |
| success_rate | DECIMAL(5,2) | Percentage of successful feature usage attempts | Non-PII |
| error_count | INTEGER | Number of errors encountered during usage | Non-PII |
| peak_concurrent_usage | INTEGER | Maximum simultaneous users of the feature | Non-PII |
| load_date | DATE | Date when the record was loaded into gold layer | Non-PII |
| update_date | DATE | Date when the record was last modified | Non-PII |
| source_system | STRING | Identifier of the source system | Non-PII |

### 1.2 Dimension Tables

#### Go_User_Dimension
**Description:** Dimension table containing comprehensive user profile and account information
**Table Type:** Dimension
**SCD Type:** Type 2 (Track historical changes in user attributes)

| Column Name | Data Type | Description | PII Classification |
|-------------|-----------|-------------|--------------------|
| user_full_name | STRING | Complete name of the platform user | PII |
| primary_email_address | STRING | Primary email for authentication and communication | PII |
| secondary_email_address | STRING | Alternative email for notifications | PII |
| department_name | STRING | Organizational department or business unit | Non-PII |
| job_title | STRING | Professional role or position within organization | PII |
| manager_name | STRING | Direct supervisor or reporting manager | PII |
| time_zone_preference | STRING | Geographic time zone setting | Non-PII |
| language_preference | STRING | Preferred interface and communication language | Non-PII |
| account_status | STRING | Current operational status | Non-PII |
| last_login_timestamp | TIMESTAMP | Most recent platform access date and time | Non-PII |
| registration_date | DATE | Initial account creation date | Non-PII |
| phone_number | STRING | Primary contact telephone number | PII |
| mobile_number | STRING | Mobile device contact number | PII |
| office_location | STRING | Physical office or work location | PII |
| plan_type | STRING | Subscription plan tier assigned to the user | Non-PII |
| company | STRING | Organization or company name | Non-PII |
| effective_start_date | DATE | Start date for this version of the record | Non-PII |
| effective_end_date | DATE | End date for this version of the record | Non-PII |
| is_current_record | BOOLEAN | Flag indicating if this is the current version | Non-PII |
| load_date | DATE | Date when the record was loaded into gold layer | Non-PII |
| update_date | DATE | Date when the record was last modified | Non-PII |
| source_system | STRING | Identifier of the source system | Non-PII |

#### Go_Account_Dimension
**Description:** Dimension table containing organizational account information and subscription details
**Table Type:** Dimension
**SCD Type:** Type 2 (Track historical changes in account attributes)

| Column Name | Data Type | Description | PII Classification |
|-------------|-----------|-------------|--------------------|
| account_name | STRING | Official name of the organizational account | Non-PII |
| account_type | STRING | Subscription tier classification | Non-PII |
| primary_billing_address | STRING | Physical address for billing purposes | PII |
| secondary_billing_address | STRING | Alternative billing address | PII |
| primary_contact_email | STRING | Main contact email for account management | PII |
| billing_contact_email | STRING | Specific email for billing matters | PII |
| primary_phone_number | STRING | Main contact telephone number | PII |
| industry_classification | STRING | Business industry category | Non-PII |
| company_size_category | STRING | Employee count range classification | Non-PII |
| annual_revenue_range | STRING | Business revenue classification | Non-PII |
| subscription_start_date | DATE | Initial subscription activation date | Non-PII |
| subscription_end_date | DATE | Current subscription expiration date | Non-PII |
| payment_status | STRING | Current billing and payment status | Non-PII |
| contract_type | STRING | Agreement type | Non-PII |
| account_manager_name | STRING | Assigned customer success manager | PII |
| effective_start_date | DATE | Start date for this version of the record | Non-PII |
| effective_end_date | DATE | End date for this version of the record | Non-PII |
| is_current_record | BOOLEAN | Flag indicating if this is the current version | Non-PII |
| load_date | DATE | Date when the record was loaded into gold layer | Non-PII |
| update_date | DATE | Date when the record was last modified | Non-PII |
| source_system | STRING | Identifier of the source system | Non-PII |

#### Go_Time_Dimension
**Description:** Comprehensive time dimension for temporal analysis and reporting
**Table Type:** Dimension
**SCD Type:** Type 1 (Static reference data)

| Column Name | Data Type | Description | PII Classification |
|-------------|-----------|-------------|--------------------|
| date_key | DATE | Primary date identifier | Non-PII |
| year | INTEGER | Year component | Non-PII |
| quarter | INTEGER | Quarter of the year (1-4) | Non-PII |
| month | INTEGER | Month component (1-12) | Non-PII |
| month_name | STRING | Full month name | Non-PII |
| week_of_year | INTEGER | Week number within the year | Non-PII |
| day_of_month | INTEGER | Day component (1-31) | Non-PII |
| day_of_week | INTEGER | Day of week (1-7) | Non-PII |
| day_name | STRING | Full day name | Non-PII |
| is_weekend | BOOLEAN | Flag indicating weekend days | Non-PII |
| is_holiday | BOOLEAN | Flag indicating public holidays | Non-PII |
| fiscal_year | INTEGER | Fiscal year designation | Non-PII |
| fiscal_quarter | INTEGER | Fiscal quarter designation | Non-PII |
| fiscal_month | INTEGER | Fiscal month designation | Non-PII |
| load_date | DATE | Date when the record was loaded into gold layer | Non-PII |
| update_date | DATE | Date when the record was last modified | Non-PII |
| source_system | STRING | Identifier of the source system | Non-PII |

#### Go_License_Dimension
**Description:** Dimension table containing license types, features, and entitlements
**Table Type:** Dimension
**SCD Type:** Type 2 (Track historical changes in license features)

| Column Name | Data Type | Description | PII Classification |
|-------------|-----------|-------------|--------------------|
| license_type | STRING | Category or tier of the license | Non-PII |
| license_description | STRING | Detailed description of license features | Non-PII |
| max_participants | INTEGER | Maximum number of meeting participants allowed | Non-PII |
| recording_enabled | BOOLEAN | Recording feature availability | Non-PII |
| cloud_storage_gb | INTEGER | Cloud storage allocation in gigabytes | Non-PII |
| webinar_enabled | BOOLEAN | Webinar feature availability | Non-PII |
| max_webinar_attendees | INTEGER | Maximum webinar attendee capacity | Non-PII |
| breakout_rooms_enabled | BOOLEAN | Breakout room feature availability | Non-PII |
| polling_enabled | BOOLEAN | Polling feature availability | Non-PII |
| whiteboard_enabled | BOOLEAN | Whiteboard collaboration feature availability | Non-PII |
| api_access_enabled | BOOLEAN | API integration access availability | Non-PII |
| sso_enabled | BOOLEAN | Single sign-on feature availability | Non-PII |
| admin_dashboard_enabled | BOOLEAN | Administrative dashboard access | Non-PII |
| monthly_price | DECIMAL(10,2) | Monthly subscription price | Non-PII |
| annual_price | DECIMAL(10,2) | Annual subscription price | Non-PII |
| effective_start_date | DATE | Start date for this version of the record | Non-PII |
| effective_end_date | DATE | End date for this version of the record | Non-PII |
| is_current_record | BOOLEAN | Flag indicating if this is the current version | Non-PII |
| load_date | DATE | Date when the record was loaded into gold layer | Non-PII |
| update_date | DATE | Date when the record was last modified | Non-PII |
| source_system | STRING | Identifier of the source system | Non-PII |

### 1.3 Process Audit Tables

#### Go_Pipeline_Audit
**Description:** Comprehensive audit trail for all Gold layer pipeline execution and data processing activities
**Table Type:** Audit
**SCD Type:** N/A (Audit table)

| Column Name | Data Type | Description | PII Classification |
|-------------|-----------|-------------|--------------------|
| pipeline_run_id | STRING | Unique identifier for each pipeline execution run | Non-PII |
| pipeline_name | STRING | Name of the data pipeline that was executed | Non-PII |
| pipeline_type | STRING | Type of pipeline (ETL, ELT, Streaming, Batch) | Non-PII |
| execution_start_time | TIMESTAMP | Timestamp when the pipeline execution began | Non-PII |
| execution_end_time | TIMESTAMP | Timestamp when the pipeline execution completed | Non-PII |
| execution_duration_seconds | INTEGER | Total duration of pipeline execution in seconds | Non-PII |
| execution_status | STRING | Final status of pipeline execution | Non-PII |
| records_processed | INTEGER | Total number of records processed during execution | Non-PII |
| records_inserted | INTEGER | Number of new records inserted during execution | Non-PII |
| records_updated | INTEGER | Number of existing records updated during execution | Non-PII |
| records_rejected | INTEGER | Number of records rejected due to quality issues | Non-PII |
| source_system | STRING | Source system from which data was processed | Non-PII |
| target_table | STRING | Target table where processed data was loaded | Non-PII |
| error_count | INTEGER | Total number of errors encountered during execution | Non-PII |
| warning_count | INTEGER | Total number of warnings generated during execution | Non-PII |
| data_volume_mb | DECIMAL(10,2) | Volume of data processed in megabytes | Non-PII |
| pipeline_version | STRING | Version of the pipeline that was executed | Non-PII |
| executed_by | STRING | System or user that initiated the pipeline execution | Non-PII |
| configuration_hash | STRING | Hash of pipeline configuration for change tracking | Non-PII |
| resource_usage_cpu_percent | DECIMAL(5,2) | CPU utilization during pipeline execution | Non-PII |
| resource_usage_memory_mb | DECIMAL(10,2) | Memory utilization during pipeline execution | Non-PII |
| load_date | DATE | Date when the audit record was created | Non-PII |
| update_date | DATE | Date when the audit record was last updated | Non-PII |

### 1.4 Error Data Tables

#### Go_Data_Quality_Errors
**Description:** Comprehensive error tracking for data validation and quality issues in Gold layer processing
**Table Type:** Error Data
**SCD Type:** N/A (Error tracking table)

| Column Name | Data Type | Description | PII Classification |
|-------------|-----------|-------------|--------------------|
| error_id | STRING | Unique identifier for each error record | Non-PII |
| error_timestamp | TIMESTAMP | Timestamp when the data quality error was detected | Non-PII |
| pipeline_run_id | STRING | Reference to the pipeline execution that detected the error | Non-PII |
| source_table | STRING | Name of the source table where the error was found | Non-PII |
| target_table | STRING | Name of the target table affected by the error | Non-PII |
| error_type | STRING | Type of data quality error | Non-PII |
| error_category | STRING | High-level category of the error | Non-PII |
| error_description | STRING | Detailed description of the data quality issue | Non-PII |
| error_severity | STRING | Severity level of the error | Non-PII |
| affected_records | INTEGER | Number of records affected by this error | Non-PII |
| error_column | STRING | Specific column where the error was detected | Non-PII |
| error_value | STRING | The actual value that caused the error | PII |
| expected_value | STRING | The expected value or format | Non-PII |
| validation_rule | STRING | The validation rule that was violated | Non-PII |
| business_rule | STRING | The business rule that was violated | Non-PII |
| resolution_status | STRING | Current status of error resolution | Non-PII |
| resolution_action | STRING | Action taken to resolve the error | Non-PII |
| resolved_by | STRING | Person or system that resolved the error | Non-PII |
| resolution_timestamp | TIMESTAMP | Timestamp when the error was resolved | Non-PII |
| impact_assessment | STRING | Assessment of business impact | Non-PII |
| root_cause_analysis | STRING | Analysis of the root cause of the error | Non-PII |
| prevention_measures | STRING | Measures implemented to prevent recurrence | Non-PII |
| load_date | DATE | Date when the error record was created | Non-PII |
| update_date | DATE | Date when the error record was last updated | Non-PII |

### 1.5 Aggregated Tables

#### Go_Daily_Usage_Summary
**Description:** Daily aggregated summary of platform usage metrics and key performance indicators
**Table Type:** Aggregated
**SCD Type:** N/A (Aggregated table)

| Column Name | Data Type | Description | PII Classification |
|-------------|-----------|-------------|--------------------|
| summary_date | DATE | Date for which the summary is calculated | Non-PII |
| total_meetings | INTEGER | Total number of meetings conducted | Non-PII |
| total_webinars | INTEGER | Total number of webinars conducted | Non-PII |
| total_participants | INTEGER | Total number of unique participants | Non-PII |
| total_meeting_minutes | INTEGER | Total duration of all meetings in minutes | Non-PII |
| total_webinar_minutes | INTEGER | Total duration of all webinars in minutes | Non-PII |
| average_meeting_duration | DECIMAL(8,2) | Average duration of meetings in minutes | Non-PII |
| average_webinar_duration | DECIMAL(8,2) | Average duration of webinars in minutes | Non-PII |
| average_participants_per_meeting | DECIMAL(8,2) | Average number of participants per meeting | Non-PII |
| average_attendees_per_webinar | DECIMAL(8,2) | Average number of attendees per webinar | Non-PII |
| total_recordings_created | INTEGER | Total number of recordings created | Non-PII |
| total_recording_storage_gb | DECIMAL(10,2) | Total storage used for recordings in GB | Non-PII |
| peak_concurrent_meetings | INTEGER | Maximum simultaneous meetings | Non-PII |
| peak_concurrent_participants | INTEGER | Maximum simultaneous participants | Non-PII |
| average_audio_quality | DECIMAL(5,3) | Average audio quality score across all sessions | Non-PII |
| average_video_quality | DECIMAL(5,3) | Average video quality score across all sessions | Non-PII |
| total_support_tickets | INTEGER | Total number of support tickets created | Non-PII |
| average_ticket_resolution_hours | DECIMAL(8,2) | Average time to resolve support tickets | Non-PII |
| load_date | DATE | Date when the record was loaded into gold layer | Non-PII |
| update_date | DATE | Date when the record was last modified | Non-PII |
| source_system | STRING | Identifier of the source system | Non-PII |

#### Go_Monthly_Account_Summary
**Description:** Monthly aggregated summary of account-level metrics and business performance indicators
**Table Type:** Aggregated
**SCD Type:** N/A (Aggregated table)

| Column Name | Data Type | Description | PII Classification |
|-------------|-----------|-------------|--------------------|
| summary_month | DATE | Month for which the summary is calculated | Non-PII |
| account_name | STRING | Name of the account | Non-PII |
| account_type | STRING | Type of account subscription | Non-PII |
| active_users | INTEGER | Number of active users during the month | Non-PII |
| total_meetings | INTEGER | Total meetings conducted by the account | Non-PII |
| total_webinars | INTEGER | Total webinars conducted by the account | Non-PII |
| total_usage_hours | DECIMAL(10,2) | Total platform usage in hours | Non-PII |
| average_daily_active_users | DECIMAL(8,2) | Average daily active users | Non-PII |
| license_utilization_rate | DECIMAL(5,2) | Percentage of licenses actively used | Non-PII |
| storage_utilization_gb | DECIMAL(10,2) | Total storage utilized in gigabytes | Non-PII |
| storage_utilization_rate | DECIMAL(5,2) | Percentage of allocated storage used | Non-PII |
| total_billing_amount | DECIMAL(12,2) | Total billing amount for the month | Non-PII |
| feature_adoption_score | DECIMAL(5,2) | Overall feature adoption score | Non-PII |
| user_satisfaction_score | DECIMAL(5,2) | Average user satisfaction rating | Non-PII |
| support_ticket_count | INTEGER | Number of support tickets raised | Non-PII |
| critical_incidents | INTEGER | Number of critical incidents | Non-PII |
| system_uptime_percentage | DECIMAL(5,2) | System availability percentage | Non-PII |
| load_date | DATE | Date when the record was loaded into gold layer | Non-PII |
| update_date | DATE | Date when the record was last modified | Non-PII |
| source_system | STRING | Identifier of the source system | Non-PII |

#### Go_Feature_Usage_Summary
**Description:** Aggregated summary of platform feature utilization across different time periods
**Table Type:** Aggregated
**SCD Type:** N/A (Aggregated table)

| Column Name | Data Type | Description | PII Classification |
|-------------|-----------|-------------|--------------------|
| summary_period | STRING | Time period for aggregation (Daily, Weekly, Monthly) | Non-PII |
| summary_date | DATE | Date for which the summary is calculated | Non-PII |
| feature_name | STRING | Name of the platform feature | Non-PII |
| feature_category | STRING | Category classification of the feature | Non-PII |
| total_usage_count | INTEGER | Total number of feature usage instances | Non-PII |
| unique_users_count | INTEGER | Number of unique users who used the feature | Non-PII |
| total_usage_duration_hours | DECIMAL(10,2) | Total time spent using the feature in hours | Non-PII |
| average_usage_per_user | DECIMAL(8,2) | Average usage count per user | Non-PII |
| average_session_duration_minutes | DECIMAL(8,2) | Average duration per usage session | Non-PII |
| adoption_rate | DECIMAL(5,2) | Percentage of total users who used the feature | Non-PII |
| success_rate | DECIMAL(5,2) | Percentage of successful feature usage attempts | Non-PII |
| error_rate | DECIMAL(5,2) | Percentage of failed feature usage attempts | Non-PII |
| peak_concurrent_usage | INTEGER | Maximum simultaneous users of the feature | Non-PII |
| growth_rate | DECIMAL(5,2) | Period-over-period growth rate | Non-PII |
| user_satisfaction_rating | DECIMAL(5,2) | Average user satisfaction for the feature | Non-PII |
| load_date | DATE | Date when the record was loaded into gold layer | Non-PII |
| update_date | DATE | Date when the record was last modified | Non-PII |
| source_system | STRING | Identifier of the source system | Non-PII |

## 2. Conceptual Data Model Diagram

### 2.1 Table Relationships and Key Fields

| Source Entity | Target Entity | Relationship Key Field | Relationship Type | Business Rule |
|---------------|---------------|----------------------|-------------------|---------------|
| Go_User_Dimension | Go_Meeting_Facts | user_full_name → meeting_topic | One-to-Many | Each user can host multiple meetings |
| Go_User_Dimension | Go_Webinar_Facts | user_full_name → webinar_title | One-to-Many | Each user can host multiple webinars |
| Go_User_Dimension | Go_Participant_Facts | user_full_name → participant_name | One-to-Many | Each user can participate in multiple sessions |
| Go_Account_Dimension | Go_User_Dimension | account_name → company | One-to-Many | Each account can have multiple users |
| Go_Account_Dimension | Go_Monthly_Account_Summary | account_name → account_name | One-to-Many | Each account has monthly summaries |
| Go_License_Dimension | Go_User_Dimension | license_type → plan_type | One-to-Many | Each license type can be assigned to multiple users |
| Go_Time_Dimension | Go_Meeting_Facts | date_key → start_time | One-to-Many | Each date can have multiple meetings |
| Go_Time_Dimension | Go_Webinar_Facts | date_key → start_time | One-to-Many | Each date can have multiple webinars |
| Go_Time_Dimension | Go_Daily_Usage_Summary | date_key → summary_date | One-to-One | Each date has one daily summary |
| Go_Time_Dimension | Go_Monthly_Account_Summary | date_key → summary_month | One-to-Many | Each month can have multiple account summaries |
| Go_Meeting_Facts | Go_Participant_Facts | meeting_topic → session_type | One-to-Many | Each meeting can have multiple participants |
| Go_Webinar_Facts | Go_Participant_Facts | webinar_title → session_type | One-to-Many | Each webinar can have multiple participants |
| Go_Pipeline_Audit | Go_Data_Quality_Errors | pipeline_run_id → pipeline_run_id | One-to-Many | Each pipeline run can generate multiple errors |
| Go_Usage_Facts | Go_Feature_Usage_Summary | feature_name → feature_name | Many-to-One | Multiple usage records contribute to feature summaries |
| Go_Meeting_Facts | Go_Daily_Usage_Summary | start_time → summary_date | Many-to-One | Multiple meetings contribute to daily summaries |
| Go_Webinar_Facts | Go_Daily_Usage_Summary | start_time → summary_date | Many-to-One | Multiple webinars contribute to daily summaries |

## 3. ER Diagram Visualization

### 3.1 Gold Layer Entity Relationship Diagram

```
┌─────────────────────┐    ┌─────────────────────┐    ┌─────────────────────┐
│   Go_Time_Dimension │────│   Go_Meeting_Facts  │────│Go_Participant_Facts │
│                     │    │                     │    │                     │
│ - date_key          │    │ - meeting_topic     │    │ - participant_name  │
│ - year              │    │ - duration_minutes  │    │ - join_time         │
│ - quarter           │    │ - start_time        │    │ - leave_time        │
│ - month             │    │ - end_time          │    │ - engagement_score  │
│ - day_name          │    │ - participant_count │    │ - device_type       │
└─────────────────────┘    └─────────────────────┘    └─────────────────────┘
         │                           │                           │
         │                           │                           │
         │                  ┌─────────────────────┐              │
         │                  │  Go_Webinar_Facts   │              │
         │                  │                     │              │
         └──────────────────│ - webinar_title     │──────────────┘
                            │ - registered_count  │
                            │ - actual_attendees  │
                            │ - attendance_rate   │
                            │ - poll_count        │
                            └─────────────────────┘
                                       │
                                       │
┌─────────────────────┐    ┌─────────────────────┐    ┌─────────────────────┐
│ Go_User_Dimension   │────│ Go_Account_Dimension│────│Go_License_Dimension │
│                     │    │                     │    │                     │
│ - user_full_name    │    │ - account_name      │    │ - license_type      │
│ - primary_email     │    │ - account_type      │    │ - max_participants  │
│ - department_name   │    │ - industry_class    │    │ - recording_enabled │
│ - job_title         │    │ - company_size      │    │ - cloud_storage_gb  │
│ - plan_type         │    │ - subscription_start│    │ - monthly_price     │
│ - effective_dates   │    │ - effective_dates   │    │ - effective_dates   │
└─────────────────────┘    └─────────────────────┘    └─────────────────────┘
         │                           │                           │
         │                           │                           │
         │                  ┌─────────────────────┐              │
         │                  │   Go_Usage_Facts    │              │
         │                  │                     │              │
         └──────────────────│ - usage_date        │──────────────┘
                            │ - feature_name      │
                            │ - usage_count       │
                            │ - unique_users      │
                            │ - success_rate      │
                            └─────────────────────┘
                                       │
                                       │
┌─────────────────────┐    ┌─────────────────────┐    ┌─────────────────────┐
│Go_Daily_Usage_      │    │Go_Monthly_Account_  │    │Go_Feature_Usage_    │
│    Summary          │    │    Summary          │    │    Summary          │
│                     │    │                     │    │                     │
│ - summary_date      │    │ - summary_month     │    │ - summary_period    │
│ - total_meetings    │    │ - account_name      │    │ - feature_name      │
│ - total_webinars    │    │ - active_users      │    │ - total_usage_count │
│ - total_participants│    │ - license_utilization│    │ - adoption_rate     │
│ - peak_concurrent   │    │ - billing_amount    │    │ - success_rate      │
└─────────────────────┘    └─────────────────────┘    └─────────────────────┘
                                       │
                                       │
┌─────────────────────┐    ┌─────────────────────┐
│ Go_Pipeline_Audit   │────│Go_Data_Quality_     │
│                     │    │    Errors           │
│ - pipeline_run_id   │    │                     │
│ - pipeline_name     │    │ - error_id          │
│ - execution_status  │    │ - error_type        │
│ - records_processed │    │ - error_severity    │
│ - execution_duration│    │ - affected_records  │
│ - data_volume_mb    │    │ - resolution_status │
└─────────────────────┘    └─────────────────────┘
```

### 3.2 Data Flow and Processing Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   BRONZE LAYER  │────│  SILVER LAYER   │────│   GOLD LAYER    │
│                 │    │                 │    │                 │
│ Raw Data        │    │ Cleansed Data   │    │ Business Ready  │
│ - si_meetings   │    │ - si_meetings   │    │ - Go_Meeting_   │
│ - si_users      │    │ - si_users      │    │   Facts         │
│ - si_webinars   │    │ - si_webinars   │    │ - Go_User_      │
│ - si_participants│   │ - si_participants│   │   Dimension     │
│ - si_licenses   │    │ - si_licenses   │    │ - Go_Daily_     │
│                 │    │                 │    │   Summary       │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│ Data Ingestion  │    │ Data Quality    │    │ Business Logic  │
│ - Extract       │    │ - Validation    │    │ - Aggregation   │
│ - Load          │    │ - Cleansing     │    │ - Calculation   │
│ - Initial Audit │    │ - Standardization│   │ - Dimensional   │
│                 │    │ - Error Tracking│    │   Modeling      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│ Go_Pipeline_    │    │ Go_Data_Quality_│    │ Analytics &     │
│ Audit           │    │ Errors          │    │ Reporting       │
│                 │    │                 │    │                 │
│ - Execution     │    │ - Error Details │    │ - Dashboards    │
│   Tracking      │    │ - Resolution    │    │ - KPI Metrics   │
│ - Performance   │    │ - Impact        │    │ - Business      │
│   Monitoring    │    │   Assessment    │    │   Intelligence  │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 4. Design Rationale and Key Decisions

### 4.1 Dimensional Modeling Approach
- **Star Schema Design**: Implemented star schema with clear fact and dimension tables for optimal query performance
- **Slowly Changing Dimensions**: Applied SCD Type 2 for user and account dimensions to track historical changes
- **Time Dimension**: Created comprehensive time dimension to support temporal analysis and reporting
- **Fact Table Granularity**: Designed fact tables at appropriate grain levels for different analytical needs

### 4.2 Data Quality and Governance
- **Comprehensive Audit Trail**: Implemented detailed pipeline audit table to track all data processing activities
- **Error Tracking**: Created dedicated error table to capture and manage data quality issues
- **PII Classification**: Classified all columns for PII to ensure compliance with privacy regulations
- **Data Lineage**: Maintained source system tracking across all tables for complete data lineage

### 4.3 Performance Optimization
- **Aggregated Tables**: Pre-calculated summary tables for common reporting patterns
- **Naming Convention**: Consistent 'Go_' prefix for all Gold layer tables
- **Data Types**: Optimized data types for analytical processing and storage efficiency
- **Metadata Columns**: Standardized load_date, update_date, and source_system columns

### 4.4 Business Alignment
- **KPI Support**: Tables designed to support all identified KPIs from the conceptual model
- **Reporting Requirements**: Structure optimized for common business reporting patterns
- **Scalability**: Design supports future expansion and additional data sources
- **Compliance**: Built-in support for audit, governance, and regulatory requirements

### 4.5 Integration Capabilities
- **Source System Flexibility**: Design accommodates multiple source systems
- **API Support**: Structure supports both batch and real-time data integration
- **External Integration**: Tables designed to support integration with external analytics tools
- **Version Control**: Pipeline versioning and configuration tracking for change management

## 5. Implementation Guidelines

### 5.1 Data Loading Strategy
- **Incremental Loading**: Implement incremental loading for fact tables based on timestamp columns
- **Full Refresh**: Dimension tables may require full refresh for SCD Type 2 implementation
- **Error Handling**: Implement robust error handling with detailed logging to error tables
- **Data Validation**: Apply comprehensive validation rules before loading to Gold layer

### 5.2 Performance Considerations
- **Indexing Strategy**: Create appropriate indexes on frequently queried columns
- **Partitioning**: Consider partitioning large fact tables by date for improved performance
- **Clustering**: Implement clustering keys for cloud data warehouse optimization
- **Materialized Views**: Consider materialized views for complex aggregations

### 5.3 Monitoring and Maintenance
- **Data Quality Monitoring**: Implement automated data quality checks with alerting
- **Performance Monitoring**: Monitor query performance and optimize as needed
- **Capacity Planning**: Regular monitoring of storage and compute resource utilization
- **Audit Review**: Regular review of audit logs and error patterns for continuous improvement

This Gold Layer Logical Data Model provides a comprehensive foundation for advanced analytics, reporting, and business intelligence capabilities for the Zoom Platform Analytics System, ensuring data quality, governance, and scalability while supporting all identified business requirements and KPIs.