{{ config(
    materialized='table',
    pre_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_licenses', CURRENT_TIMESTAMP(), 'DBT_PROCESS', 0, 'STARTED' WHERE '{{ this.name }}' != 'bz_audit_log'",
    post_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_licenses', CURRENT_TIMESTAMP(), 'DBT_PROCESS', DATEDIFF('second', (SELECT MAX(load_timestamp) FROM {{ ref('bz_audit_log') }} WHERE source_table = 'bz_licenses' AND status = 'STARTED'), CURRENT_TIMESTAMP()), 'COMPLETED' WHERE '{{ this.name }}' != 'bz_audit_log'"
) }}

-- Bronze layer transformation for licenses data
-- This model performs 1:1 mapping from raw to bronze layer with data validation

WITH source_data AS (
    SELECT 
        -- Primary identifiers
        LICENSE_ID,
        ASSIGNED_TO_USER_ID,
        
        -- License details
        LICENSE_TYPE,
        START_DATE,
        END_DATE,
        
        -- Metadata columns
        LOAD_TIMESTAMP,
        UPDATE_TIMESTAMP,
        SOURCE_SYSTEM
        
    FROM {{ source('zoom_raw', 'LICENSES') }}
),

validated_data AS (
    SELECT 
        -- Data validation and cleansing
        CASE 
            WHEN LICENSE_ID IS NULL OR TRIM(LICENSE_ID) = '' THEN 'UNKNOWN_LICENSE'
            ELSE TRIM(LICENSE_ID)
        END as license_id,
        
        CASE 
            WHEN ASSIGNED_TO_USER_ID IS NULL OR TRIM(ASSIGNED_TO_USER_ID) = '' THEN 'UNASSIGNED'
            ELSE TRIM(ASSIGNED_TO_USER_ID)
        END as assigned_to_user_id,
        
        COALESCE(TRIM(LICENSE_TYPE), 'Unknown Type') as license_type,
        
        -- Date validation
        CASE 
            WHEN START_DATE IS NULL THEN CURRENT_DATE()
            ELSE START_DATE
        END as start_date,
        
        CASE 
            WHEN END_DATE IS NULL THEN CURRENT_DATE()
            ELSE END_DATE
        END as end_date,
        
        -- Metadata with defaults
        COALESCE(LOAD_TIMESTAMP, CURRENT_TIMESTAMP()) as load_timestamp,
        COALESCE(UPDATE_TIMESTAMP, CURRENT_TIMESTAMP()) as update_timestamp,
        COALESCE(TRIM(SOURCE_SYSTEM), 'ZOOM_PLATFORM') as source_system
        
    FROM source_data
)

SELECT 
    license_id,
    assigned_to_user_id,
    license_type,
    start_date,
    end_date,
    load_timestamp,
    update_timestamp,
    source_system
FROM validated_data
