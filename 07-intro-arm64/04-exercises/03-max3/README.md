# Maximum of three numbers

This is an extension of the `max` example to three arguments. The function returns the largest of the numbers `x`, `y`, and `z`.

The reference C++ version is:

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

## What to observe

- `x` arrives in `w0`
- `y` arrives in `w1`
- `z` arrives in `w2`
- `w0` must hold the maximum at the end

Since `x` is already in `w0`, it is the initial candidate for the maximum. We then compare it with `y`, and then with `z`.

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp max3.s -o max3
```

## Running

```sh
qemu-aarch64 ./max3
```

Example interaction:

```text
4 9 2
9
```

## Navigation

- Previous: [Absolute value](../02-absolute_value/README.md)
- Next: [Divisibility by 4](../04-divisible_by_4/README.md)
- Up: [Exercises](../README.md)
