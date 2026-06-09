# Recursive binary search

This example uses recursion over a sorted array. Instead of walking through all
the elements, each call discards half of the remaining range.

## What the program does

The function `binary_search_recursive` takes an array sorted in increasing order,
the bounds of the range and the searched value. It returns the index of the found
value, or `-1` if the value is not in the array.

The reference C++ version is:

```cpp
int binary_search_recursive(int *a, int left, int right, int x) {
    if (left > right) {
        return -1;
    }

    int middle = left + (right - left) / 2;
    if (a[middle] == x) {
        return middle;
    }
    if (a[middle] < x) {
        return binary_search_recursive(a, middle + 1, right, x);
    }
    return binary_search_recursive(a, left, middle - 1, x);
}
```

## Files

- `main.cpp` reads a sorted array and the searched value
- `binary_search_recursive.s` contains the ARM64 implementation of the function

## What to watch in the assembly

Four arguments arrive in `x0`, `w1`, `w2` and `w3`: the base of the array, the
left bound, the right bound and the searched value. The middle index is computed
without adding the two bounds before the division:

```asm
sub w4, w2, w1
asr w4, w4, #1
add w4, w1, w4
```

The element is fetched via the middle index, and the comparison decides which new
range goes into the recursive call:

```asm
ldr w5, [x0, w4, sxtw #2]
cmp w5, w3
```

The function does nothing with the obtained result after the recursive call, so it
is enough to leave it in `w0` and return.

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp binary_search_recursive.s -o binary_search_recursive
```

## Running

```sh
qemu-aarch64 ./binary_search_recursive
```

Example interaction:

```text
6
-5 1 4 8 12 20
12
4
```

## What to pay attention to

- we assume that the input array is sorted in increasing order
- the base case `left > right` returns `-1`
- the comparisons of elements and indices are signed, because the arguments are of
  type `int`
- the recursive call gets only the left or only the right half of the range

## Navigation

- Previous: [Recursive string reversal](../02-reverse_string_recursive/README.md)
- Next: [Count via a predicate function](../04-count_predicate/README.md)
- Up: [Practice exercises](../README.md)
