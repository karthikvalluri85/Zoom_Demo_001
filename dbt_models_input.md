# DBT Bronze Layer Models

## bz_audit_log.sql

```sql
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
```

## bz_meetings.sql

```sql
{{ config(
    materialized='table',
    pre_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_meetings', CURRENT_TIMESTAMP(), 'dbt', 0, 'STARTED' WHERE '{{ this.name }}' != 'bz_audit_log'",
    post_hook="INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status) SELECT 'bz_meetings', CURRENT_TIMESTAMP(), 'dbt', DATEDIFF('second', (SELECT MAX(load_timestamp) FROM {{ ref('bz_audit_log') }} WHERE source_table = 'bz_meetings' AND status = 'STARTED'), CURRENT_TIMESTAMP()), 'COMPLETED' WHERE '{{ this.name }}' != 'bz_audit_log'"
) }}

/*
    Bronze Layer - Meetings Table
    Purpose: 1-1 mapping from raw MEETINGS table to bronze bz_meetings table
    Transformation: Raw data preservation with data quality checks
    Author: DBT Data Engineer
    Created: {{ run_started_at }}
*/

WITH source_data AS (
    SELECT 
        -- Direct 1-1 mapping from source to bronze
        MEETING_ID,
        MEETING_TOPIC,
        HOST_ID,
        START_TIME,
        END_TIME,
        DURATION_MINUTES,
        LOAD_TIMESTAMP,
        UPDATE_TIMESTAMP,
        SOURCE_SYSTEM,
        
        -- Data quality flags
        CASE 
            WHEN MEETING_ID IS NULL THEN 'MISSING_ID'
            WHEN START_TIME IS NULL THEN 'MISSING_START_TIME'
            WHEN END_TIME IS NULL THEN 'MISSING_END_TIME'
            ELSE 'VALID'
        END AS data_quality_flag
        
    FROM {{ source('zoom_raw', 'meetings') }}
),

data_with_audit AS (
    SELECT 
        -- Business columns (1-1 mapping)
        MEETING_ID,
        MEETING_TOPIC,
        HOST_ID,
        START_TIME,
        END_TIME,
        DURATION_MINUTES,
        LOAD_TIMESTAMP,
        UPDATE_TIMESTAMP,
        SOURCE_SYSTEM,
        
        -- Audit and process columns
        CURRENT_TIMESTAMP() AS bronze_load_timestamp,
        'dbt_bronze_pipeline' AS bronze_processed_by,
        data_quality_flag
        
    FROM source_data
)

SELECT 
    MEETING_ID,
    MEETING_TOPIC,
    HOST_ID,
    START_TIME,
    END_TIME,
    DURATION_MINUTES,
    LOAD_TIMESTAMP,
    UPDATE_TIMESTAMP,
    SOURCE_SYSTEM
FROM data_with_audit
-- Include all records, even those with data quality issues for bronze layer
ORDER BY LOAD_TIMESTAMP DESC
```