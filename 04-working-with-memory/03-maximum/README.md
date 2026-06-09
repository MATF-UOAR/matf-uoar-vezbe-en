# Array maximum

This example keeps the same pass over the array as in the previous task, but instead of a sum it maintains a running maximum.

## What the program does

The program reads the length of the array, then the elements, and prints the largest value.

A reference C++ function might look like this:

```cpp
int max(int* arr, int n) {
    if (n <= 0) {
        return 0;
    }

    int current_max = arr[0];
    for (int i = 1; i < n; i++) {
        if (current_max < arr[i]) {
            current_max = arr[i];
        }
    }
    return current_max;
}
```

In week 4 we assume the input array is non-empty, so the main idea of this example is choosing the initial value and updating it later. The assembly implementation nevertheless includes a short guard for `n <= 0` at the start.

## Files

- `main.cpp` reads the array and prints the maximum
- `max.s` iterates over the array and updates the running maximum

## What to watch for in the assembly

At the start we put `a[0]` into `r8d`, so that register represents the running maximum:

```asm
    mov r8d, [rdi]
```

In each iteration we load the next element:

```asm
    mov r9d, [rdi + 4*rcx]
```

Then we compare `current_max` and `a[i]`. If the new element is larger, we update the maximum:

```asm
    cmp r8d, r9d
    jg next
    mov r8d, r9d
```

It is important here that the elements are of type `int`, so we read the comparison as a signed comparison.

A short execution trace for the array `7 2 9 1 4` looks like this:

| Step | Current element | `current_max` after comparison |
| --- | --- | --- |
| start | `a[0] = 7` | `7` |
| `i = 1` | `2` | `7` |
| `i = 2` | `9` | `9` |
| `i = 3` | `1` | `9` |
| `i = 4` | `4` | `9` |

## Compilation

```sh
g++ main.cpp max.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
5
7 2 9 1 4
9
```

## What to pay attention to

- this example shows the typical pattern "take the first element as the initial value, then use the rest of the array to update it"
- in the explanation we assume `n > 0`, but the implementation still includes a short guard for `n <= 0`
- addressing an element is the same as in the sum example; the only new thing is the conditional updating of the result

## Navigation

- Previous: [Sum of array elements](../02-array-sum/README.md)
- Next: [Most frequent digit](../04-most-frequent-digit/README.md)
- Up: [Week 4](../README.md)
