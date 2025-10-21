# Bronze Layer Logical Data Model for Zoom Platform Analytics System

## Version 1

### Description
This Bronze Layer Logical Data Model mirrors the source data structure of the Zoom Platform Analytics System conceptual model. It excludes primary and foreign keys, uses 'Bz_' prefix for table names, includes metadata columns, classifies PII fields with reasons, and provides column descriptions. An audit table is included for tracking data processing.

---

## 1. Metadata Columns (included in all tables)
| Column Name       | Data Type | Description                          | PII Classification | Reason for PII Classification           |
|-------------------|-----------|----------------------------------|--------------------|-----------------------------------------|
| load_timestamp    | TIMESTAMP | Timestamp when the record was loaded into Bronze layer | No                 | System metadata                         |
| update_timestamp  | TIMESTAMP | Timestamp when the record was last updated in Bronze layer | No                 | System metadata                         |
| source_system     | STRING    | Source system name or identifier  | No                 | System metadata                         |

---

## 2. Entity Tables

### 2.1 Bz_User
| Column Name           | Data Type | Description                         | PII Classification | Reason for PII Classification           |
|-----------------------|-----------|-----------------------------------|--------------------|-----------------------------------------|
| user_name             | STRING    | User's full name                  | Yes                | Identifies individual                    |
| email_address         | STRING    | User's email address              | Yes                | Contact information                      |
| department            | STRING    | Department of the user            | No                 | Organizational info                      |
| job_title             | STRING    | User's job title                  | No                 | Organizational info                      |
| time_zone             | STRING    | User's time zone                  | No                 | Localization info                        |
| language_preference   | STRING    | Preferred language of the user    | No                 | Localization info                        |
| profile_picture_url   | STRING    | URL to user's profile picture    | No                 | Optional user info                       |
| account_status        | STRING    | Status of the user account       | No                 | System status                           |
| last_login_date       | TIMESTAMP | Last login date and time          | No                 | System usage tracking                   |
| registration_date     | TIMESTAMP | Date when user registered         | No                 | System usage tracking                   |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      | No                 | Metadata                                |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     | No                 | Metadata                                |
| source_system         | STRING    | Source system name or identifier  | No                 | Metadata                                |

### 2.2 Bz_Account
| Column Name           | Data Type | Description                         | PII Classification | Reason for PII Classification           |
|-----------------------|-----------|-----------------------------------|--------------------|-----------------------------------------|
| account_name          | STRING    | Name of the organizational account | No                 | Organizational info                      |
| account_type          | STRING    | Type of account                   | No                 | Organizational info                      |
| billing_address       | STRING    | Billing address of the account   | Yes                | Contact information                      |
| contact_email         | STRING    | Contact email for the account    | Yes                | Contact information                      |
| phone_number          | STRING    | Contact phone number             | Yes                | Contact information                      |
| industry              | STRING    | Industry sector                  | No                 | Organizational info                      |
| company_size          | STRING    | Size of the company              | No                 | Organizational info                      |
| subscription_start_date | TIMESTAMP | Subscription start date          | No                 | Subscription info                        |
| subscription_end_date | TIMESTAMP | Subscription end date            | No                 | Subscription info                        |
| payment_status        | STRING    | Payment status                   | No                 | Financial info                          |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      | No                 | Metadata                                |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     | No                 | Metadata                                |
| source_system         | STRING    | Source system name or identifier  | No                 | Metadata                                |

### 2.3 Bz_Meeting
| Column Name           | Data Type | Description                         | PII Classification | Reason for PII Classification           |
|-----------------------|-----------|-----------------------------------|--------------------|-----------------------------------------|
| meeting_topic         | STRING    | Topic of the meeting             | No                 | Meeting info                            |
| meeting_type          | STRING    | Type of meeting (scheduled/instant) | No                 | Meeting info                            |
| start_time            | TIMESTAMP | Meeting start time               | No                 | Meeting info                            |
| end_time              | TIMESTAMP | Meeting end time                 | No                 | Meeting info                            |
| duration              | INTEGER   | Duration in minutes              | No                 | Meeting info                            |
| meeting_password      | STRING    | Password for meeting access     | Yes                | Security info                           |
| waiting_room_enabled  | BOOLEAN   | Whether waiting room is enabled | No                 | Meeting configuration                   |
| recording_permission  | BOOLEAN   | Permission for recording         | No                 | Meeting configuration                   |
| maximum_participants  | INTEGER   | Max number of participants      | No                 | Meeting info                            |
| meeting_status        | STRING    | Status of the meeting            | No                 | Meeting info                            |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      | No                 | Metadata                                |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     | No                 | Metadata                                |
| source_system         | STRING    | Source system name or identifier  | No                 | Metadata                                |

### 2.4 Bz_Webinar
| Column Name           | Data Type | Description                         | PII Classification | Reason for PII Classification           |
|-----------------------|-----------|-----------------------------------|--------------------|-----------------------------------------|
| webinar_topic         | STRING    | Topic of the webinar            | No                 | Webinar info                           |
| presenter_roles       | STRING    | Roles of presenters             | No                 | Webinar info                           |
| attendee_roles       | STRING    | Roles of attendees             | No                 | Webinar info                           |
| start_time            | TIMESTAMP | Webinar start time              | No                 | Webinar info                           |
| end_time              | TIMESTAMP | Webinar end time                | No                 | Webinar info                           |
| duration              | INTEGER   | Duration in minutes             | No                 | Webinar info                           |
| maximum_participants  | INTEGER   | Max number of participants     | No                 | Webinar info                           |
| webinar_status        | STRING    | Status of the webinar           | No                 | Webinar info                           |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded     | No                 | Metadata                               |
| update_timestamp      | TIMESTAMP | Timestamp when record updated    | No                 | Metadata                               |
| source_system         | STRING    | Source system name or identifier | No                 | Metadata                               |

### 2.5 Bz_Participant
| Column Name           | Data Type | Description                         | PII Classification | Reason for PII Classification           |
|-----------------------|-----------|-----------------------------------|--------------------|-----------------------------------------|
| participant_name      | STRING    | Participant's full name          | Yes                | Identifies individual                    |
| participant_email     | STRING    | Participant's email address      | Yes                | Contact information                      |
| join_time             | TIMESTAMP | Time participant joined          | No                 | Meeting participation info              |
| leave_time            | TIMESTAMP | Time participant left            | No                 | Meeting participation info              |
| engagement_score      | FLOAT     | Engagement metric score          | No                 | Analytics info                          |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      | No                 | Metadata                                |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     | No                 | Metadata                                |
| source_system         | STRING    | Source system name or identifier  | No                 | Metadata                                |

### 2.6 Bz_Recording
| Column Name           | Data Type | Description                         | PII Classification | Reason for PII Classification           |
|-----------------------|-----------|-----------------------------------|--------------------|-----------------------------------------|
| recording_url         | STRING    | URL to the recording             | No                 | Content info                           |
| recording_start_time  | TIMESTAMP | Recording start time             | No                 | Content info                           |
| recording_end_time    | TIMESTAMP | Recording end time               | No                 | Content info                           |
| storage_location     | STRING    | Storage location details         | No                 | Content info                           |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      | No                 | Metadata                                |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     | No                 | Metadata                                |
| source_system         | STRING    | Source system name or identifier  | No                 | Metadata                                |

### 2.7 Bz_Chat_Message
| Column Name           | Data Type | Description                         | PII Classification | Reason for PII Classification           |
|-----------------------|-----------|-----------------------------------|--------------------|-----------------------------------------|
| message_text          | STRING    | Text content of the chat message | No                 | Communication content                   |
| sender_name           | STRING    | Name of the sender               | Yes                | Identifies individual                    |
| sender_email          | STRING    | Email of the sender              | Yes                | Contact information                      |
| sent_time             | TIMESTAMP | Time message was sent            | No                 | Communication info                      |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      | No                 | Metadata                                |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     | No                 | Metadata                                |
| source_system         | STRING    | Source system name or identifier  | No                 | Metadata                                |

### 2.8 Bz_Screen_Share
| Column Name           | Data Type | Description                         | PII Classification | Reason for PII Classification           |
|-----------------------|-----------|-----------------------------------|--------------------|-----------------------------------------|
| session_id            | STRING    | Identifier for screen share session | No                 | Session info                           |
| content_metadata      | STRING    | Metadata about shared content    | No                 | Content info                           |
| start_time            | TIMESTAMP | Screen share start time          | No                 | Session info                           |
| end_time              | TIMESTAMP | Screen share end time            | No                 | Session info                           |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      | No                 | Metadata                                |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     | No                 | Metadata                                |
| source_system         | STRING    | Source system name or identifier  | No                 | Metadata                                |

### 2.9 Bz_Breakout_Room
| Column Name           | Data Type | Description                         | PII Classification | Reason for PII Classification           |
|-----------------------|-----------|-----------------------------------|--------------------|-----------------------------------------|
| room_name             | STRING    | Name of the breakout room        | No                 | Session info                           |
| meeting_id            | STRING    | Associated meeting identifier    | No                 | Session info                           |
| start_time            | TIMESTAMP | Breakout room start time         | No                 | Session info                           |
| end_time              | TIMESTAMP | Breakout room end time           | No                 | Session info                           |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      | No                 | Metadata                                |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     | No                 | Metadata                                |
| source_system         | STRING    | Source system name or identifier  | No                 | Metadata                                |

### 2.10 Bz_Poll
| Column Name           | Data Type | Description                         | PII Classification | Reason for PII Classification           |
|-----------------------|-----------|-----------------------------------|--------------------|-----------------------------------------|
| poll_question         | STRING    | Poll question text               | No                 | Poll info                             |
| poll_options          | STRING    | Options for the poll             | No                 | Poll info                             |
| poll_results          | STRING    | Results of the poll              | No                 | Poll info                             |
| meeting_id            | STRING    | Associated meeting identifier    | No                 | Poll info                             |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      | No                 | Metadata                                |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     | No                 | Metadata                                |
| source_system         | STRING    | Source system name or identifier  | No                 | Metadata                                |

### 2.11 Bz_Analytics_Event
| Column Name           | Data Type | Description                         | PII Classification | Reason for PII Classification           |
|-----------------------|-----------|-----------------------------------|--------------------|-----------------------------------------|
| event_name            | STRING    | Name of the analytics event     | No                 | Event info                           |
| event_timestamp       | TIMESTAMP | Timestamp of the event          | No                 | Event info                           |
| user_id               | STRING    | Identifier of the user          | Yes                | Identifies individual                    |
| event_details         | STRING    | Additional event details         | No                 | Event info                           |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      | No                 | Metadata                                |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     | No                 | Metadata                                |
| source_system         | STRING    | Source system name or identifier  | No                 | Metadata                                |

### 2.12 Bz_Report
| Column Name           | Data Type | Description                         | PII Classification | Reason for PII Classification           |
|-----------------------|-----------|-----------------------------------|--------------------|-----------------------------------------|
| report_name           | STRING    | Name of the report              | No                 | Report info                          |
| report_date           | TIMESTAMP | Date of the report              | No                 | Report info                          |
| metrics               | STRING    | Metrics included in the report  | No                 | Report info                          |
| insights              | STRING    | Insights from the report        | No                 | Report info                          |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      | No                 | Metadata                                |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     | No                 | Metadata                                |
| source_system         | STRING    | Source system name or identifier  | No                 | Metadata                                |

### 2.13 Bz_Dashboard
| Column Name           | Data Type | Description                         | PII Classification | Reason for PII Classification           |
|-----------------------|-----------|-----------------------------------|--------------------|-----------------------------------------|
| dashboard_name        | STRING    | Name of the dashboard           | No                 | Dashboard info                      |
| kpi_list              | STRING    | List of KPIs displayed          | No                 | Dashboard info                      |
| last_updated          | TIMESTAMP | Last update timestamp           | No                 | Dashboard info                      |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      | No                 | Metadata                                |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     | No                 | Metadata                                |
| source_system         | STRING    | Source system name or identifier  | No                 | Metadata                                |

### 2.14 Bz_Security_Policy
| Column Name           | Data Type | Description                         | PII Classification | Reason for PII Classification           |
|-----------------------|-----------|-----------------------------------|--------------------|-----------------------------------------|
| policy_name           | STRING    | Name of the security policy    | No                 | Security info                      |
| policy_description    | STRING    | Description of the policy      | No                 | Security info                      |
| effective_date        | TIMESTAMP | Date policy became effective   | No                 | Security info                      |
| expiry_date           | TIMESTAMP | Date policy expires            | No                 | Security info                      |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      | No                 | Metadata                                |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     | No                 | Metadata                                |
| source_system         | STRING    | Source system name or identifier  | No                 | Metadata                                |

### 2.15 Bz_Audit_Log
| Column Name           | Data Type | Description                         | PII Classification | Reason for PII Classification           |
|-----------------------|-----------|-----------------------------------|--------------------|-----------------------------------------|
| record_id             | STRING    | Unique identifier for audit record | No                 | Audit tracking                      |
| source_table          | STRING    | Name of the source table         | No                 | Audit tracking                      |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      | No                 | Audit tracking                      |
| processed_by          | STRING    | Identifier of the processor       | No                 | Audit tracking                      |
| processing_time       | INTEGER   | Processing time in milliseconds   | No                 | Audit tracking                      |
| status                | STRING    | Processing status (success/failure) | No                 | Audit tracking                      |

### 2.16 Bz_Integration
| Column Name           | Data Type | Description                         | PII Classification | Reason for PII Classification           |
|-----------------------|-----------|-----------------------------------|--------------------|-----------------------------------------|
| integration_name      | STRING    | Name of the integration          | No                 | Integration info                   |
| integration_type      | STRING    | Type of integration              | No                 | Integration info                   |
| connection_details    | STRING    | Details of the connection        | No                 | Integration info                   |
| last_sync_time        | TIMESTAMP | Last synchronization time        | No                 | Integration info                   |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      | No                 | Metadata                                |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     | No                 | Metadata                                |
| source_system         | STRING    | Source system name or identifier  | No                 | Metadata                                |

### 2.17 Bz_Device
| Column Name           | Data Type | Description                         | PII Classification | Reason for PII Classification           |
|-----------------------|-----------|-----------------------------------|--------------------|-----------------------------------------|
| device_id             | STRING    | Identifier of the device         | No                 | Device info                       |
| device_type           | STRING    | Type of device                  | No                 | Device info                       |
| operating_system      | STRING    | Operating system of the device  | No                 | Device info                       |
| last_used             | TIMESTAMP | Last used timestamp             | No                 | Device usage info                 |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      | No                 | Metadata                                |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     | No                 | Metadata                                |
| source_system         | STRING    | Source system name or identifier  | No                 | Metadata                                |

### 2.18 Bz_License
| Column Name           | Data Type | Description                         | PII Classification | Reason for PII Classification           |
|-----------------------|-----------|-----------------------------------|--------------------|-----------------------------------------|
| license_type          | STRING    | Type of license                 | No                 | License info                      |
| feature_entitlements  | STRING    | Features included in license    | No                 | License info                      |
| subscription_start_date | TIMESTAMP | Subscription start date          | No                 | License info                      |
| subscription_end_date | TIMESTAMP | Subscription end date            | No                 | License info                      |
| load_timestamp        | TIMESTAMP | Timestamp when record loaded      | No                 | Metadata                                |
| update_timestamp      | TIMESTAMP | Timestamp when record updated     | No                 | Metadata                                |
| source_system         | STRING    | Source system name or identifier  | No                 | Metadata                                |

---

## 3. Conceptual Data Model Diagram (Block Diagram)

```plaintext
+----------------+     +----------------+     +----------------+     +----------------+
|   Bz_User      |<--->|  Bz_Account    |<--->|  Bz_License    |     | Bz_Device      |
+----------------+     +----------------+     +----------------+     +----------------+
        |                      |                      |                      |
        |                      |                      |                      |
+----------------+     +----------------+     +----------------+     +----------------+
|  Bz_Meeting    |<--->|  Bz_Participant|<--->|  Bz_Recording  |     | Bz_Chat_Message|
+----------------+     +----------------+     +----------------+     +----------------+
        |                      |                      |                      |
        |                      |                      |                      |
+----------------+     +----------------+     +----------------+     +----------------+
|  Bz_Webinar    |<--->|  Bz_Breakout_Room|    |  Bz_Poll      |     | Bz_Analytics_Event|
+----------------+     +----------------+     +----------------+     +----------------+
        |                      |                      |                      |
        |                      |                      |                      |
+----------------+     +----------------+     +----------------+     +----------------+
|  Bz_Report     |     |  Bz_Dashboard  |     |  Bz_Security_Policy|  | Bz_Audit_Log   |
+----------------+     +----------------+     +----------------+     +----------------+
        |
        |
+----------------+
|  Bz_Integration|
+----------------+

```

---

*End of Bronze Layer Logical Data Model Version 1*