# Minecraft Paper Server Setup

Configuración y scripts de un servidor **Paper 26.2** listo para desplegar en Windows o en un VPS Linux.
Este repositorio contiene solo la configuración: el mundo, los `.jar` y los datos de jugadores quedan fuera (ver `.gitignore`).

## Rendimiento

Medido con `spark tps` (prueba local):

![spark tps](docs/spark-tps.png)

| Métrica | Resultado |
|---|---|
| TPS (5s / 1m / 15m) | 19.97 / 20.0 / 19.99 |
| Duración de tick (mediana, último minuto) | 4.1 ms (límite: 50 ms) |
| CPU del proceso | 0–3 % |

## Contenido

| Archivo | Para qué sirve |
|---|---|
| `server.properties` | Ajustes básicos (puerto, jugadores, distancias de vista y simulación) |
| `bukkit.yml`, `spigot.yml`, `commands.yml` | Configuración de Bukkit/Spigot |
| `config/paper-global.yml`, `config/paper-world-defaults.yml` | Configuración de Paper |
| `start.bat` | Arranque en Windows |
| `start.sh` | Arranque en Linux/VPS con los flags de Aikar para el recolector G1 |
| `backup.sh` | Backups comprimidos del mundo con rotación (pensado para `cron`) |
| `plugins/*/config` | Configuración de los plugins |

## Plugins

- **LuckPerms** — gestión de permisos y rangos.
- **CoreProtect** — registro de bloques y rollback contra griefing.
- **spark** — profiler de rendimiento (TPS, MSPT, CPU, memoria).

## Despliegue en un VPS Linux

```bash
# 1. Java 21+ y un usuario sin privilegios para el servidor
sudo apt update && sudo apt install -y openjdk-21-jre-headless
sudo adduser --disabled-password minecraft

# 2. Clonar la configuración
sudo -iu minecraft
git clone https://github.com/<tu-usuario>/minecraft-paper-setup.git server
cd server

# 3. Descargar Paper como server.jar (https://papermc.io/downloads) y aceptar la EULA
echo "eula=true" > eula.txt

# 4. Arrancar (ajusta la RAM con MEM)
MEM=4G ./start.sh
```

Para backups diarios a las 4:00, añade a `crontab -e`:

```
0 4 * * * /home/minecraft/server/backup.sh
```

## Seguridad

- Abre en el firewall solo el puerto de SSH y el `25565/tcp`.
- No ejecutes el servidor como `root`.
- RCON está desactivado; si lo activas, usa una contraseña fuerte y no la subas al repositorio.
