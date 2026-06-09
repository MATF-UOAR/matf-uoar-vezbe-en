# Standalone mini-examples

This unit contains four short, ready-made mini-examples for independent work after the fourth week.

The idea is not to introduce entirely new concepts, but to reinforce:

- iterating over an array and reading elements using a base address and an index
- conditionally updating a result while traversing memory
- working with two different base addresses in the same loop
- modifying an array "in place", without making a copy
- remembering indices or values that we reuse later

## Contents

- [Count of positives](./01-count_positives/README.md)
- [Minimum](./02-minimum/README.md)
- [Dot product](./03-dot_product/README.md)
- [Swapping the minimum and maximum](./04-swap_min_and_max/README.md)

## Recommended order

1. Start with [Count of positives](./01-count_positives/README.md), since it is the shortest task with a single condition in the loop body.
2. Then move on to [Minimum](./02-minimum/README.md), since it is the direct counterpart of the already covered maximum.
3. After that do [Dot product](./03-dot_product/README.md), to practice working with two base addresses in the same loop.
4. Finally leave [Swapping the minimum and maximum](./04-swap_min_and_max/README.md) for last, since it combines finding positions and later modifying the array.

## How to work on them

It makes the most sense to first try each of these tasks on your own: write the C++ version, trace which registers and addresses you need, and only then look at the ready-made assembly variant.

A short practical template is:

- first write the C++ loop and clearly mark what is your index and what is your result
- then decide which register carries the base address, and which the index or the current address
- only after that translate the conditions and updates into jumps and `mov`/`cmp` instructions

## Navigation

- Previous: [Reversing an array](../05-reverse-array/README.md)
- Next: [Count of positives](./01-count_positives/README.md)
- Up: [Week 4](../README.md)
