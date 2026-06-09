# Recursive count of ones

In assembly, implement a recursive function that returns the number of set bits
in the binary representation of an unsigned number.

Reference C++ version:

```cpp
unsigned count_ones_recursive(unsigned n) {
    if (n == 0) {
        return 0;
    }

    return (n & 1) + count_ones_recursive(n >> 1);
}
```

## Files

- `main.cpp` reads a number and prints the count of ones
- `count_ones_recursive.s` contains the ARM64 implementation of the function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp count_ones_recursive.s -o count_ones_recursive
```

## Running

```sh
qemu-aarch64 ./count_ones_recursive
```

Example:

```text
13
3
```

## What to pay attention to

- the lowest bit is obtained with the `and` instruction
- the next recursive call receives the number shifted right by one place
- the saved lowest bit is added to the result only after returning from the
  recursion

## Navigation

- Previous: [Array of largest digits](../08-array_of_largest_digits/README.md)
- Next: [Recursive array maximum](../10-maximum_recursive/README.md)
- Up: [Week 11](../README.md)
