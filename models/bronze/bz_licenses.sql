{{ config(
    materialized='table',
    pre_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, process_start_time, process_status, processed_by) SELECT 'bz_licenses', CURRENT_TIMESTAMP(), 'STARTED', 'dbt_bronze_pipeline' WHERE '{{ this.name }}' != 'bz_audit_log'",
    post_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, process_end_time, process_status, processed_by, records_processed) SELECT 'bz_licenses', CURRENT_TIMESTAMP(), 'COMPLETED', 'dbt_bronze_pipeline', (SELECT COUNT(*) FROM {{ this }}) WHERE '{{ this.name }}' != 'bz_audit_log'"
) }}

/*
    Bronze Layer - Licenses Model
    Purpose: Raw to Bronze transformation for Zoom licenses data
    Source: ZOOM_RAW_SCHEMA.LICENSES
    Target: ZOOM_BRONZE_SCHEMA.bz_licenses
    Transformation: 1-1 mapping with data quality checks
    Author: Data Engineering Team
    Created: {{ run_started_at }}
*/

WITH source_data AS (
    SELECT 
        -- Business columns from source
        LICENSE_ID,
        LICENSE_TYPE,
        ASSIGNED_TO_USER_ID,
        START_DATE,
        END_DATE,
        
        -- Audit columns from source
        LOAD_TIMESTAMP,
        UPDATE_TIMESTAMP,
        SOURCE_SYSTEM
        
    FROM {{ source('zoom_raw', 'LICENSES') }}
),

-- Data quality and validation layer
validated_data AS (
    SELECT 
        -- Apply data quality checks and transformations
        COALESCE(TRIM(LICENSE_ID), 'UNKNOWN') AS LICENSE_ID,
        COALESCE(TRIM(LICENSE_TYPE), 'UNKNOWN_TYPE') AS LICENSE_TYPE,
        COALESCE(TRIM(ASSIGNED_TO_USER_ID), 'UNASSIGNED') AS ASSIGNED_TO_USER_ID,
        START_DATE,
        END_DATE,
        
        -- Preserve audit columns
        COALESCE(LOAD_TIMESTAMP, CURRENT_TIMESTAMP()) AS LOAD_TIMESTAMP,
        COALESCE(UPDATE_TIMESTAMP, CURRENT_TIMESTAMP()) AS UPDATE_TIMESTAMP,
        COALESCE(TRIM(SOURCE_SYSTEM), 'ZOOM') AS SOURCE_SYSTEM,
        
        -- Add bronze layer audit columns
        CURRENT_TIMESTAMP() AS bronze_created_at,
        CURRENT_TIMESTAMP() AS bronze_updated_at,
        
        -- Data quality flags
        CASE 
            WHEN LICENSE_ID IS NULL OR TRIM(LICENSE_ID) = '' THEN 'MISSING_ID'
            WHEN LICENSE_TYPE IS NULL OR TRIM(LICENSE_TYPE) = '' THEN 'MISSING_TYPE'
            WHEN START_DATE IS NULL THEN 'MISSING_START_DATE'
            ELSE 'VALID'
        END AS data_quality_status
        
    FROM source_data
)

-- Final select with all transformations applied
SELECT 
    LICENSE_ID,
    LICENSE_TYPE,
    ASSIGNED_TO_USER_ID,
    START_DATE,
    END_DATE,
    LOAD_TIMESTAMP,
    UPDATE_TIMESTAMP,
    SOURCE_SYSTEM,
    bronze_created_at,
    bronze_updated_at,
    data_quality_status
FROM validated_data