# Array range

In assembly, implement a function that returns the difference between the
largest and the smallest element of an array. The main function `range` calls
the helper functions `minimum` and `maximum`.

Reference C++ version:

```cpp
int minimum(int *a, int n);
int maximum(int *a, int n);

int range(int *a, int n) {
    if (n <= 0) {
        return 0;
    }

    int min = minimum(a, n);
    int max = maximum(a, n);
    return max - min;
}
```

## Files

- `main.cpp` reads an array and prints its range
- `minimum.s` finds the smallest element
- `maximum.s` finds the largest element
- `range.s` calls both helper functions

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp range.s minimum.s maximum.s -o range
```

## Running

```sh
qemu-aarch64 ./range
```

Example:

```text
5
-2 7 3 9 -5
14
```

## What to pay attention to

- `range` must save the array address and the length before the first call
- the result of the `minimum` function must survive the call to the `maximum`
  function
- both helper functions are leaf functions, but `range` is not

## Navigation

- Previous: [Replace the largest digit](../06-replace_largest_digit/README.md)
- Next: [Array of largest digits](../08-array_of_largest_digits/README.md)
- Up: [Week 11](../README.md)
