#!/bin/bash
TEST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$TEST_DIR/../base_test.sh"

SCRIPT="$TEST_DIR/../../02_flow_control/01_if_else.sh"

test_case "Número mayor que 10" \
  "echo 15 | bash $SCRIPT" \
  "*15 es mayor que 10*" \
  0

test_case "Número menor que 10" \
  "echo 7 | bash $SCRIPT" \
  "*7 no es mayor que 10*" \
  0

summary || exit 1
