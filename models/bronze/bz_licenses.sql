{{
  config(
    materialized='table',
    pre_hook="{% if this.name != 'bz_audit_log' %}INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) VALUES ('bz_licenses', CURRENT_TIMESTAMP(), 'DBT_BRONZE_PIPELINE', 0, 'STARTED'){% endif %}",
    post_hook="{% if this.name != 'bz_audit_log' %}INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) VALUES ('bz_licenses', CURRENT_TIMESTAMP(), 'DBT_BRONZE_PIPELINE', DATEDIFF('millisecond', (SELECT MAX(load_timestamp) FROM {{ ref('bz_audit_log') }} WHERE source_table = 'bz_licenses' AND status = 'STARTED'), CURRENT_TIMESTAMP()), 'SUCCESS'){% endif %}"
  )
}}

-- Bronze Layer Licenses Model
-- Purpose: 1:1 mapping from raw licenses data to bronze layer with audit information
-- Source: ZOOM_RAW_SCHEMA.LICENSES
-- Target: ZOOM_BRONZE_SCHEMA.BZ_LICENSES

WITH source_licenses AS (
    SELECT 
        -- Business attributes - direct 1:1 mapping from source
        license_type,
        end_date,
        start_date,
        license_id,
        assigned_to_user_id,
        
        -- Metadata columns - preserved from source
        source_system,
        load_timestamp,
        update_timestamp
        
    FROM {{ source('zoom_raw', 'licenses') }}
    
    -- Data quality filter - exclude records with null license_id (business key)
    WHERE license_id IS NOT NULL
),

final_licenses AS (
    SELECT 
        -- Business columns
        license_type,
        end_date,
        start_date,
        license_id,
        assigned_to_user_id,
        
        -- Audit and metadata columns
        load_timestamp,
        update_timestamp,
        source_system
        
    FROM source_licenses
)

SELECT * FROM final_licenses

-- Model documentation
-- This model performs a 1:1 transformation from raw licenses data to bronze layer
-- Includes data quality filtering and preserves all source metadata
