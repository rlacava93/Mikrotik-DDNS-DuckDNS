# DuckDNS DDNS Script for MikroTik (RouterOS 7+)

A **simple, scheduler-safe DuckDNS Dynamic DNS script** for MikroTik routers running **RouterOS 7+**.

This script:
- Detects your public IP directly from a WAN interface (PPPoE, DHCP, etc.)
- Resolves the current DuckDNS DNS record
- Updates DuckDNS **only when the IP actually changes**
- Does **not** use files (no permission issues with Scheduler)

---

## Features

- Scheduler-safe (no file writes)
- Works with PPPoE and static WAN interfaces
- Avoids unnecessary DuckDNS updates
- No dependency on MikroTik IP Cloud
- Clean single-section configuration

---

## Requirements

- MikroTik RouterOS **7.0 or newer**
- A public IPv4 address on the WAN interface
- A DuckDNS account and token

---

## Configuration

Only edit the **USER CONFIGURATION** section at the top of the script:

############################
# USER CONFIGURATION
############################
:global wanInterface "pppoe-out1"
:global duckDomain   "example.duckdns.org"
:global duckToken    "YOUR-DUCKDNS-TOKEN"

#### Paste the script into the mikrotik
From WinBox:
    Go to System/Scripts and create a new script
        - Set a name
        - Set permissions to read, policy and test

#### Create a Scheduler
From WinBox:
    Go to System/Scheduler
    Create a new scheduler
    Assign permissions to read, policy and test
    Set an interval 
    Set "OnEvent" with the script name (case sensitive!)

