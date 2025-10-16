{{ config(
    materialized='table',
    pre_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_meetings', CURRENT_TIMESTAMP(), 'DBT_PROCESS', 0, 'STARTED' WHERE '{{ this.name }}' != 'bz_audit_log'",
    post_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_meetings', CURRENT_TIMESTAMP(), 'DBT_PROCESS', DATEDIFF('second', (SELECT MAX(load_timestamp) FROM {{ ref('bz_audit_log') }} WHERE source_table = 'bz_meetings' AND status = 'STARTED'), CURRENT_TIMESTAMP()), 'COMPLETED' WHERE '{{ this.name }}' != 'bz_audit_log'"
) }}

-- Bronze layer transformation for meetings data
-- This model performs 1:1 mapping from raw to bronze layer with data validation

WITH source_data AS (
    SELECT 
        -- Primary identifiers
        MEETING_ID,
        HOST_ID,
        
        -- Meeting details
        MEETING_TOPIC,
        START_TIME,
        END_TIME,
        DURATION_MINUTES,
        
        -- Metadata columns
        LOAD_TIMESTAMP,
        UPDATE_TIMESTAMP,
        SOURCE_SYSTEM
        
    FROM {{ source('zoom_raw', 'MEETINGS') }}
),

validated_data AS (
    SELECT 
        -- Data validation and cleansing
        CASE 
            WHEN MEETING_ID IS NULL OR TRIM(MEETING_ID) = '' THEN 'UNKNOWN_MEETING'
            ELSE TRIM(MEETING_ID)
        END as meeting_id,
        
        CASE 
            WHEN HOST_ID IS NULL OR TRIM(HOST_ID) = '' THEN 'UNKNOWN_HOST'
            ELSE TRIM(HOST_ID)
        END as host_id,
        
        COALESCE(TRIM(MEETING_TOPIC), 'No Topic') as meeting_topic,
        
        -- Timestamp validation
        CASE 
            WHEN START_TIME IS NULL THEN CURRENT_TIMESTAMP()
            ELSE START_TIME
        END as start_time,
        
        CASE 
            WHEN END_TIME IS NULL THEN CURRENT_TIMESTAMP()
            ELSE END_TIME
        END as end_time,
        
        COALESCE(DURATION_MINUTES, 0) as duration_minutes,
        
        -- Metadata with defaults
        COALESCE(LOAD_TIMESTAMP, CURRENT_TIMESTAMP()) as load_timestamp,
        COALESCE(UPDATE_TIMESTAMP, CURRENT_TIMESTAMP()) as update_timestamp,
        COALESCE(TRIM(SOURCE_SYSTEM), 'ZOOM_PLATFORM') as source_system
        
    FROM source_data
)

SELECT 
    meeting_id,
    host_id,
    meeting_topic,
    start_time,
    end_time,
    duration_minutes,
    load_timestamp,
    update_timestamp,
    source_system
FROM validated_data
