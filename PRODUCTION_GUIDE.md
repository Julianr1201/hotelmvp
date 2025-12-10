# Hotel MVP - Production Guide

This guide details how to deploy, configure, and maintain the Hotel MVP system in a production environment (Reception PC).

## System Architecture

The system is divided into two independent stacks:

1.  **OpenWISP Stack** (`docker-openwisp/`):
    *   **Purpose**: Network management, captive portal, VPN.
    *   **Core Services**: Dashboard, API, Nginx, PostgreSQL, Redis, InfluxDB.
    *   **Access**: `https://localhost` (or configured domain).

2.  **Hotel Stack** (`hotel-stack/`):
    *   **Purpose**: Guest services, monitoring, DNS.
    *   **Core Services**: Home Assistant, Jellyfin, Pi-hole, Grafana, Prometheus, Mosquitto.
    *   **Access**: See "Service Access" below.

## Deployment Steps

### 1. Prerequisites
*   Windows 10/11 Pro (for Docker Desktop) or Linux Server.
*   Docker & Docker Compose installed.
*   Git installed.
*   Cloudflare Tunnel (recommended for external access).

### 2. Clone & Setup
```bash
git clone https://github.com/Julianr1201/hotelmvp.git
cd hotelmvp
```

### 3. Deploy OpenWISP Stack
```bash
cd docker-openwisp
# Ensure .env is configured (copy from .env.local if needed)
docker compose up -d
```
*   **Initial Login**: `https://localhost`
*   **Default Credentials**: `admin` / `admin` (Change immediately!)

### 4. Deploy Hotel Stack
```bash
cd ../hotel-stack
# Ensure .env.custom is configured
docker compose --env-file .env.custom up -d
```

## Service Access

| Service | URL | Default Port | Notes |
| :--- | :--- | :--- | :--- |
| **OpenWISP** | https://localhost | 443 | Network Controller |
| **Pi-hole** | http://localhost:8053/admin | 8053 | DNS Sinkhole (Pass: `admin`) |
| **Home Assistant** | http://localhost:8123 | 8123 | IoT Automation |
| **Jellyfin** | http://localhost:8096 | 8096 | Media Server |
| **Grafana** | http://localhost:3000 | 3000 | Monitoring (admin/admin) |
| **Prometheus** | http://localhost:9090 | 9090 | Metrics |
| **Mosquitto** | (No Web UI) | 1883 | MQTT Broker |

## Configuration & Maintenance

### Backups
*   **OpenWISP**: Backup the `docker-openwisp/` directory and its volumes (Postgres, etc.).
*   **Hotel Stack**: Backup `hotel-stack/` directory, especially `homeassistant/`, `jellyfin/config`, and `pihole/`.

### Updates
To update services:
```bash
docker compose pull
docker compose up -d
```

### Troubleshooting
*   **Logs**: `docker logs <container_name>`
*   **Restart**: `docker compose restart <service_name>`
