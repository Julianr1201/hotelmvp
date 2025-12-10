# Hotel MVP - Hotel Posada del Cobre

Infraestructura contenerizada para el Hotel Posada del Cobre (20 habitaciones). Este proyecto gestiona la red WiFi, servicios para huéspedes y monitoreo del sistema.

## 🏗️ Arquitectura del Sistema

El proyecto está dividido en dos stacks independientes para facilitar el mantenimiento y la escalabilidad:

### 1. Stack OpenWISP (`docker-openwisp/`)
Este stack gestiona la infraestructura de red y el portal cautivo.
*   **Basado en**: El repositorio oficial de `openwisp/docker-openwisp`.
*   **Servicios Principales**:
    *   **Network Controller**: Gestión centralizada de puntos de acceso y dispositivos de red.
    *   **Captive Portal**: Portal de acceso para invitados con autenticación.
    *   **RADIUS**: Servidor para autenticación, autorización y contabilidad (AAA).
    *   **OpenVPN**: Para gestión segura remota de dispositivos.
*   **Acceso**: `https://dashboard.hotelposadadelcobre.com` (o `https://localhost` en desarrollo).

### 2. Stack Hotel (`hotel-stack/`)
Este stack aloja servicios locales para la operación del hotel y entretenimiento.
*   **Servicios**:
    *   **Pi-hole**: Bloqueo de anuncios a nivel de red y servidor DHCP (`http://localhost:8053/admin`).
    *   **Home Assistant**: Automatización del hotel, control de clima y dispositivos IoT (`http://localhost:8123`).
    *   **Jellyfin**: Servidor de medios para entretenimiento en las habitaciones (`http://localhost:8096`).
    *   **Grafana**: Dashboards visuales para monitoreo de infraestructura y red (`http://localhost:3000`).
    *   **Prometheus**: Recolección de métricas de todos los servicios (`http://localhost:9090`).
    *   **Mosquitto**: Broker MQTT para comunicación entre dispositivos IoT (Puerto 1883).

## 🚀 Inicio Rápido (Quick Start)

### Prerrequisitos
*   Docker y Docker Compose instalados.
*   Puertos 80, 443, 1812, 1813 libres (verificar no conflictos con otros servicios).

### 1. Iniciar OpenWISP
```bash
cd docker-openwisp
docker compose up -d
```
Esperar unos minutos a que todos los contenedores de OpenWISP estén saludables (`healthy`).

### 2. Iniciar Stack Hotel
```bash
cd hotel-stack
docker compose --env-file .env.custom up -d
```

## 📚 Documentación Adicional

Para detalles específicos, consulte las guías especializadas:

*   **[Guía de Producción (PRODUCTION_GUIDE.md)](PRODUCTION_GUIDE.md)**: Instrucciones detalladas de despliegue, copias de seguridad, mantenimiento y estructura de directorios.
*   **[Credenciales y Accesos (ACCESS_CREDENTIALS.md)](ACCESS_CREDENTIALS.md)**: Información sobre cuentas por defecto y accesos (¡Asegúrese de cambiar las contraseñas por defecto!).
*   **[Integración de API (API_INTEGRATION.md)](API_INTEGRATION.md)**: Detalles sobre cómo interactúan los diferentes servicios vía API.
*   **[Configuración de Dominio (CONFIGURACION_DOMINIO.md)](CONFIGURACION_DOMINIO.md)**: Guía para configurar dominios y certificados SSL.

## 🛠️ Mantenimiento y Comandos Útiles

### Ver logs
```bash
# OpenWISP
cd docker-openwisp
docker compose logs -f

# Hotel Stack
cd hotel-stack
docker compose logs -f [servicio]
```

### Reiniciar un servicio específico
```bash
docker compose restart [nombre-del-servicio]
```

## 🔐 Seguridad
*   Todas las credenciales por defecto deben ser cambiadas inmediatamente después del primer despliegue.
*   El archivo `.env` contiene secretos y no debe ser compartido públicamente.
*   Asegúrese de configurar correctamente el firewall para restringir el acceso a puertos de gestión.
