# Secret

This example has a deliberately uninformative function name, but the function itself performs a familiar process: it sums the digits of a number until the result becomes a single digit.

## What the program does

The program reads an `unsigned n` and prints the result of the `secret` function.

The reference C++ function is:

```cpp
unsigned secret(unsigned n) {
    while (n >= 10) {
        unsigned sum = 0;
        while (n != 0) {
            sum += n % 10;
            n /= 10;
        }
        n = sum;
    }
    return n;
}
```

For example, for `9875` the first digit sum is `29`, then `2 + 9 = 11`, then `1 + 1 = 2`.

## What to watch for in the assembly

The example has two loops. The outer loop checks whether the number is already a single digit:

```asm
outer_loop:
    cmp w0, #10
    b.lo end
```

The inner loop extracts the digits one by one. As in the `gcd` example, the remainder is obtained with a combination of `udiv` and `msub`:

```asm
udiv w2, w0, w10
msub w3, w2, w10, w0

mov w0, w2
add w1, w1, w3
```

The register `w10` holds the constant `10`, `w1` is the current digit sum, `w2` is the quotient, and `w3` is the last digit.

## Files

- `main.cpp` reads a number and calls `secret`
- `secret.s` contains the ARM64 implementation of the function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp secret.s -o secret
```

## Running

```sh
qemu-aarch64 ./secret
```

Example interaction:

```text
9875
secret(9875) = 2
```

## What to pay attention to

- the outer loop runs while `n >= 10`
- the inner loop is the same pattern as the digit sum, just in ARM64 form
- the function does not call other functions, so it does not need a stack frame

## Navigation

- Previous: [Prime number](../04-is_prime/README.md)
- Next: [Printing bits](../06-print_bits/README.md)
- Up: [Week 8](../README.md)
