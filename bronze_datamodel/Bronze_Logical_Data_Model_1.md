# Bronze Layer Logical Data Model for Zoom Platform Analytics System

---

## Metadata
- **Author:** AAVA
- **Version:** 1
- **Description:** Comprehensive Bronze Layer Logical Data Model for Zoom Platform Analytics System following Medallion Architecture principles. This model mirrors source data structure with enhancements for metadata, PII classification, and audit capabilities.
- **Created On:** 2024-12-19
- **Updated On:** 2024-12-19

---

## 1. PII Classification
| Column Name | Table | Reason for PII Classification |
|-------------|-------|-------------------------------|
| EMAIL | USERS | Contains personal email addresses identifying individuals |
| USER_NAME | USERS | Contains personal identifiable user names |
| COMPANY | USERS | May reveal employer information linked to individuals |
| HOST_ID | MEETINGS, WEBINARS | Identifies meeting hosts, linked to users |
| USER_ID | USERS, PARTICIPANTS, SUPPORT_TICKETS, BILLING_EVENTS | Unique user identifiers linked to individuals |
| ASSIGNED_TO_USER_ID | LICENSES | User assignment for licenses, linked to individuals |

*PII columns are handled with appropriate data governance and security controls.*

---

## 2. Bronze Layer Logical Model

### 2.1 Bz_MEETINGS
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| MEETING_TOPIC | TEXT | Subject or title of the meeting |
| DURATION_MINUTES | NUMBER | Total length of the meeting in minutes |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when data was loaded into Bronze layer |
| SOURCE_SYSTEM | TEXT | Origin system of the data |
| END_TIME | TIMESTAMP_NTZ | Scheduled or actual end time of the meeting |
| START_TIME | TIMESTAMP_NTZ | Scheduled or actual start time of the meeting |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of last update in source system |

### 2.2 Bz_LICENSES
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| LICENSE_TYPE | TEXT | Type of Zoom license assigned |
| END_DATE | DATE | License expiration date |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when data was loaded into Bronze layer |
| SOURCE_SYSTEM | TEXT | Origin system of the data |
| START_DATE | DATE | License start date |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of last update in source system |

### 2.3 Bz_SUPPORT_TICKETS
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| RESOLUTION_STATUS | TEXT | Status of ticket resolution |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when data was loaded into Bronze layer |
| OPEN_DATE | DATE | Date when ticket was opened |
| SOURCE_SYSTEM | TEXT | Origin system of the data |
| TICKET_TYPE | TEXT | Type/category of support ticket |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of last update in source system |

### 2.4 Bz_USERS
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| EMAIL | TEXT | Primary email address of the user |
| SOURCE_SYSTEM | TEXT | Origin system of the data |
| USER_NAME | TEXT | Full name of the user |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when data was loaded into Bronze layer |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of last update in source system |
| PLAN_TYPE | TEXT | Zoom plan type assigned to user |
| COMPANY | TEXT | Company or organization of the user |

### 2.5 Bz_BILLING_EVENTS
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| SOURCE_SYSTEM | TEXT | Origin system of the data |
| AMOUNT | NUMBER | Monetary amount of billing event |
| EVENT_TYPE | TEXT | Type of billing event |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when data was loaded into Bronze layer |
| EVENT_DATE | DATE | Date of billing event |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of last update in source system |

### 2.6 Bz_PARTICIPANTS
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of last update in source system |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when data was loaded into Bronze layer |
| LEAVE_TIME | TIMESTAMP_NTZ | Time participant left the meeting |
| JOIN_TIME | TIMESTAMP_NTZ | Time participant joined the meeting |
| SOURCE_SYSTEM | TEXT | Origin system of the data |

### 2.7 Bz_WEBINARS
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| END_TIME | TIMESTAMP_NTZ | Scheduled or actual end time of the webinar |
| SOURCE_SYSTEM | TEXT | Origin system of the data |
| WEBINAR_TOPIC | TEXT | Subject or title of the webinar |
| START_TIME | TIMESTAMP_NTZ | Scheduled or actual start time of the webinar |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when data was loaded into Bronze layer |
| REGISTRANTS | NUMBER | Number of registrants for the webinar |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of last update in source system |

### 2.8 Bz_FEATURE_USAGE
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| FEATURE_NAME | TEXT | Name of the Zoom feature used |
| USAGE_DATE | DATE | Date of feature usage |
| UPDATE_TIMESTAMP | TIMESTAMP_NTZ | Timestamp of last update in source system |
| SOURCE_SYSTEM | TEXT | Origin system of the data |
| LOAD_TIMESTAMP | TIMESTAMP_NTZ | Timestamp when data was loaded into Bronze layer |
| USAGE_COUNT | NUMBER | Count of feature usage occurrences |

---

## 3. Audit Table Design

### Bz_Audit_Table
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| record_id | TEXT | Unique identifier for audit record |
| source_table | TEXT | Name of source table being processed |
| load_timestamp | TIMESTAMP_NTZ | Timestamp when record was loaded into Bronze layer |
| processed_by | TEXT | Identifier of process or user performing load |
| processing_time | NUMBER | Duration of processing in seconds |
| status | TEXT | Status of processing (Success, Failed, etc.) |

---

## 4. Conceptual Data Model Diagram

```plaintext
+----------------+       +----------------+       +----------------+
|   Bz_Account   |1-----*|  Bz_Department |1-----*|    Bz_User     |
+----------------+       +----------------+       +----------------+
                             |                          |
                             |                          |*
                             |                          |
                             |                          +----------------+
                             |                          |   Bz_Role      |
                             |                          +----------------+

+----------------+       +----------------+       +----------------+
|  Bz_Meeting    |1-----*| Bz_Participant |1-----*|  Bz_Session    |
+----------------+       +----------------+       +----------------+
       |                          |                          |
       |                          |                          |
       |                          |                          |
       |                          |                          |
       |                          |                          |
       |                          |                          |
       |                          |                          |
       |                          |                          |
       |                          |                          |
       |                          |                          |
       |                          |                          |
       |                          |                          |
       |                          |                          |
       |                          |                          |
       |                          |                          |
       |                          |                          |
       |                          |                          |
       |                          |                          |
       |                          |                          |
       |                          |                          |
+----------------+       +----------------+       +----------------+
| Bz_Device      |*-----1| Bz_Session     |1-----1| Bz_NetworkData |
+----------------+       +----------------+       +----------------+

+----------------+       +----------------+       +----------------+
| Bz_UsageMetrics|*-----1| Bz_Meeting     |       | Bz_Performance |
+----------------+       +----------------+       +----------------+

+----------------+       +----------------+       +----------------+
| Bz_Engagement  |*-----1| Bz_Participant |       |                |
+----------------+       +----------------+       +----------------+

+----------------+
| Bz_Audit_Table |
+----------------+
```

---

## 5. Relationships Between Tables
- **Account to Department:** One-to-many; an account contains multiple departments.
- **Department to User:** One-to-many; each department has multiple users.
- **User to Role:** Many-to-one; users have roles defining permissions.
- **User to Meeting:** One-to-many; users can host multiple meetings.
- **Meeting to Participant:** One-to-many; meetings have multiple participants.
- **Participant to Session:** One-to-many; participants can have multiple sessions.
- **Session to Device:** Many-to-one; sessions use devices.
- **Session to Network Data:** One-to-one; each session has network data.
- **Meeting to Usage Metrics:** One-to-many; meetings generate usage metrics.
- **Session to Performance Data:** One-to-one; sessions have performance data.
- **Participant to Engagement Statistics:** One-to-many; participants have engagement stats.

---

## 6. Rationale for Design Decisions
- **Mirroring Source Structure:** Ensures data fidelity and traceability from source to Bronze layer.
- **Excluding ID Fields:** Removes technical keys to focus on business-relevant attributes in Bronze layer.
- **Metadata Columns:** Added for data lineage, auditing, and operational tracking.
- **PII Classification:** Identifies sensitive data for compliance with privacy regulations.
- **Audit Table:** Enables monitoring of data ingestion processes and troubleshooting.
- **Conceptual Diagram:** Provides clear visualization of entity relationships for stakeholders.
- **Naming Convention:** 'Bz_' prefix standardizes Bronze layer tables for clarity and governance.

---

*End of Bronze Layer Logical Data Model Document.*
