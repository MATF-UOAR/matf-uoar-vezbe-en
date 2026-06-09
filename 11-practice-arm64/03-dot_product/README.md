# Dot product

In assembly, implement a function that computes the dot product of two arrays
of the same length.

Reference C++ version:

```cpp
int dot_product(int *a, int *b, int n) {
    int sum = 0;
    for (int i = 0; i < n; i++) {
        sum += a[i] * b[i];
    }
    return sum;
}
```

## Files

- `main.cpp` reads two arrays and prints their dot product
- `dot_product.s` contains the ARM64 implementation of the function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp dot_product.s -o dot_product
```

## Running

```sh
qemu-aarch64 ./dot_product
```

Example:

```text
3
1 2 3
4 5 6
32
```

## What to pay attention to

- two base addresses, `x0` and `x1`, are used in the same loop
- the same index reads `a[i]` and `b[i]`
- the product is computed with the `mul` instruction and then added to the
  accumulator

## Navigation

- Previous: [Square the negative elements](../02-square_negatives/README.md)
- Next: [Swap minimum and maximum](../04-swap_min_and_max/README.md)
- Up: [Week 11](../README.md)
