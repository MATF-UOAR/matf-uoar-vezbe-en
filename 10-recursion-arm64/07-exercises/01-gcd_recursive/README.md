# Recursive GCD

This example translates the well-known Euclidean algorithm into a recursive ARM64
form.

## What the program does

The function `gcd_recursive` returns the greatest common divisor of two unsigned
numbers.

The reference C++ version is:

```cpp
unsigned gcd_recursive(unsigned a, unsigned b) {
    if (b == 0) {
        return a;
    }

    return gcd_recursive(b, a % b);
}
```

## Files

- `main.cpp` reads two numbers and prints their GCD
- `gcd_recursive.s` contains the ARM64 implementation of the function

## What to watch in the assembly

The base case is `b == 0`; at that moment `a` is already in the return value
register `w0`.

For the recursive call we need the remainder `a % b`. As in week 8, ARM64 computes
the quotient with the `udiv` instruction, and the remainder with the `msub`
instruction:

```asm
udiv w2, w0, w1
msub w2, w2, w1, w0
mov w0, w1
mov w1, w2
bl gcd_recursive
```

There is no extra work here after returning from the recursion: the result of the
deeper call is immediately also the result of the current call.

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp gcd_recursive.s -o gcd_recursive
```

## Running

```sh
qemu-aarch64 ./gcd_recursive
```

Example interaction:

```text
48 18
gcd(48, 18) = 6
```

## What to pay attention to

- `udiv` and `msub` work with `unsigned` arguments
- the arguments of the next call are `b` and `a % b`
- the function still saves `lr`, because it recursively runs `bl`

## Navigation

- Previous: [Practice exercises](../README.md)
- Next: [Recursive string reversal](../02-reverse_string_recursive/README.md)
- Up: [Practice exercises](../README.md)
