# Maximum of two numbers

This is the first clear example in which a single `if/else` from C++ code is translated directly into a comparison and a conditional jump.

In it you can see:

- how `cmp` works
- how the conditional jump `jle` is used
- how `if` and `else` branches are organized in assembly

## What the program does

The program reads two `int` numbers, calls the function `max`, and prints the larger of the two numbers.

A reference C++ version of the function could look like this:

```cpp
int max(int x, int y) {
    int return_value;
    if (x > y) {
        return_value = x;
    }
    else {
        return_value = y;
    }
    return return_value;
}
```

In this code there are two possible execution paths:

- if `x > y`, we return `x`
- otherwise, we return `y`

In C++ we write this using `if/else`, but in assembly we do not have a special construct of that kind. Instead, we have a sequence of instructions that are normally executed in order, one after another. When we want branching, we have to make it possible to skip part of that sequence. This is done with jump instructions.

Jumps can be:

- unconditional, like `jmp`
- conditional, like `jle`

An unconditional jump always transfers execution to some other label. In this example, once the `if` branch is executed and the value `x` is written as the result, we no longer want execution to continue into the `else` branch, so we skip it with the `jmp` instruction.

A conditional jump transfers execution only if the corresponding condition is met. In this example we do not test the condition `x > y` directly; instead we do the opposite: if `x <= y`, we go to the `else` branch. That way the `if` branch is skipped exactly when its condition is not met.

The pattern therefore looks like this:

```asm
cmp x, y
jle else_branch

; if branch
jmp end

else_branch:
; else branch

end:
```

The `cmp` instruction is key because it is what makes conditional branching possible. In this example `cmp edi, esi` compares `x` and `y`, and `jle` (`jump if less or equal`) then goes to the `else` branch if `x <= y`. Since we are working with the type `int`, here we use a signed comparison.

This example is also very clearly shown in [Compiler Explorer](https://godbolt.org/z/Mo9GWhe4v), where parts of the code are marked with matching colors.

## How a conditional jump really works

An important detail of the previous code is that the comparison instruction is executed first, and only after that the conditional jump instruction. This means that the result of the comparison we obtain with the `cmp` instruction must be stored somewhere, so that the conditional jumps can later look at that information.

If we want to compare the numbers `x` and `y`, it is natural to look at the sign of the expression `x - y`. Things get a little complicated because the processor works with a fixed register width, so subtraction can lead to overflow. That is why `cmp` does not only remember whether the result is zero or negative, but sets several bits in the `FLAGS` register.

The information it stores is:
- `SF` (`sign flag`) - set if the result is negative
- `ZF` (`zero flag`) - set if the result is zero, i.e. if the operands are equal
- `OF` (`overflow flag`) - set if signed arithmetic overflowed
- `CF` (`carry flag`) - used in unsigned comparisons; signals a carry or borrow

Based on the values of these bits, the conditional jump instructions make their decisions. The way decisions are made can be seen in the following table:

| Instruction | Meaning | When it jumps |
| --- | --- | --- |
| `je` / `jz` | equal | `ZF = 1` |
| `jne` / `jnz` | not equal | `ZF = 0` |
| `jl` | less, for signed numbers | `SF != OF` |
| `jle` | less or equal, for signed numbers | `ZF = 1` or `SF != OF` |
| `jg` | greater, for signed numbers | `ZF = 0` and `SF = OF` |
| `jge` | greater or equal, for signed numbers | `SF = OF` |
| `jb` | less, for unsigned numbers | `CF = 1` |
| `jbe` | less or equal, for unsigned numbers | `CF = 1` or `ZF = 1` |
| `ja` | greater, for unsigned numbers | `CF = 0` and `ZF = 0` |
| `jae` | greater or equal, for unsigned numbers | `CF = 0` |

In this example the most important row is the one with `jle`: after `cmp edi, esi` that jump is taken when `edi <= esi`, i.e. when `x <= y`.

## Files

- `main.cpp` reads two numbers and calls `max`
- `max.s` contains the assembly implementation of the function

## Compilation

```sh
g++ main.cpp max.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
4 9
max(4, 9) = 9
```

## What to pay attention to

- this is one of the most important patterns for reading assembly: `cmp` plus a conditional jump
- the example uses a signed comparison, because it works with the type `int`
- the same pattern will appear later in more complex functions with several branches

## Navigation

- Previous: [Passing arguments](../01-passing-arguments/README.md)
- Next: [Division](../03-division/README.md)
