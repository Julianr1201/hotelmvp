# Configuración con Dominio hotelposadadelcobre.com

## ✅ Servicios Configurados

### OpenWISP
- **Dominio**: `hotelposadadelcobre.com` (configurado en variables de entorno)
- **Acceso directo**: http://localhost:8000
- **Acceso por dominio**: http://wifi.hotelposadadelcobre.com (configurar en NGINX Proxy Manager)
- **Estado**: Habilitado con dominio configurado

### OpenWrt con LuCI
- **Acceso directo**: http://localhost:8880
- **Acceso por dominio**: http://router.hotelposadadelcobre.com (configurar en NGINX Proxy Manager)
- **SSH**: `ssh root@localhost -p 2222`
- **Estado**: ✅ Activo con interfaz LuCI

## 🔧 Configuración de NGINX Proxy Manager

Para acceder a los servicios usando tu dominio, configura estos Proxy Hosts en NGINX Proxy Manager (http://localhost:81):

### 1. OpenWISP (wifi.hotelposadadelcobre.com)
- **Domain Names**: `wifi.hotelposadadelcobre.com`
- **Scheme**: `http`
- **Forward Hostname/IP**: `openwisp`
- **Forward Port**: `8000`
- ✅ WebSocket Support
- ✅ Block Common Exploits

### 2. OpenWrt LuCI (router.hotelposadadelcobre.com)
- **Domain Names**: `router.hotelposadadelcobre.com`
- **Scheme**: `http`
- **Forward Hostname/IP**: `openwrt`
- **Forward Port**: `80`
- ✅ WebSocket Support

### 3. Jellyfin (media.hotelposadadelcobre.com)
- **Domain Names**: `media.hotelposadadelcobre.com`
- **Scheme**: `http`
- **Forward Hostname/IP**: `jellyfin`
- **Forward Port**: `8096`
- ✅ WebSocket Support

### 4. Home Assistant (clima.hotelposadadelcobre.com)
- **Domain Names**: `clima.hotelposadadelcobre.com`
- **Scheme**: `http`
- **Forward Hostname/IP**: `localhost` (o IP del host)
- **Forward Port**: `8123`
- ✅ WebSocket Support

## 📋 Configuración DNS

Para que los subdominios funcionen, configura estos registros DNS en tu proveedor de dominio:

```
A     wifi.hotelposadadelcobre.com    → IP_PUBLICA_DEL_SERVIDOR
A     router.hotelposadadelcobre.com  → IP_PUBLICA_DEL_SERVIDOR
A     media.hotelposadadelcobre.com   → IP_PUBLICA_DEL_SERVIDOR
A     clima.hotelposadadelcobre.com   → IP_PUBLICA_DEL_SERVIDOR
```

O si prefieres usar CNAME:

```
CNAME wifi.hotelposadadelcobre.com    → hotelposadadelcobre.com
CNAME router.hotelposadadelcobre.com  → hotelposadadelcobre.com
CNAME media.hotelposadadelcobre.com   → hotelposadadelcobre.com
CNAME clima.hotelposadadelcobre.com   → hotelposadadelcobre.com
```

## 🔐 Certificados SSL

Una vez configurados los Proxy Hosts, puedes obtener certificados SSL gratuitos desde NGINX Proxy Manager:

1. Ve a **SSL Certificates**
2. Agrega un certificado Let's Encrypt
3. Ingresa los dominios: `wifi.hotelposadadelcobre.com`, `router.hotelposadadelcobre.com`, etc.
4. Asigna el certificado a cada Proxy Host

## 🚀 Accesos Actuales

| Servicio | URL Local | URL con Dominio |
|----------|-----------|------------------|
| **NGINX Proxy Manager** | http://localhost:81 | - |
| **OpenWISP** | http://localhost:8000 | http://wifi.hotelposadadelcobre.com |
| **OpenWrt LuCI** | http://localhost:8880 | http://router.hotelposadadelcobre.com |
| **Jellyfin** | http://localhost:8096 | http://media.hotelposadadelcobre.com |
| **Home Assistant** | http://localhost:8123 | http://clima.hotelposadadelcobre.com |

## 📝 Variables de Entorno Configuradas

En el archivo `.env`:
- `OPENWISP_DOMAIN=hotelposadadelcobre.com`
- `OPENWISP_DB_PASSWORD`: Generada automáticamente
- `OPENWISP_SECRET_KEY`: Generada automáticamente

## ⚠️ Notas Importantes

1. **OpenWISP**: Requiere configuración inicial después del primer acceso. Crea un usuario administrador.

2. **OpenWrt LuCI**: 
   - Usuario por defecto: `root`
   - Contraseña: Puede estar vacía o ser `password` (cambiar inmediatamente)
   - Acceso SSH: `ssh root@localhost -p 2222`

3. **Dominio**: Asegúrate de que los registros DNS estén configurados correctamente antes de usar los subdominios.

4. **Firewall**: Si tienes un firewall, abre los puertos 80, 443, 8000, 8880, 8096, 8123.

---

**Configuración completada** ✅

