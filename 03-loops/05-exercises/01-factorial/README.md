# Factorial

This is the most natural continuation of the `sum_to_n` example, except that instead of addition, multiplication is used in each iteration.

The `factorial` function takes one `unsigned` number and returns `n!`. The goal is to reinforce:

- a `for` loop with a counter that goes from `1` to `n`
- an accumulator that starts from `1`
- the use of the `mul` instruction

A reference C++ version of the function could look like this:

```cpp
unsigned factorial(unsigned n) {
    unsigned result = 1;
    for (unsigned i = 1; i <= n; i++) {
        result *= i;
    }
    return result;
}
```

## Files

- `main.cpp` reads a number and prints `n!`
- `factorial.s` contains the assembly implementation of the function

## Compilation

```sh
g++ main.cpp factorial.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
5
5! = 120
```

## What to pay attention to

- `0!` is `1`, so the accumulator starts from `1`
- `mul` multiplies the contents of `eax` by the given operand and places the whole product in `edx:eax`
- as with the other `unsigned` examples, here we naturally keep only the lower 32 bits of the result

## Navigation

- Previous: [Self-study mini-examples](../README.md)
- Next: [Power](../02-power/README.md)
