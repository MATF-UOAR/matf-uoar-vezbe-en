# Power

This example reinforces the same idea as `factorial`, but now the function has two arguments: the base and the number of repetitions.

The function `power` returns the value `a^n` using repeated multiplication.

The reference C++ version of the function is:

```cpp
unsigned power(unsigned a, unsigned n) {
    unsigned result = 1;
    for (unsigned i = 0; i < n; i++) {
        result *= a;
    }
    return result;
}
```

## What to watch for in the assembly

The arguments arrive in `w0` and `w1`, but we also use `w0` for the return value. So we keep the base in `w2`, and place the accumulator in `w0`:

```asm
mov w2, w0
mov w0, #1
mov w3, #0
```

The condition `i < n` is written as exiting when `i >= n`:

```asm
cmp w3, w1
b.hs loop_end
```

## Files

- `main.cpp` reads the base and the exponent and prints the result
- `power.s` contains the ARM64 implementation of the `power` function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp power.s -o power
```

## Running

```sh
qemu-aarch64 ./power
```

Example interaction:

```text
3 4
3^4 = 81
```

## What to pay attention to

- `a^0` is `1`, so the accumulator starts from `1`
- `mul w0, w0, w2` multiplies the current result by the base
- the function is a leaf function and therefore does not need a stack frame

## Navigation

- Previous: [Standalone mini-examples](../README.md)
- Next: [Sum of digits](../02-sum_of_digits/README.md)
- Up: [Standalone mini-examples](../README.md)
