# sum_three

This is the shortest possible continuation of the `sum_two` example.

Now the function takes not two but three `int` arguments. The goal is to clearly see:

- that the third argument arrives in `edx`
- that the return value is still returned via `eax`
- that a simple **leaf function** can still work without a stack frame

## Files

- `main.cpp` reads three numbers and calls `sum_three`
- `sum_three.s` contains the assembly implementation of the function

## Compilation

```sh
g++ main.cpp sum_three.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
2 4 7
13
```

## What to pay attention to

- `a`, `b`, `c` arrive in `edi`, `esi`, `edx`
- the stack is not used anywhere, since the function has no local variables and does not call other functions
- the result is placed in `eax` at the end
