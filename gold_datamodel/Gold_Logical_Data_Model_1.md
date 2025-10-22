_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Gold Layer Logical Data Model for Zoom Platform Analytics System with dimensional modeling for advanced analytics and reporting
## *Version*: 1
## *Updated on*: 
_____________________________________________

# Gold Layer Logical Data Model for Zoom Platform Analytics System

## 1. Gold Layer Logical Model

### 1.1 Fact Tables

#### Go_Meeting_Facts
**Description:** Central fact table capturing meeting performance metrics and key business measures
**Table Type:** Fact
**SCD Type:** N/A (Fact table)

| Column Name | Data Type | Description | PII Classification |
|-------------|-----------|-------------|--------------------|
| meeting_topic | STRING | Subject or descriptive title of the meeting session | Non-PII |
| duration_minutes | INTEGER | Total duration of the meeting measured in minutes | Non-PII |
| start_time | TIMESTAMP | Timestamp indicating when the meeting began | Non-PII |
| end_time | TIMESTAMP | Timestamp indicating when the meeting concluded | Non-PII |
| participant_count | INTEGER | Total number of participants who joined the meeting | Non-PII |
| average_engagement_score | DECIMAL(5