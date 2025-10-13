{{ config(
    materialized='table',
    pre_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, process_start_time, process_status, processed_by) SELECT 'bz_webinars', CURRENT_TIMESTAMP(), 'STARTED', 'dbt_bronze_pipeline' WHERE '{{ this.name }}' != 'bz_audit_log'",
    post_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, process_end_time, process_status, processed_by, records_processed) SELECT 'bz_webinars', CURRENT_TIMESTAMP(), 'COMPLETED', 'dbt_bronze_pipeline', (SELECT COUNT(*) FROM {{ this }}) WHERE '{{ this.name }}' != 'bz_audit_log'"
) }}

/*
    Bronze Layer - Webinars Model
    Purpose: Raw to Bronze transformation for Zoom webinars data
    Source: ZOOM_RAW_SCHEMA.WEBINARS
    Target: ZOOM_BRONZE_SCHEMA.bz_webinars
    Transformation: 1-1 mapping with data quality checks
    Author: Data Engineering Team
    Created: {{ run_started_at }}
*/

WITH source_data AS (
    SELECT 
        -- Business columns from source
        WEBINAR_ID,
        WEBINAR_TOPIC,
        HOST_ID,
        START_TIME,
        END_TIME,
        REGISTRANTS,
        
        -- Audit columns from source
        LOAD_TIMESTAMP,
        UPDATE_TIMESTAMP,
        SOURCE_SYSTEM
        
    FROM {{ source('zoom_raw', 'WEBINARS') }}
),

-- Data quality and validation layer
validated_data AS (
    SELECT 
        -- Apply data quality checks and transformations
        COALESCE(TRIM(WEBINAR_ID), 'UNKNOWN') AS WEBINAR_ID,
        COALESCE(TRIM(WEBINAR_TOPIC), 'NO_TOPIC') AS WEBINAR_TOPIC,
        COALESCE(TRIM(HOST_ID), 'UNKNOWN_HOST') AS HOST_ID,
        START_TIME,
        END_TIME,
        COALESCE(REGISTRANTS, 0) AS REGISTRANTS,
        
        -- Preserve audit columns
        COALESCE(LOAD_TIMESTAMP, CURRENT_TIMESTAMP()) AS LOAD_TIMESTAMP,
        COALESCE(UPDATE_TIMESTAMP, CURRENT_TIMESTAMP()) AS UPDATE_TIMESTAMP,
        COALESCE(TRIM(SOURCE_SYSTEM), 'ZOOM') AS SOURCE_SYSTEM,
        
        -- Add bronze layer audit columns
        CURRENT_TIMESTAMP() AS bronze_created_at,
        CURRENT_TIMESTAMP() AS bronze_updated_at,
        
        -- Data quality flags
        CASE 
            WHEN WEBINAR_ID IS NULL OR TRIM(WEBINAR_ID) = '' THEN 'MISSING_ID'
            WHEN WEBINAR_TOPIC IS NULL OR TRIM(WEBINAR_TOPIC) = '' THEN 'MISSING_TOPIC'
            WHEN HOST_ID IS NULL OR TRIM(HOST_ID) = '' THEN 'MISSING_HOST_ID'
            WHEN START_TIME IS NULL THEN 'MISSING_START_TIME'
            ELSE 'VALID'
        END AS data_quality_status
        
    FROM source_data
)

-- Final select with all transformations applied
SELECT 
    WEBINAR_ID,
    WEBINAR_TOPIC,
    HOST_ID,
    START_TIME,
    END_TIME,
    REGISTRANTS,
    LOAD_TIMESTAMP,
    UPDATE_TIMESTAMP,
    SOURCE_SYSTEM,
    bronze_created_at,
    bronze_updated_at,
    data_quality_status
FROM validated_data