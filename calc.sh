#!/usr/bin/env bash
# calc.sh — Simple integer calculator.
# Usage: calc.sh <num1> <op> [<num2>] [<num3>]
# Supported operators: + - x / square cube abs modpow
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

if [ "$OP" = "abs" ]; then
  if [ "$NUM1" -lt 0 ]; then
    echo $((-NUM1))
  else
    echo $NUM1
  fi
  exit 0
fi

if [ "$OP" = "modpow" ]; then
  BASE="$NUM1"
  EXPONENT="${3:-}"
  MODULUS="${4:-}"
  
  if [ -z "$EXPONENT" ] || [ -z "$MODULUS" ]; then
    echo "modpow requires 3 arguments: base exponent modulus" >&2
    exit 1
  fi
  
  # Compute base^exponent % modulus using iterative method
  result=1
  base=$((BASE % MODULUS))
  exp=$EXPONENT
  
  while [ $exp -gt 0 ]; do
    if [ $((exp % 2)) -eq 1 ]; then
      result=$(( (result * base) % MODULUS ))
    fi
    exp=$((exp / 2))
    base=$(( (base * base) % MODULUS ))
  done
  
  echo $result
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
  *) echo "Unknown operator: $OP" >&2; exit 1 ;;
esac
