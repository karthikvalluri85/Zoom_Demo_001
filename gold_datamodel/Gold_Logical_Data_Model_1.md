_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Gold Layer Logical Data Model for Zoom Platform Analytics System following medallion architecture principles
## *Version*: 1
## *Updated on*: 
_____________________________________________

# Gold Layer Logical Data Model for Zoom Platform Analytics System

## 1. Gold Layer Logical Model

### 1.1 Dimension Tables

#### Go_User_Dim
**Description:** User profile and account attributes with historical tracking for comprehensive user analytics
**Table Type:** Dimension
**SCD Type:** Type 2

| Column Name | Data Type | Description | PII Classification |
|-------------|-----------|-------------|--------------------|
| email | STRING | User email address for authentication and communication | PII |
| user_name | STRING | Display name or username for the platform user | None |
| plan_type | STRING | Subscription plan tier assigned to the user | None |
| company | STRING | Organization or company name associated with the user | None |
| status | STRING | User status (Active