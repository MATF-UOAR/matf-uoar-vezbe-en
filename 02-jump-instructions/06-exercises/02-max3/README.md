# Max3

This example is a natural continuation of the `max` example, but now the function takes three numbers.

The function `max3` returns the largest of three `int` arguments. The goal is to reinforce:

- that the third argument arrives in `edx`
- how the current maximum can be kept in `eax`
- what several consecutive `if` checks look like in assembly

A reference C++ version of the function could look like this:

```cpp
int max3(int x, int y, int z) {
    int result = x;
    if (y > result) {
        result = y;
    }
    if (z > result) {
        result = z;
    }
    return result;
}
```

## Files

- `main.cpp` reads three numbers and calls `max3`
- `max3.s` contains the assembly implementation of the function

## Compilation

```sh
g++ main.cpp max3.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
4 9 2
max3(4, 9, 2) = 9
```

## What to pay attention to

- `x`, `y`, `z` arrive in `edi`, `esi`, `edx`
- in `eax` we can first put `x`, and then update it later if needed
- this is a good example for reading code that has several short branches, but without an `else` part

## Navigation

- Previous: [Absolute value](../01-absolute-value/README.md)
- Next: [Leap year](../03-leap-year/README.md)
