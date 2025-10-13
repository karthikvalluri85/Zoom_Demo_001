{{ config(
    materialized='table',
    pre_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, process_start_time, process_status, processed_by) SELECT 'bz_participants', CURRENT_TIMESTAMP(), 'STARTED', 'dbt_bronze_pipeline' WHERE '{{ this.name }}' != 'bz_audit_log'",
    post_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, process_end_time, process_status, processed_by, records_processed) SELECT 'bz_participants', CURRENT_TIMESTAMP(), 'COMPLETED', 'dbt_bronze_pipeline', (SELECT COUNT(*) FROM {{ this }}) WHERE '{{ this.name }}' != 'bz_audit_log'"
) }}

/*
    Bronze Layer - Participants Model
    Purpose: Raw to Bronze transformation for Zoom participants data
    Source: ZOOM_RAW_SCHEMA.PARTICIPANTS
    Target: ZOOM_BRONZE_SCHEMA.bz_participants
    Transformation: 1-1 mapping with data quality checks
    Author: Data Engineering Team
    Created: {{ run_started_at }}
*/

WITH source_data AS (
    SELECT 
        -- Business columns from source
        PARTICIPANT_ID,
        MEETING_ID,
        USER_ID,
        JOIN_TIME,
        LEAVE_TIME,
        
        -- Audit columns from source
        LOAD_TIMESTAMP,
        UPDATE_TIMESTAMP,
        SOURCE_SYSTEM
        
    FROM {{ source('zoom_raw', 'PARTICIPANTS') }}
),

-- Data quality and validation layer
validated_data AS (
    SELECT 
        -- Apply data quality checks and transformations
        COALESCE(TRIM(PARTICIPANT_ID), 'UNKNOWN') AS PARTICIPANT_ID,
        COALESCE(TRIM(MEETING_ID), 'UNKNOWN_MEETING') AS MEETING_ID,
        COALESCE(TRIM(USER_ID), 'UNKNOWN_USER') AS USER_ID,
        JOIN_TIME,
        LEAVE_TIME,
        
        -- Preserve audit columns
        COALESCE(LOAD_TIMESTAMP, CURRENT_TIMESTAMP()) AS LOAD_TIMESTAMP,
        COALESCE(UPDATE_TIMESTAMP, CURRENT_TIMESTAMP()) AS UPDATE_TIMESTAMP,
        COALESCE(TRIM(SOURCE_SYSTEM), 'ZOOM') AS SOURCE_SYSTEM,
        
        -- Add bronze layer audit columns
        CURRENT_TIMESTAMP() AS bronze_created_at,
        CURRENT_TIMESTAMP() AS bronze_updated_at,
        
        -- Data quality flags
        CASE 
            WHEN PARTICIPANT_ID IS NULL OR TRIM(PARTICIPANT_ID) = '' THEN 'MISSING_ID'
            WHEN MEETING_ID IS NULL OR TRIM(MEETING_ID) = '' THEN 'MISSING_MEETING_ID'
            WHEN USER_ID IS NULL OR TRIM(USER_ID) = '' THEN 'MISSING_USER_ID'
            WHEN JOIN_TIME IS NULL THEN 'MISSING_JOIN_TIME'
            ELSE 'VALID'
        END AS data_quality_status
        
    FROM source_data
)

-- Final select with all transformations applied
SELECT 
    PARTICIPANT_ID,
    MEETING_ID,
    USER_ID,
    JOIN_TIME,
    LEAVE_TIME,
    LOAD_TIMESTAMP,
    UPDATE_TIMESTAMP,
    SOURCE_SYSTEM,
    bronze_created_at,
    bronze_updated_at,
    data_quality_status
FROM validated_data