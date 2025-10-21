{{
  config(
    materialized='table',
    pre_hook="{% if this.name != 'bz_audit_log' %}INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) VALUES ('bz_billing_events', CURRENT_TIMESTAMP(), 'DBT_BRONZE_PIPELINE', 0, 'STARTED'){% endif %}",
    post_hook="{% if this.name != 'bz_audit_log' %}INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) VALUES ('bz_billing_events', CURRENT_TIMESTAMP(), 'DBT_BRONZE_PIPELINE', DATEDIFF('millisecond', (SELECT MAX(load_timestamp) FROM {{ ref('bz_audit_log') }} WHERE source_table = 'bz_billing_events' AND status = 'STARTED'), CURRENT_TIMESTAMP()), 'SUCCESS'){% endif %}"
  )
}}

-- Bronze Layer Billing Events Model
-- Purpose: 1:1 mapping from raw billing events data to bronze layer with audit information
-- Source: ZOOM_RAW_SCHEMA.BILLING_EVENTS
-- Target: ZOOM_BRONZE_SCHEMA.BZ_BILLING_EVENTS

WITH source_billing_events AS (
    SELECT 
        -- Business attributes - direct 1:1 mapping from source
        amount,
        event_type,
        event_date,
        event_id,
        user_id,
        
        -- Metadata columns - preserved from source
        source_system,
        load_timestamp,
        update_timestamp
        
    FROM {{ source('zoom_raw', 'billing_events') }}
    
    -- Data quality filter - exclude records with null event_id (business key)
    WHERE event_id IS NOT NULL
),

final_billing_events AS (
    SELECT 
        -- Business columns
        amount,
        event_type,
        event_date,
        event_id,
        user_id,
        
        -- Audit and metadata columns
        load_timestamp,
        update_timestamp,
        source_system
        
    FROM source_billing_events
)

SELECT * FROM final_billing_events

-- Model documentation
-- This model performs a 1:1 transformation from raw billing events data to bronze layer
-- Includes data quality filtering and preserves all source metadata
