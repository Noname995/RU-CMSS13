/// Generic access for 1:1 conversations with ARES and unrestricted commands.
#define ARES_ACCESS_BASIC 0
/// Secure Access, can read ARES Announcements and Bioscans.
#define ARES_ACCESS_COMMAND 1
#define ARES_ACCESS_JOE 2
/// CL, can read Apollo Log and also Delete Announcements.
#define ARES_ACCESS_CORPORATE 3
/// Senior Command, can Delete Bioscans.
#define ARES_ACCESS_SENIOR 4
/// Synth, CE & Commanding Officer, can read the access log.
#define ARES_ACCESS_CE 5
#define ARES_ACCESS_SYNTH 6
#define ARES_ACCESS_CO 7
/// High Command, can read the deletion log.
#define ARES_ACCESS_HIGH 8
#define ARES_ACCESS_WY_COMMAND 9
/// Debugging. Allows me to view everything without using a high command rank. Unlikely to stay in a full merge.
#define ARES_ACCESS_DEBUG 10

#define ARES_RECORD_ANNOUNCE "Announcement Record"
#define ARES_RECORD_ANTIAIR "AntiAir Control Log"
#define ARES_RECORD_ASRS "Requisition Record"
#define ARES_RECORD_BIOSCAN "Bioscan Record"
#define ARES_RECORD_BOMB "Orbital Bombardment Record"
#define ARES_RECORD_DELETED "Deleted Record"
#define ARES_RECORD_SECURITY "Security Update"
#define ARES_RECORD_MAINTENANCE "Maintenance Ticket"
#define ARES_RECORD_ACCESS "Access Ticket"

/// Not by ARES logged through marine_announcement()
#define ARES_LOG_NONE 0
/// Logged with all announcements
#define ARES_LOG_MAIN 1
/// Logged in the security updates
#define ARES_LOG_SECURITY 2

/// Access levels specifically for Working Joe management console
#define APOLLO_ACCESS_REQUEST 0
#define APOLLO_ACCESS_REPORTER 1
#define APOLLO_ACCESS_TEMP 2
#define APOLLO_ACCESS_AUTHED 3
#define APOLLO_ACCESS_JOE 4
#define APOLLO_ACCESS_DEBUG 5

/// Ticket statuses, both for Access and Maintenance
#define TICKET_PENDING "pending"
#define TICKET_ASSIGNED "assigned"
#define TICKET_REJECTED "rejected"
#define TICKET_CANCELLED "cancelled"
#define TICKET_COMPLETED "complete"

/// Cooldowns
#define COOLDOWN_ARES_SENSOR 60 SECONDS
#define COOLDOWN_ARES_ACCESS_CONTROL 20 SECONDS
