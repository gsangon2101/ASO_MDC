#!/bin/bash
TEST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$TEST_DIR/../base_test.sh"

SCRIPT="$TEST_DIR/../../02_flow_control/06_while_counter.sh"

test_case "Contador normal 3" \
  "echo 3 | bash $SCRIPT" \
  $'1\n2\n3\nContador finalizado. Se han mostrado 3 números' \
  0

test_case "Contador 1" \
  "echo 1 | bash $SCRIPT" \
  $'1\nContador finalizado. Se han mostrado 1 números' \
  0

test_case "Entrada 0 error" \
  "echo 0 | bash $SCRIPT" \
  "*Que sea mayor que 0 la próxima vez*" \
  1

test_case "Entrada negativa error" \
  "echo -5 | bash $SCRIPT" \
  "*Que sea mayor que 0 la próxima vez*" \
  1

summary || exit 1
