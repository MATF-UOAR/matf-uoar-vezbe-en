# Week 8: loops in ARM64

This week continues the ARM64 part of the course through examples that are close to the `x86-64` loops we covered earlier. The goal is to read familiar patterns now in ARM64 form:

- `for` and `while` loops using `cmp`, `b.<condition>` and the unconditional `b`
- signed and unsigned comparisons, in particular the conditions `b.hi`, `b.hs` and `b.lo`
- unsigned division with the `udiv` instruction
- computing the remainder with `msub`, since ARM64 has no separate instruction that directly returns the remainder
- preserving values on the stack when a function does a `bl`
- calling the library function `putchar` from assembly

## Contents

- [Factorial](./01-factorial/README.md)
- [GCD](./02-gcd/README.md)
- [Euler](./03-euler/README.md)
- [Prime number](./04-is_prime/README.md)
- [Secret](./05-secret/README.md)
- [Printing bits](./06-print_bits/README.md)
- [Mirroring bits](./07-mirror/README.md)
- [Standalone mini-examples](./08-exercises/README.md)

## Recommended order

1. First look at [Factorial](./01-factorial/README.md), since it is the most direct example of a `for` loop with an accumulator.
2. Then go through [GCD](./02-gcd/README.md), where a `while` loop is combined with `udiv` and `msub`.
3. After that look at [Euler](./03-euler/README.md), since one ARM64 function calls another and must preserve the values it needs after the call.
4. Then do [Prime number](./04-is_prime/README.md), which comes back to `udiv` and `msub` but adds an early return from a function inside a loop. A second variant of that example uses the Euler function we wrote earlier.
5. Then go through [Secret](./05-secret/README.md), which has nested loops and repeated digit extraction.
6. Finally look at [Printing bits](./06-print_bits/README.md) and [Mirroring bits](./07-mirror/README.md), since here the loops operate over individual bits and `putchar` is used.
7. Once you have gone through the basic examples, try the [Standalone mini-examples](./08-exercises/README.md), which reinforce the same patterns on smaller tasks.

## Reminder

The first function arguments are in `w0`, `w1`, `w2`, and the integer return value is in `w0`. When working with `unsigned` values, conditional branches should follow an unsigned comparison:

| Condition | ARM64 branch | Meaning |
| --- | --- | --- |
| `a > b` | `b.hi` | higher |
| `a >= b` | `b.hs` | higher or same |
| `a < b` | `b.lo` | lower |

For dividing `unsigned` values we use `udiv`. For signed values there is a separate instruction `sdiv`, since the sign must be taken into account when computing the quotient. ARM64 does not return the quotient and remainder as a pair the way `x86-64` does, so the remainder is usually computed like this:

```asm
udiv w2, w0, w1
msub w3, w2, w1, w0
```

The instruction `msub w3, w2, w1, w0` computes `w3 = w0 - w2 * w1`, that is, the remainder when `w2` is the quotient.

## Navigation

- Previous: [Week 7](../07-intro-arm64/README.md)
- Next: [Factorial](./01-factorial/README.md)
