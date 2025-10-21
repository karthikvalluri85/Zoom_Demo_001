{{
  config(
    materialized='table',
    pre_hook="{% if this.name != 'bz_audit_log' %}INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) VALUES ('bz_participants', CURRENT_TIMESTAMP(), 'DBT_BRONZE_PIPELINE', 0, 'STARTED'){% endif %}",
    post_hook="{% if this.name != 'bz_audit_log' %}INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) VALUES ('bz_participants', CURRENT_TIMESTAMP(), 'DBT_BRONZE_PIPELINE', DATEDIFF('millisecond', (SELECT MAX(load_timestamp) FROM {{ ref('bz_audit_log') }} WHERE source_table = 'bz_participants' AND status = 'STARTED'), CURRENT_TIMESTAMP()), 'SUCCESS'){% endif %}"
  )
}}

-- Bronze Layer Participants Model
-- Purpose: 1:1 mapping from raw participants data to bronze layer with audit information
-- Source: ZOOM_RAW_SCHEMA.PARTICIPANTS
-- Target: ZOOM_BRONZE_SCHEMA.BZ_PARTICIPANTS

WITH source_participants AS (
    SELECT 
        -- Business attributes - direct 1:1 mapping from source
        leave_time,
        join_time,
        participant_id,
        meeting_id,
        user_id,
        
        -- Metadata columns - preserved from source
        source_system,
        load_timestamp,
        update_timestamp
        
    FROM {{ source('zoom_raw', 'participants') }}
    
    -- Data quality filter - exclude records with null participant_id (business key)
    WHERE participant_id IS NOT NULL
),

final_participants AS (
    SELECT 
        -- Business columns
        leave_time,
        join_time,
        participant_id,
        meeting_id,
        user_id,
        
        -- Audit and metadata columns
        load_timestamp,
        update_timestamp,
        source_system
        
    FROM source_participants
)

SELECT * FROM final_participants

-- Model documentation
-- This model performs a 1:1 transformation from raw participants data to bronze layer
-- Includes data quality filtering and preserves all source metadata
