#!/bin/bash

# Script para iniciar el stack completo del Hotel MVP
# Uso: ./scripts/start.sh

set -e

echo "=========================================="
echo "  Hotel MVP Stack - Iniciando servicios"
echo "  Hotel Posada del Cobre"
echo "=========================================="
echo ""

# Verificar que existe .env
if [ ! -f .env ]; then
    echo "❌ ERROR: No se encontró el archivo .env"
    echo "   Por favor, copia .env.example a .env y configura las variables:"
    echo "   cp .env.example .env"
    exit 1
fi

# Verificar que Docker está corriendo
if ! docker info > /dev/null 2>&1; then
    echo "❌ ERROR: Docker no está corriendo"
    echo "   Por favor, inicia Docker y vuelve a intentar"
    exit 1
fi

echo "✅ Verificaciones completadas"
echo ""
echo "🚀 Iniciando contenedores..."
echo ""

# Iniciar servicios
docker compose up -d

echo ""
echo "⏳ Esperando a que los servicios estén listos..."
sleep 5

echo ""
echo "=========================================="
echo "  ✅ Stack iniciado correctamente"
echo "=========================================="
echo ""
echo "📋 Servicios disponibles:"
echo ""
echo "  🌐 Proxy (NGINX Proxy Manager):"
echo "     Panel: http://localhost:81"
echo "     Usuario: admin@example.com"
echo "     Contraseña: changeme (CAMBIAR INMEDIATAMENTE)"
echo ""
echo "  📡 OpenWISP (Controlador WiFi):"
echo "     http://localhost:8000"
echo ""
echo "  🎬 Jellyfin (Servidor Multimedia):"
echo "     http://localhost:8096"
echo ""
echo "  🏠 Home Assistant (Climatización):"
echo "     http://localhost:8123"
echo ""
echo "=========================================="
echo ""
echo "💡 Próximos pasos:"
echo "   1. Configura el proxy para usar dominios locales (wifi.local, media.local, clima.local)"
echo "   2. Crea usuarios administradores en cada servicio"
echo "   3. Consulta el README.md para más detalles"
echo ""
echo "📊 Ver estado de contenedores:"
echo "   docker compose ps"
echo ""
echo "📝 Ver logs:"
echo "   docker compose logs -f [nombre_servicio]"
echo ""

