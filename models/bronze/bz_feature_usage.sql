{{ config(
    materialized='table',
    pre_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_feature_usage', CURRENT_TIMESTAMP(), 'dbt', 0, 'STARTED' WHERE '{{ this.name }}' != 'bz_audit_log'",
    post_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_feature_usage', CURRENT_TIMESTAMP(), 'dbt', DATEDIFF('second', (SELECT MAX(load_timestamp) FROM {{ ref('bz_audit_log') }} WHERE source_table = 'bz_feature_usage' AND status = 'STARTED'), CURRENT_TIMESTAMP()), 'COMPLETED' WHERE '{{ this.name }}' != 'bz_audit_log'"
) }}

/*
    Bronze Layer - Feature Usage Table
    Purpose: 1-1 mapping from raw FEATURE_USAGE table to bronze bz_feature_usage table
    Transformation: Raw data preservation with data quality checks
    Author: DBT Data Engineer
    Created: {{ run_started_at }}
*/

WITH source_data AS (
    SELECT 
        -- Direct 1-1 mapping from source to bronze
        USAGE_ID,
        MEETING_ID,
        FEATURE_NAME,
        USAGE_DATE,
        USAGE_COUNT,
        LOAD_TIMESTAMP,
        UPDATE_TIMESTAMP,
        SOURCE_SYSTEM,
        
        -- Data quality flags
        CASE 
            WHEN USAGE_ID IS NULL THEN 'MISSING_ID'
            WHEN MEETING_ID IS NULL THEN 'MISSING_MEETING_ID'
            WHEN FEATURE_NAME IS NULL THEN 'MISSING_FEATURE_NAME'
            ELSE 'VALID'
        END AS data_quality_flag
        
    FROM {{ source('zoom_raw', 'feature_usage') }}
),

data_with_audit AS (
    SELECT 
        -- Business columns (1-1 mapping)
        USAGE_ID,
        MEETING_ID,
        FEATURE_NAME,
        USAGE_DATE,
        USAGE_COUNT,
        LOAD_TIMESTAMP,
        UPDATE_TIMESTAMP,
        SOURCE_SYSTEM,
        
        -- Audit and process columns
        CURRENT_TIMESTAMP() AS bronze_load_timestamp,
        'dbt_bronze_pipeline' AS bronze_processed_by,
        data_quality_flag
        
    FROM source_data
)

SELECT 
    USAGE_ID,
    MEETING_ID,
    FEATURE_NAME,
    USAGE_DATE,
    USAGE_COUNT,
    LOAD_TIMESTAMP,
    UPDATE_TIMESTAMP,
    SOURCE_SYSTEM
FROM data_with_audit
-- Include all records, even those with data quality issues for bronze layer
ORDER BY LOAD_TIMESTAMP DESC