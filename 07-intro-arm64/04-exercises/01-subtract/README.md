# Subtraction

This is the shortest exercise after `sum_two`. The function takes two `int` arguments and returns `a - b`.

The reference C++ version is:

```cpp
int subtract(int a, int b) {
    return a - b;
}
```

## What to observe

- `a` arrives in `w0`
- `b` arrives in `w1`
- the result should stay in `w0`
- the ARM64 instruction `sub w0, w0, w1` means `w0 = w0 - w1`

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp subtract.s -o subtract
```

## Running

```sh
qemu-aarch64 ./subtract
```

Example interaction:

```text
10 4
6
```

## Navigation

- Previous: [Exercises](../README.md)
- Next: [Absolute value](../02-absolute_value/README.md)
- Up: [Exercises](../README.md)
