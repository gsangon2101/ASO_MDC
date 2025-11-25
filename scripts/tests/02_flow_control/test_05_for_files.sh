#!/bin/bash
source "../base_test.sh"

SCRIPT="../../02_flow_control/05_for_files.sh"

# Crear un entorno temporal para test
TMPDIR=$(mktemp -d)
cd "$TMPDIR" || exit 1

# Crear archivos para test
echo "contenido" > archivo_regular.txt
mkdir dir_prueba
ln -s archivo_regular.txt enlace_simbolico

# Ejecutar el script y capturar salida
out=$(bash "$SCRIPT")

# Pruebas sobre la salida
test_case "Detecta archivo regular" \
  "echo \"$out\"" \
  "*Archivo: archivo_regular.txt*" \
  0

test_case "Detecta directorio" \
  "echo \"$out\"" \
  "*Directorio: dir_prueba*" \
  0

test_case "Detecta otro tipo de archivo" \
  "echo \"$out\"" \
  "*Otro tipo de archivo: enlace_simbolico*" \
  0

summary || exit 1

# Limpiar
rm -rf "$TMPDIR"
