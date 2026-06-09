# Swapping the minimum and maximum

This is a good final mini-task for this week, since it combines ideas from the `Array maximum` and `Swapping two values` examples.

The function `swap_min_and_max` finds the positions of the minimum and maximum elements, and then swaps those two values within the array itself. The goal is to reinforce:

- remembering the indices of the smallest and largest element
- traversing the array with several conditional updates
- later modifying memory at the found positions

A reference C++ version of the function might look like this:

```cpp
void swap_min_and_max(int* arr, int n) {
    if (n <= 1) {
        return;
    }

    int i_min = 0;
    int i_max = 0;

    for (int i = 1; i < n; i++) {
        if (arr[i] < arr[i_min]) {
            i_min = i;
        }
        if (arr[i] > arr[i_max]) {
            i_max = i;
        }
    }

    int tmp = arr[i_min];
    arr[i_min] = arr[i_max];
    arr[i_max] = tmp;
}
```

## Files

- `main.cpp` reads the array, calls `swap_min_and_max`, and prints the modified array
- `swap_min_and_max.s` contains the assembly implementation of the function

## What to watch for in the assembly

This task has two clear phases.

In the first phase the loop remembers the indices of the minimum and maximum:

```asm
    cmp eax, r10d
    jge check_maximum

    cmp eax, r11d
    jle next
```

In the second phase, once both positions are already known, we perform one classic value swap at the found addresses:

```asm
    mov eax, [rdi + 4*r8]
    mov edx, [rdi + 4*r9]
    mov [rdi + 4*r8], edx
    mov [rdi + 4*r9], eax
```

## Compilation

```sh
g++ main.cpp swap_min_and_max.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
5
4 -2 7 0 3
4 7 -2 0 3 
```

## What to pay attention to

- if `n <= 1`, there is nothing to swap and the function exits immediately
- with the strict comparisons `<` and `>`, the first occurrences of the minimum and maximum are the ones remembered
- the swap itself happens only after the pass over the array, once both positions are already known
- this is a good mini-task to see how a single loop can prepare data for a later modification of memory

## Navigation

- Previous: [Dot product](../03-dot_product/README.md)
- Up: [Standalone mini-examples](../README.md)
