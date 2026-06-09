# Reversing an array

This example shows modifying an array "in place": the elements are not copied into a new array, but are changed directly at their existing addresses.

## What the program does

The program reads the length of the array and its elements, calls `reverse`, and then prints the elements in reverse order.

A reference C++ function might look like this:

```cpp
void reverse(int* arr, int n) {
    int i = 0;
    int j = n - 1;

    while (i < j) {
        int tmp = arr[i];
        arr[i] = arr[j];
        arr[j] = tmp;
        i++;
        j--;
    }
}
```

## Files

- `main.cpp` reads the array, calls `reverse`, and prints the result
- `reverse.s` implements the solution using the indices `i` and `j`
- `reverse_v2.s` implements the same idea using two addresses that move toward the middle

## What to watch for in the assembly

In the first version (`reverse.s`) we do the same thing as in C++:

- `ecx` plays the role of the index `i`
- `edx` plays the role of the index `j`
- access to elements uses the pattern `base + index * element_size`, here `[rdi + 4 * index]`

In the second version (`reverse_v2.s`) we do not keep indices, but ready-made addresses:

```asm
    mov rcx, rdi
    lea rdx, [rdi + 4*rsi - 4]
```

Then `rcx` points to the left end and `rdx` to the right end of the array. After each swap:

```asm
    add rcx, 4
    sub rdx, 4
```

This way the two addresses move toward each other.

In the version with addresses, the early exit for `n <= 1` is also important, so that the address `&a[n-1]` is not computed when there is nothing to reverse.

When we later compare `rcx` and `rdx`, we are comparing the addresses themselves. We read addresses as unsigned values, so we write the condition "the left address has reached the right one or has crossed past it" with the jump `jae`, not `jge`.

A short comparison of the two versions:

| Version | What we keep during the loop | How we reach an element |
| --- | --- | --- |
| index-based | the indices `i` and `j` | each time via `base + index * element_size` |
| address-based | the address of the left and the address of the right element | the addresses are computed once, then only moved by `4` bytes |

## Compilation

The version with indices:

```sh
g++ main.cpp reverse.s
```

The version with addresses:

```sh
g++ main.cpp reverse_v2.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
5
1 2 3 4 5
5 4 3 2 1 
```

## What to pay attention to

- both files do the same thing, but one uses indices and the other direct addresses
- this is a good example for comparing the "index-based" and "address-based" way of thinking
- swapping elements is the same idea as in `01-swap`, only now the addresses no longer arrive from outside, but we compute them ourselves from the array base

## Navigation

- Previous: [Most frequent digit](../04-most-frequent-digit/README.md)
- Next: [Standalone mini-examples](../06-exercises/README.md)
- Up: [Week 4](../README.md)
