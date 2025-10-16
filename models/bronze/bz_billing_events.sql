{{ config(
    materialized='table',
    pre_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_billing_events', CURRENT_TIMESTAMP(), 'DBT_PROCESS', 0, 'STARTED' WHERE '{{ this.name }}' != 'bz_audit_log'",
    post_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_billing_events', CURRENT_TIMESTAMP(), 'DBT_PROCESS', DATEDIFF('second', (SELECT MAX(load_timestamp) FROM {{ ref('bz_audit_log') }} WHERE source_table = 'bz_billing_events' AND status = 'STARTED'), CURRENT_TIMESTAMP()), 'COMPLETED' WHERE '{{ this.name }}' != 'bz_audit_log'"
) }}

-- Bronze layer transformation for billing events data
-- This model performs 1:1 mapping from raw to bronze layer with data validation

WITH source_data AS (
    SELECT 
        -- Primary identifiers
        EVENT_ID,
        USER_ID,
        
        -- Event details
        EVENT_TYPE,
        EVENT_DATE,
        AMOUNT,
        
        -- Metadata columns
        LOAD_TIMESTAMP,
        UPDATE_TIMESTAMP,
        SOURCE_SYSTEM
        
    FROM {{ source('zoom_raw', 'BILLING_EVENTS') }}
),

validated_data AS (
    SELECT 
        -- Data validation and cleansing
        CASE 
            WHEN EVENT_ID IS NULL OR TRIM(EVENT_ID) = '' THEN 'UNKNOWN_EVENT'
            ELSE TRIM(EVENT_ID)
        END as event_id,
        
        CASE 
            WHEN USER_ID IS NULL OR TRIM(USER_ID) = '' THEN 'UNKNOWN_USER'
            ELSE TRIM(USER_ID)
        END as user_id,
        
        COALESCE(TRIM(EVENT_TYPE), 'Unknown Event') as event_type,
        
        -- Date validation
        CASE 
            WHEN EVENT_DATE IS NULL THEN CURRENT_DATE()
            ELSE EVENT_DATE
        END as event_date,
        
        COALESCE(AMOUNT, 0) as amount,
        
        -- Metadata with defaults
        COALESCE(LOAD_TIMESTAMP, CURRENT_TIMESTAMP()) as load_timestamp,
        COALESCE(UPDATE_TIMESTAMP, CURRENT_TIMESTAMP()) as update_timestamp,
        COALESCE(TRIM(SOURCE_SYSTEM), 'ZOOM_PLATFORM') as source_system
        
    FROM source_data
)

SELECT 
    event_id,
    user_id,
    event_type,
    event_date,
    amount,
    load_timestamp,
    update_timestamp,
    source_system
FROM validated_data
