#!/bin/bash
source "../base_test.sh"

SCRIPT="../../02_flow_control/04_menu_loop.sh"

test_case "Mostrar fecha" \
  "echo -e '1\n4' | bash $SCRIPT" \
  "*Fecha actual:*" \
  0

test_case "Mostrar usuario" \
  "echo -e '2\n4' | bash $SCRIPT" \
  "*Usuario actual:*" \
  0

test_case "Directorio" \
  "echo -e '3\n4' | bash $SCRIPT" \
  "*Directorio actual:*" \
  0

test_case "Salir" \
  "echo 4 | bash $SCRIPT" \
  "*Saliendo. ¡Hasta luego!*" \
  0

test_case "Opción no válida" \
  "echo -e '999\n4' | bash $SCRIPT" \
  "*Opción no válida*" \
  0

summary || exit 1

