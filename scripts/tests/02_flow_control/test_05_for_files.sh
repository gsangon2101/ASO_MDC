#!/bin/bash
source "../base_test.sh"

SCRIPT="$(cd ../../02_flow_control && pwd)/05_for_files.sh"

# Crear entorno temporal y datos
TMPDIR=$(mktemp -d)
echo "contenido" > "$TMPDIR/archivo_regular.txt"
mkdir "$TMPDIR/dir_prueba"
ln -s "archivo_regular.txt" "$TMPDIR/enlace_simbolico"

# Ejecutar el script en el TMPDIR y capturar salida
out="$(cd "$TMPDIR" && bash "$SCRIPT")"

test_case "Detecta archivo regular" \
  "echo \"$out\"" \
  "*Archivo: archivo_regular.txt*" \
  0

test_case "Detecta directorio" \
  "echo \"$out\"" \
  "*Directorio: dir_prueba*" \
  0

summary || { rm -rf "$TMPDIR"; exit 1; }
rm -rf "$TMPDIR"
