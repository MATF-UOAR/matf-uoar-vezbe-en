# Index of the maximum

This example returns the index of the largest element in an array. The maximum value is tracked as in the basic example, but the result returned is the position, not the value itself.

## What the program does

The program reads the length of the array and the elements, calls `index_of_max`, and prints the index of the first largest element.

The reference C++ function is:

```cpp
int index_of_max(int* a, int n) {
    int max = a[0];
    int index = 0;
    for (int i = 1; i < n; i++) {
        if (a[i] > max) {
            max = a[i];
            index = i;
        }
    }
    return index;
}
```

We assume that `n > 0`, because we take the initial value from `a[0]`.

## What to watch for in the assembly

The initial maximum is `a[0]`, and the initial index is `0`:

```asm
ldr w2, [x0]
mov w3, #0
mov w4, #1
```

When we find a strictly larger element, we update both the maximum and the index:

```asm
cmp w5, w2
b.le continue
mov w2, w5
mov w3, w4
```

Since we update only on a strictly larger element, if the maximum appears more than once, the index of the first occurrence is returned.

## Files

- `main.cpp` reads the array and calls `index_of_max`
- `index_of_max.s` contains the ARM64 implementation of the function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp index_of_max.s -o index_of_max
```

## Running

```sh
qemu-aarch64 ./index_of_max
```

Example interaction:

```text
6
4 9 2 9 5 1
1
```

## What to pay attention to

- the result is an index, not the value of the maximum
- `w2` keeps the current maximum, and `w3` its index
- the example assumes a non-empty array
- the function is a leaf function and so does not need a stack frame

## Navigation

- Previous: [Count of occurrences](../02-count_occurrences/README.md)
- Next: [Largest digit sum](../04-max_digit_sum/README.md)
- Up: [Exercises](../README.md)
