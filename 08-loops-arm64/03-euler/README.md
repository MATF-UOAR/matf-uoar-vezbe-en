# Euler

This is the first example in the ARM64 part where one assembly function calls another assembly function inside a loop.

## What the program does

The program reads an `unsigned n` and prints the value of Euler's totient function, that is, the number of values `i` for which `1 <= i < n` and `gcd(i, n) = 1`.

The reference C++ function is:

```cpp
unsigned euler(unsigned n) {
    unsigned count = 0;
    for (unsigned i = 1; i < n; i++) {
        if (gcd(i, n) == 1) {
            count++;
        }
    }
    return count;
}
```

## What to watch for in the assembly

The loop uses three values:

```asm
mov w1, w0
mov w2, #0
mov w3, #1
```

Here `w1` is the number `n`, `w2` is the counter of coprime numbers, and `w3` is the loop index. The condition `i < n` is written as exiting when `i >= n` holds:

```asm
cmp w3, w1
b.hs loop_end
```

## Function call

Before the first `bl` it is important to know the basic ARM64 convention for integer arguments:

| Group | Registers | Practical rule |
| --- | --- | --- |
| Arguments and return value | `x0`-`x7`, or `w0`-`w7` for 32-bit values | The first arguments go in order into these registers, and the return value comes back in `x0` or `w0`. |
| `caller-saved` | `x0`-`x17` | If we need values from these registers after a `bl`, the calling function must save them. |
| `callee-saved` | `x19`-`x28`, `fp`/`x29`, `sp` | If the called function uses them, it must restore them to their old values before `ret`. |

The register `x18` is platform-dependent, so in these examples we do not use it as a place to store values.

The `bl` instruction writes the return address into `lr`/`x30`. That is why the `euler` function, since it itself calls another function, saves `fp` and `lr` at the start:

```asm
stp fp, lr, [sp, #-16]!
mov fp, sp
```

For the call `gcd(i, n)` the first argument should be in `w0`, and the second in `w1`. In our code `n` is already in `w1`, so before the call we only move `i` into `w0`:

```asm
mov w0, w3
bl gcd
```

Before the call to `gcd`, we save the values from `w1`, `w2` and `w3` on the stack, since the called function is allowed to overwrite them:

```asm
sub sp, sp, #16
str w1, [sp]
str w2, [sp, #4]
str w3, [sp, #8]

mov w0, w3
bl gcd
```

After returning we restore them and continue the loop. The space on the stack is `16` bytes so that `sp` stays aligned to `16` before the `bl`.

## Files

- `main.cpp` reads a number and calls `euler`
- `euler.s` contains the ARM64 implementation of the `euler` function
- `gcd.s` contains the helper ARM64 function `gcd`

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp euler.s gcd.s -o euler
```

## Running

```sh
qemu-aarch64 ./euler
```

Example interaction:

```text
87
euler(87) = 56
```

## What to pay attention to

- a function that does a `bl` must save `lr`, so `euler` has a stack frame
- values needed after the call to `gcd` must be saved before the `bl`
- the condition `b.hs` matches the unsigned comparison `i >= n`

## Navigation

- Previous: [GCD](../02-gcd/README.md)
- Next: [Prime number](../04-is_prime/README.md)
- Up: [Week 8](../README.md)
