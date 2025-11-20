#!/bin/bash
source "../base_test.sh"  # Ajustar ruta a base_test.sh según la ubicación real

SCRIPT="../../02_flow_control/01_if_else.sh"  # Ruta relativa al script a testear

test_case "Número mayor que 10" \
  "echo 15 | bash $SCRIPT" \
  "*15 es mayor que 10*" \
  0

test_case "Número menor que 10" \
  "echo 7 | bash $SCRIPT" \
  "*7 no es mayor que 10*" \
  0

summary || exit 1
