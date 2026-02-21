#!/usr/bin/env bash
# calc.sh — Simple integer calculator.
# Usage: calc.sh <num1> <op> <num2>
# Supported operators: + - x /
# BUG: no division-by-zero check
# BUG: no modulo support
set -euo pipefail

NUM1="$1"; OP="$2"; NUM2="$3"
case "$OP" in
  +) echo $((NUM1 + NUM2)) ;;
  -) echo $((NUM1 - NUM2)) ;;
  x) echo $((NUM1 * NUM2)) ;;
  /) if [[ "$NUM2" -eq 0 ]]; then echo "Error: division by zero" >&2; exit 1; fi; echo $((NUM1 / NUM2)) ;;
  *) echo "Unknown operator: $OP" >&2; exit 1 ;;
esac
