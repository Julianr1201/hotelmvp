# Notas de Implementación - Hotel MVP Stack

Este documento contiene notas importantes y puntos de atención para la implementación del stack.

## ⚠️ Puntos Críticos que Requieren Atención Manual

### 1. Configuración de OpenWISP

**IMPORTANTE**: La imagen de OpenWISP puede requerir configuración adicional después del primer arranque. Si la imagen `openwisp/openwisp:latest` no funciona directamente, considera:

- Usar la imagen `openwisp/openwisp-all-in-one:latest` como alternativa
- O seguir la documentación oficial para desplegar OpenWISP con servicios separados (web, celery, etc.)

**Referencia**: https://openwisp.org/docs/user/install.html

### 2. Variables de Entorno Requeridas

Antes de iniciar el stack, **DEBES** configurar estas variables en `.env`:

- `OPENWISP_DB_PASSWORD`: Contraseña segura para PostgreSQL
- `OPENWISP_SECRET_KEY`: Clave secreta de Django (generar con: `openssl rand -hex 32`)
- `MEDIA_PATH`: Ruta absoluta a la carpeta de medios

**Sin estas variables, el stack NO funcionará correctamente.**

### 3. Permisos de Carpetas (Linux)

En Linux, asegúrate de que las carpetas tengan los permisos correctos:

```bash
# Dar permisos al usuario actual
sudo chown -R $USER:$USER services/ media/

# O si prefieres permisos más abiertos (menos seguro)
chmod -R 755 services/
chmod -R 755 media/
```

### 4. Network Mode Host en Home Assistant

Home Assistant usa `network_mode: host` para descubrir dispositivos en la red. Esto significa:

- **No puede estar en la red Docker** (`hotel-network`)
- **Accede directamente a la red del host**
- En algunos sistemas, esto puede requerir permisos adicionales

Si tienes problemas, verifica que Docker tiene permisos para usar el modo host.

### 5. Puertos en Uso

Verifica que estos puertos no estén en uso antes de iniciar:

- `80` (HTTP)
- `443` (HTTPS)
- `81` (NGINX Proxy Manager admin)
- `8000` (OpenWISP)
- `8096` (Jellyfin)
- `8123` (Home Assistant)

```bash
# Linux: Verificar puertos en uso
sudo netstat -tulpn | grep -E ':(80|443|81|8000|8096|8123)'

# O usar ss
sudo ss -tulpn | grep -E ':(80|443|81|8000|8096|8123)'
```

### 6. Configuración de DNS Local (.local)

Los nombres como `wifi.local`, `media.local`, etc. requieren configuración adicional:

**Opción A: Archivo hosts** (cada PC)
- Editar `/etc/hosts` (Linux/Mac) o `C:\Windows\System32\drivers\etc\hosts` (Windows)
- Agregar: `IP_DEL_SERVIDOR wifi.local media.local clima.local`

**Opción B: DNS local en router**
- Configurar el router para resolver estos nombres
- O usar un servidor DNS local (Pi-hole, dnsmasq, etc.)

### 7. Certificados SSL (Opcional pero Recomendado)

Para producción, configura certificados SSL en NGINX Proxy Manager:

1. Accede al panel: http://localhost:81
2. Ve a **SSL Certificates**
3. Agrega un certificado (Let's Encrypt, o sube uno propio)
4. Asigna el certificado a cada Proxy Host

**Nota**: Let's Encrypt requiere un dominio real y acceso desde Internet.

### 8. Backup de Configuraciones

**Haz backups regulares** de estas carpetas:

- `services/jellyfin/config/`
- `services/home-assistant/config/`
- `services/openwisp/config/` y `services/openwisp/data/`
- `services/proxy/data/`

Usa el script: `./scripts/backup.sh`

### 9. Actualización de Imágenes

Para mantener el stack actualizado:

```bash
# Descargar nuevas versiones
docker compose pull

# Reiniciar con nuevas versiones
docker compose up -d
```

**⚠️ ADVERTENCIA**: Antes de actualizar, haz un backup completo.

### 10. WSL2 Consideraciones

Si usas WSL2 en Windows:

- Docker Desktop debe estar corriendo
- Las rutas de volúmenes pueden necesitar formato WSL2: `/mnt/c/ruta/windows`
- `network_mode: host` puede no funcionar igual que en Linux nativo
- Considera usar IPs explícitas en lugar de `localhost` para algunos servicios

## 🔧 Ajustes Post-Instalación

### Jellyfin - Configurar Bibliotecas

1. Accede a Jellyfin
2. Ve a **Configuración** → **Bibliotecas**
3. Agrega bibliotecas apuntando a:
   - Películas: `/media/peliculas`
   - Series: `/media/series`
   - Música: `/media/musica`

### Home Assistant - Integraciones

1. Accede a Home Assistant
2. Ve a **Configuración** → **Dispositivos y servicios**
3. Agrega integraciones según tus dispositivos:
   - Minisplits WiFi: Buscar integración específica de la marca
   - ESPHome: Instalar addon o integración
   - MQTT: Si usas módulos MQTT

### OpenWISP - Configuración Inicial

1. Accede a OpenWISP
2. Crea una organización: "Hotel Posada del Cobre"
3. Configura templates para portal cautivo
4. Prepara para conectar APs (ver README.md)

## 📝 Checklist de Implementación

- [ ] Docker y Docker Compose instalados y funcionando
- [ ] Repositorio clonado
- [ ] `.env` creado desde `.env.example` y configurado
- [ ] Carpetas creadas con permisos correctos
- [ ] Puertos verificados (no en uso)
- [ ] Stack iniciado: `./scripts/start.sh`
- [ ] Todos los contenedores corriendo: `docker compose ps`
- [ ] Accesos verificados (proxy, Jellyfin, HA, OpenWISP)
- [ ] Contraseñas cambiadas en todos los servicios
- [ ] Proxy configurado con dominios locales
- [ ] Bibliotecas de Jellyfin configuradas
- [ ] Integraciones de Home Assistant configuradas
- [ ] Servicio systemd configurado (opcional pero recomendado)
- [ ] Backup inicial realizado
- [ ] Documentación del proyecto revisada

## 🆘 Solución de Problemas Comunes

### Contenedores no inician

```bash
# Ver logs detallados
docker compose logs

# Verificar variables de entorno
cat .env

# Verificar que Docker está corriendo
docker info
```

### OpenWISP no se conecta a la base de datos

```bash
# Verificar que la DB está corriendo
docker compose ps openwisp-db

# Ver logs de la DB
docker compose logs openwisp-db

# Verificar variables en .env
grep OPENWISP .env
```

### Home Assistant no detecta dispositivos

- Verifica que `network_mode: host` está configurado
- Verifica que los dispositivos están en la misma red
- Revisa los logs: `docker compose logs -f homeassistant`

### Jellyfin no encuentra archivos

- Verifica la ruta en `.env` (`MEDIA_PATH`)
- Verifica permisos de la carpeta media
- Verifica que los archivos están en la estructura correcta

## 📞 Soporte

Para problemas o dudas:

1. Revisa los logs: `docker compose logs -f [servicio]`
2. Consulta la documentación oficial de cada servicio
3. Verifica el README.md principal
4. Abre un issue en el repositorio si es un problema del proyecto

---

**Última actualización**: 2024

