#!/bin/bash
source "../base_test.sh"
SCRIPT="../../02_flow_control/03_case_menu.sh"

test_case "Mostrar fecha" \
  "echo 1 | bash $SCRIPT" \
  "*$(date)*" \  # Se espera cualquier salida porque date muestra los segundos (y el test no es instantaneo)
  0

test_case "Mostrar usuario" \
  "echo 2 | bash $SCRIPT" \
  "*$(whoami)*" \  # Verifica que imprima el usuario actual
  0

test_case "Salir" \
  "echo 3 | bash $SCRIPT" \
  "*Saliendo*" \
  0

test_case "Opción no válida" \
  "echo 999 | bash $SCRIPT" \
  "*Opción no válida*" \
  0

summary || exit 1
