# GCD

This example translates Euclid's algorithm to ARM64 and shows how a `while` loop is combined with unsigned division.

## What the program does

The program reads two `unsigned` numbers and prints their greatest common divisor.

The reference C++ function is:

```cpp
unsigned gcd(unsigned a, unsigned b) {
    while (b != 0) {
        unsigned r = a % b;
        a = b;
        b = r;
    }
    return a;
}
```

## What to watch for in the assembly

We check the loop condition at the start:

```asm
while_loop:
    cmp w1, #0
    b.eq loop_end
```

On ARM64 the `udiv` instruction returns only the quotient. It is the variant for unsigned division and therefore matches the `unsigned` type; for signed division you use `sdiv`. We obtain the remainder by subtracting `quotient * b` from the old `a`:

```asm
udiv w2, w0, w1
msub w3, w2, w1, w0
```

After that the arguments are rotated as in the C++ code:

```asm
mov w0, w1
mov w1, w3
```

## Files

- `main.cpp` reads two numbers and calls `gcd`
- `gcd.s` contains the ARM64 implementation of the `gcd` function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp gcd.s -o gcd
```

## Running

```sh
qemu-aarch64 ./gcd
```

Example interaction:

```text
12 18
GCD(12, 18) = 6
```

## What to pay attention to

- the first argument is in `w0`, the second in `w1`
- `udiv` is unsigned division, so it matches the `unsigned` type
- `msub` here serves as the ARM64 way to obtain the remainder of a division

## Navigation

- Previous: [Factorial](../01-factorial/README.md)
- Next: [Euler](../03-euler/README.md)
- Up: [Week 8](../README.md)
