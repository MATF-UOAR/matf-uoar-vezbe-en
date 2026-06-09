# Exercises

These examples serve to translate familiar short `x86-64` tasks into ARM64. They are all deliberately small: the goal is to reinforce the registers `w0`, `w1`, `w2`, the return value in `w0`, and the `cmp` + `b.<condition>` pattern.

## Contents

- [Subtraction](./01-subtract/README.md)
- [Absolute value](./02-absolute_value/README.md)
- [Maximum of three numbers](./03-max3/README.md)
- [Divisibility by 4](./04-divisible_by_4/README.md)

## Recommended order

1. First do [Subtraction](./01-subtract/README.md), since it is closest to the `sum_two` example.
2. Then [Absolute value](./02-absolute_value/README.md), since it introduces one simple branch.
3. After that [Maximum of three numbers](./03-max3/README.md), which repeats the same pattern twice.
4. Finally [Divisibility by 4](./04-divisible_by_4/README.md), where the condition is obtained with a bitwise operation.

## How to read them

For each example, first look at the function signature in `main.cpp`, and based on it determine where the arguments are:

- the first `int` is in `w0`
- the second `int` is in `w1`
- the third `int` is in `w2`
- the return value is in `w0`

After that it is easier to read the ARM64 code itself, since each example only moves values through these registers.

## Navigation

- Previous: [Maximum of two numbers](../03-max/README.md)
- Next: [Subtraction](./01-subtract/README.md)
- Up: [Week 7](../README.md)
