#!/bin/bash
source "../base_test.sh"

SCRIPT="../../02_flow_control/02_elif.sh"

test_case "Suspenso" \
  "echo 4 | bash $SCRIPT" \
  "*Suspenso*" \
  0

test_case "Aprobado" \
  "echo 5 | bash $SCRIPT" \
  "*Aprobado*" \
  0

test_case "Bien" \
  "echo 6 | bash $SCRIPT" \
  "*Bien*" \
  0

test_case "Notable" \
  "echo 7 | bash $SCRIPT" \
  "*Notable*" \
  0

test_case "Sobresaliente" \
  "echo 9 | bash $SCRIPT" \
  "*Sobresaliente*" \
  0

test_case "Error" \
  "echo 15 | bash $SCRIPT" \
  "*Introduzca un número del 0 al 10.*" \
  1



summary || exit 1
