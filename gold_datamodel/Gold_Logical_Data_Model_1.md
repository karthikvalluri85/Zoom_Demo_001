_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Gold Layer Logical Data Model for Zoom Platform Analytics System with dimensional modeling for advanced analytics
## *Version*: 1
## *Updated on*: 
_____________________________________________

# Gold Layer Logical Data Model for Zoom Platform Analytics System

## 1. Gold Layer Logical Model

### 1.1 Fact Tables

#### 1.1.1 Go_Meeting_Facts
**Table Type:** Fact Table  
**SCD Type:** N/A (Transactional Facts)  
**Description:** Central fact table capturing meeting performance metrics and transactional data for comprehensive meeting analytics

| Column Name | Data Type | Description | PII Classification | Business Rationale |
|-------------|-----------|-------------|-------------------|--------------------| 
| meeting_topic | STRING | Subject or descriptive title of the meeting session | Non-PII | Essential for meeting identification and categorization |
| duration_minutes | INTEGER | Total duration of the meeting measured in minutes | Non-PII | Core metric for meeting efficiency and resource utilization analysis |
| start_time | TIMESTAMP | Timestamp when the meeting began