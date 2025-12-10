# Hotel MVP - Hotel Posada del Cobre

Dockerized infrastructure for Hotel Posada del Cobre (20 rooms). This project manages the WiFi network, guest services, and monitoring.

## 🏗️ System Architecture

The project is split into two independent stacks:

### 1. OpenWISP Stack (`docker-openwisp/`)
*   **Based on**: Official `openwisp/docker-openwisp` repository.
*   **Services**: Network Controller, Captive Portal, RADIUS, VPN.
*   **Access**: `https://localhost` (or configured domain).

### 2. Hotel Stack (`hotel-stack/`)
*   **Services**:
    *   **Pi-hole**: DNS Sinkhole & DHCP (`http://localhost:8053/admin`).
    *   **Home Assistant**: IoT & Climate Control (`http://localhost:8123`).
    *   **Jellyfin**: Media Server (`http://localhost:8096`).
    *   **Grafana**: Monitoring Dashboard (`http://localhost:3000`).
    *   **Prometheus**: Metrics Collection (`http://localhost:9090`).
    *   **Mosquitto**: MQTT Broker (Port 1883).

## � Quick Start

1.  **OpenWISP**:
    ```bash
    cd docker-openwisp
    docker compose up -d
    ```

2.  **Hotel Stack**:
    ```bash
    cd hotel-stack
    docker compose --env-file .env.custom up -d
    ```

## 📚 Documentation

*   **[Production Guide](PRODUCTION_GUIDE.md)**: Detailed deployment, backup, and maintenance instructions.
*   **[Quick Start](QUICK_START.md)**: Fast track for development.

## � Credentials

See `PRODUCTION_GUIDE.md` or `walkthrough.md` for default credentials. **Change them immediately in production.**
