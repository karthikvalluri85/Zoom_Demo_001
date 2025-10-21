{{
  config(
    materialized='table',
    pre_hook="{% if this.name != 'bz_audit_log' %}INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) VALUES ('bz_users', CURRENT_TIMESTAMP(), 'DBT_BRONZE_PIPELINE', 0, 'STARTED'){% endif %}",
    post_hook="{% if this.name != 'bz_audit_log' %}INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) VALUES ('bz_users', CURRENT_TIMESTAMP(), 'DBT_BRONZE_PIPELINE', DATEDIFF('millisecond', (SELECT MAX(load_timestamp) FROM {{ ref('bz_audit_log') }} WHERE source_table = 'bz_users' AND status = 'STARTED'), CURRENT_TIMESTAMP()), 'SUCCESS'){% endif %}"
  )
}}

-- Bronze Layer Users Model
-- Purpose: 1:1 mapping from raw users data to bronze layer with audit information
-- Source: ZOOM_RAW_SCHEMA.USERS
-- Target: ZOOM_BRONZE_SCHEMA.BZ_USERS

WITH source_users AS (
    SELECT 
        -- Business attributes - direct 1:1 mapping from source
        email,
        user_name,
        plan_type,
        company,
        user_id,
        
        -- Metadata columns - preserved from source
        source_system,
        load_timestamp,
        update_timestamp
        
    FROM {{ source('zoom_raw', 'users') }}
    
    -- Data quality filter - exclude records with null email (business key)
    WHERE email IS NOT NULL
),

final_users AS (
    SELECT 
        -- Business columns
        email,
        user_name,
        plan_type,
        company,
        user_id,
        
        -- Audit and metadata columns
        load_timestamp,
        update_timestamp,
        source_system
        
    FROM source_users
)

SELECT * FROM final_users

-- Model documentation
-- This model performs a 1:1 transformation from raw users data to bronze layer
-- Includes data quality filtering and preserves all source metadata
