{{ config(
    materialized='table',
    pre_hook="INSERT INTO {{ this }} (source_table, process_start_time, process_status) SELECT 'bz_audit_log', CURRENT_TIMESTAMP(), 'STARTED' WHERE '{{ this.name }}' != 'bz_audit_log'",
    post_hook="INSERT INTO {{ this }} (source_table, process_end_time, process_status) SELECT 'bz_audit_log', CURRENT_TIMESTAMP(), 'COMPLETED' WHERE '{{ this.name }}' != 'bz_audit_log'"
) }}

/*
    Bronze Layer Audit Log Model
    Purpose: Track all data processing activities in the bronze layer
    Author: Data Engineering Team
    Created: {{ run_started_at }}
*/

WITH audit_log_base AS (
    SELECT 
        -- Audit tracking columns
        CAST(NULL AS VARCHAR(255)) AS source_table,
        CAST(NULL AS TIMESTAMP_NTZ) AS process_start_time,
        CAST(NULL AS TIMESTAMP_NTZ) AS process_end_time,
        CAST(NULL AS VARCHAR(50)) AS process_status,
        CAST(NULL AS VARCHAR(255)) AS processed_by,
        CAST(NULL AS NUMBER) AS records_processed,
        CAST(NULL AS VARCHAR(1000)) AS error_message,
        CURRENT_TIMESTAMP() AS created_at
    WHERE 1=0  -- This ensures no data is selected initially
)

SELECT 
    source_table,
    process_start_time,
    process_end_time,
    process_status,
    processed_by,
    records_processed,
    error_message,
    created_at
FROM audit_log_base