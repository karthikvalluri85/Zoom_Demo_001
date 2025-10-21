{{
  config(
    materialized='table',
    pre_hook="{% if this.name != 'bz_audit_log' %}INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) VALUES ('bz_webinars', CURRENT_TIMESTAMP(), 'DBT_BRONZE_PIPELINE', 0, 'STARTED'){% endif %}",
    post_hook="{% if this.name != 'bz_audit_log' %}INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) VALUES ('bz_webinars', CURRENT_TIMESTAMP(), 'DBT_BRONZE_PIPELINE', DATEDIFF('millisecond', (SELECT MAX(load_timestamp) FROM {{ ref('bz_audit_log') }} WHERE source_table = 'bz_webinars' AND status = 'STARTED'), CURRENT_TIMESTAMP()), 'SUCCESS'){% endif %}"
  )
}}

-- Bronze Layer Webinars Model
-- Purpose: 1:1 mapping from raw webinars data to bronze layer with audit information
-- Source: ZOOM_RAW_SCHEMA.WEBINARS
-- Target: ZOOM_BRONZE_SCHEMA.BZ_WEBINARS

WITH source_webinars AS (
    SELECT 
        -- Business attributes - direct 1:1 mapping from source
        end_time,
        webinar_topic,
        start_time,
        registrants,
        webinar_id,
        host_id,
        
        -- Metadata columns - preserved from source
        source_system,
        load_timestamp,
        update_timestamp
        
    FROM {{ source('zoom_raw', 'webinars') }}
    
    -- Data quality filter - exclude records with null webinar_id (business key)
    WHERE webinar_id IS NOT NULL
),

final_webinars AS (
    SELECT 
        -- Business columns
        end_time,
        webinar_topic,
        start_time,
        registrants,
        webinar_id,
        host_id,
        
        -- Audit and metadata columns
        load_timestamp,
        update_timestamp,
        source_system
        
    FROM source_webinars
)

SELECT * FROM final_webinars

-- Model documentation
-- This model performs a 1:1 transformation from raw webinars data to bronze layer
-- Includes data quality filtering and preserves all source metadata
