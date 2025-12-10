# Script para levantar el stack Hotel MVP
# Ejecutar: .\levantar-stack.ps1

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  LEVANTANDO STACK HOTEL MVP" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Cambiar al directorio del proyecto
Set-Location "c:\Users\CTRE DESIGN STUDIOS\Documents\GitHub\hotelmvp"

# Verificar Docker
Write-Host "[1] Verificando Docker..." -ForegroundColor Yellow
docker --version
docker compose version
Write-Host ""

# Verificar .env
Write-Host "[2] Verificando archivo .env..." -ForegroundColor Yellow
if (Test-Path .env) {
    Write-Host "   ✓ .env existe" -ForegroundColor Green
    $lineCount = (Get-Content .env | Measure-Object -Line).Lines
    Write-Host "   Líneas: $lineCount" -ForegroundColor White
} else {
    Write-Host "   ✗ .env NO existe" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Detener servicios existentes
Write-Host "[3] Deteniendo servicios existentes..." -ForegroundColor Yellow
docker compose down
Write-Host "   ✓ Servicios detenidos" -ForegroundColor Green
Write-Host ""

# Levantar el stack
Write-Host "[4] Levantando todos los servicios..." -ForegroundColor Yellow
docker compose up -d
Write-Host ""

# Esperar a que los servicios inicien
Write-Host "[5] Esperando 15 segundos para que los servicios inicien..." -ForegroundColor Yellow
Start-Sleep -Seconds 15
Write-Host ""

# Verificar estado
Write-Host "[6] Estado de contenedores:" -ForegroundColor Yellow
docker compose ps
Write-Host ""

# Ver contenedores con puertos
Write-Host "[7] Contenedores con puertos:" -ForegroundColor Yellow
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
Write-Host ""

# Resumen final
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  STACK LEVANTADO" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Accesos locales:" -ForegroundColor Yellow
Write-Host "  🌐 Proxy Admin:     http://localhost:81" -ForegroundColor White
Write-Host "  📡 OpenWISP:        http://localhost:8001" -ForegroundColor White
Write-Host "  🎬 Jellyfin:        http://localhost:8096" -ForegroundColor White
Write-Host "  🏠 Home Assistant:  http://localhost:8123" -ForegroundColor White
Write-Host "  🔧 OpenWrt LuCI:    http://localhost:8880" -ForegroundColor White
Write-Host "  📊 InfluxDB:        http://localhost:8086" -ForegroundColor White
Write-Host ""
Write-Host "Comandos útiles:" -ForegroundColor Yellow
Write-Host "  Ver estado:        docker compose ps" -ForegroundColor White
Write-Host "  Ver logs:          docker compose logs -f [servicio]" -ForegroundColor White
Write-Host "  Detener:           docker compose down" -ForegroundColor White
Write-Host ""




