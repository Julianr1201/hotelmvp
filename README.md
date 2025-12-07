# Hotel MVP Stack - Hotel Posada del Cobre

Stack completo en Docker para la gestión de red WiFi, servidor multimedia y control de climatización del Hotel Posada del Cobre (20 habitaciones).

## 📋 Descripción del Proyecto

Este proyecto contiene todos los servicios necesarios para el MVP del hotel:

- **🌐 OpenWISP**: Controlador WiFi y portal cautivo para gestión de red
- **🎬 Jellyfin**: Servidor multimedia local para streaming a las TVs
- **🏠 Home Assistant**: Sistema de automatización para control de climatización
- **🔀 NGINX Proxy Manager**: Proxy inverso para acceso unificado a todos los servicios

Todo corre en Docker sobre una PC en recepción (Linux recomendado, compatible con WSL2).

## 🎯 Requisitos Previos

Antes de comenzar, asegúrate de tener instalado:

1. **Docker** (versión 20.10 o superior)
   - Linux: `sudo apt install docker.io docker-compose-plugin` (o según tu distribución)
   - WSL2: Instalar Docker Desktop para Windows
   - Verificar: `docker --version` y `docker compose version`

2. **Git** (para clonar el repositorio)
   - Linux: `sudo apt install git`
   - Windows/WSL2: Ya viene incluido

3. **Permisos adecuados**
   - En Linux, tu usuario debe estar en el grupo `docker` o usar `sudo`
   - Verificar: `docker ps` (no debe dar error)

## 🚀 Instalación y Puesta en Marcha

### Paso 1: Clonar el Repositorio

```bash
git clone https://github.com/tu-usuario/hotel-mvp-stack.git
cd hotel-mvp-stack
```

### Paso 2: Configurar Variables de Entorno

```bash
# Copiar el archivo de ejemplo
cp .env.example .env

# Editar el archivo .env con tus valores
nano .env  # o usa el editor que prefieras
```

**⚠️ IMPORTANTE**: Cambia TODAS las contraseñas y secretos en el archivo `.env`:
- `OPENWISP_DB_PASSWORD`: Contraseña para la base de datos de OpenWISP
- `OPENWISP_SECRET_KEY`: Clave secreta larga y aleatoria (puedes generarla con: `openssl rand -hex 32`)
- `MEDIA_PATH`: Ruta absoluta a tu carpeta de medios (películas, series, música)

### Paso 3: Crear Carpetas Necesarias

```bash
# Crear carpeta de medios (si no existe)
mkdir -p media

# Dar permisos adecuados (ajusta según tu usuario)
# En Linux:
sudo chown -R $USER:$USER media
```

### Paso 4: Iniciar el Stack

```bash
# Opción 1: Usar el script (recomendado)
chmod +x scripts/*.sh
./scripts/start.sh

# Opción 2: Usar docker compose directamente
docker compose up -d
```

### Paso 5: Verificar que Todo Está Corriendo

```bash
# Ver estado de todos los contenedores
docker compose ps

# Ver logs de un servicio específico
docker compose logs -f jellyfin
docker compose logs -f openwisp
docker compose logs -f homeassistant
```

## 🌐 Accesos por Defecto

Una vez iniciado el stack, los servicios estarán disponibles en:

| Servicio | URL Local | Credenciales Iniciales |
|----------|-----------|------------------------|
| **NGINX Proxy Manager** | http://localhost:81 | admin@example.com / changeme |
| **OpenWISP** | http://localhost:8000 | Se crea en el primer acceso |
| **Jellyfin** | http://localhost:8096 | Se crea en el primer acceso |
| **Home Assistant** | http://localhost:8123 | Se crea en el primer acceso |

**⚠️ IMPORTANTE**: Cambia todas las contraseñas por defecto inmediatamente después del primer acceso.

## 🔧 Configuración de Servicios

### 1. NGINX Proxy Manager (Proxy Inverso)

El proxy permite acceder a los servicios con nombres amigables como `wifi.local`, `media.local`, etc.

#### Configuración Inicial:

1. Accede a http://localhost:81
2. Inicia sesión con: `admin@example.com` / `changeme`
3. **Cambia la contraseña** en el primer acceso

#### Crear Proxy Hosts:

Para cada servicio, crea un "Proxy Host" en el panel:

**OpenWISP (wifi.local):**
- Domain Names: `wifi.local`
- Scheme: `http`
- Forward Hostname/IP: `openwisp`
- Forward Port: `8000`
- ✅ WebSocket Support
- ✅ Block Common Exploits

**Jellyfin (media.local):**
- Domain Names: `media.local`
- Scheme: `http`
- Forward Hostname/IP: `jellyfin`
- Forward Port: `8096`
- ✅ WebSocket Support

**Home Assistant (clima.local):**
- Domain Names: `clima.local`
- Scheme: `http`
- Forward Hostname/IP: `localhost` (o la IP de la máquina)
- Forward Port: `8123`
- ✅ WebSocket Support

**Nota**: Para que los nombres `.local` funcionen, necesitas configurar DNS local o usar el archivo `/etc/hosts` (ver sección más abajo).

### 2. Jellyfin (Servidor Multimedia)

#### Crear Usuario Administrador:

1. Accede a http://localhost:8096 (o http://media.local si configuraste el proxy)
2. En la primera pantalla, completa el asistente de configuración:
   - Selecciona idioma: Español
   - Crea un usuario administrador
   - Configura bibliotecas de medios (películas, series, música)
   - Ajusta la ruta de medios si es necesario

#### Configurar Bibliotecas:

1. Ve a **Configuración** → **Bibliotecas**
2. Agrega bibliotecas apuntando a carpetas dentro de `/media`:
   - Películas: `/media/peliculas`
   - Series: `/media/series`
   - Música: `/media/musica`

#### Conectar Kodi a Jellyfin:

En cada TV con Kodi:

1. Instala el addon **Jellyfin for Kodi** desde el repositorio oficial
2. Durante la configuración, ingresa:
   - **URL del servidor**: `http://IP_DEL_SERVIDOR:8096` (ejemplo: `http://192.168.1.100:8096`)
   - **Usuario y contraseña** de Jellyfin
3. El addon sincronizará tu biblioteca de Jellyfin con Kodi

**Nota**: Reemplaza `IP_DEL_SERVIDOR` con la IP real de la PC donde corre Docker.

### 3. Home Assistant (Control de Climatización)

#### Crear Usuario Administrador:

1. Accede a http://localhost:8123 (o http://clima.local si configuraste el proxy)
2. En la primera pantalla, crea tu cuenta de administrador
3. Completa el asistente de configuración inicial

#### Configurar Integraciones:

Home Assistant puede detectar automáticamente dispositivos en la red gracias a `network_mode: host`.

**Para minisplits con WiFi:**
1. Ve a **Configuración** → **Dispositivos y servicios**
2. Busca integraciones compatibles con tu marca de minisplit
3. Sigue las instrucciones de cada integración

**Para módulos ESPHome:**
1. Instala el addon ESPHome (si usas Home Assistant OS) o instala ESPHome por separado
2. Flashea los módulos ESPHome con el firmware adecuado
3. Home Assistant los detectará automáticamente

**Para dispositivos UART:**
- Puedes usar integraciones como Modbus, MQTT, o crear integraciones personalizadas

### 4. OpenWISP (Controlador WiFi y Portal Cautivo)

#### Crear Usuario Administrador:

1. Accede a http://localhost:8000 (o http://wifi.local si configuraste el proxy)
2. En la primera pantalla, crea tu cuenta de administrador
3. Completa la configuración inicial

#### Configurar OpenWISP:

1. **Crear una Organización:**
   - Ve a **Organizations** → **Add organization**
   - Nombre: "Hotel Posada del Cobre"
   - Slug: `hotel-posada-del-cobre`

2. **Configurar Template para Portal Cautivo:**
   - Ve a **Configurations** → **Templates**
   - Crea un template con las configuraciones de portal cautivo
   - Incluye redirección a la página de login/registro

3. **Preparar para Conectar APs OpenWrt:**

OpenWISP necesita que los APs (Access Points) con OpenWrt se conecten como "dispositivos". Sigue estos pasos conceptuales:

#### Conectar un AP OpenWrt a OpenWISP:

**Paso 1: Instalar el Agente en OpenWrt**

En cada AP con OpenWrt, instala el paquete del agente de OpenWISP:

```bash
# SSH al AP
ssh root@IP_DEL_AP

# Instalar el agente
opkg update
opkg install openwisp-config
```

**Paso 2: Configurar la URL del Controlador**

Edita el archivo de configuración del agente:

```bash
# Editar configuración
vi /etc/config/openwisp

# O usando UCI:
uci set openwisp.@openwisp[0].url='http://IP_DEL_SERVIDOR:8000'
uci set openwisp.@openwisp[0].uuid='GENERAR_UUID_UNICO'
uci commit openwisp
```

**Paso 3: Registrar el Dispositivo en OpenWISP**

1. En OpenWISP, ve a **Devices** → **Add device**
2. Ingresa:
   - **Name**: Nombre descriptivo (ej: "AP-Recepcion", "AP-Piso1")
   - **MAC Address**: MAC del AP (se puede obtener con `ifconfig` en el AP)
   - **Organization**: Selecciona "Hotel Posada del Cobre"
   - **Template**: Asigna el template de portal cautivo creado anteriormente

3. **Obtener el UUID y Token:**
   - Después de crear el dispositivo, OpenWISP mostrará un UUID y un token
   - Copia estos valores

**Paso 4: Completar Configuración en el AP**

En el AP, completa la configuración con el UUID y token:

```bash
uci set openwisp.@openwisp[0].uuid='UUID_DEL_DISPOSITIVO'
uci set openwisp.@openwisp[0].key='TOKEN_DEL_DISPOSITIVO'
uci commit openwisp

# Reiniciar el servicio
/etc/init.d/openwisp restart
```

**Paso 5: Verificar Conexión**

1. En OpenWISP, ve al dispositivo creado
2. Deberías ver que el estado cambia a "Online" cuando el AP se conecta
3. El AP comenzará a recibir configuraciones del controlador

**Nota**: Para más detalles, consulta la [documentación oficial de OpenWISP](https://openwisp.org/docs/user/install-openwisp-config.html).

## 🔄 Gestión del Stack

### Scripts Disponibles

El proyecto incluye scripts para facilitar la gestión:

```bash
# Iniciar todos los servicios
./scripts/start.sh

# Detener todos los servicios
./scripts/stop.sh

# Reiniciar todos los servicios
./scripts/restart.sh

# Hacer backup de configuraciones
./scripts/backup.sh
```

### Comandos Docker Útiles

```bash
# Ver estado de contenedores
docker compose ps

# Ver logs de un servicio
docker compose logs -f jellyfin
docker compose logs -f openwisp
docker compose logs -f homeassistant
docker compose logs -f proxy

# Reiniciar un servicio específico
docker compose restart jellyfin

# Detener y eliminar todo (CUIDADO: no borra volúmenes)
docker compose down

# Detener y eliminar todo incluyendo volúmenes (CUIDADO: borra datos)
docker compose down -v

# Actualizar imágenes y reiniciar
docker compose pull
docker compose up -d
```

## 🔌 Arranque Automático (Auto-start)

Para que el stack se inicie automáticamente después de un corte de luz o reinicio del sistema, puedes crear un servicio de systemd.

### Crear Servicio systemd (Linux)

1. Crea el archivo del servicio:

```bash
sudo nano /etc/systemd/system/hotel-mvp.service
```

2. Pega el siguiente contenido (ajusta las rutas según tu instalación):

```ini
[Unit]
Description=Hotel MVP Stack - Docker Compose
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/ruta/completa/al/proyecto/hotel-mvp-stack
ExecStart=/usr/bin/docker compose up -d
ExecStop=/usr/bin/docker compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
```

3. Reemplaza `/ruta/completa/al/proyecto/hotel-mvp-stack` con la ruta real de tu proyecto.

4. Habilitar y iniciar el servicio:

```bash
# Recargar systemd
sudo systemctl daemon-reload

# Habilitar el servicio (inicia automáticamente al arrancar)
sudo systemctl enable hotel-mvp.service

# Iniciar el servicio ahora
sudo systemctl start hotel-mvp.service

# Verificar estado
sudo systemctl status hotel-mvp.service
```

### Para WSL2 (Windows)

En WSL2, puedes usar Task Scheduler de Windows o crear un script de inicio. Consulta la documentación de WSL2 para más detalles.

## 💾 Persistencia de Datos

Todos los datos importantes se almacenan en volúmenes persistentes:

- **Jellyfin**: `./services/jellyfin/config` (configuración) y `./media` (archivos multimedia)
- **Home Assistant**: `./services/home-assistant/config` (toda la configuración)
- **OpenWISP**: `./services/openwisp/config` y `./services/openwisp/data` (configuración y datos)
- **OpenWISP DB**: Volumen Docker `hotel-openwisp-db-data` (base de datos PostgreSQL)
- **OpenWISP Redis**: Volumen Docker `hotel-openwisp-redis-data` (cache)
- **NGINX Proxy Manager**: `./services/proxy/data` (configuración del proxy)

**⚠️ IMPORTANTE**: Haz backups periódicos de estas carpetas. Usa el script `scripts/backup.sh` para automatizar backups de configuraciones.

### Backup Manual

```bash
# Backup completo (sin media)
tar -czf backup-$(date +%Y%m%d).tar.gz services/ docker-compose.yml .env

# Restaurar
tar -xzf backup-YYYYMMDD.tar.gz
```

## 🌍 Configurar Nombres de Dominio Local (.local)

Para que los nombres como `wifi.local`, `media.local`, etc. funcionen en tu red local, tienes dos opciones:

### Opción 1: Archivo hosts (Cada PC)

En cada PC que quieras usar estos nombres, edita el archivo hosts:

**Linux/Mac:**
```bash
sudo nano /etc/hosts
```

**Windows:**
```
C:\Windows\System32\drivers\etc\hosts
```

Agrega estas líneas (reemplaza `IP_DEL_SERVIDOR` con la IP real):

```
IP_DEL_SERVIDOR    wifi.local
IP_DEL_SERVIDOR    media.local
IP_DEL_SERVIDOR    clima.local
```

### Opción 2: DNS Local (Recomendado para Red Completa)

Configura tu router o servidor DNS local para resolver estos nombres. Consulta la documentación de tu router o configura un servidor DNS como Pi-hole, dnsmasq, etc.

## 🔒 Seguridad

**⚠️ IMPORTANTE - Lee esto antes de poner en producción:**

1. **Cambia todas las contraseñas por defecto** inmediatamente
2. **No expongas estos servicios a Internet** sin un firewall adecuado
3. **Usa HTTPS** para servicios expuestos (configura certificados en NGINX Proxy Manager)
4. **Mantén Docker y las imágenes actualizadas**: `docker compose pull && docker compose up -d`
5. **Haz backups regulares** de las configuraciones
6. **Revisa los logs periódicamente** para detectar problemas

## 🐛 Solución de Problemas

### Los contenedores no inician

```bash
# Ver logs detallados
docker compose logs

# Verificar que Docker está corriendo
docker info

# Verificar que los puertos no están en uso
sudo netstat -tulpn | grep -E ':(80|443|81|8000|8096|8123)'
```

### Jellyfin no encuentra archivos multimedia

1. Verifica que la ruta en `.env` (`MEDIA_PATH`) es correcta y absoluta
2. Verifica permisos: `ls -la media/`
3. Verifica que los archivos están en la carpeta correcta

### Home Assistant no detecta dispositivos

1. Verifica que el contenedor tiene `network_mode: host` (ya está configurado)
2. Verifica que los dispositivos están en la misma red
3. Revisa los logs: `docker compose logs -f homeassistant`

### OpenWISP no se conecta a la base de datos

1. Verifica que el contenedor `openwisp-db` está corriendo: `docker compose ps`
2. Verifica las variables en `.env`
3. Revisa los logs: `docker compose logs -f openwisp openwisp-db`

## 📚 Recursos Adicionales

- [Documentación de OpenWISP](https://openwisp.org/docs/)
- [Documentación de Jellyfin](https://jellyfin.org/docs/)
- [Documentación de Home Assistant](https://www.home-assistant.io/docs/)
- [Documentación de NGINX Proxy Manager](https://nginxproxymanager.com/guide/)

## 📝 Notas del Proyecto

- **Hotel**: Hotel Posada del Cobre
- **Habitaciones**: 20
- **Ubicación**: Recepción (PC torre)
- **Sistema Operativo**: Linux recomendado (compatible con WSL2)

## 🤝 Contribuciones

Este es un proyecto MVP. Para mejoras o reportes de problemas, abre un issue en el repositorio.

## 📄 Licencia

Este proyecto es de uso interno del Hotel Posada del Cobre.

---

**Última actualización**: 2024
