# Hello world

This example comes after addition, just as in week one, because it introduces several new ideas:

- a string stored in the `.rodata` section
- computing the address of a symbol
- calling the library function `puts`
- saving `fp` and `lr` on the stack

## Files

- `hello.cpp` is the reference C++ version of the program
- `hello.s` is the ARM64 assembly implementation of the `main` function

## What is new compared to addition

The function `sum_two` is a leaf function: it does not call anyone. Here `main` calls `puts`, so it must save the return address.

On ARM64 the instruction `bl puts` writes the return address into `lr`, i.e. `x30`. If our function calls another function, we must save `lr` before the call, otherwise we would not know where to return at the end of the `main` function.

This is also the first example where we have to keep the register agreement in mind: `puts` gets its first argument in `x0`, and the registers `x0`-`x17` are `caller-saved`. That means the called function may overwrite them, so we ourselves must save any values we need after `bl`. By contrast, the registers `x19`-`x28`, `fp`/`x29`, and `sp` must be preserved by the called function if it uses them.

That is why the example begins like this:

```asm
stp fp, lr, [sp, #-16]!
mov fp, sp
```

and ends symmetrically:

```asm
ldp fp, lr, [sp], #16
ret
```

## The address of the string

The string is in the `.rodata` section:

```asm
msg: .asciz "Hello world!"
```

The function `puts` expects the address of the string as its first argument. On ARM64 the first argument goes into `x0`, so we prepare the address like this:

```asm
adr x0, msg
```

This is the ARM64 form of what we wrote on `x86-64` as:

```asm
lea rdi, [rip+msg]
```

The instruction `adr` computes the address of the label `msg` relative to the current instruction. In such a small example this is the most readable form.

## Compilation

The reference C++ version:

```sh
aarch64-linux-gnu-g++ hello.cpp -o hello-cpp
```

The assembly version:

```sh
aarch64-linux-gnu-g++ hello.s -o hello
```

## Running

```sh
qemu-aarch64 ./hello
```

The expected output is:

```text
Hello world!
```

## What to pay attention to

- `bl` is the ARM64 function call
- `ret` returns to the address in `lr`, i.e. `x30`
- `adr x0, msg` writes the address of the string into the first-argument register
- `puts` itself adds a newline at the end of the output
- at the end we set `w0` to `0`, because that is the return value of the `main` function

## Navigation

- Previous: [Addition](../01-addition/README.md)
- Next: [Maximum of two numbers](../03-max/README.md)
- Up: [Week 7](../README.md)
