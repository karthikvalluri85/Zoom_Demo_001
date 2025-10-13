{{ config(
    materialized='table',
    pre_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_webinars', CURRENT_TIMESTAMP(), 'dbt', 0, 'STARTED' WHERE '{{ this.name }}' != 'bz_audit_log'",
    post_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_webinars', CURRENT_TIMESTAMP(), 'dbt', DATEDIFF('second', (SELECT MAX(load_timestamp) FROM {{ ref('bz_audit_log') }} WHERE source_table = 'bz_webinars' AND status = 'STARTED'), CURRENT_TIMESTAMP()), 'COMPLETED' WHERE '{{ this.name }}' != 'bz_audit_log'"
) }}

/*
    Bronze Layer - Webinars Table
    Purpose: 1-1 mapping from raw WEBINARS table to bronze bz_webinars table
    Transformation: Raw data preservation with data quality checks
    Author: DBT Data Engineer
    Created: {{ run_started_at }}
*/

WITH source_data AS (
    SELECT 
        -- Direct 1-1 mapping from source to bronze
        WEBINAR_ID,
        WEBINAR_TOPIC,
        HOST_ID,
        START_TIME,
        END_TIME,
        REGISTRANTS,
        LOAD_TIMESTAMP,
        UPDATE_TIMESTAMP,
        SOURCE_SYSTEM,
        
        -- Data quality flags
        CASE 
            WHEN WEBINAR_ID IS NULL THEN 'MISSING_ID'
            WHEN HOST_ID IS NULL THEN 'MISSING_HOST_ID'
            WHEN WEBINAR_TOPIC IS NULL THEN 'MISSING_TOPIC'
            ELSE 'VALID'
        END AS data_quality_flag
        
    FROM {{ source('zoom_raw', 'webinars') }}
),

data_with_audit AS (
    SELECT 
        -- Business columns (1-1 mapping)
        WEBINAR_ID,
        WEBINAR_TOPIC,
        HOST_ID,
        START_TIME,
        END_TIME,
        REGISTRANTS,
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
    WEBINAR_ID,
    WEBINAR_TOPIC,
    HOST_ID,
    START_TIME,
    END_TIME,
    REGISTRANTS,
    LOAD_TIMESTAMP,
    UPDATE_TIMESTAMP,
    SOURCE_SYSTEM
FROM data_with_audit
-- Include all records, even those with data quality issues for bronze layer
ORDER BY LOAD_TIMESTAMP DESC