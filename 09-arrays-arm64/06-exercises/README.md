# Exercises

This unit contains four smaller worked examples for independent practice after week nine. They are intentionally closer to the basic examples from this week than to searches and sortings that require more algorithmic structure.

The idea is to reinforce:

- iterating over an array using the base and the index
- a condition in the body of the loop
- counting elements that satisfy a condition
- remembering an index, not just the value of an element
- combining iteration over an array with the already familiar extraction of digits

## Contents

- [Linear search](./01-linear_search/README.md)
- [Count of occurrences](./02-count_occurrences/README.md)
- [Index of the maximum](./03-index_of_max/README.md)
- [Largest digit sum](./04-max_digit_sum/README.md)

## Recommended order

1. Start with [Linear search](./01-linear_search/README.md), because it is the shortest example with an early exit from the loop.
2. Then do [Count of occurrences](./02-count_occurrences/README.md), where instead of an early exit you go through the whole array and maintain a counter.
3. After that move on to [Index of the maximum](./03-index_of_max/README.md), because in addition to the current largest value, its position is also remembered.
4. Finally do [Largest digit sum](./04-max_digit_sum/README.md), which adds an inner loop over the digits of each element.

## How to work on them

For each example, first write a short C++ function, then translate it into ARM64 piece by piece:

- determine which argument arrives in which register
- choose registers for the index, the current element, and the result
- translate the loop condition into `cmp` and `b.<condition>`
- only at the end add the update of the result

All examples in this unit are leaf functions and so do not need a stack frame.

## Navigation

- Previous: [String length](../05-string_length/README.md)
- Next: [Linear search](./01-linear_search/README.md)
- Up: [Week 9](../README.md)
