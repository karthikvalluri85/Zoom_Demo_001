_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Bronze Layer Data Mapping for Zoom Platform Analytics System
## *Version*: 1
## *Updated on*: 
_____________________________________________

# Bronze Layer Data Mapping for Zoom Platform Analytics System

## Overview
This document provides the comprehensive data mapping for the Bronze layer in the Medallion architecture implementation for the Zoom Platform Analytics System. The Bronze layer serves as the raw data ingestion layer, preserving the original structure of source data while enabling efficient downstream processing.

## Data Mapping Tables

### 1. Bz_User Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | Bz_User | User_Name | Source | User | User Name | 1-1 Mapping |
| Bronze | Bz_User | Email_Address | Source | User | Email Address | 1-1 Mapping |
| Bronze | Bz_User | Department | Source | User | Department | 1-1 Mapping |
| Bronze | Bz_User | Job_Title | Source | User | Job Title | 1-1 Mapping |
| Bronze | Bz_User | Time_Zone | Source | User | Time Zone | 1-1 Mapping |
| Bronze | Bz_User | Language_Preference | Source | User | Language Preference | 1-1 Mapping |
| Bronze | Bz_User | Profile_Picture_URL | Source | User | Profile Picture URL | 1-1 Mapping |
| Bronze | Bz_User | Account_Status | Source | User | Account Status | 1-1 Mapping |
| Bronze | Bz_User | Last_Login_Date | Source | User | Last Login Date | 1-1 Mapping |
| Bronze | Bz_User | Registration_Date | Source | User | Registration Date | 1-1 Mapping |

### 2. Bz_Account Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | Bz_Account | Account_Name | Source | Account | Account Name | 1-1 Mapping |
| Bronze | Bz_Account | Account_Type | Source | Account | Account Type | 1-1 Mapping |
| Bronze | Bz_Account | Billing_Address | Source | Account | Billing Address | 1-1 Mapping |
| Bronze | Bz_Account | Contact_Email | Source | Account | Contact Email | 1-1 Mapping |
| Bronze | Bz_Account | Phone_Number | Source | Account | Phone Number | 1-1 Mapping |
| Bronze | Bz_Account | Industry | Source | Account | Industry | 1-1 Mapping |
| Bronze | Bz_Account | Company_Size | Source | Account | Company Size | 1-1 Mapping |
| Bronze | Bz_Account | Subscription_Start_Date | Source | Account | Subscription Start Date | 1-1 Mapping |
| Bronze | Bz_Account | Subscription_End_Date | Source | Account | Subscription End Date | 1-1 Mapping |
| Bronze | Bz_Account | Payment_Status | Source | Account | Payment Status | 1-1 Mapping |

### 3. Bz_Meeting Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | Bz_Meeting | Meeting_Topic | Source | Meeting | Meeting Topic | 1-1 Mapping |
| Bronze | Bz_Meeting | Meeting_Type | Source | Meeting | Meeting Type | 1-1 Mapping |
| Bronze | Bz_Meeting | Start_Time | Source | Meeting | Start Time | 1-1 Mapping |
| Bronze | Bz_Meeting | End_Time | Source | Meeting | End Time | 1-1 Mapping |
| Bronze | Bz_Meeting | Duration | Source | Meeting | Duration | 1-1 Mapping |
| Bronze | Bz_Meeting | Meeting_Password | Source | Meeting | Meeting Password | 1-1 Mapping |
| Bronze | Bz_Meeting | Waiting_Room_Enabled | Source | Meeting | Waiting Room Enabled | 1-1 Mapping |
| Bronze | Bz_Meeting | Recording_Permission | Source | Meeting | Recording Permission | 1-1 Mapping |
| Bronze | Bz_Meeting | Maximum_Participants | Source | Meeting | Maximum Participants | 1-1 Mapping |
| Bronze | Bz_Meeting | Meeting_Status | Source | Meeting | Meeting Status | 1-1 Mapping |

### 4. Bz_Webinar Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | Bz_Webinar | Webinar_Title | Source | Webinar | Webinar Title | 1-1 Mapping |
| Bronze | Bz_Webinar | Description | Source | Webinar | Description | 1-1 Mapping |
| Bronze | Bz_Webinar | Start_Time | Source | Webinar | Start Time | 1-1 Mapping |
| Bronze | Bz_Webinar | End_Time | Source | Webinar | End Time | 1-1 Mapping |
| Bronze | Bz_Webinar | Duration | Source | Webinar | Duration | 1-1 Mapping |
| Bronze | Bz_Webinar | Registration_Required | Source | Webinar | Registration Required | 1-1 Mapping |
| Bronze | Bz_Webinar | Maximum_Attendees | Source | Webinar | Maximum Attendees | 1-1 Mapping |
| Bronze | Bz_Webinar | Panelist_Count | Source | Webinar | Panelist Count | 1-1 Mapping |
| Bronze | Bz_Webinar | QA_Enabled | Source | Webinar | Q&A Enabled | 1-1 Mapping |
| Bronze | Bz_Webinar | Webinar_Status | Source | Webinar | Webinar Status | 1-1 Mapping |

### 5. Bz_Participant Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | Bz_Participant | Participant_Name | Source | Participant | Participant Name | 1-1 Mapping |
| Bronze | Bz_Participant | Email_Address | Source | Participant | Email Address | 1-1 Mapping |
| Bronze | Bz_Participant | Join_Time | Source | Participant | Join Time | 1-1 Mapping |
| Bronze | Bz_Participant | Leave_Time | Source | Participant | Leave Time | 1-1 Mapping |
| Bronze | Bz_Participant | Duration | Source | Participant | Duration | 1-1 Mapping |
| Bronze | Bz_Participant | Audio_Status | Source | Participant | Audio Status | 1-1 Mapping |
| Bronze | Bz_Participant | Video_Status | Source | Participant | Video Status | 1-1 Mapping |
| Bronze | Bz_Participant | Screen_Share_Usage | Source | Participant | Screen Share Usage | 1-1 Mapping |
| Bronze | Bz_Participant | Chat_Participation | Source | Participant | Chat Participation | 1-1 Mapping |
| Bronze | Bz_Participant | Device_Type | Source | Participant | Device Type | 1-1 Mapping |

### 6. Bz_Recording Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | Bz_Recording | Recording_Name | Source | Recording | Recording Name | 1-1 Mapping |
| Bronze | Bz_Recording | File_Format | Source | Recording | File Format | 1-1 Mapping |
| Bronze | Bz_Recording | File_Size | Source | Recording | File Size | 1-1 Mapping |
| Bronze | Bz_Recording | Recording_Type | Source | Recording | Recording Type | 1-1 Mapping |
| Bronze | Bz_Recording | Start_Time | Source | Recording | Start Time | 1-1 Mapping |
| Bronze | Bz_Recording | End_Time | Source | Recording | End Time | 1-1 Mapping |
| Bronze | Bz_Recording | Duration | Source | Recording | Duration | 1-1 Mapping |
| Bronze | Bz_Recording | Storage_Location | Source | Recording | Storage Location | 1-1 Mapping |
| Bronze | Bz_Recording | Access_Permission | Source | Recording | Access Permission | 1-1 Mapping |
| Bronze | Bz_Recording | Download_Count | Source | Recording | Download Count | 1-1 Mapping |

### 7. Bz_Chat_Message Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | Bz_Chat_Message | Message_Content | Source | Chat Message | Message Content | 1-1 Mapping |
| Bronze | Bz_Chat_Message | Message_Type | Source | Chat Message | Message Type | 1-1 Mapping |
| Bronze | Bz_Chat_Message | Timestamp | Source | Chat Message | Timestamp | 1-1 Mapping |
| Bronze | Bz_Chat_Message | Sender_Name | Source | Chat Message | Sender Name | 1-1 Mapping |
| Bronze | Bz_Chat_Message | Recipient_Name | Source | Chat Message | Recipient Name | 1-1 Mapping |
| Bronze | Bz_Chat_Message | Message_Status | Source | Chat Message | Message Status | 1-1 Mapping |
| Bronze | Bz_Chat_Message | File_Attachment | Source | Chat Message | File Attachment | 1-1 Mapping |
| Bronze | Bz_Chat_Message | Emoji_Usage | Source | Chat Message | Emoji Usage | 1-1 Mapping |

### 8. Bz_Screen_Share Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | Bz_Screen_Share | Session_ID | Source | Screen Share | Session ID | 1-1 Mapping |
| Bronze | Bz_Screen_Share | Participant_Name | Source | Screen Share | Participant Name | 1-1 Mapping |
| Bronze | Bz_Screen_Share | Start_Time | Source | Screen Share | Start Time | 1-1 Mapping |
| Bronze | Bz_Screen_Share | End_Time | Source | Screen Share | End Time | 1-1 Mapping |
| Bronze | Bz_Screen_Share | Duration | Source | Screen Share | Duration | 1-1 Mapping |
| Bronze | Bz_Screen_Share | Content_Type | Source | Screen Share | Content Type | 1-1 Mapping |
| Bronze | Bz_Screen_Share | Quality_Rating | Source | Screen Share | Quality Rating | 1-1 Mapping |
| Bronze | Bz_Screen_Share | Viewer_Count | Source | Screen Share | Viewer Count | 1-1 Mapping |

### 9. Bz_Breakout_Room Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | Bz_Breakout_Room | Room_Name | Source | Breakout Room | Room Name | 1-1 Mapping |
| Bronze | Bz_Breakout_Room | Room_Number | Source | Breakout Room | Room Number | 1-1 Mapping |
| Bronze | Bz_Breakout_Room | Start_Time | Source | Breakout Room | Start Time | 1-1 Mapping |
| Bronze | Bz_Breakout_Room | End_Time | Source | Breakout Room | End Time | 1-1 Mapping |
| Bronze | Bz_Breakout_Room | Duration | Source | Breakout Room | Duration | 1-1 Mapping |
| Bronze | Bz_Breakout_Room | Participant_Count | Source | Breakout Room | Participant Count | 1-1 Mapping |
| Bronze | Bz_Breakout_Room | Room_Status | Source | Breakout Room | Room Status | 1-1 Mapping |
| Bronze | Bz_Breakout_Room | Auto_Assignment | Source | Breakout Room | Auto Assignment | 1-1 Mapping |

### 10. Bz_Poll Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | Bz_Poll | Poll_Question | Source | Poll | Poll Question | 1-1 Mapping |
| Bronze | Bz_Poll | Poll_Type | Source | Poll | Poll Type | 1-1 Mapping |
| Bronze | Bz_Poll | Start_Time | Source | Poll | Start Time | 1-1 Mapping |
| Bronze | Bz_Poll | End_Time | Source | Poll | End Time | 1-1 Mapping |
| Bronze | Bz_Poll | Total_Responses | Source | Poll | Total Responses | 1-1 Mapping |
| Bronze | Bz_Poll | Response_Options | Source | Poll | Response Options | 1-1 Mapping |
| Bronze | Bz_Poll | Anonymous_Voting | Source | Poll | Anonymous Voting | 1-1 Mapping |
| Bronze | Bz_Poll | Poll_Status | Source | Poll | Poll Status | 1-1 Mapping |

### 11. Bz_Analytics_Event Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | Bz_Analytics_Event | Event_Type | Source | Analytics Event | Event Type | 1-1 Mapping |
| Bronze | Bz_Analytics_Event | Event_Name | Source | Analytics Event | Event Name | 1-1 Mapping |
| Bronze | Bz_Analytics_Event | Event_Description | Source | Analytics Event | Event Description | 1-1 Mapping |
| Bronze | Bz_Analytics_Event | Timestamp | Source | Analytics Event | Timestamp | 1-1 Mapping |
| Bronze | Bz_Analytics_Event | Event_Source | Source | Analytics Event | Event Source | 1-1 Mapping |
| Bronze | Bz_Analytics_Event | Event_Severity | Source | Analytics Event | Event Severity | 1-1 Mapping |
| Bronze | Bz_Analytics_Event | Event_Parameters | Source | Analytics Event | Event Parameters | 1-1 Mapping |
| Bronze | Bz_Analytics_Event | Processing_Status | Source | Analytics Event | Processing Status | 1-1 Mapping |

### 12. Bz_Report Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | Bz_Report | Report_Name | Source | Report | Report Name | 1-1 Mapping |
| Bronze | Bz_Report | Report_Type | Source | Report | Report Type | 1-1 Mapping |
| Bronze | Bz_Report | Report_Description | Source | Report | Report Description | 1-1 Mapping |
| Bronze | Bz_Report | Generation_Date | Source | Report | Generation Date | 1-1 Mapping |
| Bronze | Bz_Report | Report_Period | Source | Report | Report Period | 1-1 Mapping |
| Bronze | Bz_Report | Report_Format | Source | Report | Report Format | 1-1 Mapping |
| Bronze | Bz_Report | Report_Status | Source | Report | Report Status | 1-1 Mapping |
| Bronze | Bz_Report | Recipient_List | Source | Report | Recipient List | 1-1 Mapping |
| Bronze | Bz_Report | Delivery_Method | Source | Report | Delivery Method | 1-1 Mapping |

### 13. Bz_Dashboard Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | Bz_Dashboard | Dashboard_Name | Source | Dashboard | Dashboard Name | 1-1 Mapping |
| Bronze | Bz_Dashboard | Dashboard_Type | Source | Dashboard | Dashboard Type | 1-1 Mapping |
| Bronze | Bz_Dashboard | Creation_Date | Source | Dashboard | Creation Date | 1-1 Mapping |
| Bronze | Bz_Dashboard | Last_Updated | Source | Dashboard | Last Updated | 1-1 Mapping |
| Bronze | Bz_Dashboard | Widget_Count | Source | Dashboard | Widget Count | 1-1 Mapping |
| Bronze | Bz_Dashboard | Access_Level | Source | Dashboard | Access Level | 1-1 Mapping |
| Bronze | Bz_Dashboard | Refresh_Frequency | Source | Dashboard | Refresh Frequency | 1-1 Mapping |
| Bronze | Bz_Dashboard | Dashboard_Status | Source | Dashboard | Dashboard Status | 1-1 Mapping |

### 14. Bz_Security_Policy Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | Bz_Security_Policy | Policy_Name | Source | Security Policy | Policy Name | 1-1 Mapping |
| Bronze | Bz_Security_Policy | Policy_Type | Source | Security Policy | Policy Type | 1-1 Mapping |
| Bronze | Bz_Security_Policy | Policy_Description | Source | Security Policy | Policy Description | 1-1 Mapping |
| Bronze | Bz_Security_Policy | Creation_Date | Source | Security Policy | Creation Date | 1-1 Mapping |
| Bronze | Bz_Security_Policy | Effective_Date | Source | Security Policy | Effective Date | 1-1 Mapping |
| Bronze | Bz_Security_Policy | Expiration_Date | Source | Security Policy | Expiration Date | 1-1 Mapping |
| Bronze | Bz_Security_Policy | Policy_Status | Source | Security Policy | Policy Status | 1-1 Mapping |
| Bronze | Bz_Security_Policy | Compliance_Level | Source | Security Policy | Compliance Level | 1-1 Mapping |

### 15. Bz_Audit_Log Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | Bz_Audit_Log | Log_Entry_ID | Source | Audit Log | Log Entry ID | 1-1 Mapping |
| Bronze | Bz_Audit_Log | Event_Type | Source | Audit Log | Event Type | 1-1 Mapping |
| Bronze | Bz_Audit_Log | User_Name | Source | Audit Log | User Name | 1-1 Mapping |
| Bronze | Bz_Audit_Log | Timestamp | Source | Audit Log | Timestamp | 1-1 Mapping |
| Bronze | Bz_Audit_Log | Action_Performed | Source | Audit Log | Action Performed | 1-1 Mapping |
| Bronze | Bz_Audit_Log | Resource_Accessed | Source | Audit Log | Resource Accessed | 1-1 Mapping |
| Bronze | Bz_Audit_Log | IP_Address | Source | Audit Log | IP Address | 1-1 Mapping |
| Bronze | Bz_Audit_Log | Result_Status | Source | Audit Log | Result Status | 1-1 Mapping |

### 16. Bz_Integration Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | Bz_Integration | Integration_Name | Source | Integration | Integration Name | 1-1 Mapping |
| Bronze | Bz_Integration | Integration_Type | Source | Integration | Integration Type | 1-1 Mapping |
| Bronze | Bz_Integration | Provider_Name | Source | Integration | Provider Name | 1-1 Mapping |
| Bronze | Bz_Integration | Configuration_Date | Source | Integration | Configuration Date | 1-1 Mapping |
| Bronze | Bz_Integration | Last_Sync_Date | Source | Integration | Last Sync Date | 1-1 Mapping |
| Bronze | Bz_Integration | Sync_Frequency | Source | Integration | Sync Frequency | 1-1 Mapping |
| Bronze | Bz_Integration | Integration_Status | Source | Integration | Integration Status | 1-1 Mapping |
| Bronze | Bz_Integration | Error_Count | Source | Integration | Error Count | 1-1 Mapping |

### 17. Bz_Device Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | Bz_Device | Device_ID | Source | Device | Device ID | 1-1 Mapping |
| Bronze | Bz_Device | Device_Type | Source | Device | Device Type | 1-1 Mapping |
| Bronze | Bz_Device | Device_Model | Source | Device | Device Model | 1-1 Mapping |
| Bronze | Bz_Device | Operating_System | Source | Device | Operating System | 1-1 Mapping |
| Bronze | Bz_Device | Browser_Type | Source | Device | Browser Type | 1-1 Mapping |
| Bronze | Bz_Device | IP_Address | Source | Device | IP Address | 1-1 Mapping |
| Bronze | Bz_Device | Location | Source | Device | Location | 1-1 Mapping |
| Bronze | Bz_Device | Registration_Date | Source | Device | Registration Date | 1-1 Mapping |

### 18. Bz_License Table Mapping

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | Bz_License | License_ID | Source | License | License ID | 1-1 Mapping |
| Bronze | Bz_License | License_Type | Source | License | License Type | 1-1 Mapping |
| Bronze | Bz_License | License_Name | Source | License | License Name | 1-1 Mapping |
| Bronze | Bz_License | Purchase_Date | Source | License | Purchase Date | 1-1 Mapping |
| Bronze | Bz_License | Expiration_Date | Source | License | Expiration Date | 1-1 Mapping |
| Bronze | Bz_License | Seat_Count | Source | License | Seat Count | 1-1 Mapping |
| Bronze | Bz_License | Used_Seats | Source | License | Used Seats | 1-1 Mapping |
| Bronze | Bz_License | License_Status | Source | License | License Status | 1-1 Mapping |

## Metadata Management

### Data Ingestion Metadata
- **Ingestion Timestamp**: System timestamp when data is loaded into Bronze layer
- **Source System**: Identifier of the originating system
- **Batch ID**: Unique identifier for each data load batch
- **Record Count**: Number of records processed in each batch
- **File Name**: Original source file name (for file-based ingestion)
- **Data Quality Score**: Initial data quality assessment score

### Data Validation Rules

#### Primary Validation Rules
1. **Null Value Checks**: Identify and flag null values in critical fields
2. **Data Type Validation**: Ensure data types match expected schema
3. **Format Validation**: Validate email addresses, phone numbers, and date formats
4. **Range Validation**: Check numeric values are within expected ranges
5. **Referential Integrity**: Validate foreign key relationships where applicable

#### Secondary Validation Rules
1. **Duplicate Detection**: Identify potential duplicate records
2. **Business Rule Validation**: Apply domain-specific business rules
3. **Completeness Checks**: Ensure required fields are populated
4. **Consistency Checks**: Validate data consistency across related fields
5. **Historical Validation**: Compare against historical data patterns

## Data Governance Framework

### Data Lineage Tracking
- Source to Bronze layer mapping documentation
- Data transformation audit trail
- Impact analysis for schema changes
- Data flow documentation

### Data Quality Monitoring
- Automated data quality checks on ingestion
- Exception handling and error logging
- Data quality metrics and KPIs
- Alerting mechanisms for data quality issues

### Security and Compliance
- Data classification and sensitivity labeling
- Access control and authorization
- Data retention policies
- Audit logging for all data access and modifications

This Bronze layer data mapping provides the foundation for the Medallion architecture implementation, ensuring robust data ingestion, preservation of data lineage, and establishment of data governance practices for the Zoom Platform Analytics System.