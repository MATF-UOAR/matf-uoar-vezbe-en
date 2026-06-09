# Absolute value

This example is the first exercise with a conditional jump. The function returns the absolute value of a number.

The reference C++ version is:

```cpp
int absolute_value(int x) {
    if (x < 0) {
        return -x;
    }
    return x;
}
```

## What to observe

The argument `x` arrives in `w0`, and the return value should also be in `w0`.

The pattern is:

```asm
cmp w0, #0
b.ge end
neg w0, w0
```

If `x >= 0`, the value is already correct and we jump to the end. If not, the `neg` instruction changes the sign of the value in `w0`.

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp absolute_value.s -o absolute_value
```

## Running

```sh
qemu-aarch64 ./absolute_value
```

Example interaction:

```text
-7
7
```

## Navigation

- Previous: [Subtraction](../01-subtract/README.md)
- Next: [Maximum of three numbers](../03-max3/README.md)
- Up: [Exercises](../README.md)
