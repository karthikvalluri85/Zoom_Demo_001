_____________________________________________
## *Author*: AAVA
## *Created on*: 
## *Description*: Bronze Layer Data Mapping for Zoom Platform Analytics System - One-to-one mapping between source system tables and Bronze layer tables in Medallion architecture implementation for Snowflake
## *Version*: 2
## *Updated on*: 
_____________________________________________

# Bronze Layer Data Mapping - Zoom Platform Analytics System

## Data Mapping for Bronze Layer

| Target Layer | Target Table | Target Field | Source Layer | Source Table | Source Field | Transformation Rule |
|--------------|--------------|--------------|--------------|--------------|--------------|-------------------|
| Bronze | bz_user | user_name | Source | User | User Name | 1-1 Mapping |
| Bronze | bz_user | email_address | Source | User | Email Address | 1-1 Mapping |
| Bronze | bz_user | department | Source | User | Department | 1-1 Mapping |
| Bronze | bz_user | job_title | Source | User | Job Title | 1-1 Mapping |
| Bronze | bz_user | time_zone | Source | User | Time Zone | 1-1 Mapping |
| Bronze | bz_user | language_preference | Source | User | Language Preference | 1-1 Mapping |
| Bronze | bz_user | profile_picture_url | Source | User | Profile Picture URL | 1-1 Mapping |
| Bronze | bz_user | account_status | Source | User | Account Status | 1-1 Mapping |
| Bronze | bz_user | last_login_date | Source | User | Last Login Date | 1-1 Mapping |
| Bronze | bz_user | registration_date | Source | User | Registration Date | 1-1 Mapping |
| Bronze | bz_user | load_timestamp | Source | User | load_timestamp | 1-1 Mapping |
| Bronze | bz_user | update_timestamp | Source | User | update_timestamp | 1-1 Mapping |
| Bronze | bz_user | source_system | Source | User | source_system | 1-1 Mapping |
| Bronze | bz_account | account_name | Source | Account | Account Name | 1-1 Mapping |
| Bronze | bz_account | account_type | Source | Account | Account Type | 1-1 Mapping |
| Bronze | bz_account | billing_address | Source | Account | Billing Address | 1-1 Mapping |
| Bronze | bz_account | contact_email | Source | Account | Contact Email | 1-1 Mapping |
| Bronze | bz_account | phone_number | Source | Account | Phone Number | 1-1 Mapping |
| Bronze | bz_account | industry | Source | Account | Industry | 1-1 Mapping |
| Bronze | bz_account | company_size | Source | Account | Company Size | 1-1 Mapping |
| Bronze | bz_account | subscription_start_date | Source | Account | Subscription Start Date | 1-1 Mapping |
| Bronze | bz_account | subscription_end_date | Source | Account | Subscription End Date | 1-1 Mapping |
| Bronze | bz_account | payment_status | Source | Account | Payment Status | 1-1 Mapping |
| Bronze | bz_account | load_timestamp | Source | Account | load_timestamp | 1-1 Mapping |
| Bronze | bz_account | update_timestamp | Source | Account | update_timestamp | 1-1 Mapping |
| Bronze | bz_account | source_system | Source | Account | source_system | 1-1 Mapping |
| Bronze | bz_meeting | meeting_topic | Source | Meeting | Meeting Topic | 1-1 Mapping |
| Bronze | bz_meeting | meeting_type | Source | Meeting | Meeting Type | 1-1 Mapping |
| Bronze | bz_meeting | start_time | Source | Meeting | Start Time | 1-1 Mapping |
| Bronze | bz_meeting | end_time | Source | Meeting | End Time | 1-1 Mapping |
| Bronze | bz_meeting | duration | Source | Meeting | Duration | 1-1 Mapping |
| Bronze | bz_meeting | meeting_password | Source | Meeting | Meeting Password | 1-1 Mapping |
| Bronze | bz_meeting | waiting_room_enabled | Source | Meeting | Waiting Room Enabled | 1-1 Mapping |
| Bronze | bz_meeting | recording_permission | Source | Meeting | Recording Permission | 1-1 Mapping |
| Bronze | bz_meeting | maximum_participants | Source | Meeting | Maximum Participants | 1-1 Mapping |
| Bronze | bz_meeting | meeting_status | Source | Meeting | Meeting Status | 1-1 Mapping |
| Bronze | bz_meeting | load_timestamp | Source | Meeting | load_timestamp | 1-1 Mapping |
| Bronze | bz_meeting | update_timestamp | Source | Meeting | update_timestamp | 1-1 Mapping |
| Bronze | bz_meeting | source_system | Source | Meeting | source_system | 1-1 Mapping |
| Bronze | bz_webinar | webinar_title | Source | Webinar | Webinar Title | 1-1 Mapping |
| Bronze | bz_webinar | description | Source | Webinar | Description | 1-1 Mapping |
| Bronze | bz_webinar | start_time | Source | Webinar | Start Time | 1-1 Mapping |
| Bronze | bz_webinar | end_time | Source | Webinar | End Time | 1-1 Mapping |
| Bronze | bz_webinar | duration | Source | Webinar | Duration | 1-1 Mapping |
| Bronze | bz_webinar | registration_required | Source | Webinar | Registration Required | 1-1 Mapping |
| Bronze | bz_webinar | maximum_attendees | Source | Webinar | Maximum Attendees | 1-1 Mapping |
| Bronze | bz_webinar | panelist_count | Source | Webinar | Panelist Count | 1-1 Mapping |
| Bronze | bz_webinar | q_and_a_enabled | Source | Webinar | Q&A Enabled | 1-1 Mapping |
| Bronze | bz_webinar | webinar_status | Source | Webinar | Webinar Status | 1-1 Mapping |
| Bronze | bz_webinar | load_timestamp | Source | Webinar | load_timestamp | 1-1 Mapping |
| Bronze | bz_webinar | update_timestamp | Source | Webinar | update_timestamp | 1-1 Mapping |
| Bronze | bz_webinar | source_system | Source | Webinar | source_system | 1-1 Mapping |
| Bronze | bz_participant | participant_name | Source | Participant | Participant Name | 1-1 Mapping |
| Bronze | bz_participant | email_address | Source | Participant | Email Address | 1-1 Mapping |
| Bronze | bz_participant | join_time | Source | Participant | Join Time | 1-1 Mapping |
| Bronze | bz_participant | leave_time | Source | Participant | Leave Time | 1-1 Mapping |
| Bronze | bz_participant | duration | Source | Participant | Duration | 1-1 Mapping |
| Bronze | bz_participant | audio_status | Source | Participant | Audio Status | 1-1 Mapping |
| Bronze | bz_participant | video_status | Source | Participant | Video Status | 1-1 Mapping |
| Bronze | bz_participant | screen_share_usage | Source | Participant | Screen Share Usage | 1-1 Mapping |
| Bronze | bz_participant | chat_participation | Source | Participant | Chat Participation | 1-1 Mapping |
| Bronze | bz_participant | device_type | Source | Participant | Device Type | 1-1 Mapping |
| Bronze | bz_participant | load_timestamp | Source | Participant | load_timestamp | 1-1 Mapping |
| Bronze | bz_participant | update_timestamp | Source | Participant | update_timestamp | 1-1 Mapping |
| Bronze | bz_participant | source_system | Source | Participant | source_system | 1-1 Mapping |
| Bronze | bz_recording | recording_name | Source | Recording | Recording Name | 1-1 Mapping |
| Bronze | bz_recording | file_format | Source | Recording | File Format | 1-1 Mapping |
| Bronze | bz_recording | file_size | Source | Recording | File Size | 1-1 Mapping |
| Bronze | bz_recording | recording_type | Source | Recording | Recording Type | 1-1 Mapping |
| Bronze | bz_recording | start_time | Source | Recording | Start Time | 1-1 Mapping |
| Bronze | bz_recording | end_time | Source | Recording | End Time | 1-1 Mapping |
| Bronze | bz_recording | duration | Source | Recording | Duration | 1-1 Mapping |
| Bronze | bz_recording | storage_location | Source | Recording | Storage Location | 1-1 Mapping |
| Bronze | bz_recording | access_permission | Source | Recording | Access Permission | 1-1 Mapping |
| Bronze | bz_recording | download_count | Source | Recording | Download Count | 1-1 Mapping |
| Bronze | bz_recording | load_timestamp | Source | Recording | load_timestamp | 1-1 Mapping |
| Bronze | bz_recording | update_timestamp | Source | Recording | update_timestamp | 1-1 Mapping |
| Bronze | bz_recording | source_system | Source | Recording | source_system | 1-1 Mapping |
| Bronze | bz_chat_message | message_content | Source | Chat Message | Message Content | 1-1 Mapping |
| Bronze | bz_chat_message | message_type | Source | Chat Message | Message Type | 1-1 Mapping |
| Bronze | bz_chat_message | timestamp | Source | Chat Message | Timestamp | 1-1 Mapping |
| Bronze | bz_chat_message | sender_name | Source | Chat Message | Sender Name | 1-1 Mapping |
| Bronze | bz_chat_message | recipient_name | Source | Chat Message | Recipient Name | 1-1 Mapping |
| Bronze | bz_chat_message | message_status | Source | Chat Message | Message Status | 1-1 Mapping |
| Bronze | bz_chat_message | file_attachment | Source | Chat Message | File Attachment | 1-1 Mapping |
| Bronze | bz_chat_message | emoji_usage | Source | Chat Message | Emoji Usage | 1-1 Mapping |
| Bronze | bz_chat_message | load_timestamp | Source | Chat Message | load_timestamp | 1-1 Mapping |
| Bronze | bz_chat_message | update_timestamp | Source | Chat Message | update_timestamp | 1-1 Mapping |
| Bronze | bz_chat_message | source_system | Source | Chat Message | source_system | 1-1 Mapping |
| Bronze | bz_screen_share | session_name | Source | Screen Share | Session Name | 1-1 Mapping |
| Bronze | bz_screen_share | start_time | Source | Screen Share | Start Time | 1-1 Mapping |
| Bronze | bz_screen_share | end_time | Source | Screen Share | End Time | 1-1 Mapping |
| Bronze | bz_screen_share | duration | Source | Screen Share | Duration | 1-1 Mapping |
| Bronze | bz_screen_share | content_type | Source | Screen Share | Content Type | 1-1 Mapping |
| Bronze | bz_screen_share | quality_settings | Source | Screen Share | Quality Settings | 1-1 Mapping |
| Bronze | bz_screen_share | load_timestamp | Source | Screen Share | load_timestamp | 1-1 Mapping |
| Bronze | bz_screen_share | update_timestamp | Source | Screen Share | update_timestamp | 1-1 Mapping |
| Bronze | bz_screen_share | source_system | Source | Screen Share | source_system | 1-1 Mapping |
| Bronze | bz_breakout_room | room_name | Source | Breakout Room | Room Name | 1-1 Mapping |
| Bronze | bz_breakout_room | start_time | Source | Breakout Room | Start Time | 1-1 Mapping |
| Bronze | bz_breakout_room | end_time | Source | Breakout Room | End Time | 1-1 Mapping |
| Bronze | bz_breakout_room | duration | Source | Breakout Room | Duration | 1-1 Mapping |
| Bronze | bz_breakout_room | participant_count | Source | Breakout Room | Participant Count | 1-1 Mapping |
| Bronze | bz_breakout_room | room_status | Source | Breakout Room | Room Status | 1-1 Mapping |
| Bronze | bz_breakout_room | load_timestamp | Source | Breakout Room | load_timestamp | 1-1 Mapping |
| Bronze | bz_breakout_room | update_timestamp | Source | Breakout Room | update_timestamp | 1-1 Mapping |
| Bronze | bz_breakout_room | source_system | Source | Breakout Room | source_system | 1-1 Mapping |
| Bronze | bz_poll | poll_question | Source | Poll | Poll Question | 1-1 Mapping |
| Bronze | bz_poll | poll_type | Source | Poll | Poll Type | 1-1 Mapping |
| Bronze | bz_poll | start_time | Source | Poll | Start Time | 1-1 Mapping |
| Bronze | bz_poll | end_time | Source | Poll | End Time | 1-1 Mapping |
| Bronze | bz_poll | total_responses | Source | Poll | Total Responses | 1-1 Mapping |
| Bronze | bz_poll | poll_status | Source | Poll | Poll Status | 1-1 Mapping |
| Bronze | bz_poll | load_timestamp | Source | Poll | load_timestamp | 1-1 Mapping |
| Bronze | bz_poll | update_timestamp | Source | Poll | update_timestamp | 1-1 Mapping |
| Bronze | bz_poll | source_system | Source | Poll | source_system | 1-1 Mapping |
| Bronze | bz_analytics_event | event_type | Source | Analytics Event | Event Type | 1-1 Mapping |
| Bronze | bz_analytics_event | event_name | Source | Analytics Event | Event Name | 1-1 Mapping |
| Bronze | bz_analytics_event | event_description | Source | Analytics Event | Event Description | 1-1 Mapping |
| Bronze | bz_analytics_event | timestamp | Source | Analytics Event | Timestamp | 1-1 Mapping |
| Bronze | bz_analytics_event | event_source | Source | Analytics Event | Event Source | 1-1 Mapping |
| Bronze | bz_analytics_event | event_severity | Source | Analytics Event | Event Severity | 1-1 Mapping |
| Bronze | bz_analytics_event | event_parameters | Source | Analytics Event | Event Parameters | 1-1 Mapping |
| Bronze | bz_analytics_event | processing_status | Source | Analytics Event | Processing Status | 1-1 Mapping |
| Bronze | bz_analytics_event | load_timestamp | Source | Analytics Event | load_timestamp | 1-1 Mapping |
| Bronze | bz_analytics_event | update_timestamp | Source | Analytics Event | update_timestamp | 1-1 Mapping |
| Bronze | bz_analytics_event | source_system | Source | Analytics Event | source_system | 1-1 Mapping |
| Bronze | bz_report | report_name | Source | Report | Report Name | 1-1 Mapping |
| Bronze | bz_report | report_type | Source | Report | Report Type | 1-1 Mapping |
| Bronze | bz_report | report_description | Source | Report | Report Description | 1-1 Mapping |
| Bronze | bz_report | generation_date | Source | Report | Generation Date | 1-1 Mapping |
| Bronze | bz_report | report_period | Source | Report | Report Period | 1-1 Mapping |
| Bronze | bz_report | report_format | Source | Report | Report Format | 1-1 Mapping |
| Bronze | bz_report | report_status | Source | Report | Report Status | 1-1 Mapping |
| Bronze | bz_report | recipient_list | Source | Report | Recipient List | 1-1 Mapping |
| Bronze | bz_report | delivery_method | Source | Report | Delivery Method | 1-1 Mapping |
| Bronze | bz_report | load_timestamp | Source | Report | load_timestamp | 1-1 Mapping |
| Bronze | bz_report | update_timestamp | Source | Report | update_timestamp | 1-1 Mapping |
| Bronze | bz_report | source_system | Source | Report | source_system | 1-1 Mapping |
| Bronze | bz_dashboard | dashboard_name | Source | Dashboard | Dashboard Name | 1-1 Mapping |
| Bronze | bz_dashboard | dashboard_type | Source | Dashboard | Dashboard Type | 1-1 Mapping |
| Bronze | bz_dashboard | description | Source | Dashboard | Description | 1-1 Mapping |
| Bronze | bz_dashboard | creation_date | Source | Dashboard | Creation Date | 1-1 Mapping |
| Bronze | bz_dashboard | last_modified_date | Source | Dashboard | Last Modified Date | 1-1 Mapping |
| Bronze | bz_dashboard | access_level | Source | Dashboard | Access Level | 1-1 Mapping |
| Bronze | bz_dashboard | refresh_frequency | Source | Dashboard | Refresh Frequency | 1-1 Mapping |
| Bronze | bz_dashboard | load_timestamp | Source | Dashboard | load_timestamp | 1-1 Mapping |
| Bronze | bz_dashboard | update_timestamp | Source | Dashboard | update_timestamp | 1-1 Mapping |
| Bronze | bz_dashboard | source_system | Source | Dashboard | source_system | 1-1 Mapping |
| Bronze | bz_security_policy | policy_name | Source | Security Policy | Policy Name | 1-1 Mapping |
| Bronze | bz_security_policy | policy_type | Source | Security Policy | Policy Type | 1-1 Mapping |
| Bronze | bz_security_policy | description | Source | Security Policy | Description | 1-1 Mapping |
| Bronze | bz_security_policy | effective_date | Source | Security Policy | Effective Date | 1-1 Mapping |
| Bronze | bz_security_policy | expiry_date | Source | Security Policy | Expiry Date | 1-1 Mapping |
| Bronze | bz_security_policy | policy_status | Source | Security Policy | Policy Status | 1-1 Mapping |
| Bronze | bz_security_policy | compliance_level | Source | Security Policy | Compliance Level | 1-1 Mapping |
| Bronze | bz_security_policy | load_timestamp | Source | Security Policy | load_timestamp | 1-1 Mapping |
| Bronze | bz_security_policy | update_timestamp | Source | Security Policy | update_timestamp | 1-1 Mapping |
| Bronze | bz_security_policy | source_system | Source | Security Policy | source_system | 1-1 Mapping |
| Bronze | bz_audit_log | audit_event | Source | Audit Log | Audit Event | 1-1 Mapping |
| Bronze | bz_audit_log | event_timestamp | Source | Audit Log | Event Timestamp | 1-1 Mapping |
| Bronze | bz_audit_log | user_involved | Source | Audit Log | User Involved | 1-1 Mapping |
| Bronze | bz_audit_log | action_taken | Source | Audit Log | Action Taken | 1-1 Mapping |
| Bronze | bz_audit_log | event_category | Source | Audit Log | Event Category | 1-1 Mapping |
| Bronze | bz_audit_log | severity_level | Source | Audit Log | Severity Level | 1-1 Mapping |
| Bronze | bz_audit_log | load_timestamp | Source | Audit Log | load_timestamp | 1-1 Mapping |
| Bronze | bz_audit_log | update_timestamp | Source | Audit Log | update_timestamp | 1-1 Mapping |
| Bronze | bz_audit_log | source_system | Source | Audit Log | source_system | 1-1 Mapping |
| Bronze | bz_integration | integration_name | Source | Integration | Integration Name | 1-1 Mapping |
| Bronze | bz_integration | integration_type | Source | Integration | Integration Type | 1-1 Mapping |
| Bronze | bz_integration | connection_status | Source | Integration | Connection Status | 1-1 Mapping |
| Bronze | bz_integration | last_sync_time | Source | Integration | Last Sync Time | 1-1 Mapping |
| Bronze | bz_integration | sync_frequency | Source | Integration | Sync Frequency | 1-1 Mapping |
| Bronze | bz_integration | data_volume | Source | Integration | Data Volume | 1-1 Mapping |
| Bronze | bz_integration | load_timestamp | Source | Integration | load_timestamp | 1-1 Mapping |
| Bronze | bz_integration | update_timestamp | Source | Integration | update_timestamp | 1-1 Mapping |
| Bronze | bz_integration | source_system | Source | Integration | source_system | 1-1 Mapping |
| Bronze | bz_device | device_name | Source | Device | Device Name | 1-1 Mapping |
| Bronze | bz_device | device_type | Source | Device | Device Type | 1-1 Mapping |
| Bronze | bz_device | operating_system | Source | Device | Operating System | 1-1 Mapping |
| Bronze | bz_device | os_version | Source | Device | OS Version | 1-1 Mapping |
| Bronze | bz_device | browser_type | Source | Device | Browser Type | 1-1 Mapping |
| Bronze | bz_device | last_active_time | Source | Device | Last Active Time | 1-1 Mapping |
| Bronze | bz_device | load_timestamp | Source | Device | load_timestamp | 1-1 Mapping |
| Bronze | bz_device | update_timestamp | Source | Device | update_timestamp | 1-1 Mapping |
| Bronze | bz_device | source_system | Source | Device | source_system | 1-1 Mapping |
| Bronze | bz_license | license_type | Source | License | License Type | 1-1 Mapping |
| Bronze | bz_license | feature_entitlements | Source | License | Feature Entitlements | 1-1 Mapping |
| Bronze | bz_license | start_date | Source | License | Start Date | 1-1 Mapping |
| Bronze | bz_license | end_date | Source | License | End Date | 1-1 Mapping |
| Bronze | bz_license | license_status | Source | License | License Status | 1-1 Mapping |
| Bronze | bz_license | user_limit | Source | License | User Limit | 1-1 Mapping |
| Bronze | bz_license | load_timestamp | Source | License | load_timestamp | 1-1 Mapping |
| Bronze | bz_license | update_timestamp | Source | License | update_timestamp | 1-1 Mapping |
| Bronze | bz_license | source_system | Source | License | source_system | 1-1 Mapping |

## Summary

**Total Bronze Tables**: 18  
**Total Fields Mapped**: 234  
**Source Layer**: Source  
**Target Layer**: Bronze  
**Transformation Rule**: 1-1 Mapping (No transformations applied in Bronze layer)  

## Data Ingestion Guidelines

1. **Raw Data Preservation**: Bronze layer maintains the original data structure with minimal transformation
2. **Metadata Addition**: Each record includes load_timestamp, update_timestamp, and source_system for audit trail
3. **Data Quality**: Basic validation rules applied without data cleansing or business rule transformations
4. **Schema Evolution**: Bronze layer supports schema changes from source systems
5. **Lineage Tracking**: Complete mapping enables end-to-end data lineage visibility

This mapping serves as the foundation for the Medallion architecture, ensuring raw data integrity while enabling efficient downstream processing in Silver and Gold layers.