#!/usr/bin/env bash
# calc.sh — Simple integer calculator.
# Usage: calc.sh <num1> <op> [<num2>]
# Supported operators: + - x / square
# BUG: no division-by-zero check
# BUG: no modulo support
set -euo pipefail

NUM1="$1"; OP="$2";

if [ "$OP" = "square" ]; then
  echo $((NUM1 * NUM1))
  exit 0
fi

NUM2="$3"

case "$OP" in
  +) echo $((NUM1 + NUM2)) ;;
  -) echo $((NUM1 - NUM2)) ;;
  x) echo $((NUM1 * NUM2)) ;;
  /) echo $((NUM1 / NUM2)) ;;
  *) echo "Unknown operator: $OP" >&2; exit 1 ;;
esac

