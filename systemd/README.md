# Configuración de Arranque Automático

Este directorio contiene un ejemplo de servicio systemd para que el stack se inicie automáticamente después de un reinicio o corte de luz.

## Instrucciones de Instalación

1. **Copiar el archivo de ejemplo al directorio de systemd:**

```bash
sudo cp systemd/hotel-mvp.service.example /etc/systemd/system/hotel-mvp.service
```

2. **Editar el archivo con la ruta correcta de tu proyecto:**

```bash
sudo nano /etc/systemd/system/hotel-mvp.service
```

Asegúrate de cambiar:
- `WorkingDirectory`: Ruta completa a tu proyecto (ej: `/home/usuario/hotel-mvp-stack`)
- `User`: Usuario que ejecutará Docker (opcional, pero recomendado)
- Verificar que el comando `docker compose` o `docker-compose` sea el correcto para tu sistema

3. **Recargar systemd y habilitar el servicio:**

```bash
# Recargar configuración de systemd
sudo systemctl daemon-reload

# Habilitar el servicio (inicia automáticamente al arrancar)
sudo systemctl enable hotel-mvp.service

# Iniciar el servicio ahora
sudo systemctl start hotel-mvp.service

# Verificar estado
sudo systemctl status hotel-mvp.service
```

## Comandos Útiles

```bash
# Ver logs del servicio
sudo journalctl -u hotel-mvp.service -f

# Reiniciar el servicio
sudo systemctl restart hotel-mvp.service

# Detener el servicio
sudo systemctl stop hotel-mvp.service

# Deshabilitar el servicio (no inicia automáticamente)
sudo systemctl disable hotel-mvp.service
```

## Notas

- El servicio espera a que Docker y la red estén disponibles antes de iniciar
- Si cambias la ubicación del proyecto, actualiza el `WorkingDirectory` y recarga: `sudo systemctl daemon-reload`
- Los logs de Docker Compose se pueden ver con: `docker compose logs -f`

