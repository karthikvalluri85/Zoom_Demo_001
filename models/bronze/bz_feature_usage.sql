{{
  config(
    materialized='table',
    pre_hook="{% if this.name != 'bz_audit_log' %}INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) VALUES ('bz_feature_usage', CURRENT_TIMESTAMP(), 'DBT_BRONZE_PIPELINE', 0, 'STARTED'){% endif %}",
    post_hook="{% if this.name != 'bz_audit_log' %}INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) VALUES ('bz_feature_usage', CURRENT_TIMESTAMP(), 'DBT_BRONZE_PIPELINE', DATEDIFF('millisecond', (SELECT MAX(load_timestamp) FROM {{ ref('bz_audit_log') }} WHERE source_table = 'bz_feature_usage' AND status = 'STARTED'), CURRENT_TIMESTAMP()), 'SUCCESS'){% endif %}"
  )
}}

-- Bronze Layer Feature Usage Model
-- Purpose: 1:1 mapping from raw feature usage data to bronze layer with audit information
-- Source: ZOOM_RAW_SCHEMA.FEATURE_USAGE
-- Target: ZOOM_BRONZE_SCHEMA.BZ_FEATURE_USAGE

WITH source_feature_usage AS (
    SELECT 
        -- Business attributes - direct 1:1 mapping from source
        feature_name,
        usage_date,
        usage_count,
        usage_id,
        meeting_id,
        
        -- Metadata columns - preserved from source
        source_system,
        load_timestamp,
        update_timestamp
        
    FROM {{ source('zoom_raw', 'feature_usage') }}
    
    -- Data quality filter - exclude records with null usage_id (business key)
    WHERE usage_id IS NOT NULL
),

final_feature_usage AS (
    SELECT 
        -- Business columns
        feature_name,
        usage_date,
        usage_count,
        usage_id,
        meeting_id,
        
        -- Audit and metadata columns
        load_timestamp,
        update_timestamp,
        source_system
        
    FROM source_feature_usage
)

SELECT * FROM final_feature_usage

-- Model documentation
-- This model performs a 1:1 transformation from raw feature usage data to bronze layer
-- Includes data quality filtering and preserves all source metadata
