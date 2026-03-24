#!/usr/bin/env bash
set -euo pipefail

assert_eq() {
  local expected="$1"
  local actual="$2"
  local msg="${3:-}"
  if [ "$expected" != "$actual" ]; then
    echo "Assertion failed: expected '$expected', got '$actual'. ${msg}" >&2
    exit 1
  fi
  echo "✓ Test passed: $expected == $actual"
}

# Existing tests
assert_eq 8 "$(bash ./calc.sh 5 + 3)"
assert_eq 2 "$(bash ./calc.sh 5 - 3)"
assert_eq 15 "$(bash ./calc.sh 5 x 3)"
assert_eq 1 "$(bash ./calc.sh 5 / 3)"

# New test for square
assert_eq 25 "$(bash ./calc.sh 5 square)"

echo "All tests passed."

