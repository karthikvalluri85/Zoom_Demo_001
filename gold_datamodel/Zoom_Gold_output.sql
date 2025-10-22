_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Gold Layer Physical Data Model for Zoom Platform Analytics System with business-ready dimensional model
## *Version*: 1
## *Updated on*: 
_____________________________________________

/*
=============================================================================
GOLD LAYER PHYSICAL DATA MODEL - ZOOM PLATFORM ANALYTICS SYSTEM
=============================================================================

This script creates the Gold Layer physical data model for the Zoom Platform 
Analytics System following Snowflake SQL standards and dimensional modeling 
best practices.

Database: ZOOM_DATABASE
Schema: ZOOM_GOLD_SCHEMA
Table Naming Convention: go_[table_name]

Features:
- Snowflake-compatible data types
- Dimensional model with fact and dimension tables
- Aggregate tables for performance optimization
- ID fields added for each table as surrogate keys
- Error data table for data quality tracking
- Audit table for pipeline execution monitoring
- CREATE TABLE IF NOT EXISTS syntax for idempotent execution
- Business-ready data for analytics and reporting

=============================================================================
*/

-- =============================================================================
-- 1. DIMENSION TABLES
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1.1 GO_USER_DIM - User Dimension
-- Purpose: Stores user profile information for dimensional analysis
-- Source: ZOOM_SILVER_SCHEMA.si_users
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ZOOM_GOLD_SCHEMA.go_user_dim (
    -- Surrogate Key
    user_dim_id NUMBER AUTOINCREMENT COMMENT 'Surrogate key for user dimension'