# Swap minimum and maximum

In assembly, implement a function that finds the positions of the smallest and
largest elements of an array and then swaps those two elements.

Reference C++ version:

```cpp
void swap_min_and_max(int *a, int n) {
    if (n <= 1) {
        return;
    }

    int i_min = 0;
    int i_max = 0;
    for (int i = 1; i < n; i++) {
        if (a[i] < a[i_min]) {
            i_min = i;
        }
        if (a[i] > a[i_max]) {
            i_max = i;
        }
    }

    int tmp = a[i_min];
    a[i_min] = a[i_max];
    a[i_max] = tmp;
}
```

## Files

- `main.cpp` reads an array, calls the function, and prints the modified array
- `swap_min_and_max.s` contains the ARM64 implementation of the function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp swap_min_and_max.s -o swap_min_and_max
```

## Running

```sh
qemu-aarch64 ./swap_min_and_max
```

Example:

```text
5
4 -2 7 0 3
4 7 -2 0 3
```

## What to pay attention to

- the loop remembers both the values and the indices of the minimum and maximum
- signed comparisons `lt` and `gt` are used
- memory is modified only after the whole array has been traversed

## Navigation

- Previous: [Dot product](../03-dot_product/README.md)
- Next: [Word count](../05-word_count/README.md)
- Up: [Week 11](../README.md)
