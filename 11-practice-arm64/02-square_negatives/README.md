# Square the negative elements

In assembly, implement a function that squares all negative elements of an
array of integers. The array is modified in place.

Reference C++ version:

```cpp
void square_negatives(int *a, int n) {
    for (int i = 0; i < n; i++) {
        if (a[i] < 0) {
            a[i] *= a[i];
        }
    }
}
```

## Files

- `main.cpp` reads an array, calls the function, and prints the modified array
- `square_negatives.s` contains the ARM64 implementation of the function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp square_negatives.s -o square_negatives
```

## Running

```sh
qemu-aarch64 ./square_negatives
```

Example:

```text
6
3 4 -1 2 -5 3
3 4 1 2 25 3
```

## What to pay attention to

- an array element is read using the base and the index: `a + i * 4`
- the comparison with zero is signed, since the elements are of type `int`
- the function has no return value; instead it writes new values into memory

## Navigation

- Previous: [Largest digit](../01-largest_digit/README.md)
- Next: [Dot product](../03-dot_product/README.md)
- Up: [Week 11](../README.md)
