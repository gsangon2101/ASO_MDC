#!/bin/bash

# Directorio donde está este test
TEST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Cargar la librería de tests
source "$TEST_DIR/../base_test.sh"

# Ruta absoluta al script que vamos a testear
SCRIPT="$TEST_DIR/../../02_flow_control/05_for_files.sh"

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
