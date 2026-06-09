# Count via a predicate function

This example is a continuation of the `find_first` function: the address of the
condition is still passed as an argument and called with the `blr` instruction,
but now we walk through the whole array and count all the matches.

## What the program does

The function `count_predicate` returns the number of elements of the array for
which the predicate function returns a nonzero value.

The reference C++ version is:

```cpp
int count_predicate(unsigned *a, int n, int (*pred)(unsigned)) {
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (pred(a[i])) {
            count++;
        }
    }
    return count;
}
```

## Files

- `main.cpp` reads an array and calls the function with the conditions `is_even` and `greater_than_99`
- `count_predicate.s` contains the ARM64 implementation of the function

## What to watch in the assembly

As in the main example `find_first`, the array, the length, the index and the
address of the predicate function must survive every indirect call. What is new is
that the match counter must also stay in the stack frame:

```asm
str x0, [sp]
str x2, [sp, #8]
str w1, [sp, #16]
str wzr, [sp, #20]
str wzr, [sp, #24]
```

For each element the same indirect call is made:

```asm
ldr w0, [x4, w3, sxtw #2]
ldr x8, [sp, #8]
blr x8
```

If the obtained value is nonzero, the counter is incremented, but the loop does
not stop as in `find_first`.

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp count_predicate.s -o count_predicate
```

## Running

```sh
qemu-aarch64 ./count_predicate
```

Example interaction:

```text
6
11 15 18 21 130 7
evens: 2
> 99: 1
```

## What to pay attention to

- `blr` calls the predicate function whose address arrived as an argument
- the result counter must survive every call
- unlike `find_first`, the function continues to the end of the array even after a match

## Navigation

- Previous: [Recursive binary search](../03-binary_search_recursive/README.md)
- Up: [Practice exercises](../README.md)
