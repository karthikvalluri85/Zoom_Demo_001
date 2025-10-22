_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Gold layer Dimension table Data Mapping for Zoom Platform Analytics System
## *Version*: 1
## *Updated on*: 
_____________________________________________

# Gold Layer Dimension Table Data Mapping for Zoom Platform Analytics System

## Overview

This document provides comprehensive data mapping specifications for Gold layer Dimension tables in the Zoom Platform Analytics System. The Gold layer implements a dimensional modeling approach optimized for analytical workloads and business intelligence reporting. All dimension tables are designed using Snowflake-specific features including sequences for surrogate key generation, MERGE INTO statements for SCD Type 2 implementation, and optimized data types for analytical performance.

### Key Design Considerations:
- **Slowly Changing Dimensions (SCD)**: Type 2 implementation for historical tracking with effective dates
- **Surrogate Keys**: Generated using Snowflake sequences for optimal performance
- **Data Quality**: Comprehensive validation and standardization rules applied
- **Business Rules**: Transformation logic aligned with business requirements and KPIs
- **Snowflake Optimization**: Leveraging Snowflake-specific SQL syntax and features

### Transformation Approach:
- Email standardization using LOWER(TRIM()) with regex validation
- Name standardization using INITCAP(TRIM()) for consistent formatting
- Plan type mapping to standardized values (Basic/Pro/Business/Enterprise)
- Duration categorization for analytical grouping
- Feature categorization for enhanced reporting capabilities
- Geographic region mapping for location-based analytics

## Data Mapping for Dimension Tables

### 1. User Dimension (SCD Type 2)

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|--------------------|
| Gold | go_user_dimension | user_sk | Gold | SEQUENCE | user_dimension_seq.NEXTVAL | Surrogate key using Snowflake sequence |
| Gold | go_user_dimension | user_id | Silver | si_users | user_id | Direct mapping with validation: COALESCE(user_id, 'UNKNOWN') |
| Gold | go_user_dimension | email_address | Silver | si_users | email | Email standardization: LOWER(TRIM(email)) with REGEXP validation |
| Gold | go_user_dimension | user_full_name | Silver | si_users | user_name | Name standardization: INITCAP(TRIM(user_name)) |
| Gold | go_user_dimension | plan_type_code | Silver | si_users | plan_type | Plan type mapping: CASE WHEN UPPER(plan_type) IN ('BASIC','FREE') THEN 'BASIC' WHEN UPPER(plan_type) IN ('PRO','PROFESSIONAL') THEN 'PRO' WHEN UPPER(plan_type) IN ('BUSINESS','BIZ') THEN 'BUSINESS' WHEN UPPER(plan_type) IN ('ENTERPRISE','ENT') THEN 'ENTERPRISE' ELSE 'OTHER' END |
| Gold | go_user_dimension | company_name | Silver | si_users | company | Company standardization: INITCAP(TRIM(COALESCE(company, 'Not Specified'))) |
| Gold | go_user_dimension | user_segment | Silver | si_users | plan_type | User segmentation: CASE WHEN UPPER(plan_type) IN ('BASIC','FREE') THEN 'Individual' WHEN UPPER(plan_type) = 'PRO' THEN 'Professional' ELSE 'Enterprise' END |
| Gold | go_user_dimension | email_domain | Silver | si_users | email | Email domain extraction: UPPER(SUBSTRING(email, POSITION('@' IN email) + 1)) |
| Gold | go_user_dimension | is_business_user | Silver | si_users | company | Business user flag: CASE WHEN company IS NOT NULL AND TRIM(company) != '' THEN TRUE ELSE FALSE END |
| Gold | go_user_dimension | effective_start_date | Silver | si_users | load_date | SCD Type 2: COALESCE(load_date, CURRENT_DATE()) |
| Gold | go_user_dimension | effective_end_date | Gold | Derived | NULL | SCD Type 2: NULL for current records, updated during MERGE |
| Gold | go_user_dimension | is_current | Gold | Derived | TRUE | SCD Type 2: TRUE for current records, FALSE for historical |
| Gold | go_user_dimension | created_timestamp | Silver | si_users | load_date | Record creation: CURRENT_TIMESTAMP() |
| Gold | go_user_dimension | updated_timestamp | Silver | si_users | update_date | Record update: COALESCE(update_date, CURRENT_TIMESTAMP()) |

### 2. Account Dimension (SCD Type 2)

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|--------------------|
| Gold | go_account_dimension | account_sk | Gold | SEQUENCE | account_dimension_seq.NEXTVAL | Surrogate key using Snowflake sequence |
| Gold | go_account_dimension | account_id | Silver | si_users | company | Account ID derivation: MD5(UPPER(TRIM(COALESCE(company, 'INDIVIDUAL')))) |
| Gold | go_account_dimension | account_name | Silver | si_users | company | Account name: INITCAP(TRIM(COALESCE(company, 'Individual Account'))) |
| Gold | go_account_dimension | account_type | Silver | si_users | plan_type | Account type mapping: CASE WHEN UPPER(plan_type) IN ('BASIC','FREE') THEN 'Individual' WHEN UPPER(plan_type) = 'PRO' THEN 'Professional' WHEN UPPER(plan_type) = 'BUSINESS' THEN 'Small Business' ELSE 'Enterprise' END |
| Gold | go_account_dimension | user_count | Silver | si_users | company | User count per account: COUNT(*) OVER (PARTITION BY UPPER(TRIM(COALESCE(company, 'INDIVIDUAL')))) |
| Gold | go_account_dimension | primary_domain | Silver | si_users | email | Primary domain: MODE() OVER (PARTITION BY company ORDER BY SUBSTRING(email, POSITION('@' IN email) + 1)) |
| Gold | go_account_dimension | account_status | Silver | si_users | plan_type | Account status: CASE WHEN plan_type IS NOT NULL THEN 'Active' ELSE 'Inactive' END |
| Gold | go_account_dimension | is_enterprise | Silver | si_users | plan_type | Enterprise flag: CASE WHEN UPPER(plan_type) IN ('BUSINESS','ENTERPRISE') THEN TRUE ELSE FALSE END |
| Gold | go_account_dimension | effective_start_date | Silver | si_users | load_date | SCD Type 2: MIN(load_date) OVER (PARTITION BY company) |
| Gold | go_account_dimension | effective_end_date | Gold | Derived | NULL | SCD Type 2: NULL for current records |
| Gold | go_account_dimension | is_current | Gold | Derived | TRUE | SCD Type 2: TRUE for current records |
| Gold | go_account_dimension | created_timestamp | Gold | Derived | CURRENT_TIMESTAMP() | Record creation timestamp |
| Gold | go_account_dimension | updated_timestamp | Gold | Derived | CURRENT_TIMESTAMP() | Record update timestamp |

### 3. Time Dimension (SCD Type 1)

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|--------------------|
| Gold | go_time_dimension | time_sk | Gold | SEQUENCE | time_dimension_seq.NEXTVAL | Surrogate key using Snowflake sequence |
| Gold | go_time_dimension | date_key | Gold | Derived | DATE_RANGE | Date key: TO_NUMBER(TO_CHAR(date_value, 'YYYYMMDD')) |
| Gold | go_time_dimension | full_date | Gold | Derived | DATE_RANGE | Full date: Generated date value |
| Gold | go_time_dimension | day_of_week | Gold | Derived | DATE_RANGE | Day of week: DAYOFWEEK(date_value) |
| Gold | go_time_dimension | day_name | Gold | Derived | DATE_RANGE | Day name: DAYNAME(date_value) |
| Gold | go_time_dimension | day_of_month | Gold | Derived | DATE_RANGE | Day of month: DAY(date_value) |
| Gold | go_time_dimension | day_of_year | Gold | Derived | DATE_RANGE | Day of year: DAYOFYEAR(date_value) |
| Gold | go_time_dimension | week_of_year | Gold | Derived | DATE_RANGE | Week of year: WEEKOFYEAR(date_value) |
| Gold | go_time_dimension | month_number | Gold | Derived | DATE_RANGE | Month number: MONTH(date_value) |
| Gold | go_time_dimension | month_name | Gold | Derived | DATE_RANGE | Month name: MONTHNAME(date_value) |
| Gold | go_time_dimension | quarter_number | Gold | Derived | DATE_RANGE | Quarter: QUARTER(date_value) |
| Gold | go_time_dimension | quarter_name | Gold | Derived | DATE_RANGE | Quarter name: 'Q' || QUARTER(date_value) |
| Gold | go_time_dimension | year_number | Gold | Derived | DATE_RANGE | Year: YEAR(date_value) |
| Gold | go_time_dimension | is_weekend | Gold | Derived | DATE_RANGE | Weekend flag: CASE WHEN DAYOFWEEK(date_value) IN (1,7) THEN TRUE ELSE FALSE END |
| Gold | go_time_dimension | is_holiday | Gold | Derived | HOLIDAY_CALENDAR | Holiday flag: Based on predefined holiday calendar |
| Gold | go_time_dimension | fiscal_year | Gold | Derived | DATE_RANGE | Fiscal year: CASE WHEN MONTH(date_value) >= 4 THEN YEAR(date_value) ELSE YEAR(date_value) - 1 END |
| Gold | go_time_dimension | fiscal_quarter | Gold | Derived | DATE_RANGE | Fiscal quarter: CASE WHEN MONTH(date_value) IN (4,5,6) THEN 1 WHEN MONTH(date_value) IN (7,8,9) THEN 2 WHEN MONTH(date_value) IN (10,11,12) THEN 3 ELSE 4 END |

### 4. License Dimension (SCD Type 2)

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|--------------------|
| Gold | go_license_dimension | license_sk | Gold | SEQUENCE | license_dimension_seq.NEXTVAL | Surrogate key using Snowflake sequence |
| Gold | go_license_dimension | license_id | Silver | si_licenses | license_id | Direct mapping: COALESCE(license_id, UUID_STRING()) |
| Gold | go_license_dimension | license_type_code | Silver | si_licenses | license_type | License type standardization: UPPER(TRIM(COALESCE(license_type, 'UNKNOWN'))) |
| Gold | go_license_dimension | license_type_name | Silver | si_licenses | license_type | License type name: CASE WHEN UPPER(license_type) = 'BASIC' THEN 'Basic Plan' WHEN UPPER(license_type) = 'PRO' THEN 'Professional Plan' WHEN UPPER(license_type) = 'BUSINESS' THEN 'Business Plan' WHEN UPPER(license_type) = 'ENTERPRISE' THEN 'Enterprise Plan' ELSE 'Other Plan' END |
| Gold | go_license_dimension | license_start_date | Silver | si_licenses | start_date | License start: COALESCE(start_date, '1900-01-01') |
| Gold | go_license_dimension | license_end_date | Silver | si_licenses | end_date | License end: COALESCE(end_date, '2099-12-31') |
| Gold | go_license_dimension | license_status | Silver | si_licenses | start_date, end_date | License status: CASE WHEN CURRENT_DATE() < start_date THEN 'Future' WHEN CURRENT_DATE() > end_date THEN 'Expired' WHEN DATEDIFF('day', CURRENT_DATE(), end_date) <= 30 THEN 'Expiring Soon' ELSE 'Active' END |
| Gold | go_license_dimension | license_duration_days | Silver | si_licenses | start_date, end_date | Duration calculation: DATEDIFF('day', start_date, end_date) |
| Gold | go_license_dimension | is_active | Silver | si_licenses | start_date, end_date | Active flag: CASE WHEN CURRENT_DATE() BETWEEN start_date AND end_date THEN TRUE ELSE FALSE END |
| Gold | go_license_dimension | effective_start_date | Silver | si_licenses | load_date | SCD Type 2: COALESCE(load_date, CURRENT_DATE()) |
| Gold | go_license_dimension | effective_end_date | Gold | Derived | NULL | SCD Type 2: NULL for current records |
| Gold | go_license_dimension | is_current | Gold | Derived | TRUE | SCD Type 2: TRUE for current records |
| Gold | go_license_dimension | created_timestamp | Gold | Derived | CURRENT_TIMESTAMP() | Record creation timestamp |
| Gold | go_license_dimension | updated_timestamp | Silver | si_licenses | update_date | Record update timestamp |

### 5. Meeting Types Dimension

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|--------------------|
| Gold | go_meeting_types | meeting_type_sk | Gold | SEQUENCE | meeting_type_seq.NEXTVAL | Surrogate key using Snowflake sequence |
| Gold | go_meeting_types | meeting_type_code | Silver | si_meetings | meeting_topic | Meeting type classification: CASE WHEN UPPER(meeting_topic) LIKE '%STANDUP%' OR UPPER(meeting_topic) LIKE '%DAILY%' THEN 'STANDUP' WHEN UPPER(meeting_topic) LIKE '%REVIEW%' OR UPPER(meeting_topic) LIKE '%RETROSPECTIVE%' THEN 'REVIEW' WHEN UPPER(meeting_topic) LIKE '%TRAINING%' OR UPPER(meeting_topic) LIKE '%WORKSHOP%' THEN 'TRAINING' WHEN UPPER(meeting_topic) LIKE '%INTERVIEW%' THEN 'INTERVIEW' WHEN UPPER(meeting_topic) LIKE '%DEMO%' OR UPPER(meeting_topic) LIKE '%PRESENTATION%' THEN 'PRESENTATION' ELSE 'GENERAL' END |
| Gold | go_meeting_types | meeting_type_name | Gold | Derived | meeting_type_code | Meeting type name: CASE WHEN meeting_type_code = 'STANDUP' THEN 'Daily Standup' WHEN meeting_type_code = 'REVIEW' THEN 'Review Meeting' WHEN meeting_type_code = 'TRAINING' THEN 'Training Session' WHEN meeting_type_code = 'INTERVIEW' THEN 'Interview' WHEN meeting_type_code = 'PRESENTATION' THEN 'Presentation/Demo' ELSE 'General Meeting' END |
| Gold | go_meeting_types | meeting_category | Gold | Derived | meeting_type_code | Meeting category: CASE WHEN meeting_type_code IN ('STANDUP','REVIEW') THEN 'Operational' WHEN meeting_type_code IN ('TRAINING','PRESENTATION') THEN 'Educational' WHEN meeting_type_code = 'INTERVIEW' THEN 'HR' ELSE 'General' END |
| Gold | go_meeting_types | duration_category | Silver | si_meetings | duration_minutes | Duration category: CASE WHEN duration_minutes < 30 THEN 'Short' WHEN duration_minutes BETWEEN 30 AND 60 THEN 'Medium' WHEN duration_minutes BETWEEN 61 AND 120 THEN 'Long' ELSE 'Extended' END |
| Gold | go_meeting_types | typical_duration_minutes | Gold | Derived | meeting_type_code | Typical duration: CASE WHEN meeting_type_code = 'STANDUP' THEN 15 WHEN meeting_type_code = 'REVIEW' THEN 60 WHEN meeting_type_code = 'TRAINING' THEN 120 WHEN meeting_type_code = 'INTERVIEW' THEN 45 WHEN meeting_type_code = 'PRESENTATION' THEN 90 ELSE 60 END |
| Gold | go_meeting_types | is_recurring_typical | Gold | Derived | meeting_type_code | Recurring flag: CASE WHEN meeting_type_code IN ('STANDUP','REVIEW') THEN TRUE ELSE FALSE END |
| Gold | go_meeting_types | created_timestamp | Gold | Derived | CURRENT_TIMESTAMP() | Record creation timestamp |
| Gold | go_meeting_types | updated_timestamp | Gold | Derived | CURRENT_TIMESTAMP() | Record update timestamp |

### 6. Feature Categories Dimension

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|--------------------|
| Gold | go_feature_categories | feature_category_sk | Gold | SEQUENCE | feature_category_seq.NEXTVAL | Surrogate key using Snowflake sequence |
| Gold | go_feature_categories | feature_name | Silver | si_feature_usage | feature_name | Feature name standardization: UPPER(TRIM(COALESCE(feature_name, 'UNKNOWN'))) |
| Gold | go_feature_categories | feature_category_code | Silver | si_feature_usage | feature_name | Feature categorization: CASE WHEN UPPER(feature_name) LIKE '%VIDEO%' OR UPPER(feature_name) LIKE '%CAMERA%' THEN 'VIDEO' WHEN UPPER(feature_name) LIKE '%AUDIO%' OR UPPER(feature_name) LIKE '%MIC%' OR UPPER(feature_name) LIKE '%SOUND%' THEN 'AUDIO' WHEN UPPER(feature_name) LIKE '%SCREEN%' OR UPPER(feature_name) LIKE '%SHARE%' THEN 'SCREEN_SHARING' WHEN UPPER(feature_name) LIKE '%CHAT%' OR UPPER(feature_name) LIKE '%MESSAGE%' THEN 'CHAT' WHEN UPPER(feature_name) LIKE '%RECORD%' THEN 'RECORDING' WHEN UPPER(feature_name) LIKE '%POLL%' OR UPPER(feature_name) LIKE '%SURVEY%' THEN 'ENGAGEMENT' WHEN UPPER(feature_name) LIKE '%BREAKOUT%' OR UPPER(feature_name) LIKE '%ROOM%' THEN 'COLLABORATION' ELSE 'OTHER' END |
| Gold | go_feature_categories | feature_category_name | Gold | Derived | feature_category_code | Category name: CASE WHEN feature_category_code = 'VIDEO' THEN 'Video Features' WHEN feature_category_code = 'AUDIO' THEN 'Audio Features' WHEN feature_category_code = 'SCREEN_SHARING' THEN 'Screen Sharing' WHEN feature_category_code = 'CHAT' THEN 'Chat & Messaging' WHEN feature_category_code = 'RECORDING' THEN 'Recording Features' WHEN feature_category_code = 'ENGAGEMENT' THEN 'Engagement Tools' WHEN feature_category_code = 'COLLABORATION' THEN 'Collaboration Tools' ELSE 'Other Features' END |
| Gold | go_feature_categories | feature_type | Gold | Derived | feature_category_code | Feature type: CASE WHEN feature_category_code IN ('VIDEO','AUDIO') THEN 'Core' WHEN feature_category_code IN ('SCREEN_SHARING','CHAT') THEN 'Communication' WHEN feature_category_code IN ('RECORDING','ENGAGEMENT','COLLABORATION') THEN 'Advanced' ELSE 'Utility' END |
| Gold | go_feature_categories | is_premium_feature | Gold | Derived | feature_category_code | Premium flag: CASE WHEN feature_category_code IN ('RECORDING','ENGAGEMENT','COLLABORATION') THEN TRUE ELSE FALSE END |
| Gold | go_feature_categories | feature_priority | Gold | Derived | feature_category_code | Priority ranking: CASE WHEN feature_category_code IN ('VIDEO','AUDIO') THEN 1 WHEN feature_category_code IN ('SCREEN_SHARING','CHAT') THEN 2 WHEN feature_category_code IN ('RECORDING','ENGAGEMENT') THEN 3 ELSE 4 END |
| Gold | go_feature_categories | created_timestamp | Gold | Derived | CURRENT_TIMESTAMP() | Record creation timestamp |
| Gold | go_feature_categories | updated_timestamp | Silver | si_feature_usage | update_date | Record update timestamp |

### 7. Geographic Regions Dimension

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|--------------------|
| Gold | go_geographic_regions | region_sk | Gold | SEQUENCE | geographic_region_seq.NEXTVAL | Surrogate key using Snowflake sequence |
| Gold | go_geographic_regions | region_code | Silver | si_users | email | Region derivation from email domain: CASE WHEN UPPER(email) LIKE '%.COM' THEN 'NA' WHEN UPPER(email) LIKE '%.UK' OR UPPER(email) LIKE '%.EU' THEN 'EMEA' WHEN UPPER(email) LIKE '%.JP' OR UPPER(email) LIKE '%.CN' OR UPPER(email) LIKE '%.IN' THEN 'APAC' WHEN UPPER(email) LIKE '%.AU' OR UPPER(email) LIKE '%.NZ' THEN 'APAC' WHEN UPPER(email) LIKE '%.BR' OR UPPER(email) LIKE '%.MX' THEN 'LATAM' ELSE 'OTHER' END |
| Gold | go_geographic_regions | region_name | Gold | Derived | region_code | Region name: CASE WHEN region_code = 'NA' THEN 'North America' WHEN region_code = 'EMEA' THEN 'Europe, Middle East & Africa' WHEN region_code = 'APAC' THEN 'Asia Pacific' WHEN region_code = 'LATAM' THEN 'Latin America' ELSE 'Other Regions' END |
| Gold | go_geographic_regions | country_code | Silver | si_users | email | Country code derivation: UPPER(RIGHT(SUBSTRING(email, POSITION('@' IN email) + 1), 2)) |
| Gold | go_geographic_regions | time_zone_offset | Gold | Derived | region_code | Time zone offset: CASE WHEN region_code = 'NA' THEN -5 WHEN region_code = 'EMEA' THEN 0 WHEN region_code = 'APAC' THEN 8 WHEN region_code = 'LATAM' THEN -3 ELSE 0 END |
| Gold | go_geographic_regions | business_hours_start | Gold | Derived | region_code | Business hours start: CASE WHEN region_code = 'NA' THEN '09:00' WHEN region_code = 'EMEA' THEN '08:00' WHEN region_code = 'APAC' THEN '09:00' WHEN region_code = 'LATAM' THEN '08:00' ELSE '09:00' END |
| Gold | go_geographic_regions | business_hours_end | Gold | Derived | region_code | Business hours end: CASE WHEN region_code = 'NA' THEN '17:00' WHEN region_code = 'EMEA' THEN '17:00' WHEN region_code = 'APAC' THEN '18:00' WHEN region_code = 'LATAM' THEN '17:00' ELSE '17:00' END |
| Gold | go_geographic_regions | is_primary_market | Gold | Derived | region_code | Primary market flag: CASE WHEN region_code IN ('NA','EMEA','APAC') THEN TRUE ELSE FALSE END |
| Gold | go_geographic_regions | created_timestamp | Gold | Derived | CURRENT_TIMESTAMP() | Record creation timestamp |
| Gold | go_geographic_regions | updated_timestamp | Gold | Derived | CURRENT_TIMESTAMP() | Record update timestamp |

## Complex Transformation Explanations

### 1. SCD Type 2 Implementation
The Slowly Changing Dimension Type 2 implementation uses Snowflake's MERGE INTO statement to handle historical tracking:

```sql
MERGE INTO go_user_dimension AS target
USING (
    SELECT 
        user_id,
        LOWER(TRIM(email)) AS email_address,
        INITCAP(TRIM(user_name)) AS user_full_name,
        -- other transformed fields
        CURRENT_DATE() AS effective_start_date,
        TRUE AS is_current
    FROM si_users
) AS source
ON target.user_id = source.user_id AND target.is_current = TRUE
WHEN MATCHED AND (
    target.email_address != source.email_address OR
    target.user_full_name != source.user_full_name
    -- other change detection conditions
) THEN UPDATE SET
    effective_end_date = CURRENT_DATE() - 1,
    is_current = FALSE,
    updated_timestamp = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT (
    user_sk, user_id, email_address, user_full_name,
    effective_start_date, effective_end_date, is_current,
    created_timestamp, updated_timestamp
) VALUES (
    user_dimension_seq.NEXTVAL, source.user_id, source.email_address,
    source.user_full_name, source.effective_start_date, NULL, TRUE,
    CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()
);
```

### 2. Email Domain Analysis
Email domain extraction and geographic region mapping supports location-based analytics:

```sql
SELECT 
    email,
    UPPER(SUBSTRING(email, POSITION('@' IN email) + 1)) AS email_domain,
    CASE 
        WHEN UPPER(email) LIKE '%.COM' THEN 'NA'
        WHEN UPPER(email) LIKE '%.UK' OR UPPER(email) LIKE '%.EU' THEN 'EMEA'
        WHEN UPPER(email) LIKE '%.JP' OR UPPER(email) LIKE '%.CN' THEN 'APAC'
        ELSE 'OTHER'
    END AS region_code
FROM si_users;
```

### 3. Feature Categorization Logic
Advanced pattern matching for feature categorization supports detailed usage analytics:

```sql
SELECT 
    feature_name,
    CASE 
        WHEN UPPER(feature_name) LIKE '%VIDEO%' OR UPPER(feature_name) LIKE '%CAMERA%' THEN 'VIDEO'
        WHEN UPPER(feature_name) LIKE '%AUDIO%' OR UPPER(feature_name) LIKE '%MIC%' THEN 'AUDIO'
        WHEN UPPER(feature_name) LIKE '%SCREEN%' OR UPPER(feature_name) LIKE '%SHARE%' THEN 'SCREEN_SHARING'
        WHEN UPPER(feature_name) LIKE '%CHAT%' OR UPPER(feature_name) LIKE '%MESSAGE%' THEN 'CHAT'
        WHEN UPPER(feature_name) LIKE '%RECORD%' THEN 'RECORDING'
        ELSE 'OTHER'
    END AS feature_category_code
FROM si_feature_usage;
```

### 4. License Status Derivation
Dynamic license status calculation based on current date and license validity period:

```sql
SELECT 
    license_id,
    start_date,
    end_date,
    CASE 
        WHEN CURRENT_DATE() < start_date THEN 'Future'
        WHEN CURRENT_DATE() > end_date THEN 'Expired'
        WHEN DATEDIFF('day', CURRENT_DATE(), end_date) <= 30 THEN 'Expiring Soon'
        ELSE 'Active'
    END AS license_status
FROM si_licenses;
```

## KPI Support Alignment

The dimension table mappings directly support the following key KPIs:

1. **User Engagement Metrics**: User dimension with segmentation and plan type analysis
2. **Meeting Performance**: Meeting types dimension with duration categorization
3. **Feature Adoption**: Feature categories dimension with premium feature identification
4. **Geographic Analysis**: Geographic regions dimension with time zone and market classification
5. **License Utilization**: License dimension with status tracking and duration analysis
6. **Account Growth**: Account dimension with user count and enterprise classification
7. **Temporal Analysis**: Time dimension with comprehensive date attributes for trending

This comprehensive mapping ensures that all Gold layer dimension tables provide the necessary attributes and transformations to support advanced analytics, reporting, and business intelligence requirements for the Zoom Platform Analytics System.