# Moving from x86-64 to ARM64

This section serves as a short glossary for moving from familiar `x86-64` code to ARM64 code. It should not be read as a complete description of the architecture, but as a map of the most important differences that will appear in the examples.

## The most important difference

`x86-64` allows many different forms of instructions. For example, some arithmetic instructions can read a value directly from memory.

ARM64 is a load/store architecture. This means that arithmetic mostly works on registers, while memory access is done with separate instructions:

```asm
ldr w2, [x0]      // load an int from memory
add w0, w1, w2    // add registers
str w0, [x0]      // store an int into memory
```

That is why ARM64 code often has a clearer pattern: first a load from memory, then computation in registers, then a store back to memory if needed.

## Registers and the calling convention

| Idea | x86-64 System V | ARM64 AAPCS64 |
| --- | --- | --- |
| 1st `int` argument | `edi` | `w0` |
| 2nd `int` argument | `esi` | `w1` |
| 3rd `int` argument | `edx` | `w2` |
| 4th `int` argument | `ecx` | `w3` |
| 64-bit arguments | `rdi`, `rsi`, `rdx`, ... | `x0`, `x1`, `x2`, ... |
| `int` return value | `eax` | `w0` |
| 64-bit return value | `rax` | `x0` |
| frame pointer | `rbp` | `fp`, i.e. `x29` |
| stack pointer | `rsp` | `sp` |
| return address | on the stack after `call` | in `lr`, i.e. `x30`, after `bl` |

The ARM64 registers `x0` through `x30` are 64-bit. Their lower 32-bit parts are called `w0` through `w30`. When we work with the `int` type, we naturally use the `w` registers.

## Calling a function

On `x86-64` a call looks like this:

```asm
call puts
ret
```

The `call` instruction places the return address on the stack. The `ret` instruction later pops it off the stack.

On ARM64 a call looks like this:

```asm
bl puts
ret
```

The `bl` instruction writes the return address into `lr`, i.e. `x30` (the `link register`). That is why a function that calls another function must save `lr`, because the next `bl` would overwrite the old return address.

For integer arguments and the registers that functions are allowed to modify, we use the following practical rule:

| Group | Registers | Practical rule |
| --- | --- | --- |
| Arguments and return value | `x0`-`x7`, i.e. `w0`-`w7` for 32-bit values | The first arguments go in order into these registers, and the return value is returned in `x0` or `w0`. |
| `caller-saved` | `x0`-`x17` | If we need the values from these registers after `bl`, the calling function must save them. |
| `callee-saved` | `x19`-`x28`, `fp`/`x29`, `sp` | If the called function uses them, it must restore them to their old values before `ret`. |

The register `x18` is platform-dependent, so in these examples we do not use it as a place to store values.

A typical ARM64 stack frame therefore looks like this:

```asm
stp fp, lr, [sp, #-16]!
mov fp, sp

// function body

ldp fp, lr, [sp], #16
ret
```

`stp` writes a pair of registers into memory, and `ldp` reads them back. The form `[sp, #-16]!` first moves `sp` down by 16 bytes, then writes the registers. The closing `[sp], #16` first reads the registers, then moves `sp` back up.

## Addition

The `x86-64` version of the `sum_two` function:

```asm
// int sum_two(int a, int b)
// eax          edi    esi
sum_two:
    add edi, esi
    mov eax, edi
    ret
```

The ARM64 version:

```asm
// int sum_two(int a, int b)
// w0           w0     w1
sum_two:
    add w0, w0, w1
    ret
```

On ARM64 the instruction `add w0, w0, w1` means: add `w0` and `w1`, then write the result into `w0`. That is also the register for the return value.

## Conditional branching

The `x86-64` pattern:

```asm
cmp edi, esi
jle else_branch
```

The ARM64 pattern:

```asm
cmp w0, w1
b.le else_branch
```

The idea is the same: `cmp` sets the information about the result of the comparison, and the conditional branch after it decides whether to jump.

The most common ARM64 conditions in these examples are:

| ARM64 | Meaning for signed numbers |
| --- | --- |
| `b.eq` | equal |
| `b.ne` | not equal |
| `b.lt` | less than |
| `b.le` | less than or equal |
| `b.gt` | greater than |
| `b.ge` | greater than or equal |

## Addresses in memory

On `x86-64` we often used this for the address of a string:

```asm
lea rdi, [rip+msg]
```

On ARM64 we will use a single instruction for the same goal:

```asm
adr x0, msg
```

`adr` computes the address of the label `msg` relative to the current instruction and writes it into `x0`. For short examples in a single file this is the most readable form.

In larger programs and in compiler-generated code you often also see the longer form:

```asm
adrp x0, msg
add x0, x0, :lo12:msg
```

That form splits the address into a page and an offset within the page. The notation `:lo12:msg` means "the lower 12 bits of the address of the symbol `msg`". That detail is not important for the first examples, so in hand-written code we will use `adr` whenever it is enough.

## Practical rule

When you translate a familiar `x86-64` example into ARM64, proceed in this order:

1. Rewrite the function signature and determine where the arguments are: `edi`, `esi` become `w0`, `w1`.
2. Determine where the return value is: `eax` becomes `w0`.
3. If the function does not call other functions, it probably does not need a stack frame.
4. If the function calls another function, save `fp` and `lr`.
5. For branching, first look for `cmp`, then translate the conditional jump into `b.<condition>`.

## Navigation

- Previous: [Week 7](../README.md)
- Next: [Addition](../01-addition/README.md)
- Up: [Week 7](../README.md)
