# Quick Start - Hotel MVP Stack

Guía rápida para poner en marcha el stack en 5 minutos.

## ⚡ Inicio Rápido

### 1. Prerrequisitos

```bash
# Verificar Docker
docker --version
docker compose version

# Si no está instalado, instalar según tu sistema
```

### 2. Configuración Inicial

```bash
# Clonar repositorio (o descomprimir)
cd hotel-mvp-stack

# Crear archivo de configuración
cp .env.example .env

# Editar .env (IMPORTANTE: cambiar contraseñas)
nano .env  # o tu editor preferido
```

**Variables críticas a cambiar en `.env`:**
- `OPENWISP_DB_PASSWORD`: Cambiar por una contraseña segura
- `OPENWISP_SECRET_KEY`: Generar con `openssl rand -hex 32`
- `MEDIA_PATH`: Ruta absoluta a tu carpeta de medios

### 3. Iniciar Stack

```bash
# Dar permisos a scripts (Linux/Mac)
chmod +x scripts/*.sh

# Iniciar todo
./scripts/start.sh

# O directamente
docker compose up -d
```

### 4. Verificar

```bash
# Ver estado
docker compose ps

# Ver logs
docker compose logs -f
```

### 5. Acceder a Servicios

| Servicio | URL | Credenciales |
|----------|-----|--------------|
| Proxy Admin | http://localhost:81 | admin@example.com / changeme |
| OpenWISP | http://localhost:8000 | Crear en primer acceso |
| Jellyfin | http://localhost:8096 | Crear en primer acceso |
| Home Assistant | http://localhost:8123 | Crear en primer acceso |

**⚠️ IMPORTANTE**: Cambiar todas las contraseñas por defecto inmediatamente.

## 📋 Próximos Pasos

1. **Configurar Proxy**: Acceder a http://localhost:81 y crear Proxy Hosts para:
   - `wifi.local` → OpenWISP (puerto 8000)
   - `media.local` → Jellyfin (puerto 8096)
   - `clima.local` → Home Assistant (puerto 8123)

2. **Configurar Jellyfin**:
   - Crear usuario administrador
   - Agregar bibliotecas multimedia

3. **Configurar Home Assistant**:
   - Crear usuario administrador
   - Agregar integraciones de dispositivos

4. **Configurar OpenWISP**:
   - Crear organización
   - Preparar templates para portal cautivo
   - Conectar APs OpenWrt

## 🔧 Comandos Útiles

```bash
# Detener todo
./scripts/stop.sh

# Reiniciar todo
./scripts/restart.sh

# Backup
./scripts/backup.sh

# Ver logs de un servicio
docker compose logs -f jellyfin
```

## 📚 Documentación Completa

- **README.md**: Guía completa y detallada
- **NOTAS_IMPLEMENTACION.md**: Notas técnicas y solución de problemas
- **ESTRUCTURA_PROYECTO.md**: Estructura del proyecto

## 🆘 Problemas Comunes

**Contenedores no inician:**
```bash
docker compose logs
```

**Puertos en uso:**
```bash
sudo netstat -tulpn | grep -E ':(80|443|81|8000|8096|8123)'
```

**Permisos en Linux:**
```bash
sudo chown -R $USER:$USER services/ media/
```

---

**Para más detalles, consulta README.md**

