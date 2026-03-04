#!/usr/bin/env python3
"""test_calc.py — Test runner for calc.py (mirrors test.sh)"""

import subprocess
import sys
from pathlib import Path

SCRIPT = Path(__file__).parent / "calc.py"
PASS = 0
FAIL = 0


def check(expected, *args):
    global PASS, FAIL
    result = subprocess.run(
        [sys.executable, str(SCRIPT)] + list(args),
        capture_output=True, text=True
    )
    output = result.stdout.strip()
    if output == str(expected):
        PASS += 1
    else:
        print(f"FAIL: {' '.join(args)} = {output!r} (expected {expected!r})")
        FAIL += 1


def check_error(expected_exit, expected_stderr, *args):
    global PASS, FAIL
    result = subprocess.run(
        [sys.executable, str(SCRIPT)] + list(args),
        capture_output=True, text=True
    )
    combined = result.stdout + result.stderr
    if result.returncode == expected_exit and expected_stderr in combined:
        PASS += 1
    else:
        print(
            f"FAIL: {' '.join(args)} → exit={result.returncode} "
            f"(expected {expected_exit}), output={combined!r}"
        )
        FAIL += 1


# ── Basic arithmetic (mirrors test.sh) ───────────────────────────────────────
check("5",  "2", "+", "3")
check("10", "20", "-", "10")
check("42", "6", "x", "7")
check("3",  "10", "/", "3")

# ── Error handling ────────────────────────────────────────────────────────────
check_error(1, "division by zero", "10", "/", "0")
check_error(1, "Unknown operator",  "5", "?", "3")

print(f"Tests: {PASS} passed, {FAIL} failed")
sys.exit(0 if FAIL == 0 else 1)
