_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Bronze Layer Logical Data Model for Zoom Platform Analytics System covering user management, meetings, analytics, and reporting capabilities
## *Version*: 1
## *Updated on*: 
_____________________________________________

# Zoom Platform Analytics System - Bronze Layer Logical Data Model

## 1. PII Classification

### PII Fields Identified:

1. **user_name** (Bz_User) - Contains individual's full name which directly identifies a person
2. **email_address** (Bz_User) - Personal contact information that can identify an individual
3. **billing_address** (Bz_Account) - Physical address information that can identify location and individual
4. **contact_email** (Bz_Account) - Contact information that can identify an individual
5. **phone_number** (Bz_Account) - Personal contact information that can identify an individual
6. **meeting_password** (Bz_Meeting) - Security credential that could provide unauthorized access
7. **participant_name** (Bz_Participant) - Individual's name that directly identifies a person
8. **participant_email** (Bz_Participant) - Personal contact information that can identify an individual
9. **sender_name** (Bz_Chat_Message) - Individual's name that directly identifies a person
10. **sender_email** (Bz_Chat_Message) - Personal contact information that can identify an individual
11. **user_id** (Bz_Analytics_Event) - Identifier that can be used to track individual user behavior

## 2. Bronze Layer Logical Model

### 2.1 Bz_User
**Description**: Stores individual user information who access the Zoom platform with their profile information and preferences

| Column Name           | Data Type | Description                         |
|-----------------------|-----------|---------------------------------|
| user_name             | STRING    | User's full name                  |
| email_address         | STRING    | User's email address              |
| department            | STRING    | Department of the user            |
| job_title             | STRING    | User's job title                  |
| time_zone             | STRING    | User's time zone                  |
| language_preference   | STRING    | Preferred language of the user    |
| profile_picture_url   | STRING    | URL to user's profile picture    |
| account_status        | STRING    | Status of the user account       |
| last_login_date       | TIMESTAMP | Last login date and time          |
| registration_date     | TIMESTAMP | Date when user registered         |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     |
| source_system         | STRING    | Source system name or identifier  |

### 2.2 Bz_Account
**Description**: Stores organizational accounts that manage multiple users and billing information

| Column Name           | Data Type | Description                         |
|-----------------------|-----------|---------------------------------|
| account_name          | STRING    | Name of the organizational account |
| account_type          | STRING    | Type of account subscription      |
| billing_address       | STRING    | Billing address of the account   |
| contact_email         | STRING    | Contact email for the account    |
| phone_number          | STRING    | Contact phone number             |
| industry              | STRING    | Industry sector                  |
| company_size          | STRING    | Size of the company              |
| subscription_start_date | TIMESTAMP | Subscription start date          |
| subscription_end_date | TIMESTAMP | Subscription end date            |
| payment_status        | STRING    | Payment status                   |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     |
| source_system         | STRING    | Source system name or identifier  |

### 2.3 Bz_Meeting
**Description**: Stores scheduled or instant video conferences with associated metadata

| Column Name           | Data Type | Description                         |
|-----------------------|-----------|---------------------------------|
| meeting_topic         | STRING    | Topic or subject of the meeting  |
| meeting_type          | STRING    | Type of meeting (scheduled/instant/recurring) |
| start_time            | TIMESTAMP | Meeting start time               |
| end_time              | TIMESTAMP | Meeting end time                 |
| duration              | INTEGER   | Duration in minutes              |
| meeting_password      | STRING    | Password for meeting access     |
| waiting_room_enabled  | BOOLEAN   | Whether waiting room is enabled |
| recording_permission  | STRING    | Who is allowed to record         |
| maximum_participants  | INTEGER   | Max number of participants      |
| meeting_status        | STRING    | Status of the meeting            |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     |
| source_system         | STRING    | Source system name or identifier  |

### 2.4 Bz_Webinar
**Description**: Stores large-scale broadcast events with presenter and attendee roles

| Column Name           | Data Type | Description                         |
|-----------------------|-----------|---------------------------------|
| webinar_title         | STRING    | Name or title of the webinar    |
| description           | STRING    | Detailed description of webinar content |
| start_time            | TIMESTAMP | Scheduled start time             |
| end_time              | TIMESTAMP | Scheduled end time               |
| duration              | INTEGER   | Total length of the webinar     |
| registration_required | BOOLEAN   | Whether attendees must register |
| maximum_attendees     | INTEGER   | Limit on number of participants |
| panelist_count        | INTEGER   | Number of presenters or panelists |
| qa_enabled            | BOOLEAN   | Whether question and answer feature is active |
| webinar_status        | STRING    | Current status of the webinar   |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     |
| source_system         | STRING    | Source system name or identifier  |

### 2.5 Bz_Participant
**Description**: Stores individuals who join meetings or webinars with their engagement data

| Column Name           | Data Type | Description                         |
|-----------------------|-----------|---------------------------------|
| participant_name      | STRING    | Name of the meeting or webinar participant |
| email_address         | STRING    | Email address of the participant |
| join_time             | TIMESTAMP | Time when participant joined the session |
| leave_time            | TIMESTAMP | Time when participant left the session |
| duration              | INTEGER   | Total time spent in the session |
| audio_status          | STRING    | Whether audio was enabled/disabled |
| video_status          | STRING    | Whether video was enabled/disabled |
| screen_share_usage    | BOOLEAN   | Whether participant shared screen |
| chat_participation    | STRING    | Level of chat engagement         |
| device_type           | STRING    | Type of device used to join     |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     |
| source_system         | STRING    | Source system name or identifier  |

### 2.6 Bz_Recording
**Description**: Stores audio/video recordings of meetings and webinars with storage details

| Column Name           | Data Type | Description                         |
|-----------------------|-----------|---------------------------------|
| recording_name        | STRING    | Title or name of the recording  |
| file_format           | STRING    | Format of the recorded file (MP4, M4A, etc.) |
| file_size             | BIGINT    | Size of the recording file      |
| recording_type        | STRING    | Type of recording (cloud, local) |
| start_time            | TIMESTAMP | When recording began            |
| end_time              | TIMESTAMP | When recording ended            |
| duration              | INTEGER   | Total length of recording       |
| storage_location      | STRING    | Where the recording is stored   |
| access_permission     | STRING    | Who can access the recording    |
| download_count        | INTEGER   | Number of times recording was downloaded |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     |
| source_system         | STRING    | Source system name or identifier  |

### 2.7 Bz_Chat_Message
**Description**: Stores text communications during meetings and webinars

| Column Name           | Data Type | Description                         |
|-----------------------|-----------|---------------------------------|
| message_content       | STRING    | Text content of the chat message |
| message_type          | STRING    | Type of message (public, private, to host) |
| timestamp             | TIMESTAMP | When the message was sent       |
| sender_name           | STRING    | Name of the person who sent the message |
| recipient_name        | STRING    | Name of the message recipient (if private) |
| message_status        | STRING    | Status of the message delivery  |
| file_attachment       | BOOLEAN   | Whether message includes file attachment |
| emoji_usage           | BOOLEAN   | Whether message contains emoji reactions |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     |
| source_system         | STRING    | Source system name or identifier  |

### 2.8 Bz_Screen_Share
**Description**: Stores screen sharing sessions during meetings with content metadata

| Column Name           | Data Type | Description                         |
|-----------------------|-----------|---------------------------------|
| session_id            | STRING    | Unique identifier for screen share session |
| content_metadata      | STRING    | Metadata about shared content    |
| start_time            | TIMESTAMP | Screen share start time          |
| end_time              | TIMESTAMP | Screen share end time            |
| duration              | INTEGER   | Duration of screen share in minutes |
| presenter_name        | STRING    | Name of person sharing screen   |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     |
| source_system         | STRING    | Source system name or identifier  |

### 2.9 Bz_Breakout_Room
**Description**: Stores smaller group sessions within larger meetings

| Column Name           | Data Type | Description                         |
|-----------------------|-----------|---------------------------------|
| room_name             | STRING    | Name of the breakout room        |
| room_number           | INTEGER   | Number identifier of the room   |
| start_time            | TIMESTAMP | Breakout room start time         |
| end_time              | TIMESTAMP | Breakout room end time           |
| duration              | INTEGER   | Duration of breakout session    |
| participant_count     | INTEGER   | Number of participants in room  |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     |
| source_system         | STRING    | Source system name or identifier  |

### 2.10 Bz_Poll
**Description**: Stores interactive polls conducted during meetings and webinars

| Column Name           | Data Type | Description                         |
|-----------------------|-----------|---------------------------------|
| poll_question         | STRING    | The poll question text          |
| poll_options          | STRING    | Available options for the poll  |
| poll_results          | STRING    | Results and responses to the poll |
| poll_start_time       | TIMESTAMP | When the poll was launched      |
| poll_end_time         | TIMESTAMP | When the poll was closed        |
| response_count        | INTEGER   | Number of responses received    |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     |
| source_system         | STRING    | Source system name or identifier  |

### 2.11 Bz_Analytics_Event
**Description**: Stores tracked user actions and system events for analysis

| Column Name           | Data Type | Description                         |
|-----------------------|-----------|---------------------------------|
| event_type            | STRING    | Category of the tracked event   |
| event_name            | STRING    | Specific name of the event      |
| event_description     | STRING    | Detailed description of what occurred |
| timestamp             | TIMESTAMP | When the event occurred         |
| event_source          | STRING    | Origin system or component that generated the event |
| event_severity        | STRING    | Importance level of the event   |
| event_parameters      | STRING    | Additional data associated with the event |
| processing_status     | STRING    | Whether event has been processed |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     |
| source_system         | STRING    | Source system name or identifier  |

### 2.12 Bz_Report
**Description**: Stores generated analytical reports with metrics and insights

| Column Name           | Data Type | Description                         |
|-----------------------|-----------|---------------------------------|
| report_name           | STRING    | Title of the analytical report  |
| report_type           | STRING    | Category of report (usage, performance, security) |
| report_description    | STRING    | Summary of report contents      |
| generation_date       | TIMESTAMP | When the report was created     |
| report_period         | STRING    | Time range covered by the report |
| report_format         | STRING    | Output format (PDF, Excel, CSV) |
| report_status         | STRING    | Current status of report generation |
| recipient_list        | STRING    | Who receives the report         |
| delivery_method       | STRING    | How the report is distributed   |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     |
| source_system         | STRING    | Source system name or identifier  |

### 2.13 Bz_Dashboard
**Description**: Stores visual interfaces displaying key performance indicators

| Column Name           | Data Type | Description                         |
|-----------------------|-----------|---------------------------------|
| dashboard_name        | STRING    | Name of the dashboard           |
| dashboard_type        | STRING    | Type or category of dashboard   |
| kpi_list              | STRING    | List of KPIs displayed          |
| last_updated          | TIMESTAMP | Last update timestamp           |
| refresh_frequency     | STRING    | How often dashboard is updated  |
| access_permissions    | STRING    | Who can view the dashboard      |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     |
| source_system         | STRING    | Source system name or identifier  |

### 2.14 Bz_Security_Policy
**Description**: Stores security rules and configurations for the platform

| Column Name           | Data Type | Description                         |
|-----------------------|-----------|---------------------------------|
| policy_name           | STRING    | Name of the security policy    |
| policy_type           | STRING    | Type or category of policy     |
| policy_description    | STRING    | Description of the policy      |
| effective_date        | TIMESTAMP | Date policy became effective   |
| expiry_date           | TIMESTAMP | Date policy expires            |
| compliance_standard   | STRING    | Regulatory standard it addresses |
| enforcement_level     | STRING    | How strictly policy is enforced |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     |
| source_system         | STRING    | Source system name or identifier  |

### 2.15 Bz_Audit_Log
**Description**: Stores security and compliance tracking records

| Column Name           | Data Type | Description                         |
|-----------------------|-----------|---------------------------------|
| audit_event_type      | STRING    | Type of audited event           |
| event_timestamp       | TIMESTAMP | When the audited event occurred |
| user_identifier       | STRING    | User associated with the event |
| action_performed      | STRING    | What action was performed       |
| resource_accessed     | STRING    | What resource was accessed      |
| event_outcome         | STRING    | Success or failure of the event |
| ip_address            | STRING    | IP address of the user          |
| session_id            | STRING    | Session identifier              |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     |
| source_system         | STRING    | Source system name or identifier  |

### 2.16 Bz_Integration
**Description**: Stores connections with external systems and applications

| Column Name           | Data Type | Description                         |
|-----------------------|-----------|---------------------------------|
| integration_name      | STRING    | Name of the integration          |
| integration_type      | STRING    | Type of integration (API, webhook, etc.) |
| external_system       | STRING    | Name of the external system     |
| connection_status     | STRING    | Current status of the connection |
| last_sync_time        | TIMESTAMP | Last synchronization time        |
| sync_frequency        | STRING    | How often data is synchronized  |
| data_flow_direction   | STRING    | Direction of data flow          |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     |
| source_system         | STRING    | Source system name or identifier  |

### 2.17 Bz_Device
**Description**: Stores hardware devices used to access the platform

| Column Name           | Data Type | Description                         |
|-----------------------|-----------|---------------------------------|
| device_identifier     | STRING    | Unique identifier of the device |
| device_type           | STRING    | Type of device (mobile, desktop, tablet) |
| operating_system      | STRING    | Operating system of the device  |
| browser_type          | STRING    | Browser used to access platform |
| device_model          | STRING    | Model of the device             |
| last_used             | TIMESTAMP | Last used timestamp             |
| registration_date     | TIMESTAMP | When device was first registered |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     |
| source_system         | STRING    | Source system name or identifier  |

### 2.18 Bz_License
**Description**: Stores subscription plans and feature entitlements

| Column Name           | Data Type | Description                         |
|-----------------------|-----------|---------------------------------|
| license_type          | STRING    | Type of license (Basic, Pro, Business, Enterprise) |
| feature_entitlements  | STRING    | Features included in license    |
| license_status        | STRING    | Current status of the license   |
| allocation_count      | INTEGER   | Number of licenses allocated    |
| usage_count           | INTEGER   | Number of licenses currently used |
| subscription_start_date | TIMESTAMP | Subscription start date          |
| subscription_end_date | TIMESTAMP | Subscription end date            |
| auto_renewal          | BOOLEAN   | Whether license auto-renews     |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     |
| source_system         | STRING    | Source system name or identifier  |

## 3. Audit Table Design

### Bz_Audit_Table
**Description**: Tracks data processing activities across all Bronze layer tables

| Column Name           | Data Type | Description                         |
|-----------------------|-----------|---------------------------------|
| record_id             | STRING    | Unique identifier for audit record |
| source_table          | STRING    | Name of the source table         |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      |
| processed_by          | STRING    | Identifier of the processor       |
| processing_time       | INTEGER   | Processing time in milliseconds   |
| status                | STRING    | Processing status (success/failure) |

## 4. Conceptual Data Model Diagram

### Block Diagram Format:

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Bz_Account    │────│    Bz_User      │────│   Bz_License    │
│                 │    │                 │    │                 │
│ Connected by:   │    │ Connected by:   │    │ Connected by:   │
│ account_name    │    │ user_name       │    │ license_type    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  Bz_Security_   │    │   Bz_Meeting    │────│  Bz_Participant │
│    Policy       │    │                 │    │                 │
│                 │    │ Connected by:   │    │ Connected by:   │
│ Connected by:   │    │ meeting_topic   │    │participant_name │
│ account_name    │    └─────────────────┘    └─────────────────┘
└─────────────────┘             │                       │
         │                      │                       │
         │                      ▼                       ▼
         │             ┌─────────────────┐    ┌─────────────────┐
         │             │   Bz_Webinar    │    │  Bz_Recording   │
         │             │                 │    │                 │
         │             │ Connected by:   │    │ Connected by:   │
         │             │ webinar_title   │    │ recording_name  │
         │             └─────────────────┘    └─────────────────┘
         │                      │                       │
         │                      │                       │
         ▼                      ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Bz_Audit_Log  │    │ Bz_Breakout_Room│    │ Bz_Chat_Message │
│                 │    │                 │    │                 │
│ Connected by:   │    │ Connected by:   │    │ Connected by:   │
│user_identifier  │    │ room_name       │    │ sender_name     │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│Analytics_Event  │    │    Bz_Poll      │    │ Bz_Screen_Share │
│                 │    │                 │    │                 │
│ Connected by:   │    │ Connected by:   │    │ Connected by:   │
│ event_name      │    │ poll_question   │    │ session_id      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Bz_Report     │    │  Bz_Dashboard   │    │ Bz_Integration  │
│                 │    │                 │    │                 │
│ Connected by:   │    │ Connected by:   │    │ Connected by:   │
│ report_name     │    │dashboard_name   │    │integration_name │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                                 ▼
                        ┌─────────────────┐
                        │   Bz_Device     │
                        │                 │
                        │ Connected by:   │
                        │device_identifier│
                        └─────────────────┘
```

### Table Relationships:

1. **Bz_Account** connects to **Bz_User** by `account_name`
2. **Bz_User** connects to **Bz_Meeting** by `user_name`
3. **Bz_User** connects to **Bz_Webinar** by `user_name`
4. **Bz_Meeting** connects to **Bz_Participant** by `meeting_topic`
5. **Bz_Webinar** connects to **Bz_Participant** by `webinar_title`
6. **Bz_Meeting** connects to **Bz_Recording** by `meeting_topic`
7. **Bz_Webinar** connects to **Bz_Recording** by `webinar_title`
8. **Bz_Meeting** connects to **Bz_Chat_Message** by `meeting_topic`
9. **Bz_Webinar** connects to **Bz_Chat_Message** by `webinar_title`
10. **Bz_Participant** connects to **Bz_Chat_Message** by `participant_name`
11. **Bz_Meeting** connects to **Bz_Screen_Share** by `meeting_topic`
12. **Bz_Meeting** connects to **Bz_Breakout_Room** by `meeting_topic`
13. **Bz_Meeting** connects to **Bz_Poll** by `meeting_topic`
14. **Bz_Webinar** connects to **Bz_Poll** by `webinar_title`
15. **Bz_User** connects to **Bz_Analytics_Event** by `user_name`
16. **Bz_Meeting** connects to **Bz_Analytics_Event** by `meeting_topic`
17. **Bz_Webinar** connects to **Bz_Analytics_Event** by `webinar_title`
18. **Bz_Analytics_Event** connects to **Bz_Report** by `event_type`
19. **Bz_Report** connects to **Bz_Dashboard** by `report_name`
20. **Bz_Account** connects to **Bz_Security_Policy** by `account_name`
21. **Bz_User** connects to **Bz_Audit_Log** by `user_name`
22. **Bz_Account** connects to **Bz_Integration** by `account_name`
23. **Bz_Participant** connects to **Bz_Device** by `participant_name`
24. **Bz_Account** connects to **Bz_License** by `account_name`