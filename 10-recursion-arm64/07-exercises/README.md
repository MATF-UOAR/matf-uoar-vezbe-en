# Practice exercises

These tasks supplement the main examples from week 10. Each one uses ARM64
patterns we have already seen, but applies them in a new algorithm or with
different state that must survive a call.

## Contents

- [Recursive GCD](./01-gcd_recursive/README.md)
- [Recursive string reversal](./02-reverse_string_recursive/README.md)
- [Recursive binary search](./03-binary_search_recursive/README.md)
- [Count via a predicate function](./04-count_predicate/README.md)

## Recommended order

1. Start with [Recursive GCD](./01-gcd_recursive/README.md), since it is a short recursive variant of the already familiar Euclidean algorithm.
2. Continue with [Recursive string reversal](./02-reverse_string_recursive/README.md), which builds on the palindrome but writes new bytes into memory.
3. Then do [Recursive binary search](./03-binary_search_recursive/README.md), where the recursive call gets only one half of the sorted array.
4. Finally look at [Count via a predicate function](./04-count_predicate/README.md), which extends `find_first` by continuing the loop after every match.

## What is practiced

| example | main idea |
| --- | --- |
| `gcd_recursive` | recursive call with changed arguments and no work after returning |
| `reverse_string_recursive` | recursion over two pointers and modifying the string with the `strb` instruction |
| `binary_search_recursive` | choosing one half of the range and several function arguments |
| `count_predicate` | repeated `blr` calls and keeping a counter of matches |

## Navigation

- Previous: [Find first via a predicate function](../06-find_first/README.md)
- Next: [Recursive GCD](./01-gcd_recursive/README.md)
- Up: [Week 10](../README.md)
