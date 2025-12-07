# Estructura del Proyecto - Hotel MVP Stack

```
hotel-mvp-stack/
│
├── docker-compose.yml          # Configuración principal de Docker Compose
├── .env.example                # Plantilla de variables de entorno
├── .env                        # Variables de entorno reales (NO versionar)
├── .gitignore                  # Archivos y carpetas ignorados por Git
│
├── README.md                   # Documentación principal (en español)
├── NOTAS_IMPLEMENTACION.md     # Notas técnicas y puntos de atención
├── ESTRUCTURA_PROYECTO.md      # Este archivo
│
├── scripts/                    # Scripts de gestión
│   ├── start.sh               # Iniciar el stack
│   ├── stop.sh                # Detener el stack
│   ├── restart.sh             # Reiniciar el stack
│   └── backup.sh              # Hacer backup de configuraciones
│
├── services/                   # Configuraciones de cada servicio
│   ├── proxy/                 # NGINX Proxy Manager
│   │   ├── data/              # Datos del proxy (NO versionar)
│   │   └── letsencrypt/       # Certificados SSL (NO versionar)
│   │
│   ├── jellyfin/
│   │   └── config/            # Configuración de Jellyfin (NO versionar)
│   │
│   ├── home-assistant/
│   │   └── config/            # Configuración de Home Assistant (NO versionar)
│   │
│   └── openwisp/
│       ├── config/            # Configuración de OpenWISP (NO versionar)
│       └── data/              # Datos de OpenWISP (NO versionar)
│
├── media/                      # Archivos multimedia (NO versionar)
│   ├── peliculas/             # Películas
│   ├── series/                # Series de TV
│   └── musica/                # Música
│
├── systemd/                    # Configuración de arranque automático
│   ├── hotel-mvp.service.example  # Ejemplo de servicio systemd
│   └── README.md              # Instrucciones de instalación
│
└── backups/                    # Backups (creado por backup.sh, NO versionar)
    └── hotel-mvp-backup-YYYYMMDD_HHMMSS.tar.gz
```

## Descripción de Carpetas

### Raíz del Proyecto

- **docker-compose.yml**: Archivo principal que define todos los servicios Docker
- **.env.example**: Plantilla con variables de entorno (copiar a `.env` y configurar)
- **.gitignore**: Define qué archivos no se versionan (configs, media, etc.)

### Documentación

- **README.md**: Guía completa de instalación y uso (en español)
- **NOTAS_IMPLEMENTACION.md**: Notas técnicas, puntos críticos y solución de problemas
- **ESTRUCTURA_PROYECTO.md**: Este archivo, describe la estructura del proyecto

### Scripts

Todos los scripts están en `scripts/` y son ejecutables con `bash` o `sh`:

- **start.sh**: Inicia todos los servicios con verificaciones
- **stop.sh**: Detiene todos los servicios
- **restart.sh**: Reinicia todos los servicios
- **backup.sh**: Crea un backup comprimido de las configuraciones

### Servicios

Cada servicio tiene su carpeta en `services/`:

- **proxy/**: NGINX Proxy Manager (reverse proxy)
- **jellyfin/**: Servidor multimedia Jellyfin
- **home-assistant/**: Sistema de automatización Home Assistant
- **openwisp/**: Controlador WiFi OpenWISP

**Nota**: Las carpetas `config/` y `data/` dentro de cada servicio contienen datos persistentes y NO se versionan (están en `.gitignore`).

### Media

La carpeta `media/` contiene los archivos multimedia (películas, series, música). Esta carpeta:

- **NO se versiona** (está en `.gitignore`)
- Se monta como volumen de solo lectura en Jellyfin
- Debe configurarse la ruta absoluta en `.env` (`MEDIA_PATH`)

### Systemd

Carpeta con ejemplos y documentación para configurar el arranque automático del stack usando systemd (Linux).

### Backups

Carpeta creada automáticamente por `backup.sh` con backups comprimidos de las configuraciones. No se versiona.

## Archivos que NO se Versionan

Los siguientes archivos/carpetas están en `.gitignore` y NO se suben al repositorio:

- `.env` (contiene secretos)
- `services/*/config/` (configuraciones con datos sensibles)
- `services/*/data/` (datos persistentes)
- `media/` (archivos multimedia, pueden ser muy grandes)
- `backups/` (backups de configuraciones)
- `*.log` (archivos de log)

## Comandos Útiles

```bash
# Ver estructura del proyecto
tree -L 3 -I 'node_modules|.git'

# Ver tamaño de carpetas
du -sh services/* media/ 2>/dev/null

# Ver archivos versionados
git ls-files

# Ver archivos ignorados
git status --ignored
```

---

**Última actualización**: 2024

