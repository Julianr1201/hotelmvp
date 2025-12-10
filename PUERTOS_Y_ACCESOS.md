# 🔌 Puertos y Accesos - Hotel MVP Stack

**Última actualización**: Diciembre 2024

## 📋 Resumen de Puertos

| Servicio | Puerto | Protocolo | URL Local | Estado |
|----------|--------|-----------|-----------|--------|
| **NGINX Proxy Manager** | 80 | HTTP | http://localhost:80 | ✅ |
| **NGINX Proxy Manager** | 443 | HTTPS | https://localhost:443 | ✅ |
| **NGINX Proxy Manager** | 81 | HTTP | http://localhost:81 | ✅ Admin Panel |
| **OpenWISP** | 8000 | HTTP | http://localhost:8000 | ✅ |
| **OpenWrt LuCI** | 8880 | HTTP | http://localhost:8880 | ✅ |
| **OpenWrt LuCI** | 8443 | HTTPS | https://localhost:8443 | ✅ |
| **OpenWrt SSH** | 2222 | TCP | ssh root@localhost -p 2222 | ✅ |
| **Jellyfin** | 8096 | HTTP | http://localhost:8096 | ✅ |
| **Jellyfin** | 8920 | HTTPS | https://localhost:8920 | ✅ |
| **Jellyfin** | 7359 | UDP | Auto-discovery | ✅ |
| **Home Assistant** | 8123 | HTTP | http://localhost:8123 | ✅ (network_mode: host) |

## 🌐 Accesos por Servicio

### 1. NGINX Proxy Manager (Proxy Inverso)
- **Panel de Administración**: http://localhost:81
- **Credenciales iniciales**:
  - Usuario: `admin@example.com`
  - Contraseña: `changeme`
  - ⚠️ **CAMBIAR INMEDIATAMENTE** después del primer acceso

**Puertos expuestos**:
- `80` - HTTP (tráfico web)
- `443` - HTTPS (tráfico web seguro)
- `81` - Panel de administración

### 2. OpenWISP (Controlador WiFi)
- **URL Local**: http://localhost:8000
- **URL con Dominio**: http://wifi.hotelposadadelcobre.com (configurar en proxy)
- **Puerto**: `8000` (HTTP)

**Nota**: Requiere crear usuario administrador en el primer acceso.

### 3. OpenWrt (Router/Firewall con LuCI)
- **URL Local HTTP**: http://localhost:8880
- **URL Local HTTPS**: https://localhost:8443
- **URL con Dominio**: http://router.hotelposadadelcobre.com (configurar en proxy)
- **SSH**: `ssh root@localhost -p 2222`

**Puertos expuestos**:
- `8880` - LuCI HTTP
- `8443` - LuCI HTTPS
- `2222` - SSH

**Credenciales iniciales**:
- Usuario: `root`
- Contraseña: Puede estar vacía o ser `password` (cambiar inmediatamente)

### 4. Jellyfin (Servidor Multimedia)
- **URL Local**: http://localhost:8096
- **URL HTTPS**: https://localhost:8920
- **URL con Dominio**: http://media.hotelposadadelcobre.com (configurar en proxy)

**Puertos expuestos**:
- `8096` - HTTP
- `8920` - HTTPS
- `7359/UDP` - Auto-discovery para dispositivos

**Nota**: Requiere crear usuario administrador en el primer acceso.

### 5. Home Assistant (Control de Climatización)
- **URL Local**: http://localhost:8123
- **URL con Dominio**: http://clima.hotelposadadelcobre.com (configurar en proxy)

**⚠️ IMPORTANTE**: Home Assistant usa `network_mode: host`, por lo que:
- **NO aparece puerto en `docker compose ps`** (es normal)
- Accede directamente a `http://localhost:8123` o `http://IP_DEL_SERVIDOR:8123`
- Funciona directamente en la red del host

**Puerto**: `8123` (HTTP, accesible directamente en el host)

**Nota**: Requiere crear usuario administrador en el primer acceso.

## 🔍 Verificar Puertos en Uso

Para verificar qué puertos están en uso en Windows:

```powershell
# Ver puertos en uso
netstat -ano | findstr ":80 :443 :81 :8000 :8880 :8096 :8123 :2222"

# O más específico
netstat -ano | findstr "LISTENING" | findstr ":80 :443 :81 :8000 :8880 :8096 :8123"
```

## 📝 Configuración de Proxy (NGINX Proxy Manager)

Una vez que todos los servicios estén corriendo, configura estos Proxy Hosts en http://localhost:81:

### OpenWISP
- **Domain Names**: `wifi.hotelposadadelcobre.com`
- **Scheme**: `http`
- **Forward Hostname/IP**: `openwisp`
- **Forward Port**: `8000`
- ✅ WebSocket Support
- ✅ Block Common Exploits

### OpenWrt LuCI
- **Domain Names**: `router.hotelposadadelcobre.com`
- **Scheme**: `http`
- **Forward Hostname/IP**: `openwrt`
- **Forward Port**: `80` (interno del contenedor)
- ✅ WebSocket Support

### Jellyfin
- **Domain Names**: `media.hotelposadadelcobre.com`
- **Scheme**: `http`
- **Forward Hostname/IP**: `jellyfin`
- **Forward Port**: `8096`
- ✅ WebSocket Support

### Home Assistant
- **Domain Names**: `clima.hotelposadadelcobre.com`
- **Scheme**: `http`
- **Forward Hostname/IP**: `localhost` (o IP del servidor)
- **Forward Port**: `8123`
- ✅ WebSocket Support

**Nota**: Para Home Assistant, usa `localhost` o la IP real del servidor porque usa `network_mode: host`.

## 🚀 Comandos Rápidos

```powershell
# Ver todos los puertos expuestos
docker compose ps

# Ver puertos de un servicio específico
docker compose ps openwisp
docker compose ps jellyfin

# Ver logs de un servicio
docker compose logs -f openwisp
docker compose logs -f jellyfin
docker compose logs -f homeassistant

# Verificar que los puertos están escuchando
netstat -ano | findstr "LISTENING" | findstr ":8000 :8096 :8123"
```

## ⚠️ Notas Importantes

1. **Home Assistant**: No aparece puerto en `docker compose ps` porque usa `network_mode: host`. Esto es **normal** y **correcto**.

2. **Puertos en conflicto**: Si algún puerto está en uso, verifica con `netstat` y detén el servicio que lo está usando.

3. **Firewall**: Asegúrate de que el firewall de Windows permite estos puertos si necesitas acceso desde otras máquinas.

4. **Acceso desde red local**: Para acceder desde otras máquinas en la red, usa la IP del servidor en lugar de `localhost`:
   - http://192.168.1.XXX:8000 (OpenWISP)
   - http://192.168.1.XXX:8096 (Jellyfin)
   - http://192.168.1.XXX:8123 (Home Assistant)

---

**Última actualización**: Diciembre 2024








