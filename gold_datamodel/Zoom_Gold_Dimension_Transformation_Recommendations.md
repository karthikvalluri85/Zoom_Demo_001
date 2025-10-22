_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Gold Layer Dimension Table Transformation Recommendations for Zoom Platform Analytics System
## *Version*: 1
## *Updated on*: 
_____________________________________________

# Gold Layer Dimension Table Transformation Recommendations

## 1. Dimension Table Analysis

Based on the Silver Layer Physical DDL script analysis, the following tables have been identified as dimension tables suitable for Gold layer transformation:

### 1.1 Primary Dimension Tables
- **si_users** - User dimension with profile and account information
- **si_meetings** - Meeting dimension with session details
- **si_webinars** - Webinar dimension with event information
- **si_licenses** - License dimension with subscription details
- **si_support_tickets** - Support ticket dimension with service information
- **si_feature_usage** - Feature usage dimension with utilization tracking

### 1.2 Bridge/Junction Tables
- **si_participants** - Participant bridge table connecting users to meetings/webinars
- **si_billing_events** - Billing events for financial analysis

### 1.3 Dimension Characteristics Analysis

| Dimension Table | Type | SCD Type | Key Attributes | Business Purpose |
|-----------------|------|----------|----------------|------------------|
| si_users | Core Dimension | Type 2 | user_id, email, user_name | User analytics and segmentation |
| si_meetings | Transaction Dimension | Type 1 | meeting_id, meeting_topic | Meeting performance analysis |
| si_webinars | Transaction Dimension | Type 1 | webinar_id, webinar_topic | Webinar effectiveness tracking |
| si_licenses | Core Dimension | Type 2 | license_id, license_type | License utilization analysis |
| si_support_tickets | Transaction Dimension | Type 1 | ticket_id, ticket_type | Support performance metrics |
| si_feature_usage | Fact-like Dimension | Type 1 | feature_usage_id, feature_name | Feature adoption analysis |

## 2. Transformation Rules for Dimension Tables

### 2.1 DIM_USER Transformation Rules

**Source Table:** si_users
**Target Table:** dim_user

#### Business Rules:
- Implement SCD Type 2 for tracking user profile changes over time
- Standardize email formats to lowercase
- Create user hierarchy based on company and plan type
- Generate user segments based on plan type and activity

#### Transformation Rules:
1. **Email Standardization**: Convert all email addresses to lowercase and validate format
2. **Name Standardization**: Proper case formatting for user names
3. **Company Hierarchy**: Create company groupings and standardize company names
4. **Plan Type Categorization**: Map plan types to standard categories (Free, Basic, Pro, Business, Enterprise)
5. **User Status Derivation**: Derive active/inactive status based on last activity
6. **SCD Implementation**: Add effective dates, expiration dates, and current flag

```sql
-- Example Transformation SQL
SELECT 
    user_id,
    LOWER(TRIM(email)) AS email_standardized,
    INITCAP(TRIM(user_name)) AS user_name_formatted,
    UPPER(TRIM(company)) AS company_standardized,
    CASE 
        WHEN plan_type IN ('basic', 'Basic', 'BASIC') THEN 'Basic'
        WHEN plan_type IN ('pro', 'Pro', 'PRO') THEN 'Pro'
        WHEN plan_type IN ('business', 'Business', 'BUSINESS') THEN 'Business'
        WHEN plan_type IN ('enterprise', 'Enterprise', 'ENTERPRISE') THEN 'Enterprise'
        ELSE 'Free'
    END AS plan_type_standardized,
    CASE 
        WHEN plan_type IN ('Free', 'Basic') THEN 'Individual'
        WHEN plan_type IN ('Pro', 'Business') THEN 'Professional'
        WHEN plan_type = 'Enterprise' THEN 'Enterprise'
        ELSE 'Unknown'
    END AS user_segment,
    load_date AS effective_date,
    '9999-12-31'::DATE AS expiration_date,
    TRUE AS is_current,
    source_system
FROM ZOOM_SILVER_SCHEMA.si_users;
```

### 2.2 DIM_MEETING Transformation Rules

**Source Table:** si_meetings
**Target Table:** dim_meeting

#### Business Rules:
- Standardize meeting topics and extract meeting types
- Calculate meeting duration categories
- Create time-based attributes for temporal analysis
- Generate meeting performance indicators

#### Transformation Rules:
1. **Topic Standardization**: Clean and standardize meeting topics
2. **Duration Categorization**: Create duration buckets (Short: <30min, Medium: 30-60min, Long: >60min)
3. **Time Attributes**: Extract day of week, hour of day, month, quarter
4. **Meeting Type Classification**: Derive meeting types from topics and patterns
5. **Performance Indicators**: Calculate meeting efficiency metrics

```sql
-- Example Transformation SQL
SELECT 
    meeting_id,
    TRIM(meeting_topic) AS meeting_topic_clean,
    duration_minutes,
    CASE 
        WHEN duration_minutes < 30 THEN 'Short (< 30 min)'
        WHEN duration_minutes BETWEEN 30 AND 60 THEN 'Medium (30-60 min)'
        WHEN duration_minutes > 60 THEN 'Long (> 60 min)'
        ELSE 'Unknown'
    END AS duration_category,
    start_time,
    end_time,
    EXTRACT(DOW FROM start_time) AS day_of_week,
    EXTRACT(HOUR FROM start_time) AS hour_of_day,
    EXTRACT(MONTH FROM start_time) AS month_number,
    EXTRACT(QUARTER FROM start_time) AS quarter_number,
    EXTRACT(YEAR FROM start_time) AS year_number,
    CASE 
        WHEN LOWER(meeting_topic) LIKE '%standup%' OR LOWER(meeting_topic) LIKE '%daily%' THEN 'Daily Standup'
        WHEN LOWER(meeting_topic) LIKE '%review%' OR LOWER(meeting_topic) LIKE '%retrospective%' THEN 'Review Meeting'
        WHEN LOWER(meeting_topic) LIKE '%training%' OR LOWER(meeting_topic) LIKE '%workshop%' THEN 'Training'
        WHEN LOWER(meeting_topic) LIKE '%interview%' THEN 'Interview'
        ELSE 'General Meeting'
    END AS meeting_type_derived,
    source_system
FROM ZOOM_SILVER_SCHEMA.si_meetings;
```

### 2.3 DIM_WEBINAR Transformation Rules

**Source Table:** si_webinars
**Target Table:** dim_webinar

#### Business Rules:
- Standardize webinar topics and categorize content types
- Calculate registration efficiency metrics
- Create temporal attributes for scheduling analysis
- Generate webinar performance categories

#### Transformation Rules:
1. **Topic Categorization**: Classify webinars by content type and industry
2. **Registration Metrics**: Calculate registration rates and capacity utilization
3. **Temporal Analysis**: Extract scheduling patterns and time-based attributes
4. **Performance Classification**: Create performance tiers based on attendance

```sql
-- Example Transformation SQL
SELECT 
    webinar_id,
    TRIM(webinar_topic) AS webinar_topic_clean,
    start_time,
    end_time,
    DATEDIFF(MINUTE, start_time, end_time) AS actual_duration_minutes,
    registrants,
    CASE 
        WHEN LOWER(webinar_topic) LIKE '%training%' OR LOWER(webinar_topic) LIKE '%tutorial%' THEN 'Training'
        WHEN LOWER(webinar_topic) LIKE '%product%' OR LOWER(webinar_topic) LIKE '%demo%' THEN 'Product Demo'
        WHEN LOWER(webinar_topic) LIKE '%marketing%' OR LOWER(webinar_topic) LIKE '%promotion%' THEN 'Marketing'
        WHEN LOWER(webinar_topic) LIKE '%conference%' OR LOWER(webinar_topic) LIKE '%summit%' THEN 'Conference'
        ELSE 'General Webinar'
    END AS webinar_category,
    CASE 
        WHEN registrants < 50 THEN 'Small (< 50)'
        WHEN registrants BETWEEN 50 AND 200 THEN 'Medium (50-200)'
        WHEN registrants BETWEEN 201 AND 500 THEN 'Large (201-500)'
        WHEN registrants > 500 THEN 'Extra Large (> 500)'
        ELSE 'Unknown'
    END AS audience_size_category,
    EXTRACT(DOW FROM start_time) AS day_of_week,
    EXTRACT(HOUR FROM start_time) AS hour_of_day,
    source_system
FROM ZOOM_SILVER_SCHEMA.si_webinars;
```

### 2.4 DIM_LICENSE Transformation Rules

**Source Table:** si_licenses
**Target Table:** dim_license

#### Business Rules:
- Implement SCD Type 2 for license changes
- Standardize license types and create hierarchies
- Calculate license duration and renewal patterns
- Generate license utilization categories

#### Transformation Rules:
1. **License Type Standardization**: Map to standard license categories
2. **Duration Calculation**: Calculate license duration and renewal cycles
3. **Status Derivation**: Determine active, expired, and upcoming renewal status
4. **Hierarchy Creation**: Create license tier hierarchies

```sql
-- Example Transformation SQL
SELECT 
    license_id,
    CASE 
        WHEN UPPER(license_type) IN ('BASIC', 'Basic') THEN 'Basic'
        WHEN UPPER(license_type) IN ('PRO', 'Pro', 'Professional') THEN 'Pro'
        WHEN UPPER(license_type) IN ('BUSINESS', 'Business') THEN 'Business'
        WHEN UPPER(license_type) IN ('ENTERPRISE', 'Enterprise') THEN 'Enterprise'
        ELSE 'Other'
    END AS license_type_standardized,
    start_date,
    end_date,
    DATEDIFF(DAY, start_date, end_date) AS license_duration_days,
    CASE 
        WHEN end_date < CURRENT_DATE THEN 'Expired'
        WHEN end_date BETWEEN CURRENT_DATE AND DATEADD(DAY, 30, CURRENT_DATE) THEN 'Expiring Soon'
        WHEN start_date > CURRENT_DATE THEN 'Future'
        ELSE 'Active'
    END AS license_status,
    CASE 
        WHEN license_type IN ('Basic', 'Pro') THEN 'Individual'
        WHEN license_type = 'Business' THEN 'Small Business'
        WHEN license_type = 'Enterprise' THEN 'Enterprise'
        ELSE 'Other'
    END AS license_tier,
    load_date AS effective_date,
    '9999-12-31'::DATE AS expiration_date,
    TRUE AS is_current,
    source_system
FROM ZOOM_SILVER_SCHEMA.si_licenses;
```

### 2.5 DIM_SUPPORT_TICKET Transformation Rules

**Source Table:** si_support_tickets
**Target Table:** dim_support_ticket

#### Business Rules:
- Standardize ticket types and resolution statuses
- Create priority and severity classifications
- Calculate aging and resolution time categories
- Generate support performance indicators

#### Transformation Rules:
1. **Status Standardization**: Map to standard resolution status values
2. **Type Categorization**: Create ticket type hierarchies
3. **Aging Calculation**: Calculate ticket age and resolution timeframes
4. **Priority Assignment**: Derive priority levels from ticket types

```sql
-- Example Transformation SQL
SELECT 
    ticket_id,
    CASE 
        WHEN UPPER(resolution_status) IN ('OPEN', 'NEW', 'CREATED') THEN 'Open'
        WHEN UPPER(resolution_status) IN ('IN PROGRESS', 'ASSIGNED', 'WORKING') THEN 'In Progress'
        WHEN UPPER(resolution_status) IN ('RESOLVED', 'CLOSED', 'COMPLETED') THEN 'Resolved'
        WHEN UPPER(resolution_status) IN ('CANCELLED', 'REJECTED') THEN 'Cancelled'
        ELSE 'Unknown'
    END AS resolution_status_standardized,
    open_date,
    CASE 
        WHEN UPPER(ticket_type) LIKE '%TECHNICAL%' OR UPPER(ticket_type) LIKE '%BUG%' THEN 'Technical'
        WHEN UPPER(ticket_type) LIKE '%BILLING%' OR UPPER(ticket_type) LIKE '%PAYMENT%' THEN 'Billing'
        WHEN UPPER(ticket_type) LIKE '%ACCOUNT%' OR UPPER(ticket_type) LIKE '%ACCESS%' THEN 'Account'
        WHEN UPPER(ticket_type) LIKE '%FEATURE%' OR UPPER(ticket_type) LIKE '%REQUEST%' THEN 'Feature Request'
        ELSE 'General'
    END AS ticket_category,
    DATEDIFF(DAY, open_date, CURRENT_DATE) AS ticket_age_days,
    CASE 
        WHEN DATEDIFF(DAY, open_date, CURRENT_DATE) <= 1 THEN 'New (0-1 days)'
        WHEN DATEDIFF(DAY, open_date, CURRENT_DATE) BETWEEN 2 AND 7 THEN 'Recent (2-7 days)'
        WHEN DATEDIFF(DAY, open_date, CURRENT_DATE) BETWEEN 8 AND 30 THEN 'Aging (8-30 days)'
        WHEN DATEDIFF(DAY, open_date, CURRENT_DATE) > 30 THEN 'Old (> 30 days)'
        ELSE 'Unknown'
    END AS ticket_age_category,
    CASE 
        WHEN ticket_type LIKE '%CRITICAL%' OR ticket_type LIKE '%URGENT%' THEN 'High'
        WHEN ticket_type LIKE '%NORMAL%' OR ticket_type LIKE '%STANDARD%' THEN 'Medium'
        ELSE 'Low'
    END AS priority_level,
    source_system
FROM ZOOM_SILVER_SCHEMA.si_support_tickets;
```

### 2.6 DIM_FEATURE Transformation Rules

**Source Table:** si_feature_usage
**Target Table:** dim_feature

#### Business Rules:
- Standardize feature names and create feature hierarchies
- Categorize features by functional areas
- Create usage pattern classifications
- Generate feature adoption indicators

#### Transformation Rules:
1. **Feature Name Standardization**: Clean and standardize feature names
2. **Feature Categorization**: Group features by functional areas
3. **Usage Classification**: Create usage frequency categories
4. **Adoption Metrics**: Calculate feature adoption and utilization rates

```sql
-- Example Transformation SQL
SELECT 
    feature_usage_id,
    TRIM(UPPER(feature_name)) AS feature_name_standardized,
    usage_date,
    usage_count,
    CASE 
        WHEN UPPER(feature_name) LIKE '%VIDEO%' OR UPPER(feature_name) LIKE '%CAMERA%' THEN 'Video'
        WHEN UPPER(feature_name) LIKE '%AUDIO%' OR UPPER(feature_name) LIKE '%MIC%' THEN 'Audio'
        WHEN UPPER(feature_name) LIKE '%SCREEN%' OR UPPER(feature_name) LIKE '%SHARE%' THEN 'Screen Sharing'
        WHEN UPPER(feature_name) LIKE '%CHAT%' OR UPPER(feature_name) LIKE '%MESSAGE%' THEN 'Chat'
        WHEN UPPER(feature_name) LIKE '%RECORD%' THEN 'Recording'
        WHEN UPPER(feature_name) LIKE '%BREAKOUT%' THEN 'Breakout Rooms'
        WHEN UPPER(feature_name) LIKE '%POLL%' OR UPPER(feature_name) LIKE '%SURVEY%' THEN 'Polling'
        ELSE 'Other'
    END AS feature_category,
    CASE 
        WHEN usage_count = 0 THEN 'Not Used'
        WHEN usage_count BETWEEN 1 AND 5 THEN 'Low Usage (1-5)'
        WHEN usage_count BETWEEN 6 AND 20 THEN 'Medium Usage (6-20)'
        WHEN usage_count BETWEEN 21 AND 50 THEN 'High Usage (21-50)'
        WHEN usage_count > 50 THEN 'Very High Usage (> 50)'
        ELSE 'Unknown'
    END AS usage_intensity,
    EXTRACT(DOW FROM usage_date) AS day_of_week,
    EXTRACT(MONTH FROM usage_date) AS month_number,
    source_system
FROM ZOOM_SILVER_SCHEMA.si_feature_usage;
```

## 3. Data Type Conversions

### 3.1 Standardized Data Types for Gold Layer

| Silver Layer Type | Gold Layer Type | Conversion Rule | Rationale |
|-------------------|-----------------|-----------------|----------|
| STRING | VARCHAR(255) | Direct mapping with length constraint | Optimize storage and query performance |
| NUMBER | DECIMAL(18,2) | Precision specification for monetary values | Ensure accuracy for financial calculations |
| NUMBER (counts) | BIGINT | Integer conversion for count fields | Optimize storage for large count values |
| TIMESTAMP_NTZ | TIMESTAMP | Add timezone awareness | Support global analytics requirements |
| DATE | DATE | Direct mapping | Maintain date precision |
| BOOLEAN | BOOLEAN | Direct mapping | Preserve logical values |

### 3.2 Specific Conversion Examples

```sql
-- Email standardization with validation
CASE 
    WHEN email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' 
    THEN LOWER(TRIM(email))
    ELSE NULL 
END AS email_standardized

-- Duration conversion with validation
CASE 
    WHEN duration_minutes >= 0 AND duration_minutes <= 1440 
    THEN duration_minutes::DECIMAL(10,2)
    ELSE NULL 
END AS duration_minutes_validated

-- Timestamp conversion with timezone
CONVERT_TIMEZONE('UTC', start_time) AS start_time_utc
```

## 4. Column Derivations

### 4.1 Computed Attributes

#### User Dimension Derivations
```sql
-- User domain extraction
SUBSTRING(email, POSITION('@' IN email) + 1) AS email_domain,

-- User name components
SPLIT_PART(user_name, ' ', 1) AS first_name,
SPLIT_PART(user_name, ' ', -1) AS last_name,

-- User activity status
CASE 
    WHEN DATEDIFF(DAY, last_login_date, CURRENT_DATE) <= 7 THEN 'Active'
    WHEN DATEDIFF(DAY, last_login_date, CURRENT_DATE) <= 30 THEN 'Recently Active'
    WHEN DATEDIFF(DAY, last_login_date, CURRENT_DATE) <= 90 THEN 'Inactive'
    ELSE 'Dormant'
END AS user_activity_status
```

#### Meeting Dimension Derivations
```sql
-- Meeting efficiency score
CASE 
    WHEN duration_minutes > 0 AND participant_count > 0 
    THEN (participant_count * duration_minutes) / 60.0
    ELSE 0 
END AS meeting_efficiency_score,

-- Time slot classification
CASE 
    WHEN EXTRACT(HOUR FROM start_time) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM start_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    WHEN EXTRACT(HOUR FROM start_time) BETWEEN 18 AND 22 THEN 'Evening'
    ELSE 'Night'
END AS time_slot,

-- Business day indicator
CASE 
    WHEN EXTRACT(DOW FROM start_time) BETWEEN 1 AND 5 THEN 'Weekday'
    ELSE 'Weekend'
END AS business_day_indicator
```

### 4.2 Concatenation Rules

```sql
-- Full user identifier
CONCAT(user_name, ' (', email, ')') AS user_full_identifier,

-- Meeting description
CONCAT(meeting_topic, ' - ', duration_minutes, ' min') AS meeting_description,

-- License description
CONCAT(license_type, ' (', start_date, ' to ', end_date, ')') AS license_description
```

## 5. Hierarchy Mapping

### 5.1 User Hierarchy

```sql
-- User organizational hierarchy
SELECT 
    user_id,
    company AS level_1_company,
    COALESCE(department, 'Unknown Department') AS level_2_department,
    COALESCE(team, 'Unknown Team') AS level_3_team,
    user_name AS level_4_user,
    plan_type AS user_plan_level
FROM dim_user;
```

### 5.2 Time Hierarchy

```sql
-- Temporal hierarchy for meetings and webinars
SELECT 
    EXTRACT(YEAR FROM start_time) AS year_level,
    EXTRACT(QUARTER FROM start_time) AS quarter_level,
    EXTRACT(MONTH FROM start_time) AS month_level,
    EXTRACT(WEEK FROM start_time) AS week_level,
    DATE(start_time) AS day_level,
    EXTRACT(HOUR FROM start_time) AS hour_level
FROM dim_meeting;
```

### 5.3 Feature Hierarchy

```sql
-- Feature functional hierarchy
SELECT 
    feature_category AS level_1_category,
    feature_subcategory AS level_2_subcategory,
    feature_name AS level_3_feature
FROM dim_feature;
```

## 6. Normalization & Standardization

### 6.1 Consistent Formatting Rules

#### Email Standardization
```sql
-- Email format standardization
LOWER(TRIM(REGEXP_REPLACE(email, '\s+', ''))) AS email_clean
```

#### Name Standardization
```sql
-- Name format standardization
INITCAP(TRIM(REGEXP_REPLACE(user_name, '\s+', ' '))) AS user_name_clean
```

#### Date Format Standardization
```sql
-- Ensure all dates are in consistent format
DATE(start_time) AS start_date_standardized,
TO_CHAR(start_time, 'YYYY-MM-DD HH24:MI:SS') AS start_time_formatted
```

### 6.2 Unique Key Constraints

#### Surrogate Key Generation
```sql
-- Generate surrogate keys for dimensions
ROW_NUMBER() OVER (ORDER BY user_id, effective_date) AS user_sk,
ROW_NUMBER() OVER (ORDER BY meeting_id) AS meeting_sk,
ROW_NUMBER() OVER (ORDER BY webinar_id) AS webinar_sk
```

#### Natural Key Validation
```sql
-- Ensure natural key uniqueness
COUNT(*) OVER (PARTITION BY user_id, effective_date) AS duplicate_check
```

## 7. SQL Transformation Examples

### 7.1 Complete DIM_USER Transformation

```sql
CREATE OR REPLACE TABLE ZOOM_GOLD_SCHEMA.dim_user AS
SELECT 
    -- Surrogate Key
    ROW_NUMBER() OVER (ORDER BY user_id, load_date) AS user_sk,
    
    -- Natural Key
    user_id,
    
    -- Standardized Attributes
    LOWER(TRIM(email)) AS email,
    INITCAP(TRIM(user_name)) AS user_name,
    UPPER(TRIM(company)) AS company,
    
    -- Derived Attributes
    SUBSTRING(email, POSITION('@' IN email) + 1) AS email_domain,
    SPLIT_PART(user_name, ' ', 1) AS first_name,
    SPLIT_PART(user_name, ' ', -1) AS last_name,
    
    -- Standardized Plan Type
    CASE 
        WHEN UPPER(plan_type) IN ('BASIC', 'Basic') THEN 'Basic'
        WHEN UPPER(plan_type) IN ('PRO', 'Pro', 'Professional') THEN 'Pro'
        WHEN UPPER(plan_type) IN ('BUSINESS', 'Business') THEN 'Business'
        WHEN UPPER(plan_type) IN ('ENTERPRISE', 'Enterprise') THEN 'Enterprise'
        ELSE 'Free'
    END AS plan_type,
    
    -- User Segmentation
    CASE 
        WHEN plan_type IN ('Free', 'Basic') THEN 'Individual'
        WHEN plan_type IN ('Pro', 'Business') THEN 'Professional'
        WHEN plan_type = 'Enterprise' THEN 'Enterprise'
        ELSE 'Unknown'
    END AS user_segment,
    
    -- SCD Type 2 Attributes
    load_date AS effective_date,
    LEAD(load_date, 1, '9999-12-31'::DATE) OVER (
        PARTITION BY user_id ORDER BY load_date
    ) AS expiration_date,
    
    CASE 
        WHEN LEAD(load_date, 1) OVER (
            PARTITION BY user_id ORDER BY load_date
        ) IS NULL THEN TRUE
        ELSE FALSE
    END AS is_current,
    
    -- Metadata
    source_system,
    CURRENT_TIMESTAMP AS created_timestamp,
    CURRENT_TIMESTAMP AS updated_timestamp
    
FROM ZOOM_SILVER_SCHEMA.si_users
WHERE email IS NOT NULL
  AND user_name IS NOT NULL;
```

### 7.2 Complete DIM_MEETING Transformation

```sql
CREATE OR REPLACE TABLE ZOOM_GOLD_SCHEMA.dim_meeting AS
SELECT 
    -- Surrogate Key
    ROW_NUMBER() OVER (ORDER BY meeting_id) AS meeting_sk,
    
    -- Natural Key
    meeting_id,
    
    -- Standardized Attributes
    TRIM(meeting_topic) AS meeting_topic,
    duration_minutes,
    start_time,
    end_time,
    
    -- Derived Time Attributes
    DATE(start_time) AS meeting_date,
    EXTRACT(YEAR FROM start_time) AS meeting_year,
    EXTRACT(QUARTER FROM start_time) AS meeting_quarter,
    EXTRACT(MONTH FROM start_time) AS meeting_month,
    EXTRACT(DOW FROM start_time) AS day_of_week,
    EXTRACT(HOUR FROM start_time) AS hour_of_day,
    
    -- Duration Categorization
    CASE 
        WHEN duration_minutes < 15 THEN 'Very Short (< 15 min)'
        WHEN duration_minutes BETWEEN 15 AND 29 THEN 'Short (15-29 min)'
        WHEN duration_minutes BETWEEN 30 AND 59 THEN 'Medium (30-59 min)'
        WHEN duration_minutes BETWEEN 60 AND 119 THEN 'Long (60-119 min)'
        WHEN duration_minutes >= 120 THEN 'Very Long (≥ 120 min)'
        ELSE 'Unknown'
    END AS duration_category,
    
    -- Time Slot Classification
    CASE 
        WHEN EXTRACT(HOUR FROM start_time) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM start_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN EXTRACT(HOUR FROM start_time) BETWEEN 18 AND 22 THEN 'Evening'
        ELSE 'Night'
    END AS time_slot,
    
    -- Business Day Indicator
    CASE 
        WHEN EXTRACT(DOW FROM start_time) BETWEEN 1 AND 5 THEN 'Weekday'
        ELSE 'Weekend'
    END AS business_day_indicator,
    
    -- Meeting Type Classification
    CASE 
        WHEN LOWER(meeting_topic) LIKE '%standup%' OR LOWER(meeting_topic) LIKE '%daily%' THEN 'Daily Standup'
        WHEN LOWER(meeting_topic) LIKE '%review%' OR LOWER(meeting_topic) LIKE '%retrospective%' THEN 'Review Meeting'
        WHEN LOWER(meeting_topic) LIKE '%training%' OR LOWER(meeting_topic) LIKE '%workshop%' THEN 'Training'
        WHEN LOWER(meeting_topic) LIKE '%interview%' THEN 'Interview'
        WHEN LOWER(meeting_topic) LIKE '%1:1%' OR LOWER(meeting_topic) LIKE '%one on one%' THEN 'One-on-One'
        ELSE 'General Meeting'
    END AS meeting_type,
    
    -- Metadata
    source_system,
    CURRENT_TIMESTAMP AS created_timestamp,
    CURRENT_TIMESTAMP AS updated_timestamp
    
FROM ZOOM_SILVER_SCHEMA.si_meetings
WHERE meeting_id IS NOT NULL
  AND start_time IS NOT NULL
  AND end_time IS NOT NULL
  AND duration_minutes > 0;
```

### 7.3 Complete DIM_DATE Transformation

```sql
CREATE OR REPLACE TABLE ZOOM_GOLD_SCHEMA.dim_date AS
WITH date_range AS (
    SELECT 
        DATEADD(DAY, ROW_NUMBER() OVER (ORDER BY NULL) - 1, '2020-01-01'::DATE) AS date_value
    FROM TABLE(GENERATOR(ROWCOUNT => 3653)) -- 10 years of dates
)
SELECT 
    -- Surrogate Key
    TO_NUMBER(TO_CHAR(date_value, 'YYYYMMDD')) AS date_sk,
    
    -- Natural Key
    date_value AS date_key,
    
    -- Date Attributes
    EXTRACT(YEAR FROM date_value) AS year_number,
    EXTRACT(QUARTER FROM date_value) AS quarter_number,
    EXTRACT(MONTH FROM date_value) AS month_number,
    EXTRACT(DAY FROM date_value) AS day_number,
    EXTRACT(DOW FROM date_value) AS day_of_week_number,
    EXTRACT(DOY FROM date_value) AS day_of_year_number,
    EXTRACT(WEEK FROM date_value) AS week_number,
    
    -- Formatted Date Attributes
    TO_CHAR(date_value, 'YYYY') AS year_name,
    TO_CHAR(date_value, 'YYYY-Q') AS quarter_name,
    TO_CHAR(date_value, 'YYYY-MM') AS month_name,
    TO_CHAR(date_value, 'Day') AS day_name,
    TO_CHAR(date_value, 'Month') AS month_full_name,
    
    -- Business Attributes
    CASE 
        WHEN EXTRACT(DOW FROM date_value) IN (0, 6) THEN FALSE
        ELSE TRUE
    END AS is_weekday,
    
    CASE 
        WHEN EXTRACT(DOW FROM date_value) IN (0, 6) THEN TRUE
        ELSE FALSE
    END AS is_weekend,
    
    -- Fiscal Year (assuming April start)
    CASE 
        WHEN EXTRACT(MONTH FROM date_value) >= 4 
        THEN EXTRACT(YEAR FROM date_value)
        ELSE EXTRACT(YEAR FROM date_value) - 1
    END AS fiscal_year,
    
    -- Metadata
    CURRENT_TIMESTAMP AS created_timestamp
    
FROM date_range;
```

## 8. Traceability Matrix

### 8.1 Conceptual Model to Gold Layer Mapping

| Conceptual Entity | Silver Table | Gold Dimension | Key Transformations | Business Rules Applied |
|-------------------|--------------|----------------|--------------------|-----------------------|
| User | si_users | dim_user | Email standardization, SCD Type 2, User segmentation | User hierarchy, Activity status, Plan categorization |
| Meeting | si_meetings | dim_meeting | Duration categorization, Time attributes, Type classification | Meeting efficiency, Time slot analysis, Business day logic |
| Webinar | si_webinars | dim_webinar | Topic categorization, Audience sizing, Performance metrics | Content classification, Registration analysis |
| License | si_licenses | dim_license | Type standardization, Status derivation, SCD Type 2 | License hierarchy, Renewal tracking, Utilization analysis |
| Support Ticket | si_support_tickets | dim_support_ticket | Status standardization, Priority assignment, Aging calculation | SLA tracking, Category analysis, Resolution metrics |
| Feature Usage | si_feature_usage | dim_feature | Feature categorization, Usage classification, Adoption metrics | Feature hierarchy, Usage patterns, Adoption tracking |

### 8.2 Data Constraints to Transformation Rules Mapping

| Constraint Category | Specific Constraint | Transformation Rule | Implementation |
|--------------------|--------------------|--------------------|-----------------|
| Data Completeness | Email format validation | Email standardization with regex validation | REGEXP validation in transformation |
| Data Accuracy | Timestamp precision | UTC standardization with millisecond precision | CONVERT_TIMEZONE function |
| Format Standards | ISO 8601 timestamps | Consistent timestamp formatting | TO_CHAR formatting |
| Consistency Rules | Cross-entity consistency | Foreign key validation in transformations | JOIN validation checks |
| Uniqueness Constraints | User email uniqueness | Duplicate detection and handling | ROW_NUMBER() for deduplication |
| Business Rules | Meeting duration logic | Duration validation and categorization | CASE statements for validation |
| Quality Monitoring | 98% quality metrics | Data quality scoring and monitoring | Quality score calculations |

### 8.3 Silver to Gold Schema Mapping

| Silver Column | Gold Column | Transformation Applied | Data Quality Rule |
|---------------|-------------|----------------------|-------------------|
| si_users.email | dim_user.email | LOWER(TRIM()) + validation | Email format validation |
| si_users.user_name | dim_user.user_name | INITCAP(TRIM()) | Name standardization |
| si_users.plan_type | dim_user.plan_type | CASE statement mapping | Plan type standardization |
| si_meetings.duration_minutes | dim_meeting.duration_category | Duration bucketing | Duration validation (>0, <=1440) |
| si_meetings.start_time | dim_meeting.meeting_date | DATE extraction | Timestamp validation |
| si_webinars.registrants | dim_webinar.audience_size_category | Size categorization | Count validation (>=0) |
| si_licenses.license_type | dim_license.license_tier | Hierarchy mapping | Type standardization |
| si_support_tickets.resolution_status | dim_support_ticket.resolution_status_standardized | Status mapping | Status validation |
| si_feature_usage.feature_name | dim_feature.feature_category | Category classification | Feature name standardization |

### 8.4 KPI Requirements to Dimension Design

| KPI Requirement | Dimension Support | Attributes Provided | Calculation Support |
|-----------------|-------------------|--------------------|-----------------|
| Daily Active Users | dim_user, dim_date | User segments, Activity status | User activity tracking |
| Meeting Completion Rate | dim_meeting | Duration categories, Status | Meeting success metrics |
| License Utilization Rate | dim_license | License tiers, Status | Utilization calculations |
| Feature Adoption Rate | dim_feature | Feature categories, Usage intensity | Adoption trend analysis |
| Support Resolution Time | dim_support_ticket | Priority levels, Age categories | SLA performance tracking |
| User Engagement Duration | dim_user, dim_meeting | User segments, Time slots | Engagement pattern analysis |
| Platform Uptime Percentage | dim_date, dim_meeting | Business day indicators | Availability calculations |
| Customer Satisfaction Score | dim_support_ticket, dim_user | Ticket categories, User tiers | Satisfaction trend analysis |

This comprehensive traceability matrix ensures that all transformation rules are directly linked to their source requirements from the Conceptual Model, Data Constraints, and business KPI needs, providing complete auditability and justification for each transformation decision.