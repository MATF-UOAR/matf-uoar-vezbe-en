# Week 7: introduction to ARM64

This week is an introduction to the ARM64 part of the course. Since we have worked on `x86-64` so far, we introduce ARM64 through a direct comparison with familiar examples. The goal is not to learn every detail of the ARM architecture at once, but to recognize the same ideas we already know:

- function arguments arrive in registers
- the return value is returned through a register
- a function can be a simple leaf function, or it can call other functions
- comparison and branching still reduce to `cmp` and a conditional jump
- the stack and alignment matter when a function calls another function

## Contents

- [Moving from x86-64 to ARM64](./00-comparison-x86-64-and-arm64/README.md)
- [Addition](./01-addition/README.md)
- [Hello world](./02-hello-world/README.md)
- [Maximum of two numbers](./03-max/README.md)
- [Exercises](./04-exercises/README.md)

## Recommended order

1. First read [Moving from x86-64 to ARM64](./00-comparison-x86-64-and-arm64/README.md), since it contains a map of concepts we already know from `x86-64`.
2. Then go through [Addition](./01-addition/README.md). It is the smallest example of an ARM64 function.
3. After that, look at [Hello world](./02-hello-world/README.md), which introduces calling a library function and saving the return address.
4. Then look at [Maximum of two numbers](./03-max/README.md), where the familiar `cmp` + conditional jump pattern is translated into ARM64 form.
5. Finally, try the [Exercises](./04-exercises/README.md), which reinforce translating short `x86-64` patterns into ARM64.

## What is ARM

`ARM` is a family of processor architectures based on RISC ideas: the instructions are simpler, the registers are more uniform, and working with memory is clearly separated from arithmetic. `ARM64` is the common name for 64-bit ARM, while official terminology often uses the name `AArch64`.

ARM is used today in:

- phones and tablets
- single-board computers, such as the Raspberry Pi
- embedded systems, IoT devices, and networking equipment
- laptops and desktop computers, for example Apple Silicon
- servers and cloud environments where the ratio of power consumption to performance matters

ARM is a common choice in these areas because it scales well from small, power-efficient devices to large server systems. Manufacturers can also license ARM cores or the ARM instruction set and build them into their own SoC, together with a memory controller, graphics, input/output devices, and other components.

## Why we use a cross compiler

The computer we work on is most often `x86-64`, while this week's examples are written for `ARM64`. An ordinary `g++` builds an executable for the architecture of the computer it runs on. That is why we need a cross compiler:

```sh
aarch64-linux-gnu-g++ main.cpp example.s -o example
```

This command builds a Linux `ELF` program whose machine instructions are ARM64 instructions, not `x86-64` instructions.

## Why we use QEMU

Since the resulting program contains ARM64 machine code, an `x86-64` processor cannot run it directly. To run it we use an emulator:

```sh
qemu-aarch64 ./example
```

`qemu-aarch64` executes ARM64 instructions on our machine.

If QEMU on some system cannot find the ARM64 dynamic linker or libraries, you can explicitly give it a path:

```sh
qemu-aarch64 -L /usr/aarch64-linux-gnu ./example
```

The option `-L /usr/aarch64-linux-gnu` tells QEMU where to look for the ARM64 dynamic linker and the libraries the cross compiler used. In the examples we will write the shorter command, but this form is useful as a fallback if running does not work right away.

## Useful checks

- `file example` shows that the program is `ARM aarch64`, not `x86-64`
- `aarch64-linux-gnu-objdump -d example` shows the ARM64 instructions
- `aarch64-linux-gnu-nm example` shows the symbols in the ARM64 executable

## A suggestion for working

For each example, first read the C++ declaration of the function, then look at which ARM64 registers the arguments arrive in, and only then read the instructions. That is the easiest way to see that the ideas are the same as on `x86-64`, only the concrete set of registers and instructions is different.

## Exercises for independent work

After the basic examples, a good next step is to translate the familiar short tasks from `x86-64` into ARM64:

- **Subtraction**: a direct counterpart of the `sum_two` example, only with the `sub` instruction
- **Absolute value**: the first exercise with a single conditional jump
- **Maximum of three numbers**: an extension of the `max` example to three arguments
- **Divisibility by 4**: a short bitwise check of the two lowest bits

Finished versions are in [Exercises](./04-exercises/README.md).

## Navigation

- Previous: [Week 6](../06-practice/README.md)
- Next: [Moving from x86-64 to ARM64](./00-comparison-x86-64-and-arm64/README.md)
