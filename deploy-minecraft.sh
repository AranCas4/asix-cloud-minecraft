#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

# Pt1.3 - Fase 2: actualitzacio del sistema i instal.lacio de Docker
apt update -y
apt upgrade -y
apt install -y docker.io
systemctl enable --now docker

# Pt1.3 - Fase 3: volum persistent (ruta absoluta, sense ~)
mkdir -p /home/ubuntu/minecraft-data

# Pt1.3 - Fase 3: contenidor del servidor
docker run -d --name minecraft-server --restart unless-stopped \
  -p 25565:25565 \
  -v /home/ubuntu/minecraft-data:/data \
  -e EULA=TRUE \
  -e ENABLE_AUTOPAUSE=FALSE \
  -e ONLINE_MODE=FALSE \
  -e MOTD="Server Aran Casals" \
  itzg/minecraft-server
