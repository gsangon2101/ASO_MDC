#!/bin/bash
# Script para generar un informe de los archivos en un directorio, mostrando nombre, size y permisos (tabulado)

# Pedir al usuario una ruta de directorio válida
read -p "Introduce la ruta de un directorio válido > " dir

# Comprobar que la ruta existe y es un directorio
if [[ ! -d "$dir" ]]; then
  echo "Error: La ruta no es un directorio válido."
  exit 1
fi

# Archivo donde se guardará el informe
informe="informe.txt"

# Cabecera del informe (tabulada)
printf "%-25s\t%-12s\t%-12s\n" "Nombre" "Size (bytes)" "Permisos" > "$informe"
echo "-------------------------------------------------------------" >> "$informe"

# Contador de archivos procesados
count=0

# Recorrer los archivos del directorio con un bucle for
for archivo in "$dir"/*; do
  # Comprobar que es un archivo regular
  if [[ -f "$archivo" ]]; then
    # Usar stat para obtener nombre, size y permisos
    nombre=$(basename "$archivo")
    size=$(stat -c "%s" "$archivo")
    permisos=$(stat -c "%A" "$archivo")

    # Añadir línea al informe tabulando con printf
    printf "%-25s\t%-12s\t%-12s\n" "$nombre" "$size" "$permisos" >> "$informe"

    # Incrementar contador
    ((count++))
  fi
done

# Mostrar resumen final
echo "Proceso finalizado. Archivos procesados: $count"
echo "Informe guardado en $informe"

