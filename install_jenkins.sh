#!/bin/bash

# Actualizar paquetes
sudo apt update && sudo apt upgrade -y

# Instalar dependencias
sudo apt install fontconfig openjdk-17-jre -y

# Verificar versión de Java
java -version

# Agregar clave y repositorio de Jenkins
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Actualizar lista de paquetes
sudo apt update

# Instalar Jenkins
sudo apt install jenkins -y

# Habilitar y arrancar Jenkins
sudo systemctl enable --now jenkins

# Mostrar estado de Jenkins
sudo systemctl status jenkins
