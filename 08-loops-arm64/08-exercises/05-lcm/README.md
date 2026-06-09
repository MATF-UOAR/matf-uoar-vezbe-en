# LCM

This example is a short continuation of the `euler` and `is_prime_via_euler` examples, since one assembly function calls another and then continues computing over the result.

The function `lcm` returns the least common multiple of the numbers `a` and `b`.

The reference C++ version of the function is:

```cpp
unsigned gcd(unsigned a, unsigned b);

unsigned lcm(unsigned a, unsigned b) {
    unsigned d = gcd(a, b);
    if (d == 0) {
        return 0;
    }
    return a / d * b;
}
```

## What to watch for in the assembly

Since `lcm` calls the `gcd` function, it saves `fp` and `lr` at the start:

```asm
stp fp, lr, [sp, #-16]!
mov fp, sp
```

We will also need the arguments `a` and `b` after the call, so we save them on the stack:

```asm
sub sp, sp, #16
str w0, [sp]
str w1, [sp, #4]

bl gcd
```

If `gcd(a, b)` equals `0`, both numbers were `0`, so the function returns `0`. Otherwise we use the formula `a / gcd(a, b) * b`:

```asm
mov w2, w0
ldr w3, [sp]
ldr w4, [sp, #4]

udiv w5, w3, w2
mul w0, w5, w4
```

## Files

- `main.cpp` reads two numbers and prints their LCM
- `lcm.s` contains the ARM64 implementation of the `lcm` function
- `gcd.s` contains the helper ARM64 function `gcd`

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp lcm.s gcd.s -o lcm
```

## Running

```sh
qemu-aarch64 ./lcm
```

Example interaction:

```text
12 18
LCM(12, 18) = 36
```

## What to pay attention to

- `lcm` is not a leaf function, since it does `bl gcd`
- before `bl gcd` the stack stays aligned to `16` bytes
- we pay special attention to the case `a = 0` and `b = 0`, so as not to divide by zero

## Navigation

- Previous: [Divisor count](../04-divisor_count/README.md)
- Up: [Standalone mini-examples](../README.md)
