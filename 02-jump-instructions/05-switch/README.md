# `switch` branching

This example shows how a single `switch` from C++ code can be manually translated into several comparisons and jumps in assembly.

In it you can clearly see:

- how several `case` branches can lead into the same block of code
- how the `default` branch reduces to "if nothing was matched"
- how a `switch` can be realized even without a jump table approach

## What the program does

The program reads a month number and calls the function `days_in_month`.

A reference C++ version of the function would look like this:

```cpp
int days_in_month(int month) {
    switch (month) {
    case 1:
    case 3:
    case 5:
    case 7:
    case 8:
    case 10:
    case 12:
        return 31;
    case 4:
    case 6:
    case 9:
    case 11:
        return 30;
    case 2:
        return 28;
    default:
        return -1;
    }
}
```

If the input is invalid, the function returns `-1`.

## Files

- `main.cpp` reads the month number and prints the result
- `switch.s` contains the assembly implementation of the function `days_in_month`

## What to watch for in the assembly

Each `case` becomes a comparison and a conditional jump:

```asm
cmp edi, 1
je has_31
cmp edi, 3
je has_31
```

Several `case` values can jump to the same label. This gives the same effect as in the C++ code when several `case` branches share one `return`.

If no comparison succeeds, execution falls through to:

```asm
mov eax, -1
```

This is the `default` branch here.


## Compilation

```sh
g++ main.cpp switch.s
```

## Running

```sh
./a.out
```

Example interactions:

```text
2
Number of days: 28
```

```text
13
Invalid month
```

## What to pay attention to

- this is the pedagogically simplest form of translating a `switch` statement
- for densely packed `case` values the compiler sometimes builds a jump table, which can speed up the code, but here we deliberately do not do that
- the pattern with several `cmp` and `je` jumps is enough to understand the branching logic

## Navigation

- Previous: [Divisibility by 4](../04-divisible-by-4/README.md)
- Next: [Exercises](../06-exercises/README.md)
