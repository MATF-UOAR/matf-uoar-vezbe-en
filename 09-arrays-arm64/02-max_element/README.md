# Maximum of an array

This example keeps the pass through the array from the previous task, but instead of a sum it maintains a running maximum.

## What the program does

The program reads the length of the array, then the elements, calls `max_element`, and prints the largest value.

The reference C++ function is:

```cpp
int max_element(int* a, int n) {
    int maximum = a[0];
    for (int i = 1; i < n; i++) {
        if (a[i] > maximum) {
            maximum = a[i];
        }
    }
    return maximum;
}
```

We assume that `n > 0`, because the function takes its initial value from `a[0]`.

## Files

- `main.cpp` reads the array and calls `max_element`
- `max_v1.s` iterates over the array using an index
- `max_v2.s` iterates over the array by advancing a pointer

Both assembly files define the same symbol, so only one version is compiled at a time.

## What to watch for in the assembly

The first version reads `a[0]` as the initial maximum, and then starts from index `1`:

```asm
ldr w2, [x0]
mov w3, #1
```

In the body of the loop the element is read through the base, the index, and the element size:

```asm
ldr w4, [x0, x3, lsl #2]
```

After the comparison it uses `csel`, a conditional select:

```asm
cmp w4, w2
csel w2, w4, w2, gt
```

If the new element is larger, `w4` goes into `w2`; otherwise `w2` stays the same.

The second version reads the first element without advancing the pointer:

```asm
ldr w2, [x0]
```

Then each iteration first advances the pointer to the next element and reads it using the pre-index form:

```asm
ldr w3, [x0, #4]!
```

## Compilation

The index version:

```sh
aarch64-linux-gnu-g++ main.cpp max_v1.s -o max_element
```

The pointer-advancing version:

```sh
aarch64-linux-gnu-g++ main.cpp max_v2.s -o max_element
```

## Running

```sh
qemu-aarch64 ./max_element
```

Example interaction:

```text
5
7 2 9 1 4
9
```

## What to pay attention to

- the initial maximum is `a[0]`, so this example assumes a non-empty array
- `csel` avoids a separate branch for updating the maximum
- `gt` is a signed comparison, because the elements are of type `int`
- the second version is a good example of when the counter only serves to tell us how many elements remain
- both versions are leaf functions and so do not need a stack frame

## Navigation

- Previous: [Sum of array elements](../01-array_sum/README.md)
- Next: [Minimum of an array of `unsigned long` values](../03-min_long/README.md)
- Up: [Week 9](../README.md)
