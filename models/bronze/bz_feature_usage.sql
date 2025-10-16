{{ config(
    materialized='table',
    pre_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_feature_usage', CURRENT_TIMESTAMP(), 'DBT_PROCESS', 0, 'STARTED' WHERE '{{ this.name }}' != 'bz_audit_log'",
    post_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_feature_usage', CURRENT_TIMESTAMP(), 'DBT_PROCESS', DATEDIFF('second', (SELECT MAX(load_timestamp) FROM {{ ref('bz_audit_log') }} WHERE source_table = 'bz_feature_usage' AND status = 'STARTED'), CURRENT_TIMESTAMP()), 'COMPLETED' WHERE '{{ this.name }}' != 'bz_audit_log'"
) }}

-- Bronze layer transformation for feature usage data
-- This model performs 1:1 mapping from raw to bronze layer with data validation

WITH source_data AS (
    SELECT 
        -- Primary identifiers
        USAGE_ID,
        MEETING_ID,
        
        -- Usage details
        FEATURE_NAME,
        USAGE_DATE,
        USAGE_COUNT,
        
        -- Metadata columns
        LOAD_TIMESTAMP,
        UPDATE_TIMESTAMP,
        SOURCE_SYSTEM
        
    FROM {{ source('zoom_raw', 'FEATURE_USAGE') }}
),

validated_data AS (
    SELECT 
        -- Data validation and cleansing
        CASE 
            WHEN USAGE_ID IS NULL OR TRIM(USAGE_ID) = '' THEN 'UNKNOWN_USAGE'
            ELSE TRIM(USAGE_ID)
        END as usage_id,
        
        CASE 
            WHEN MEETING_ID IS NULL OR TRIM(MEETING_ID) = '' THEN 'UNKNOWN_MEETING'
            ELSE TRIM(MEETING_ID)
        END as meeting_id,
        
        COALESCE(TRIM(FEATURE_NAME), 'Unknown Feature') as feature_name,
        
        -- Date validation
        CASE 
            WHEN USAGE_DATE IS NULL THEN CURRENT_DATE()
            ELSE USAGE_DATE
        END as usage_date,
        
        COALESCE(USAGE_COUNT, 0) as usage_count,
        
        -- Metadata with defaults
        COALESCE(LOAD_TIMESTAMP, CURRENT_TIMESTAMP()) as load_timestamp,
        COALESCE(UPDATE_TIMESTAMP, CURRENT_TIMESTAMP()) as update_timestamp,
        COALESCE(TRIM(SOURCE_SYSTEM), 'ZOOM_PLATFORM') as source_system
        
    FROM source_data
)

SELECT 
    usage_id,
    meeting_id,
    feature_name,
    usage_date,
    usage_count,
    load_timestamp,
    update_timestamp,
    source_system
FROM validated_data
