#!/bin/bash

# Colores para mensajes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # Sin color

echo -e "${GREEN}Iniciando instalación de Docker y Docker Compose...${NC}"

# Actualizar el sistema
echo -e "${GREEN}Actualizando sistema...${NC}"
sudo apt update && sudo apt upgrade -y

# Instalar dependencias
echo -e "${GREEN}Instalando dependencias...${NC}"
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Añadir la clave GPG oficial de Docker
echo -e "${GREEN}Añadiendo clave GPG oficial de Docker...${NC}"
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Configurar el repositorio estable de Docker
echo -e "${GREEN}Añadiendo el repositorio de Docker...${NC}"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Actualizar índice de paquetes
echo -e "${GREEN}Actualizando índice de paquetes...${NC}"
sudo apt update

# Instalar Docker Engine, CLI y Containerd
echo -e "${GREEN}Instalando Docker Engine, Docker CLI y Containerd...${NC}"
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Habilitar y arrancar Docker
echo -e "${GREEN}Habilitando y arrancando el servicio Docker...${NC}"
sudo systemctl enable docker
sudo systemctl start docker

# Verificar instalación de Docker
echo -e "${GREEN}Verificando instalación de Docker...${NC}"
docker --version
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Docker instalado correctamente.${NC}"
else
    echo -e "${RED}Error al instalar Docker.${NC}"
    exit 1
fi

# Instalar Docker Compose (opcional para versiones específicas)
echo -e "${GREEN}Instalando la última versión de Docker Compose...${NC}"
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verificar instalación de Docker Compose
docker-compose --version
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Docker Compose instalado correctamente.${NC}"
else
    echo -e "${RED}Error al instalar Docker Compose.${NC}"
    exit 1
fi

echo -e "${GREEN}Instalación completada exitosamente.${NC}"

