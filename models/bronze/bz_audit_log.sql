{{
  config(
    materialized='table',
    pre_hook="",
    post_hook=""
  )
}}

-- Bronze Layer Audit Log Model
-- Purpose: Provides comprehensive audit trail for bronze layer data processing
-- Author: DBT Data Engineering Team
-- Created: {{ run_started_at }}

WITH audit_log_base AS (
    SELECT 
        -- Generate a unique record ID using row_number
        ROW_NUMBER() OVER (ORDER BY CURRENT_TIMESTAMP()) AS record_id,
        
        -- Static audit information for initial setup
        'INITIAL_SETUP' AS source_table,
        CURRENT_TIMESTAMP() AS load_timestamp,
        'DBT_BRONZE_PIPELINE' AS processed_by,
        0 AS processing_time,
        'SUCCESS' AS status
    
    -- Create a single row for initialization
    FROM (SELECT 1 as dummy_col)
)

SELECT 
    record_id,
    source_table,
    load_timestamp,
    processed_by,
    processing_time,
    status
FROM audit_log_base

-- Add comment for documentation
-- This model creates the audit log table structure for tracking bronze layer operations
