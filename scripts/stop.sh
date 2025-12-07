#!/bin/bash

# Script para detener el stack completo del Hotel MVP
# Uso: ./scripts/stop.sh

set -e

echo "=========================================="
echo "  Hotel MVP Stack - Deteniendo servicios"
echo "=========================================="
echo ""

# Detener servicios
docker compose down

echo ""
echo "✅ Servicios detenidos correctamente"
echo ""
echo "💡 Para eliminar también los volúmenes (CUIDADO: borra datos):"
echo "   docker compose down -v"
echo ""

