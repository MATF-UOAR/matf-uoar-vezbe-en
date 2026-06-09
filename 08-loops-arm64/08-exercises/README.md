# Standalone mini-examples

This unit contains five short ready-made mini-examples for independent work after week eight.

The idea is not to introduce entirely new concepts, but to reinforce:

- `for` and `while` loops in ARM64 form
- working with `unsigned` comparisons via `b.hi`, `b.hs` and `b.lo`
- multiplication with the `mul` instruction
- extracting the remainder via `udiv` and `msub`
- bitwise loops with `tst` and `lsr`
- calling a helper function and saving values on the stack

## Contents

- [Power](./01-power/README.md)
- [Sum of digits](./02-sum_of_digits/README.md)
- [Count of ones](./03-count_ones/README.md)
- [Divisor count](./04-divisor_count/README.md)
- [LCM](./05-lcm/README.md)

## Recommended order

1. Start with [Power](./01-power/README.md), since it is closest to the `factorial` example.
2. Then do [Sum of digits](./02-sum_of_digits/README.md), which repeats the `udiv` + `msub` pattern with the divisor `10`.
3. After that move on to [Count of ones](./03-count_ones/README.md), where the loop walks over the bits of the number.
4. Then do [Divisor count](./04-divisor_count/README.md), since it combines a loop, a remainder, and a condition in the loop body.
5. Leave [LCM](./05-lcm/README.md) for last, since the assembly function calls the helper function `gcd`.

## How to work on them

It makes the most sense to first write each task as a short C++ function, and only then translate it part by part into ARM64:

- first decide which argument arrives in which `w` register
- then choose registers for counters, accumulators, and saved values
- only then translate the loop condition into `cmp` and the appropriate `b.<condition>`
- if the function does a `bl`, save the values needed after the call before the call

## Navigation

- Previous: [Mirroring bits](../07-mirror/README.md)
- Next: [Power](./01-power/README.md)
- Up: [Week 8](../README.md)
