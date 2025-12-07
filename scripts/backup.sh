#!/bin/bash

# Script para hacer backup de las configuraciones del Hotel MVP
# Uso: ./scripts/backup.sh

set -e

# Configuración
BACKUP_DIR="./backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="hotel-mvp-backup-${TIMESTAMP}.tar.gz"

echo "=========================================="
echo "  Hotel MVP Stack - Backup de configuraciones"
echo "=========================================="
echo ""

# Crear directorio de backups si no existe
mkdir -p "${BACKUP_DIR}"

echo "📦 Creando backup..."
echo ""

# Crear backup de configuraciones (sin media)
tar -czf "${BACKUP_DIR}/${BACKUP_NAME}" \
    --exclude='media' \
    --exclude='*.log' \
    --exclude='node_modules' \
    --exclude='.git' \
    services/ \
    docker-compose.yml \
    .env 2>/dev/null || {
    echo "⚠️  Advertencia: No se pudo incluir .env (puede no existir)"
    tar -czf "${BACKUP_DIR}/${BACKUP_NAME}" \
        --exclude='media' \
        --exclude='*.log' \
        --exclude='node_modules' \
        --exclude='.git' \
        services/ \
        docker-compose.yml
}

echo "✅ Backup creado: ${BACKUP_DIR}/${BACKUP_NAME}"
echo ""
echo "💡 Para restaurar un backup:"
echo "   tar -xzf ${BACKUP_DIR}/${BACKUP_NAME}"
echo ""
echo "📊 Tamaño del backup:"
du -h "${BACKUP_DIR}/${BACKUP_NAME}"
echo ""

