# Linear search

This example looks for the first occurrence of a value in an array. If the value exists, the function returns its index; if it does not exist, it returns `-1`.

## What the program does

The program reads the length of the array, the array elements, and the value `x`, then calls `linear_search` and prints the returned index.

The reference C++ function is:

```cpp
int linear_search(int* a, int n, int x) {
    for (int i = 0; i < n; i++) {
        if (a[i] == x) {
            return i;
        }
    }
    return -1;
}
```

## What to watch for in the assembly

The arguments arrive in:

- `x0`: the address of the first element
- `w1`: the number of elements
- `w2`: the value being searched for

We keep the index `i` in `w3`, and read an element through the base, the index, and the scale:

```asm
ldr w4, [x0, x3, lsl #2]
```

When an element equals the value being searched for, we leave the function immediately:

```asm
cmp w4, w2
b.eq found
```

If the loop reaches the end, we write `-1` into `w0`.

## Files

- `main.cpp` reads the array and the value being searched for, and calls `linear_search`
- `linear_search.s` contains the ARM64 implementation of the function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp linear_search.s -o linear_search
```

## Running

```sh
qemu-aarch64 ./linear_search
```

Example interaction:

```text
5
7 2 9 1 4
9
2
```

## What to pay attention to

- this is a leaf function and so does not need a stack frame
- the return value is the index in `w0`
- `-1` is the convention for "the searched value was not found"
- the search does not require the array to be sorted

## Navigation

- Previous: [Exercises](../README.md)
- Next: [Count of occurrences](../02-count_occurrences/README.md)
- Up: [Exercises](../README.md)
