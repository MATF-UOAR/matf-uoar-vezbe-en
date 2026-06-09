# Divisibility by 4

This example checks whether a number is divisible by `4`. The function returns `1` if it is, and `0` if it is not.

The reference C++ version is:

```cpp
int divisible_by_4(int x) {
    if (x % 4 == 0) {
        return 1;
    }
    return 0;
}
```

## What to observe

For divisibility by `4` it is not necessary to use division. It is enough to check the two lowest bits:

```asm
and w1, w0, #3
```

If the result is `0`, the number is divisible by `4`. After that comes the familiar pattern:

```asm
cmp w1, #0
b.ne end
```

Here `#3` is the bitmask `0b11`, i.e. the mask that leaves only the two lowest bits.

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp divisible_by_4.s -o divisible_by_4
```

## Running

```sh
qemu-aarch64 ./divisible_by_4
```

Example interaction:

```text
12
Divisible
```

## Navigation

- Previous: [Maximum of three numbers](../03-max3/README.md)
- Up: [Exercises](../README.md)
