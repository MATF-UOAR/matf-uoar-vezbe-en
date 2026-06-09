# Hello world

This example comes after addition because it introduces several new ideas at once:

- a constant string stored in memory
- a call to the external function `puts`
- the difference between the address of a string and the contents at that address
- taking care of the stack before calling another function

That is why it is more suitable as the second example, after registers, function arguments and the return value are already familiar from the addition example.

## Files

- `hello.cpp` is the reference C++ version of the program
- `hello.s` is the assembly implementation of the `main` function

## What is new in this example

Unlike addition, here the `main` function does not do everything itself, but calls the library function `puts`.

That means we now also have to understand the following:

- the text `"Hello world!"` must be stored somewhere in memory
- since it is a constant string, it is natural for it to be in the `.rodata` section
- the address of that string must be passed to the `puts` function
- `lea` computes the address of the string, it does not read its contents
- `call puts` writes the return address onto the stack and transfers control to the library function
- before calling another function we must take care of the stack and its alignment

In the assembly version the string is written in the `.rodata` section:

```asm
.section .rodata
msg: .asciz "Hello world!"
```

The instruction

```asm
lea rdi, [rip+msg]
```

computes the address of the string and writes it into the register `rdi`, which is exactly the place where, by the calling convention, the function's first argument arrives.

After that the call

```asm
call puts
```

transfers control to the library function, which prints the string to standard output.

It is also important that `puts` itself adds a newline at the end of the output, so in this example the string does not contain `\n`.

## Why there is a stack frame here

Unlike `sum_two`, the `main` function here calls another function. On entry into `main` the return address is already on the stack, so `rsp` is not aligned the same way as it is just before `call`.

The instructions

```asm
push rbp
mov rbp, rsp
```

have a double role here:

- they build a tidy stack frame
- after `push rbp` they return `rsp` to an alignment suitable for `call puts`

## Compilation

If you want to compile the C++ reference version:

```sh
g++ hello.cpp
```

If you want to compile the assembly version:

```sh
g++ hello.s
```

## Running

```sh
./a.out
```

The expected output is:

```text
Hello world!
```

## What to pay attention to

- `main` still returns a value via the register `eax`, which is why at the end we set `mov eax, 0`.
- This is the first example in which our function calls another function.
- `lea rdi, [rip+msg]` computes the address of the string; if we had used `mov`, we would have gotten something else.
- `call puts` calls the library function, and the final `ret` returns execution to the caller of the `main` function.
- That is why it is a natural introduction to later examples with more complex calls and work with the stack.
- For a visual explanation of what `rbp`, `rsp` and a stack frame are, see the [Stack frames](../00-introductory-topics/01-organization-of-executable-code.md) section.
