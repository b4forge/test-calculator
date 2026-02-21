# test-calculator

A shell-based integer calculator.

## Usage

```bash
./calc.sh 2 + 3    # => 5
./calc.sh 6 x 7    # => 42
./calc.sh 10 / 3   # => 3 (integer division)
```

Note: Use `x` for multiplication (not `*`) to avoid shell glob expansion.

## Testing

```bash
./test.sh
```

## Files

- `calc.sh` — Main script, evaluates `<num1> <op> <num2>`
- `test.sh` — Test runner (exit 0 = pass, exit 1 = fail)
