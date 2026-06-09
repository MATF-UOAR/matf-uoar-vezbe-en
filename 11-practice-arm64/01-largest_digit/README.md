# Largest digit

In assembly, implement a function that returns the largest digit in the
representation of an unsigned number.

Reference C++ version:

```cpp
unsigned largest_digit(unsigned n) {
    unsigned max = 0;
    while (n != 0) {
        unsigned digit = n % 10;
        if (digit > max) {
            max = digit;
        }
        n /= 10;
    }
    return max;
}
```

## Files

- `main.cpp` reads a number and prints the largest digit
- `largest_digit.s` contains the ARM64 implementation of the function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp largest_digit.s -o largest_digit
```

## Running

```sh
qemu-aarch64 ./largest_digit
```

Example:

```text
45316
6
```

## What to pay attention to

- the last digit is obtained using `udiv` and `msub`
- since the digits are unsigned values, the `hi` condition is used to update
  the maximum
- for `n = 0` the function returns `0`

## Navigation

- Previous: [Week 11](../README.md)
- Next: [Square the negative elements](../02-square_negatives/README.md)
- Up: [Week 11](../README.md)
