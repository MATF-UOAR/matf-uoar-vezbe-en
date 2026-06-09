# Minimum

This is the most natural counterpart of the `Array maximum` example: the loop structure is almost the same, except that now we look for the smallest element.

The function `minimum` takes an array and its length and returns the smallest element of the array. The goal is to reinforce:

- initializing the running result with the first element
- conditional updating when we encounter a smaller value
- the special case of an empty array

A reference C++ version of the function might look like this:

```cpp
int minimum(int* arr, int n) {
    if (n <= 0) {
        return 0;
    }

    int min = arr[0];
    for (int i = 1; i < n; i++) {
        if (arr[i] < min) {
            min = arr[i];
        }
    }
    return min;
}
```

## Files

- `main.cpp` reads the array and prints its minimum
- `minimum.s` contains the assembly implementation of the function

## What to watch for in the assembly

This is almost the same pattern as in `Array maximum`: first we take `a[0]` as the running result, then we traverse the rest of the array.

```asm
    mov r8d, [rdi]
    mov r9d, [rdi + 4*rcx]
```

The only difference is the direction of the comparison: here we update the running minimum when we encounter a smaller element.

## Compilation

```sh
g++ main.cpp minimum.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
5
4 -2 7 0 3
-2
```

## What to pay attention to

- in the material we assume `n > 0`, and this implementation additionally has a short guard for `n <= 0`
- the initial minimum is `arr[0]`, so the loop starts at `i = 1`
- since we work with the type `int`, the comparison should be signed

## Navigation

- Previous: [Count of positives](../01-count_positives/README.md)
- Next: [Dot product](../03-dot_product/README.md)
