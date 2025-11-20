#!/bin/bash
source "../base_test.sh"
SCRIPT="../../02_flow_control/04_menu_loop.sh"

test_case "Mostrar fecha" \
  "echo 1 | bash $SCRIPT" \
  "*$(date)*" \
  0

test_case "Mostrar usuario" \
  "echo 2 | bash $SCRIPT" \
  "*$(whoami)*" \
  0

test_case "Directorio" \
  "echo 3 | bash $SCRIPT" \
  "*$(pwd)*" \
  0

test_case "Salir" \
  "echo 4 | bash $SCRIPT" \
  "*Saliendo*" \
  0


test_case "Opción no válida" \
  "echo 999 | bash $SCRIPT" \
  "*Opción no válida*" \
  0

summary || exit 1

