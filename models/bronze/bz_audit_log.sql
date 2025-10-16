{{ config(
    materialized='table',
    pre_hook="",
    post_hook=""
) }}

WITH audit_base AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY CURRENT_TIMESTAMP()) as record_id,
        'AUDIT_LOG' as source_table,
        CURRENT_TIMESTAMP() as load_timestamp,
        'DBT_PROCESS' as processed_by,
        0 as processing_time,
        'INITIALIZED' as status
)

SELECT 
    record_id,
    CAST(source_table AS VARCHAR(255)) as source_table,
    load_timestamp,
    processed_by,
    processing_time,
    status
FROM audit_base
WHERE FALSE -- This ensures the table is created but no data is inserted initially
