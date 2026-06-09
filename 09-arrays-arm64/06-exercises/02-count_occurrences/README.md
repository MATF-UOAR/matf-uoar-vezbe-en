# Count of occurrences

This example counts how many times the value `x` appears in an array. Unlike linear search, we do not leave the loop when we first find `x`; instead we have to go through the whole array.

## What the program does

The program reads the length of the array, the array elements, and the value `x`, then calls `count_occurrences` and prints the number of occurrences.

The reference C++ function is:

```cpp
int count_occurrences(int* a, int n, int x) {
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (a[i] == x) {
            count++;
        }
    }
    return count;
}
```

## What to watch for in the assembly

The index is in `w4`, and the number of occurrences is in `w3`:

```asm
mov w3, #0
mov w4, #0
```

We read each element with the same pattern as in the basic sum example:

```asm
ldr w5, [x0, x4, lsl #2]
```

If the element is not equal to the value being searched for, we simply continue the loop. If it is, we increment the counter:

```asm
cmp w5, w2
b.ne continue
add w3, w3, #1
```

## Files

- `main.cpp` reads the array and the value being searched for, and calls `count_occurrences`
- `count_occurrences.s` contains the ARM64 implementation of the function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp count_occurrences.s -o count_occurrences
```

## Running

```sh
qemu-aarch64 ./count_occurrences
```

Example interaction:

```text
7
3 1 3 2 3 4 1
3
3
```

## What to pay attention to

- the loop always goes through the whole array
- the return value is the counter in `w0`
- if the value does not appear, the result is `0`
- the function is a leaf function and so does not need a stack frame

## Navigation

- Previous: [Linear search](../01-linear_search/README.md)
- Next: [Index of the maximum](../03-index_of_max/README.md)
- Up: [Exercises](../README.md)
