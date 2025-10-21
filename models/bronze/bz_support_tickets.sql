{{
  config(
    materialized='table',
    pre_hook="{% if this.name != 'bz_audit_log' %}INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) VALUES ('bz_support_tickets', CURRENT_TIMESTAMP(), 'DBT_BRONZE_PIPELINE', 0, 'STARTED'){% endif %}",
    post_hook="{% if this.name != 'bz_audit_log' %}INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) VALUES ('bz_support_tickets', CURRENT_TIMESTAMP(), 'DBT_BRONZE_PIPELINE', DATEDIFF('millisecond', (SELECT MAX(load_timestamp) FROM {{ ref('bz_audit_log') }} WHERE source_table = 'bz_support_tickets' AND status = 'STARTED'), CURRENT_TIMESTAMP()), 'SUCCESS'){% endif %}"
  )
}}

-- Bronze Layer Support Tickets Model
-- Purpose: 1:1 mapping from raw support tickets data to bronze layer with audit information
-- Source: ZOOM_RAW_SCHEMA.SUPPORT_TICKETS
-- Target: ZOOM_BRONZE_SCHEMA.BZ_SUPPORT_TICKETS

WITH source_support_tickets AS (
    SELECT 
        -- Business attributes - direct 1:1 mapping from source
        resolution_status,
        open_date,
        ticket_type,
        ticket_id,
        user_id,
        
        -- Metadata columns - preserved from source
        source_system,
        load_timestamp,
        update_timestamp
        
    FROM {{ source('zoom_raw', 'support_tickets') }}
    
    -- Data quality filter - exclude records with null ticket_id (business key)
    WHERE ticket_id IS NOT NULL
),

final_support_tickets AS (
    SELECT 
        -- Business columns
        resolution_status,
        open_date,
        ticket_type,
        ticket_id,
        user_id,
        
        -- Audit and metadata columns
        load_timestamp,
        update_timestamp,
        source_system
        
    FROM source_support_tickets
)

SELECT * FROM final_support_tickets

-- Model documentation
-- This model performs a 1:1 transformation from raw support tickets data to bronze layer
-- Includes data quality filtering and preserves all source metadata
