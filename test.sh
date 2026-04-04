#!/usr/bin/env bash
# test.sh — Test runner for calc.sh
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PASS=0; FAIL=0

check() {
  local expected="$1"; shift
  local result
  result=$("$SCRIPT_DIR/calc.sh" "$@")
  if [[ "$result" == "$expected" ]]; then
    PASS=$((PASS + 1))
  else
    echo "FAIL: $* = $result (expected $expected)"
    FAIL=$((FAIL + 1))
  fi
}

check_error() {
  local expected_exit="$1"; shift
  local expected_stderr="$1"; shift
  local result exit_code
  result=$("$SCRIPT_DIR/calc.sh" "$@" 2>&1) && exit_code=0 || exit_code=$?
  if [[ "$exit_code" -eq "$expected_exit" && "$result" == *"$expected_stderr"* ]]; then
    PASS=$((PASS + 1))
  else
    echo "FAIL: $* → exit=$exit_code (expected $expected_exit), output=\$result'"
    FAIL=$((FAIL + 1))
  fi
}

check "calc.sh v1.0.0" --version
check "5" 2 + 3
check "10" 20 - 10
check "42" 6 x 7
check "3" 10 / 3
check "125" 5 cube
check "5" 4 average 6    # (4 + 6) / 2 = 5
check "7" 10 average 5   # (10 + 5) / 2 = 7 (integer division)
check "3" 3.4 round      # Round to integer (default N=0)
check "4" 3.5 round      # Round to integer (half rounds up)
check "3.14" 3.14159 round 2  # Round to 2 decimal places

# Modulo tests
check "1" 10 % 3        # positive operands
check "0" 7 % 7         # zero result
check "0" 0 % 5         # zero dividend
check "-1" -7 % 3       # negative dividend (shell remainder semantics)
check "1" 7 % -3        # negative divisor (shell remainder semantics)

# Error handling
check_error 1 "division by zero" 10 / 0
check_error 1 "division by zero" 5 % 0

echo "Tests: $PASS passed, $FAIL failed"
[[ $FAIL -eq 0 ]]
