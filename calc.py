#!/usr/bin/env python3
"""calc.py — Simple integer calculator.

Usage: calc.py <num1> <op> <num2>
Supported operators: + - x /

Mirrors the behaviour of calc.sh:
  - All operands and results are integers (floor division for /)
  - Use 'x' for multiplication (avoids shell glob expansion)
  - Prints result to stdout; errors go to stderr with exit code 1
"""

import sys


def main():
    if len(sys.argv) != 4:
        print(f"Usage: {sys.argv[0]} <num1> <op> <num2>", file=sys.stderr)
        sys.exit(1)

    try:
        num1 = int(sys.argv[1])
        num2 = int(sys.argv[3])
    except ValueError as e:
        print(f"error: operands must be integers: {e}", file=sys.stderr)
        sys.exit(1)

    op = sys.argv[2]

    if op == "+":
        print(num1 + num2)
    elif op == "-":
        print(num1 - num2)
    elif op == "x":
        print(num1 * num2)
    elif op == "/":
        if num2 == 0:
            print("error: division by zero", file=sys.stderr)
            sys.exit(1)
        print(int(num1 / num2))  # integer (truncating) division, matches bash $((...))
    else:
        print(f"Unknown operator: {op}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
