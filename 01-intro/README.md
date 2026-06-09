# Week 1

The first week serves as an introduction to the course and lays the foundation for the assembly examples that follow.

In this unit we go through:

- what an executable file looks like and what `ELF` is
- how `.text`, `.data`, `.rodata`, `stack` and `heap` are organized
- what registers, operands and the basic calling convention on `x86-64` are
- what the first short assembly programs and function calls look like

## Contents

- [Introductory topics](./00-introductory-topics/README.md)
- [Addition](./01-addition/README.md)
- [Hello world](./02-hello-world/README.md)
- [Self-study mini examples](./03-exercises/README.md)

## Recommended order

1. First read the [Introductory topics](./00-introductory-topics/README.md).
2. Then go through the [Addition](./01-addition/README.md) example, since it is the simplest first contact with an assembly function.
3. After that look at [Hello world](./02-hello-world/README.md), which introduces working with a string in memory and calling an external function.
4. Finally, try the [self-study mini examples](./03-exercises/README.md), which reinforce the same ideas on slightly different tasks.

## Note

The materials are written so that the theoretical part connects directly to the examples in the subfolders, so it is most useful to read and run them side by side.

## Self-study tasks

If you want a little more practice after the basic examples, try the following short tasks:

- **Sum of three numbers**: write a function that takes three `int` arguments and returns their sum. This is the simplest continuation of the `sum_two` example, since it also introduces a third argument in `edx`. A finished example is in [sum_three](./03-exercises/01-sum_three/README.md).
- **Printing two messages**: write an assembly `main` that calls `puts` twice and prints two different strings. This reinforces `.rodata`, `lea`, `call` and stack alignment. A finished example is in [two-messages](./03-exercises/02-two-messages/README.md).
- **Subtracting two numbers**: write a function `subtract(int a, int b)` that returns `a - b`. This is a good companion to the `sum_two` example, since it uses the same calling convention but a different arithmetic instruction. A finished example is in [subtract](./03-exercises/03-subtract/README.md).

## Useful commands for inspection

While going through the examples, it is useful to occasionally look at what the compiler actually produced:

- `readelf -S a.out` shows the sections of the executable file, such as `.text`, `.rodata`, `.data` and `.bss`
- `objdump -d a.out` shows the disassembled code, that is, the instructions that will be executed
- `nm a.out` shows the symbols, so you can check whether `main`, `sum_two` and similar names are really present
