# Week 3

In the third week we move on to loops in assembly and to the first examples in which one assembly function calls another.

In this unit we will see:

- how `while` and `for` loops are built using `cmp`, conditional jumps, and `jmp`
- how the multiplication instruction `mul` is used
- how `enter` and `leave` can shorten the standard function prologue and epilogue
- how one assembly function calls another from assembly, and which registers must be saved before `call`
- how `test` and `loop` can shorten the parity check and the management of the loop counter

## Contents

- [GCD](./01-gcd/README.md)
- [Sum](./02-sum/README.md)
- [Sum of even numbers](./03-sum-of-evens/README.md)
- [Euler](./04-euler/README.md)
- [Self-study mini-examples](./05-exercises/README.md)

## Recommended order

1. First look at [GCD](./01-gcd/README.md), since there you see the basic pattern of a `while` loop and your first encounter with `enter` and `leave`.
2. Then go through the [Sum](./02-sum/README.md) example, since there you get a direct translation of a `for` loop and your first example with the `mul` instruction.
3. After that look at the [Sum of even numbers](./03-sum-of-evens/README.md), since there you see the use of `test` and `loop`, as well as a do-while-style variant.
4. Finally go through [Euler](./04-euler/README.md), since there one assembly function calls another for the first time and must save registers before `call`.
5. Once you have gone through the basic examples, try to solve the [exercises](./05-exercises/README.md).

## Note

The examples in this week often use `enter` and `leave` for a shorter notation. In practice you will frequently also see the explicit pairs `push rbp` / `mov rbp, rsp` and `mov rsp, rbp` / `pop rbp`.

## Navigation

- Previous: [Week 2](../02-jump-instructions/README.md)
- Next: [GCD](./01-gcd/README.md)
