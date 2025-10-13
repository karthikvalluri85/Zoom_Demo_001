{{ config(
    materialized='table',
    pre_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, process_start_time, process_status, processed_by) SELECT 'bz_billing_events', CURRENT_TIMESTAMP(), 'STARTED', 'dbt_bronze_pipeline' WHERE '{{ this.name }}' != 'bz_audit_log'",
    post_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, process_end_time, process_status, processed_by, records_processed) SELECT 'bz_billing_events', CURRENT_TIMESTAMP(), 'COMPLETED', 'dbt_bronze_pipeline', (SELECT COUNT(*) FROM {{ this }}) WHERE '{{ this.name }}' != 'bz_audit_log'"
) }}

/*
    Bronze Layer - Billing Events Model
    Purpose: Raw to Bronze transformation for Zoom billing events data
    Source: ZOOM_RAW_SCHEMA.BILLING_EVENTS
    Target: ZOOM_BRONZE_SCHEMA.bz_billing_events
    Transformation: 1-1 mapping with data quality checks
    Author: Data Engineering Team
    Created: {{ run_started_at }}
*/

WITH source_data AS (
    SELECT 
        -- Business columns from source
        EVENT_ID,
        USER_ID,
        EVENT_TYPE,
        EVENT_DATE,
        AMOUNT,
        
        -- Audit columns from source
        LOAD_TIMESTAMP,
        UPDATE_TIMESTAMP,
        SOURCE_SYSTEM
        
    FROM {{ source('zoom_raw', 'BILLING_EVENTS') }}
),

-- Data quality and validation layer
validated_data AS (
    SELECT 
        -- Apply data quality checks and transformations
        COALESCE(TRIM(EVENT_ID), 'UNKNOWN') AS EVENT_ID,
        COALESCE(TRIM(USER_ID), 'UNKNOWN_USER') AS USER_ID,
        COALESCE(TRIM(EVENT_TYPE), 'UNKNOWN_TYPE') AS EVENT_TYPE,
        EVENT_DATE,
        COALESCE(AMOUNT, 0) AS AMOUNT,
        
        -- Preserve audit columns
        COALESCE(LOAD_TIMESTAMP, CURRENT_TIMESTAMP()) AS LOAD_TIMESTAMP,
        COALESCE(UPDATE_TIMESTAMP, CURRENT_TIMESTAMP()) AS UPDATE_TIMESTAMP,
        COALESCE(TRIM(SOURCE_SYSTEM), 'ZOOM') AS SOURCE_SYSTEM,
        
        -- Add bronze layer audit columns
        CURRENT_TIMESTAMP() AS bronze_created_at,
        CURRENT_TIMESTAMP() AS bronze_updated_at,
        
        -- Data quality flags
        CASE 
            WHEN EVENT_ID IS NULL OR TRIM(EVENT_ID) = '' THEN 'MISSING_ID'
            WHEN USER_ID IS NULL OR TRIM(USER_ID) = '' THEN 'MISSING_USER_ID'
            WHEN EVENT_TYPE IS NULL OR TRIM(EVENT_TYPE) = '' THEN 'MISSING_TYPE'
            WHEN EVENT_DATE IS NULL THEN 'MISSING_DATE'
            ELSE 'VALID'
        END AS data_quality_status
        
    FROM source_data
)

-- Final select with all transformations applied
SELECT 
    EVENT_ID,
    USER_ID,
    EVENT_TYPE,
    EVENT_DATE,
    AMOUNT,
    LOAD_TIMESTAMP,
    UPDATE_TIMESTAMP,
    SOURCE_SYSTEM,
    bronze_created_at,
    bronze_updated_at,
    data_quality_status
FROM validated_data