# Week 11: ARM64 practice

This week we practice the ARM64 patterns from the previous units through
slightly larger tasks. The idea is similar to week six: the tasks are not
here to introduce a new instruction, but to tie together loops, working with
memory, function calls, and recursion.

In this unit we will revisit:

- extracting digits using `udiv` and `msub`
- traversing arrays and modifying elements in place
- traversing strings with the `ldrb` instruction
- saving values that must survive a `bl`
- reusing a previously written function via `bl`
- recursive functions with a stack frame

## Contents

- [Largest digit](./01-largest_digit/README.md)
- [Square the negative elements](./02-square_negatives/README.md)
- [Dot product](./03-dot_product/README.md)
- [Swap minimum and maximum](./04-swap_min_and_max/README.md)
- [Word count](./05-word_count/README.md)
- [Replace the largest digit](./06-replace_largest_digit/README.md)
- [Array range](./07-array_range/README.md)
- [Array of largest digits](./08-array_of_largest_digits/README.md)
- [Recursive count of ones](./09-count_ones_recursive/README.md)
- [Recursive array maximum](./10-maximum_recursive/README.md)

## Recommended order

1. Start with [Largest digit](./01-largest_digit/README.md), since it revisits
   the shortest pattern with division and remainder.
2. Then do the array tasks:
   [Square the negatives](./02-square_negatives/README.md),
   [Dot product](./03-dot_product/README.md), and
   [Swap minimum and maximum](./04-swap_min_and_max/README.md).
3. After that, move on to [Word count](./05-word_count/README.md), where the
   same memory traversal is done over the bytes of a string.
4. Next do the tasks with calls:
   [Replace the largest digit](./06-replace_largest_digit/README.md),
   [Array range](./07-array_range/README.md), and
   [Array of largest digits](./08-array_of_largest_digits/README.md).
5. Leave the recursive examples for the end:
   [Recursive count of ones](./09-count_ones_recursive/README.md) and
   [Recursive array maximum](./10-maximum_recursive/README.md).

## Navigation

- Previous: [Week 10](../10-recursion-arm64/README.md)
- Next: [Largest digit](./01-largest_digit/README.md)
