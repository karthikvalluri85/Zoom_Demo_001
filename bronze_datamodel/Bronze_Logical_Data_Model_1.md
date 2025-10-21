_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Bronze Layer Logical Data Model for Zoom Platform Analytics System covering user management, meetings, analytics, and reporting capabilities
## *Version*: 1
## *Updated on*: 
_____________________________________________

# Bronze Layer Logical Data Model for Zoom Platform Analytics System

## 1. PII Classification

| Column Name | Entity | Reason for PII Classification |
|-------------|--------|---------------------------------|
| User Name | Bz_User | Directly identifies an individual user by their full name |
| Email Address | Bz_User, Bz_Participant | Personal contact information that can identify individuals |
| Profile Picture URL | Bz_User | Contains personal identifiable media linked to an individual |
| Contact Email | Bz_Account | Business/personal contact information for account management |
| Phone Number | Bz_Account | Personal/business contact information that can identify individuals |
| Participant Name | Bz_Participant | Directly identifies an individual participant in meetings/webinars |
| Sender Name | Bz_Chat_Message | Identifies the individual who sent the chat message |
| Recipient Name | Bz_Chat_Message | Identifies the individual who received the chat message |
| User Involved | Bz_Audit_Log | Identifies specific users involved in audit events |

## 2. Bronze Layer Logical Model

### 2.1 Bz_User
**Description:** Stores individual user information who access the Zoom platform with their profile information and preferences

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| user_name | STRING | Full name of the user |
| email_address | STRING | Primary email address for communication |
| department | STRING | Organizational department or division |
| job_title | STRING | Professional role or position |
| time_zone | STRING | Geographic time zone preference |
| language_preference | STRING | Preferred language for interface |
| profile_picture_url | STRING | Location of user's profile image |
| account_status | STRING | Current status of user account (active, inactive, suspended) |
| last_login_date | TIMESTAMP | Most recent platform access timestamp |
| registration_date | DATE | Date when user account was created |
| load_timestamp | TIMESTAMP | Timestamp when the record was loaded into Bronze layer |
| update_timestamp | TIMESTAMP | Timestamp of the last update to the record |
| source_system | STRING | Source system identifier |

### 2.2 Bz_Account
**Description:** Stores organizational accounts that manage multiple users and billing information

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| account_name | STRING | Name of the organizational account |
| account_type | STRING | Type of subscription (Basic, Pro, Business, Enterprise) |
| billing_address | STRING | Physical address for billing purposes |
| contact_email | STRING | Primary contact email for account management |
| phone_number | STRING | Primary contact phone number |
| industry | STRING | Business industry classification |
| company_size | INTEGER | Number of employees in the organization |
| subscription_start_date | DATE | Date when subscription began |
| subscription_end_date | DATE | Date when subscription expires |
| payment_status | STRING | Current billing status |
| load_timestamp | TIMESTAMP | Timestamp when the record was loaded into Bronze layer |
| update_timestamp | TIMESTAMP | Timestamp of the last update to the record |
| source_system | STRING | Source system identifier |

### 2.3 Bz_Meeting
**Description:** Stores scheduled or instant video conferences with associated metadata

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| meeting_topic | STRING | Subject or title of the meeting |
| meeting_type | STRING | Type of meeting (scheduled, instant, recurring) |
| start_time | TIMESTAMP | Scheduled or actual start time |
| end_time | TIMESTAMP | Scheduled or actual end time |
| duration | INTEGER | Total length of the meeting in seconds |
| meeting_password | STRING | Security password if required |
| waiting_room_enabled | BOOLEAN | Whether waiting room feature is active |
| recording_permission | STRING | Who is allowed to record |
| maximum_participants | INTEGER | Limit on number of attendees |
| meeting_status | STRING | Current status (scheduled, in-progress, ended, cancelled) |
| load_timestamp | TIMESTAMP | Timestamp when the record was loaded into Bronze layer |
| update_timestamp | TIMESTAMP | Timestamp of the last update to the record |
| source_system | STRING | Source system identifier |

### 2.4 Bz_Webinar
**Description:** Stores large-scale broadcast events with presenter and attendee roles

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| webinar_title | STRING | Name or title of the webinar |
| description | STRING | Detailed description of webinar content |
| start_time | TIMESTAMP | Scheduled start time |
| end_time | TIMESTAMP | Scheduled end time |
| duration | INTEGER | Total length of the webinar in seconds |
| registration_required | BOOLEAN | Whether attendees must register |
| maximum_attendees | INTEGER | Limit on number of participants |
| panelist_count | INTEGER | Number of presenters or panelists |
| q_and_a_enabled | BOOLEAN | Whether question and answer feature is active |
| webinar_status | STRING | Current status of the webinar |
| load_timestamp | TIMESTAMP | Timestamp when the record was loaded into Bronze layer |
| update_timestamp | TIMESTAMP | Timestamp of the last update to the record |
| source_system | STRING | Source system identifier |

### 2.5 Bz_Participant
**Description:** Stores individuals who join meetings or webinars with their engagement data

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| participant_name | STRING | Name of the meeting or webinar participant |
| email_address | STRING | Email address of the participant |
| join_time | TIMESTAMP | Time when participant joined the session |
| leave_time | TIMESTAMP | Time when participant left the session |
| duration | INTEGER | Total time spent in the session in seconds |
| audio_status | STRING | Whether audio was enabled/disabled |
| video_status | STRING | Whether video was enabled/disabled |
| screen_share_usage | BOOLEAN | Whether participant shared screen |
| chat_participation | STRING | Level of chat engagement |
| device_type | STRING | Type of device used to join |
| load_timestamp | TIMESTAMP | Timestamp when the record was loaded into Bronze layer |
| update_timestamp | TIMESTAMP | Timestamp of the last update to the record |
| source_system | STRING | Source system identifier |

### 2.6 Bz_Recording
**Description:** Stores audio/video recordings of meetings and webinars with storage details

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| recording_name | STRING | Title or name of the recording |
| file_format | STRING | Format of the recorded file (MP4, M4A, etc.) |
| file_size | INTEGER | Size of the recording file in bytes |
| recording_type | STRING | Type of recording (cloud, local) |
| start_time | TIMESTAMP | When recording began |
| end_time | TIMESTAMP | When recording ended |
| duration | INTEGER | Total length of recording in seconds |
| storage_location | STRING | Where the recording is stored |
| access_permission | STRING | Who can access the recording |
| download_count | INTEGER | Number of times recording was downloaded |
| load_timestamp | TIMESTAMP | Timestamp when the record was loaded into Bronze layer |
| update_timestamp | TIMESTAMP | Timestamp of the last update to the record |
| source_system | STRING | Source system identifier |

### 2.7 Bz_Chat_Message
**Description:** Stores text communications during meetings and webinars

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| message_content | STRING | Text content of the chat message |
| message_type | STRING | Type of message (public, private, to host) |
| timestamp | TIMESTAMP | When the message was sent |
| sender_name | STRING | Name of the person who sent the message |
| recipient_name | STRING | Name of the message recipient (if private) |
| message_status | STRING | Status of the message delivery |
| file_attachment | BOOLEAN | Whether message includes file attachment |
| emoji_usage | BOOLEAN | Whether message contains emoji reactions |
| load_timestamp | TIMESTAMP | Timestamp when the record was loaded into Bronze layer |
| update_timestamp | TIMESTAMP | Timestamp of the last update to the record |
| source_system | STRING | Source system identifier |

### 2.8 Bz_Screen_Share
**Description:** Stores screen sharing sessions during meetings with content metadata

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| session_name | STRING | Name or identifier of the screen share session |
| start_time | TIMESTAMP | When screen sharing started |
| end_time | TIMESTAMP | When screen sharing ended |
| duration | INTEGER | Total length of screen sharing in seconds |
| content_type | STRING | Type of content being shared |
| quality_settings | STRING | Video quality settings used |
| load_timestamp | TIMESTAMP | Timestamp when the record was loaded into Bronze layer |
| update_timestamp | TIMESTAMP | Timestamp of the last update to the record |
| source_system | STRING | Source system identifier |

### 2.9 Bz_Breakout_Room
**Description:** Stores smaller group sessions within larger meetings

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| room_name | STRING | Name of the breakout room |
| start_time | TIMESTAMP | When breakout room session started |
| end_time | TIMESTAMP | When breakout room session ended |
| duration | INTEGER | Total length of breakout room session in seconds |
| participant_count | INTEGER | Number of participants in breakout room |
| room_status | STRING | Status of the breakout room |
| load_timestamp | TIMESTAMP | Timestamp when the record was loaded into Bronze layer |
| update_timestamp | TIMESTAMP | Timestamp of the last update to the record |
| source_system | STRING | Source system identifier |

### 2.10 Bz_Poll
**Description:** Stores interactive polls conducted during meetings and webinars

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| poll_question | STRING | Question asked in the poll |
| poll_type | STRING | Type of poll (single choice, multiple choice) |
| start_time | TIMESTAMP | When poll started |
| end_time | TIMESTAMP | When poll ended |
| total_responses | INTEGER | Number of responses received |
| poll_status | STRING | Status of the poll |
| load_timestamp | TIMESTAMP | Timestamp when the record was loaded into Bronze layer |
| update_timestamp | TIMESTAMP | Timestamp of the last update to the record |
| source_system | STRING | Source system identifier |

### 2.11 Bz_Analytics_Event
**Description:** Stores tracked user actions and system events for analysis

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| event_type | STRING | Category of the tracked event |
| event_name | STRING | Specific name of the event |
| event_description | STRING | Detailed description of what occurred |
| timestamp | TIMESTAMP | When the event occurred |
| event_source | STRING | Origin system or component that generated the event |
| event_severity | STRING | Importance level of the event |
| event_parameters | STRING | Additional data associated with the event |
| processing_status | STRING | Whether event has been processed |
| load_timestamp | TIMESTAMP | Timestamp when the record was loaded into Bronze layer |
| update_timestamp | TIMESTAMP | Timestamp of the last update to the record |
| source_system | STRING | Source system identifier |

### 2.12 Bz_Report
**Description:** Stores generated analytical reports with metrics and insights

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| report_name | STRING | Title of the analytical report |
| report_type | STRING | Category of report (usage, performance, security) |
| report_description | STRING | Summary of report contents |
| generation_date | DATE | When the report was created |
| report_period | STRING | Time range covered by the report |
| report_format | STRING | Output format (PDF, Excel, CSV) |
| report_status | STRING | Current status of report generation |
| recipient_list | STRING | Who receives the report |
| delivery_method | STRING | How the report is distributed |
| load_timestamp | TIMESTAMP | Timestamp when the record was loaded into Bronze layer |
| update_timestamp | TIMESTAMP | Timestamp of the last update to the record |
| source_system | STRING | Source system identifier |

### 2.13 Bz_Dashboard
**Description:** Stores visual interfaces displaying key performance indicators

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| dashboard_name | STRING | Name of the dashboard |
| dashboard_type | STRING | Type of dashboard (executive, operational, analytical) |
| description | STRING | Description of dashboard content |
| creation_date | DATE | Date when dashboard was created |
| last_modified_date | DATE | Date when dashboard was last modified |
| access_level | STRING | Who can access the dashboard |
| refresh_frequency | STRING | How often dashboard data is updated |
| load_timestamp | TIMESTAMP | Timestamp when the record was loaded into Bronze layer |
| update_timestamp | TIMESTAMP | Timestamp of the last update to the record |
| source_system | STRING | Source system identifier |

### 2.14 Bz_Security_Policy
**Description:** Stores security rules and configurations for the platform

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| policy_name | STRING | Name of the security policy |
| policy_type | STRING | Type of security policy |
| description | STRING | Description of the policy |
| effective_date | DATE | Date when policy became effective |
| expiry_date | DATE | Date when policy expires |
| policy_status | STRING | Status of the policy (active, inactive) |
| compliance_level | STRING | Level of compliance required |
| load_timestamp | TIMESTAMP | Timestamp when the record was loaded into Bronze layer |
| update_timestamp | TIMESTAMP | Timestamp of the last update to the record |
| source_system | STRING | Source system identifier |

### 2.15 Bz_Audit_Log
**Description:** Stores security and compliance tracking records

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| audit_event | STRING | Description of the audit event |
| event_timestamp | TIMESTAMP | When the audit event occurred |
| user_involved | STRING | User involved in the event |
| action_taken | STRING | Action performed |
| event_category | STRING | Category of audit event |
| severity_level | STRING | Severity level of the audit event |
| load_timestamp | TIMESTAMP | Timestamp when the record was loaded into Bronze layer |
| update_timestamp | TIMESTAMP | Timestamp of the last update to the record |
| source_system | STRING | Source system identifier |

### 2.16 Bz_Integration
**Description:** Stores connections with external systems and applications

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| integration_name | STRING | Name of the integration |
| integration_type | STRING | Type of integration (API, webhook, etc.) |
| connection_status | STRING | Status of the connection |
| last_sync_time | TIMESTAMP | Last synchronization timestamp |
| sync_frequency | STRING | How often synchronization occurs |
| data_volume | INTEGER | Amount of data synchronized |
| load_timestamp | TIMESTAMP | Timestamp when the record was loaded into Bronze layer |
| update_timestamp | TIMESTAMP | Timestamp of the last update to the record |
| source_system | STRING | Source system identifier |

### 2.17 Bz_Device
**Description:** Stores hardware devices used to access the platform

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| device_name | STRING | Name of the device |
| device_type | STRING | Type of device (desktop, mobile, tablet) |
| operating_system | STRING | Operating system of the device |
| os_version | STRING | Operating system version |
| browser_type | STRING | Browser used to access platform |
| last_active_time | TIMESTAMP | Last time device was active |
| load_timestamp | TIMESTAMP | Timestamp when the record was loaded into Bronze layer |
| update_timestamp | TIMESTAMP | Timestamp of the last update to the record |
| source_system | STRING | Source system identifier |

### 2.18 Bz_License
**Description:** Stores subscription plans and feature entitlements

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| license_type | STRING | Type of subscription plan |
| feature_entitlements | STRING | Features included in the license |
| start_date | DATE | License start date |
| end_date | DATE | License end date |
| license_status | STRING | Status of the license (active, expired) |
| user_limit | INTEGER | Maximum number of users allowed |
| load_timestamp | TIMESTAMP | Timestamp when the record was loaded into Bronze layer |
| update_timestamp | TIMESTAMP | Timestamp of the last update to the record |
| source_system | STRING | Source system identifier |

## 3. Audit Table Design

### Bz_Audit_Table
**Description:** Tracks data processing activities and lineage for all Bronze layer tables

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| record_id | STRING | Unique identifier for the audit record |
| source_table | STRING | Name of the source table being audited |
| load_timestamp | TIMESTAMP | Timestamp when the record was loaded |
| processed_by | STRING | Identifier of the process or user processing the record |
| processing_time | INTEGER | Time taken to process the record in milliseconds |
| status | STRING | Processing status (success, failure, pending) |

## 4. Conceptual Data Model Diagram

### Block Diagram Format:

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Bz_Account    │────│    Bz_User      │────│   Bz_Device     │
│                 │    │                 │    │                 │
│ Connected by:   │    │ Connected by:   │    │ Connected by:   │
│ Account Name    │    │ User Name       │    │ Device Type     │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Bz_License    │    │   Bz_Meeting    │────│ Bz_Participant  │
│                 │    │                 │    │                 │
│ Connected by:   │    │ Connected by:   │    │ Connected by:   │
│ Account Name    │    │ Meeting Topic   │    │ Participant Name│
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                │                       │
                                │                       │
                                ▼                       ▼
                       ┌─────────────────┐    ┌─────────────────┐
                       │   Bz_Webinar    │    │  Bz_Recording   │
                       │                 │    │                 │
                       │ Connected by:   │    │ Connected by:   │
                       │ Webinar Title   │    │ Recording Name  │
                       └─────────────────┘    └─────────────────┘
                                │                       │
                                │                       │
                                ▼                       ▼
                       ┌─────────────────┐    ┌─────────────────┐
                       │Bz_Chat_Message  │    │ Bz_Screen_Share │
                       │                 │    │                 │
                       │ Connected by:   │    │ Connected by:   │
                       │ Sender Name     │    │ Session Name    │
                       └─────────────────┘    └─────────────────┘
                                │
                                │
                                ▼
                       ┌─────────────────┐    ┌─────────────────┐
                       │Bz_Breakout_Room │    │    Bz_Poll      │
                       │                 │    │                 │
                       │ Connected by:   │    │ Connected by:   │
                       │ Room Name       │    │ Poll Question   │
                       └─────────────────┘    └─────────────────┘
                                │                       │
                                │                       │
                                ▼                       ▼
                       ┌─────────────────┐    ┌─────────────────┐
                       │Bz_Analytics_Event│   │   Bz_Report     │
                       │                 │    │                 │
                       │ Connected by:   │    │ Connected by:   │
                       │ Event Type      │    │ Report Name     │
                       └─────────────────┘    └─────────────────┘
                                │                       │
                                │                       │
                                ▼                       ▼
                       ┌─────────────────┐    ┌─────────────────┐
                       │  Bz_Dashboard   │    │Bz_Security_Policy│
                       │                 │    │                 │
                       │ Connected by:   │    │ Connected by:   │
                       │ Dashboard Name  │    │ Policy Name     │
                       └─────────────────┘    └─────────────────┘
                                │                       │
                                │                       │
                                ▼                       ▼
                       ┌─────────────────┐    ┌─────────────────┐
                       │ Bz_Integration  │    │  Bz_Audit_Log   │
                       │                 │    │                 │
                       │ Connected by:   │    │ Connected by:   │
                       │Integration Name │    │ User Involved   │
                       └─────────────────┘    └─────────────────┘
```

### Key Relationships:
1. **Bz_Account** connects to **Bz_User** via Account Name
2. **Bz_User** connects to **Bz_Meeting** via User Name
3. **Bz_Meeting** connects to **Bz_Participant** via Meeting Topic
4. **Bz_Webinar** connects to **Bz_Participant** via Webinar Title
5. **Bz_Meeting/Webinar** connects to **Bz_Recording** via Meeting Topic/Webinar Title
6. **Bz_Participant** connects to **Bz_Chat_Message** via Participant Name
7. **Bz_Meeting** connects to **Bz_Screen_Share** via Meeting Topic
8. **Bz_Meeting** connects to **Bz_Breakout_Room** via Meeting Topic
9. **Bz_Meeting/Webinar** connects to **Bz_Poll** via Meeting Topic/Webinar Title
10. **Bz_User** connects to **Bz_Analytics_Event** via User Name
11. **Bz_Analytics_Event** connects to **Bz_Report** via Event Type
12. **Bz_Report** connects to **Bz_Dashboard** via Report Name
13. **Bz_Account** connects to **Bz_Security_Policy** via Account Name
14. **Bz_User** connects to **Bz_Audit_Log** via User Name
15. **Bz_Account** connects to **Bz_Integration** via Account Name
16. **Bz_Participant** connects to **Bz_Device** via Device Type
17. **Bz_Account** connects to **Bz_License** via Account Name