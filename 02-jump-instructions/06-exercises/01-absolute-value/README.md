# Absolute value

This is the shortest possible task after the `Maximum of two numbers` example.

The function `absolute_value` takes one `int` and returns its absolute value. The goal is to reinforce:

- comparison with zero
- a single `if` branch and one conditional jump
- the `neg` instruction

A reference C++ version of the function could look like this:

```cpp
int absolute_value(int x) {
    if (x < 0) {
        return -x;
    }
    return x;
}
```

## Files

- `main.cpp` reads the number and prints the result
- `absolute_value.s` contains the assembly implementation of the function

## Compilation

```sh
g++ main.cpp absolute_value.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
-7
|x| = 7
```

## What to pay attention to

- the argument `x` arrives in `edi`
- it is enough to compare `x` with zero and apply `neg` if needed
- as in the C++ code with the type `int`, we ignore the `INT_MIN` case here

## Navigation

- Previous: [Exercises](../README.md)
- Next: [Max3](../02-max3/README.md)
