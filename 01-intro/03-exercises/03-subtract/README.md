# subtract

This is a short arithmetic task that naturally goes alongside the `sum_two` example.

The function `subtract` takes two `int` arguments and returns their difference `a - b`. The goal is to reinforce:

- that the arguments still arrive in `edi` and `esi`
- that the return value is still returned via `eax`
- that even a simple function with the `sub` instruction can work without a stack frame

## Files

- `main.cpp` reads two numbers and calls `subtract`
- `subtract.s` contains the assembly implementation of the function

## Compilation

```sh
g++ main.cpp subtract.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
9 4
5
```

## What to pay attention to

- `a` and `b` arrive in `edi` and `esi`
- the instruction `sub edi, esi` computes `edi - esi`
- the result is placed in `eax` at the end
- since the function does not call other functions and does not use local variables, a stack frame is not needed
