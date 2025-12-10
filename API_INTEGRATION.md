# API Integration Guide (Next.js Portal)

This guide documents the integration between the External Captive Portal (Next.js) and OpenWISP/RADIUS.

## 1. Parameters Sent by AP (UAM)

When a user connects to the WiFi, the AP redirects them to your portal URL (`https://hotelposadadelcobre.com/wifi`) with the following query parameters:

| Parameter | Description | Example |
| :--- | :--- | :--- |
| `challenge` | Challenge string for CHAP auth | `760d69e589...` |
| `uamip` | IP of the CoovaChilli controller | `10.1.0.1` |
| `uamport` | Port of the CoovaChilli controller | `3990` |
| `mac` | Client MAC Address | `AA-BB-CC-DD-EE-FF` |
| `ip` | Client IP Address | `10.1.0.50` |
| `nasid` | NAS ID of the AP | `ap-reception-01` |
| `userurl` | Original URL user tried to visit | `http://google.com` |

**Example URL:**
`https://hotelposadadelcobre.com/wifi?challenge=...&uamip=10.1.0.1&uamport=3990&mac=AA-BB-CC-DD-EE-FF&...`

## 2. OpenWISP API Endpoints

Use these endpoints to manage users and sessions from your Next.js backend.

**Base URL**: `https://red.hotelposadadelcobre.com/api/v1`
**Auth**: Bearer Token (Create a token in OpenWISP Admin -> Users -> Tokens)

### A. Create/Authorize User (Sign Up)

**Endpoint**: `POST /mobile/radius/user/`

**Body**:
```json
{
    "username": "AA:BB:CC:DD:EE:FF",  // Use MAC as username for transparent auth
    "password": "password",           // Default password or generated
    "email": "juan@example.com",
    "first_name": "Juan",
    "last_name": "Perez",
    "group": "Guest_10M",             // The RADIUS group we created
    "organization_slug": "hotel-posada-del-cobre"
}
```

### B. Check User Status

**Endpoint**: `GET /mobile/radius/user/?username=AA:BB:CC:DD:EE:FF`

### C. Revoke Access (Disconnect)

To disconnect a user, you typically send a CoA (Change of Authorization) packet or delete the user/session.

**Endpoint**: `POST /mobile/radius/user/batch_delete/`
```json
{
    "ids": ["<user_id>"]
}
```

## 3. Login Flow (Next.js Backend)

1.  **Frontend**: Extracts `mac`, `challenge`, `uamip`, `uamport` from URL.
2.  **Frontend**: Collects user data (Name, Email, Room).
3.  **Backend**:
    *   Calls OpenWISP API (`POST /mobile/radius/user/`) to register the MAC.
    *   Generates the PAP/CHAP response (if doing backend auth) OR returns the password to the frontend.
4.  **Frontend**:
    *   Submits a POST form to `http://<uamip>:<uamport>/logon` (The AP's internal login handler).
    *   **Fields**: `username` (MAC), `password`, `userurl`.

## 4. RADIUS Attributes (Configured)

The `Guest_10M` group enforces:
*   **Downstream**: 10 Mbps
*   **Upstream**: 10 Mbps
*   **Session Timeout**: 24 Hours
*   **Max Devices**: 3
