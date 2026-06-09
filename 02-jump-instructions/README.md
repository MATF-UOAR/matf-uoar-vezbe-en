# Week 2

The second week continues the introductory examples and introduces the first clear situations in which the flow of execution depends on the data.

In this unit we go through:

- how arguments are passed once they no longer all fit into registers
- how an `if` branch is translated into `cmp` and conditional jumps
- how `div` and `idiv` work, and why `eax` and `edx` are especially important
- how the remainder of a division is used to check a condition
- how a `switch` can be translated into several comparisons and jumps

## Contents

- [Passing arguments](./01-passing-arguments/README.md)
- [Maximum of two numbers](./02-max/README.md)
- [Division](./03-division/README.md)
- [Divisibility by 4](./04-divisible-by-4/README.md)
- [`switch` branching](./05-switch/README.md)
- [Exercises](./06-exercises/README.md)

## Recommended order

1. First look at [Passing arguments](./01-passing-arguments/README.md), because it explains what happens when a function has more parameters than fit into registers.
2. After that look at [Maximum of two numbers](./02-max/README.md), since it is the first direct example of translating an `if/else` branch into conditional jumps.
3. Then go through [Division](./03-division/README.md), where `edx:eax`, `div`, `idiv`, and the difference between signed and unsigned division are introduced.
4. After that look at [Divisibility by 4](./04-divisible-by-4/README.md), which uses the remainder of a division as the basis for making a decision.
5. Finally look at [`switch` branching](./05-switch/README.md), to see how several different `case` values can lead into the same branch.
6. Once you have gone through the basic examples, also try the [Exercises](./06-exercises/README.md), which combine the same ideas in slightly different tasks.

## Note

These examples are short, but they introduce several things that are easily confused:

- the registers for function arguments
- stack arguments
- the difference between signed and unsigned computation
- the role of the `edx:eax` register in division
- the connection between `cmp` and conditional jumps

That is why it is useful not only to read each example, but also to compile it, run it, and try it out with several different inputs.

## Navigation

- Previous: [Week 1](../01-intro/README.md)
- Next: [Passing arguments](./01-passing-arguments/README.md)
