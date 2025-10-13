{{ config(
    materialized='table',
    pre_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, process_start_time, process_status, processed_by) SELECT 'bz_support_tickets', CURRENT_TIMESTAMP(), 'STARTED', 'dbt_bronze_pipeline' WHERE '{{ this.name }}' != 'bz_audit_log'",
    post_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, process_end_time, process_status, processed_by, records_processed) SELECT 'bz_support_tickets', CURRENT_TIMESTAMP(), 'COMPLETED', 'dbt_bronze_pipeline', (SELECT COUNT(*) FROM {{ this }}) WHERE '{{ this.name }}' != 'bz_audit_log'"
) }}

/*
    Bronze Layer - Support Tickets Model
    Purpose: Raw to Bronze transformation for Zoom support tickets data
    Source: ZOOM_RAW_SCHEMA.SUPPORT_TICKETS
    Target: ZOOM_BRONZE_SCHEMA.bz_support_tickets
    Transformation: 1-1 mapping with data quality checks
    Author: Data Engineering Team
    Created: {{ run_started_at }}
*/

WITH source_data AS (
    SELECT 
        -- Business columns from source
        TICKET_ID,
        USER_ID,
        TICKET_TYPE,
        RESOLUTION_STATUS,
        OPEN_DATE,
        
        -- Audit columns from source
        LOAD_TIMESTAMP,
        UPDATE_TIMESTAMP,
        SOURCE_SYSTEM
        
    FROM {{ source('zoom_raw', 'SUPPORT_TICKETS') }}
),

-- Data quality and validation layer
validated_data AS (
    SELECT 
        -- Apply data quality checks and transformations
        COALESCE(TRIM(TICKET_ID), 'UNKNOWN') AS TICKET_ID,
        COALESCE(TRIM(USER_ID), 'UNKNOWN_USER') AS USER_ID,
        COALESCE(TRIM(TICKET_TYPE), 'UNKNOWN_TYPE') AS TICKET_TYPE,
        COALESCE(TRIM(RESOLUTION_STATUS), 'UNKNOWN_STATUS') AS RESOLUTION_STATUS,
        OPEN_DATE,
        
        -- Preserve audit columns
        COALESCE(LOAD_TIMESTAMP, CURRENT_TIMESTAMP()) AS LOAD_TIMESTAMP,
        COALESCE(UPDATE_TIMESTAMP, CURRENT_TIMESTAMP()) AS UPDATE_TIMESTAMP,
        COALESCE(TRIM(SOURCE_SYSTEM), 'ZOOM') AS SOURCE_SYSTEM,
        
        -- Add bronze layer audit columns
        CURRENT_TIMESTAMP() AS bronze_created_at,
        CURRENT_TIMESTAMP() AS bronze_updated_at,
        
        -- Data quality flags
        CASE 
            WHEN TICKET_ID IS NULL OR TRIM(TICKET_ID) = '' THEN 'MISSING_ID'
            WHEN USER_ID IS NULL OR TRIM(USER_ID) = '' THEN 'MISSING_USER_ID'
            WHEN TICKET_TYPE IS NULL OR TRIM(TICKET_TYPE) = '' THEN 'MISSING_TYPE'
            ELSE 'VALID'
        END AS data_quality_status
        
    FROM source_data
)

-- Final select with all transformations applied
SELECT 
    TICKET_ID,
    USER_ID,
    TICKET_TYPE,
    RESOLUTION_STATUS,
    OPEN_DATE,
    LOAD_TIMESTAMP,
    UPDATE_TIMESTAMP,
    SOURCE_SYSTEM,
    bronze_created_at,
    bronze_updated_at,
    data_quality_status
FROM validated_data