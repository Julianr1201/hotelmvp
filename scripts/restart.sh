#!/bin/bash

# Script para reiniciar el stack completo del Hotel MVP
# Uso: ./scripts/restart.sh

set -e

echo "=========================================="
echo "  Hotel MVP Stack - Reiniciando servicios"
echo "=========================================="
echo ""

# Reiniciar servicios
docker compose restart

echo ""
echo "✅ Servicios reiniciados correctamente"
echo ""
echo "📊 Ver estado:"
echo "   docker compose ps"
echo ""

