# Minimum of an array of `unsigned long` values

This example is intentionally similar to the maximum example, but the array elements are no longer `int`; they are `unsigned long`. That is why the width of the registers and the size of the step through the array change.

## What the program does

The program reads the length of the array, then the `unsigned long` elements, calls `min_element`, and prints the smallest value.

The reference C++ function is:

```cpp
unsigned long min_element(unsigned long* a, int n) {
    unsigned long minimum = a[0];
    for (int i = 1; i < n; i++) {
        if (a[i] < minimum) {
            minimum = a[i];
        }
    }
    return minimum;
}
```

We assume that `n > 0`, because the function takes its initial value from `a[0]`.

## Files

- `main.cpp` reads the array and calls `min_element`
- `min_v1.s` uses index addressing
- `min_v2.s` uses post-index pointer advancing

Both assembly files define the same function `min_element`, so only one of them is compiled at a time.

## What to watch for in the assembly

Since the return value is of type `unsigned long`, the result is returned in `x0`, and we keep the running minimum in `x2`.

In the index version an element is read like this:

```asm
ldr x4, [x0, x3, lsl #3]
```

Here `lsl #3` is multiplying the index by `8`, because one `unsigned long` is `8` bytes.

The comparison is unsigned:

```asm
cmp x4, x2
csel x2, x4, x2, lo
```

The condition `lo` means lower and is used for unsigned comparison. That matches the type `unsigned long`.

The second version uses the post-index form with a step of `8`:

```asm
ldr x3, [x0], #8
```

After reading the element, the pointer in `x0` already points to the next `unsigned long`.

## Compilation

The index version:

```sh
aarch64-linux-gnu-g++ main.cpp min_v1.s -o min_element
```

The pointer-advancing version:

```sh
aarch64-linux-gnu-g++ main.cpp min_v2.s -o min_element
```

## Running

```sh
qemu-aarch64 ./min_element
```

Example interaction:

```text
4
12 4 8 2
2
```

## What to pay attention to

- for 64-bit elements we use `x` registers
- the element size determines the scale: `lsl #3` means multiplying by `8`
- for the `unsigned long` comparison we use unsigned conditions, here `lo`
- this example also assumes a non-empty array
- both versions are leaf functions and so do not need a stack frame

## Navigation

- Previous: [Maximum of an array](../02-max_element/README.md)
- Next: [Minimum and maximum of `short` values](../04-minimax/README.md)
- Up: [Week 9](../README.md)
