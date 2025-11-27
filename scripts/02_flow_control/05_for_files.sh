#!/bin/bash
# Script para recorrer todos los elementos del directorio actual y mostrar info

for FILE in *; do
  echo "------------------------------"
  if [[ -f "$FILE" ]]; then
    echo "Archivo: $FILE"
    # Obtener tamaño en bytes usando stat con soporte para GNU y BSD
    if stat --version &> /dev/null; then
      SIZE=$(stat -c%s "$FILE")
    elif stat -f%z "$FILE" &> /dev/null; then
      SIZE=$(stat -f%z "$FILE")
    else
      # fallback general con wc -c
      SIZE=$(wc -c < "$FILE")
    fi
    echo "Tamaño: $SIZE bytes"
  elif [[ -d "$FILE" ]]; then
    echo "Directorio: $FILE"
  else
    # Para otros tipos: enlaces simbólicos, dispositivos, etc.
    echo "Otro tipo de archivo: $FILE"
  fi
done
echo "------------------------------"
