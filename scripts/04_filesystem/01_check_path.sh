#!/bin/bash

#Pedimos la ruta de un fichero/directorio

read -p "Introduce ruta > " RUTA

#Comprobamos si esta no existe para informar al usuario

if [[ ! -e "$RUTA" ]]; then
echo "La ruta no existe."

#Comprobamos si la ruta es un archivo se lo diremos al usuario

elif [[ -f "$RUTA" ]]; then
echo "Es un archivo regular. "

#Comprobamos si la ruta es un directorio tambien lo informaremos

elif [[ -d "$RUTA" ]]; then
echo "Es un directorio. "
fi
