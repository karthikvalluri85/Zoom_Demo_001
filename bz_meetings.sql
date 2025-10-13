{{ config(
    materialized='table',
    pre_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, process_start_time, process_status, processed_by) SELECT 'bz_meetings', CURRENT_TIMESTAMP(), 'STARTED', 'dbt_bronze_pipeline' WHERE '{{ this.name }}' != 'bz_audit_log'",
    post_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, process_end_time, process_status, processed_by, records_processed) SELECT 'bz_meetings', CURRENT_TIMESTAMP(), 'COMPLETED', 'dbt_bronze_pipeline', (SELECT COUNT(*) FROM {{ this }}) WHERE '{{ this.name }}' != 'bz_audit_log'"
) }}

/*
    Bronze Layer - Meetings Model
    Purpose: Raw to Bronze transformation for Zoom meetings data
    Source: ZOOM_RAW_SCHEMA.MEETINGS
    Target: ZOOM_BRONZE_SCHEMA.bz_meetings
    Transformation: 1-1 mapping with data quality checks
    Author: Data Engineering Team
    Created: {{ run_started_at }}
*/

WITH source_data AS (
    SELECT 
        -- Business columns from source
        MEETING_ID,
        MEETING_TOPIC,
        HOST_ID,
        START_TIME,
        END_TIME,
        DURATION_MINUTES,
        
        -- Audit columns from source
        LOAD_TIMESTAMP,
        UPDATE_TIMESTAMP,
        SOURCE_SYSTEM
        
    FROM {{ source('zoom_raw', 'MEETINGS') }}
),

-- Data quality and validation layer
validated_data AS (
    SELECT 
        -- Apply data quality checks and transformations
        COALESCE(TRIM(MEETING_ID), 'UNKNOWN') AS MEETING_ID,
        COALESCE(TRIM(MEETING_TOPIC), 'NO_TOPIC') AS MEETING_TOPIC,
        COALESCE(TRIM(HOST_ID), 'UNKNOWN_HOST') AS HOST_ID,
        START_TIME,
        END_TIME,
        COALESCE(DURATION_MINUTES, 0) AS DURATION_MINUTES,
        
        -- Preserve audit columns
        COALESCE(LOAD_TIMESTAMP, CURRENT_TIMESTAMP()) AS LOAD_TIMESTAMP,
        COALESCE(UPDATE_TIMESTAMP, CURRENT_TIMESTAMP()) AS UPDATE_TIMESTAMP,
        COALESCE(TRIM(SOURCE_SYSTEM), 'ZOOM') AS SOURCE_SYSTEM,
        
        -- Add bronze layer audit columns
        CURRENT_TIMESTAMP() AS bronze_created_at,
        CURRENT_TIMESTAMP() AS bronze_updated_at,
        
        -- Data quality flags
        CASE 
            WHEN MEETING_ID IS NULL OR TRIM(MEETING_ID) = '' THEN 'MISSING_ID'
            WHEN START_TIME IS NULL THEN 'MISSING_START_TIME'
            WHEN END_TIME IS NULL THEN 'MISSING_END_TIME'
            ELSE 'VALID'
        END AS data_quality_status
        
    FROM source_data
)

-- Final select with all transformations applied
SELECT 
    MEETING_ID,
    MEETING_TOPIC,
    HOST_ID,
    START_TIME,
    END_TIME,
    DURATION_MINUTES,
    LOAD_TIMESTAMP,
    UPDATE_TIMESTAMP,
    SOURCE_SYSTEM,
    bronze_created_at,
    bronze_updated_at,
    data_quality_status
FROM validated_data
