#!/bin/bash
# Script para crear una copia de seguridad de un archivo con fecha en el nombre

# Solicitar al usuario el nombre o ruta del archivo
read -p "Introduce un archivo para hacerle una copia de seguridad > " archivo

# Comprobar si el archivo existe y es un archivo regular
if [[ ! -f "$archivo" ]]; then
	echo "Error: El archivo no existe o no es un archivo regular."
fi

# Obtener la fecha actual en formato YYYYMMDD
fecha=$(date +%Y%m%d)

# Construir nombre de copia con sufijo -YYYYMMDD.bak
copia="${archivo}-${fecha}.bak"

# Verificar si la copia ya existe para evitar sobrescribir
if [[ -e "$copia" ]]; then
	echo "Error: $copia ya existe. No se sobrescribirá."
else
# Crear la copia de seguridad
	cp "$archivo" "$copia"
# Comprobar si la copia se creó correctamente
	if [[ $? -eq 0 ]]; then
	echo "Copia de seguridad creada con éxito: $copia"
	else
	echo "Error al crear la copia de seguridad."
	exit 1
fi

fi
