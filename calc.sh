#!/usr/bin/env bash
# calc.sh — Simple integer calculator.
# Usage: calc.sh <num1> <op> [<num2>]
# Supported operators: + - x / square cube average round
# BUG: no division-by-zero check
# BUG: no modulo support
set -euo pipefail

NUM1="$1"; OP="$2";

if [ "$OP" = "square" ]; then
  echo $((NUM1 * NUM1))
  exit 0
fi

if [ "$OP" = "cube" ]; then
  echo $((NUM1 * NUM1 * NUM1))
  exit 0
fi

if [ "$OP" = "round" ]; then
  # round operation: round <number> [<precision>]
  # If precision is 0 or omitted, return integer
  NUMBER="$NUM1"
  PRECISION="${3:-0}"
  
  # Use awk for rounding with decimal support
  result=$(awk -v num="$NUMBER" -v prec="$PRECISION" 'BEGIN {
    factor = 10 ^ prec
    rounded = int(num * factor + (num < 0 ? -0.5 : 0.5)) / factor
    if (prec == 0) {
      printf "%d\n", rounded
    } else {
      printf "%.*f\n", prec, rounded
    }
  }')
  echo "$result"
  exit 0
fi

NUM2="$3"

case "$OP" in
  +) echo $((NUM1 + NUM2)) ;;
  -) echo $((NUM1 - NUM2)) ;;
  x) echo $((NUM1 * NUM2)) ;;
  /)
    if [ "$NUM2" -eq 0 ]; then
      echo "division by zero" >&2
      exit 1
    fi
    echo $((NUM1 / NUM2)) ;;
  %)
    if [ "$NUM2" -eq 0 ]; then
      echo "division by zero" >&2
      exit 1
    fi
    echo $((NUM1 % NUM2)) ;;
  average) echo $(((NUM1 + NUM2) / 2)) ;;
  *) echo "Unknown operator: $OP" >&2; exit 1 ;;
esac
