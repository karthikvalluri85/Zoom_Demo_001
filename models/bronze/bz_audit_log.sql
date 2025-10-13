{{ config(
    materialized='table',
    pre_hook="INSERT INTO {{ this }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_audit_log', CURRENT_TIMESTAMP(), 'dbt', 0, 'STARTED' WHERE '{{ this.name }}' != 'bz_audit_log'",
    post_hook="INSERT INTO {{ this }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_audit_log', CURRENT_TIMESTAMP(), 'dbt', DATEDIFF('second', (SELECT MAX(load_timestamp) FROM {{ this }} WHERE source_table = 'bz_audit_log' AND status = 'STARTED'), CURRENT_TIMESTAMP()), 'COMPLETED' WHERE '{{ this.name }}' != 'bz_audit_log'"
) }}

/*
    Bronze Layer Audit Log Table
    Purpose: Track all data processing activities in the bronze layer
    Author: DBT Data Engineer
    Created: {{ run_started_at }}
*/

WITH audit_base AS (
    SELECT 
        1 as record_id,
        'SYSTEM_INIT' as source_table,
        CURRENT_TIMESTAMP() as load_timestamp,
        'dbt' as processed_by,
        0 as processing_time,
        'INITIALIZED' as status
    WHERE 1=0  -- This ensures no records are inserted during initial creation
)

SELECT 
    record_id,
    CAST(source_table AS VARCHAR(255)) as source_table,  -- Explicitly define VARCHAR(255) to avoid truncation
    load_timestamp,
    processed_by,
    processing_time,
    status
FROM audit_base