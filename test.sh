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
    ((PASS++))
  else
    echo "FAIL: $* = $result (expected $expected)"
    ((FAIL++))
  fi
}

check "5" 2 + 3
check "10" 20 - 10
check "42" 6 x 7
check "3" 10 / 3

echo "Tests: $PASS passed, $FAIL failed"
[[ $FAIL -eq 0 ]]
