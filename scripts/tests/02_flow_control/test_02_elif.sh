#!/bin/bash
TEST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$TEST_DIR/../base_test.sh"

SCRIPT="$TEST_DIR/../../02_flow_control/02_elif.sh"

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
  "*Inválida*" \
  0


summary || exit 1
