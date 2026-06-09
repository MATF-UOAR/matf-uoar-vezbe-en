# Standalone mini-examples

These exercises serve as a short supplement to the main examples from week 5. They are deliberately shorter than the main examples and can be done as practice after going through the main part of the material.

## Contents

- [Print several times](./01-print_times/README.md)
- [Recursive power](./02-power_recursive/README.md)
- [Recursive array sum](./03-array_sum_recursive/README.md)
- [Count via a predicate function](./04-count_predicate/README.md)
- [Recursive string length](./05-string_length_recursive/README.md)

## Recommended order

1. Start with [Print several times](./01-print_times/README.md), since it is the shortest example with several calls to `puts` from the same function.
2. Continue with [Recursive power](./02-power_recursive/README.md), which is a natural continuation of the recursive factorial.
3. Then do [Recursive array sum](./03-array_sum_recursive/README.md), since it combines recursion and address arithmetic over an array.
4. After that try [Count via a predicate function](./04-count_predicate/README.md), since it returns to the indirect `call`, but without early termination.
5. Finally look at [Recursive string length](./05-string_length_recursive/README.md), since it is a short example of recursion over a pointer to characters.

## Note

Here the tasks are shorter and deliberately leave more room for you to follow on your own what happens with the stack, the arguments, and the return values.

In the non-recursive examples, follow which values must survive several `call` instructions. In the recursive examples, look at the base case, the recursive call, and what happens on return.

| example | what it practices |
| --- | --- |
| `print_times` | several library calls from the same function |
| `power_recursive` | recursion with a saved value used after return |
| `array_sum_recursive` | recursion while moving a pointer through an array |
| `count_predicate` | indirect `call` without early termination |
| `string_length_recursive` | recursion over a pointer to characters |

## Navigation

- Previous: [Recursive palindrome](../05-is_palindrome_recursive/README.md)
- Next: [Print several times](./01-print_times/README.md)
- Up: [Week 5](../README.md)
