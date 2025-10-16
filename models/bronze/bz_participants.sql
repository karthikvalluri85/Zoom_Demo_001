{{ config(
    materialized='table',
    pre_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_participants', CURRENT_TIMESTAMP(), 'DBT_PROCESS', 0, 'STARTED' WHERE '{{ this.name }}' != 'bz_audit_log'",
    post_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_participants', CURRENT_TIMESTAMP(), 'DBT_PROCESS', DATEDIFF('second', (SELECT MAX(load_timestamp) FROM {{ ref('bz_audit_log') }} WHERE source_table = 'bz_participants' AND status = 'STARTED'), CURRENT_TIMESTAMP()), 'COMPLETED' WHERE '{{ this.name }}' != 'bz_audit_log'"
) }}

-- Bronze layer transformation for participants data
-- This model performs 1:1 mapping from raw to bronze layer with data validation

WITH source_data AS (
    SELECT 
        -- Primary identifiers
        PARTICIPANT_ID,
        MEETING_ID,
        USER_ID,
        
        -- Participation details
        JOIN_TIME,
        LEAVE_TIME,
        
        -- Metadata columns
        LOAD_TIMESTAMP,
        UPDATE_TIMESTAMP,
        SOURCE_SYSTEM
        
    FROM {{ source('zoom_raw', 'PARTICIPANTS') }}
),

validated_data AS (
    SELECT 
        -- Data validation and cleansing
        CASE 
            WHEN PARTICIPANT_ID IS NULL OR TRIM(PARTICIPANT_ID) = '' THEN 'UNKNOWN_PARTICIPANT'
            ELSE TRIM(PARTICIPANT_ID)
        END as participant_id,
        
        CASE 
            WHEN MEETING_ID IS NULL OR TRIM(MEETING_ID) = '' THEN 'UNKNOWN_MEETING'
            ELSE TRIM(MEETING_ID)
        END as meeting_id,
        
        CASE 
            WHEN USER_ID IS NULL OR TRIM(USER_ID) = '' THEN 'UNKNOWN_USER'
            ELSE TRIM(USER_ID)
        END as user_id,
        
        -- Timestamp validation
        CASE 
            WHEN JOIN_TIME IS NULL THEN CURRENT_TIMESTAMP()
            ELSE JOIN_TIME
        END as join_time,
        
        CASE 
            WHEN LEAVE_TIME IS NULL THEN CURRENT_TIMESTAMP()
            ELSE LEAVE_TIME
        END as leave_time,
        
        -- Metadata with defaults
        COALESCE(LOAD_TIMESTAMP, CURRENT_TIMESTAMP()) as load_timestamp,
        COALESCE(UPDATE_TIMESTAMP, CURRENT_TIMESTAMP()) as update_timestamp,
        COALESCE(TRIM(SOURCE_SYSTEM), 'ZOOM_PLATFORM') as source_system
        
    FROM source_data
)

SELECT 
    participant_id,
    meeting_id,
    user_id,
    join_time,
    leave_time,
    load_timestamp,
    update_timestamp,
    source_system
FROM validated_data
