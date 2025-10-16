{{ config(
    materialized='table',
    pre_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_support_tickets', CURRENT_TIMESTAMP(), 'DBT_PROCESS', 0, 'STARTED' WHERE '{{ this.name }}' != 'bz_audit_log'",
    post_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_support_tickets', CURRENT_TIMESTAMP(), 'DBT_PROCESS', DATEDIFF('second', (SELECT MAX(load_timestamp) FROM {{ ref('bz_audit_log') }} WHERE source_table = 'bz_support_tickets' AND status = 'STARTED'), CURRENT_TIMESTAMP()), 'COMPLETED' WHERE '{{ this.name }}' != 'bz_audit_log'"
) }}

-- Bronze layer transformation for support tickets data
-- This model performs 1:1 mapping from raw to bronze layer with data validation

WITH source_data AS (
    SELECT 
        -- Primary identifiers
        TICKET_ID,
        USER_ID,
        
        -- Ticket details
        TICKET_TYPE,
        OPEN_DATE,
        RESOLUTION_STATUS,
        
        -- Metadata columns
        LOAD_TIMESTAMP,
        UPDATE_TIMESTAMP,
        SOURCE_SYSTEM
        
    FROM {{ source('zoom_raw', 'SUPPORT_TICKETS') }}
),

validated_data AS (
    SELECT 
        -- Data validation and cleansing
        CASE 
            WHEN TICKET_ID IS NULL OR TRIM(TICKET_ID) = '' THEN 'UNKNOWN_TICKET'
            ELSE TRIM(TICKET_ID)
        END as ticket_id,
        
        CASE 
            WHEN USER_ID IS NULL OR TRIM(USER_ID) = '' THEN 'UNKNOWN_USER'
            ELSE TRIM(USER_ID)
        END as user_id,
        
        COALESCE(TRIM(TICKET_TYPE), 'Unknown Type') as ticket_type,
        
        -- Date validation
        CASE 
            WHEN OPEN_DATE IS NULL THEN CURRENT_DATE()
            ELSE OPEN_DATE
        END as open_date,
        
        COALESCE(TRIM(RESOLUTION_STATUS), 'Open') as resolution_status,
        
        -- Metadata with defaults
        COALESCE(LOAD_TIMESTAMP, CURRENT_TIMESTAMP()) as load_timestamp,
        COALESCE(UPDATE_TIMESTAMP, CURRENT_TIMESTAMP()) as update_timestamp,
        COALESCE(TRIM(SOURCE_SYSTEM), 'ZOOM_PLATFORM') as source_system
        
    FROM source_data
)

SELECT 
    ticket_id,
    user_id,
    ticket_type,
    open_date,
    resolution_status,
    load_timestamp,
    update_timestamp,
    source_system
FROM validated_data
