# Recursive array maximum

In assembly, implement a recursive function that returns the largest element of
an array.

Reference C++ version:

```cpp
int maximum_recursive(int *a, int n) {
    if (n <= 0) {
        return 0;
    }
    if (n == 1) {
        return a[0];
    }

    int max_of_rest = maximum_recursive(a + 1, n - 1);
    return a[0] > max_of_rest ? a[0] : max_of_rest;
}
```

## Files

- `main.cpp` reads an array and prints the recursively found maximum
- `maximum_recursive.s` contains the ARM64 implementation of the function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp maximum_recursive.s -o maximum_recursive
```

## Running

```sh
qemu-aarch64 ./maximum_recursive
```

Example:

```text
6
4 9 2 15 5 1
15
```

## What to pay attention to

- for `a + 1` with an `int` array, the address moves by `4` bytes
- the value `a[0]` must be saved before the recursive call
- after returning from the recursion, the saved element is compared with the
  maximum of the rest of the array

## Navigation

- Previous: [Recursive count of ones](../09-count_ones_recursive/README.md)
- Up: [Week 11](../README.md)
