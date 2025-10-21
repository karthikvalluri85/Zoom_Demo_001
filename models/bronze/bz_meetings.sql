{{
  config(
    materialized='table',
    pre_hook="{% if this.name != 'bz_audit_log' %}INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) VALUES ('bz_meetings', CURRENT_TIMESTAMP(), 'DBT_BRONZE_PIPELINE', 0, 'STARTED'){% endif %}",
    post_hook="{% if this.name != 'bz_audit_log' %}INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) VALUES ('bz_meetings', CURRENT_TIMESTAMP(), 'DBT_BRONZE_PIPELINE', DATEDIFF('millisecond', (SELECT MAX(load_timestamp) FROM {{ ref('bz_audit_log') }} WHERE source_table = 'bz_meetings' AND status = 'STARTED'), CURRENT_TIMESTAMP()), 'SUCCESS'){% endif %}"
  )
}}

-- Bronze Layer Meetings Model
-- Purpose: 1:1 mapping from raw meetings data to bronze layer with audit information
-- Source: ZOOM_RAW_SCHEMA.MEETINGS
-- Target: ZOOM_BRONZE_SCHEMA.BZ_MEETINGS

WITH source_meetings AS (
    SELECT 
        -- Business attributes - direct 1:1 mapping from source
        meeting_topic,
        duration_minutes,
        end_time,
        start_time,
        meeting_id,
        host_id,
        
        -- Metadata columns - preserved from source
        source_system,
        load_timestamp,
        update_timestamp
        
    FROM {{ source('zoom_raw', 'meetings') }}
    
    -- Data quality filter - exclude records with null meeting_id (business key)
    WHERE meeting_id IS NOT NULL
),

final_meetings AS (
    SELECT 
        -- Business columns
        meeting_topic,
        duration_minutes,
        end_time,
        start_time,
        meeting_id,
        host_id,
        
        -- Audit and metadata columns
        load_timestamp,
        update_timestamp,
        source_system
        
    FROM source_meetings
)

SELECT * FROM final_meetings

-- Model documentation
-- This model performs a 1:1 transformation from raw meetings data to bronze layer
-- Includes data quality filtering and preserves all source metadata
