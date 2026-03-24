#!/usr/bin/env bash
# calc.sh — Simple integer calculator.
# Usage: calc.sh <num1> <op> <num2>
#        calc.sh fact <num>
# Supported operators: + - x / pow fact
# BUG: no division-by-zero check
# BUG: no modulo support
set -euo pipefail

if [[ "$1" == "fact" ]]; then
  N="$2"
  if (( N < 0 )); then
    echo "Error: factorial of negative number" >&2
    exit 1
  fi
  result=1
  for (( i=2; i<=N; i++ )); do
    result=$(( result * i ))
  done
  echo "$result"
else
  NUM1="$1"; OP="$2"; NUM2="$3"
  case "$OP" in
    +) echo $((NUM1 + NUM2)) ;;
    -) echo $((NUM1 - NUM2)) ;;
    x) echo $((NUM1 * NUM2)) ;;
    /) echo $((NUM1 / NUM2)) ;;
    pow) echo $((NUM1 ** NUM2)) ;;
    *) echo "Unknown operator: $OP" >&2; exit 1 ;;
  esac
fi
