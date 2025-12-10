# 🔑 Access Credentials & Ports

## 🌐 Public Access (Cloudflare Tunnel)
| Service | URL | Notes |
| :--- | :--- | :--- |
| **OpenWISP Dashboard** | [https://red.hotelposadadelcobre.com](https://red.hotelposadadelcobre.com) | Network Controller |
| **Guest Portal** | [https://hotelposadadelcobre.com/wifi](https://hotelposadadelcobre.com/wifi) | External Captive Portal (Next.js) |

## 🏠 Local Access (Reception PC)
| Service | URL (Localhost) | URL (LAN - TV/Mobile) | Port | Default User |
| :--- | :--- | :--- | :--- | :--- |
| **OpenWISP** | [https://localhost](https://localhost) | `https://192.168.1.103` | 443 | `admin` |
| **Pi-hole** | [http://localhost:8053/admin](http://localhost:8053/admin) | `http://192.168.1.103:8053/admin` | 8053 | - |
| **Home Assistant** | [http://localhost:8123](http://localhost:8123) | `http://192.168.1.103:8123` | 8123 | (Created by you) |
| **Jellyfin** | [http://localhost:8096](http://localhost:8096) | `http://192.168.1.103:8096` | 8096 | (Created by you) |
| **Grafana** | [http://localhost:3000](http://localhost:3000) | `http://192.168.1.103:3000` | 3000 | `admin` |
| **Prometheus** | [http://localhost:9090](http://localhost:9090) | 9090 | - | - |
| **Mosquitto** | `localhost` | 1883 | - | - |

## 🛠️ Internal Docker Ports
| Service | Internal Port | Container Name |
| :--- | :--- | :--- |
| **PostgreSQL** | 5432 | `openwisp_db` |
| **Redis** | 6379 | `openwisp_redis` |
| **InfluxDB** | 8086 | `openwisp_influxdb` |

## 📝 Important Notes
1.  **Change Defaults**: Immediately change `admin/admin` passwords.
2.  **Jellyfin/HA**: These services require you to create the first user via the web wizard.
3.  **Pi-hole Password**: Set in `hotel-stack/.env.custom` (Variable: `PIHOLE_WEBPASSWORD`).
