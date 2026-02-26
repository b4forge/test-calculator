# Design: Subtract Function

**Issue:** ca-mol-rdox
**Blocks:** ca-mol-d266 (Implement subtract function)

## Interface

```
calc.sh <num1> - <num2>
```

Outputs the integer result of `num1 - num2` to stdout, exits 0.

## Implementation

Use bash integer arithmetic:

```bash
-) echo $((NUM1 - NUM2)) ;;
```

This is already in place at `calc.sh:12`. No changes required to the subtract case itself.

## Edge Cases

| Input | Expected output | Handled by bash arithmetic? |
|-------|----------------|------------------------------|
| `5 - 3` | `2` | Yes |
| `3 - 5` | `-2` (negative result) | Yes |
| `5 - 5` | `0` | Yes |
| `-3 - 2` | `-5` (negative operand) | Yes |
| `0 - 0` | `0` | Yes |

No special guards needed. Bash `$((...))` operates on signed integers natively.

## What Could Go Wrong

- **Non-integer inputs**: `calc.sh 1.5 - 0.5` → bash will error. Out of scope; the script declares integer-only operation in its header comment.
- **Overflow**: Bash uses 64-bit signed integers. Max value: 9223372036854775807. Practical inputs won't overflow.
- **No `-` operator confusion**: The operator token is the literal string `-` passed as `$2`, not a shell option. Safe.

## Decision

The current implementation is correct and complete. The implementer should verify:
1. `check "10" 20 - 10` passes in `test.sh`
2. `check "-7" 3 - 10` passes (negative result)
3. `check "0" 5 - 5` passes (zero result)

Test cases 2 and 3 are not yet in `test.sh` — the implementer should add them.
