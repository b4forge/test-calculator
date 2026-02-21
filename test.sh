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
    echo "FAIL: $* → exit=$exit_code (expected $expected_exit), output='$result'"
    FAIL=$((FAIL + 1))
  fi
}

check "5" 2 + 3
check "10" 20 - 10
check "42" 6 x 7
check "3" 10 / 3

# Error handling
check_error 1 "division by zero" 10 / 0

echo "Tests: $PASS passed, $FAIL failed"
[[ $FAIL -eq 0 ]]
