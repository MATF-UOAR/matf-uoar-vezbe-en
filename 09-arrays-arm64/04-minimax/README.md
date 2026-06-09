# Minimum and maximum of `short` values

This example iterates over an array of `short` values only once, but computes two values: the minimum and the maximum. Since the function needs to return two results, it writes them through references.

## What the program does

The program reads the length of the array, then the elements, calls `minimax`, and prints the minimum and the maximum.

The reference C++ function is:

```cpp
void minimax(short* a, int n, short& pmin, short& pmax) {
    short minimum = a[0];
    short maximum = a[0];

    for (int i = 1; i < n; i++) {
        if (a[i] < minimum) {
            minimum = a[i];
        }
        if (a[i] > maximum) {
            maximum = a[i];
        }
    }

    pmin = minimum;
    pmax = maximum;
}
```

We assume that `n > 0`, because the function takes its initial values from `a[0]`.

## Files

- `main.cpp` reads the array, calls `minimax`, and prints the resulting values
- `minimax.s` contains the ARM64 implementation of the function

## What to watch for in the assembly

The function signature is:

```cpp
void minimax(short* a, int n, short& pmin, short& pmax);
```

At the level of the calling convention, references are addresses. That is why the arguments arrive like this:

- `x0` is the address of the first array element
- `w1` is the number of elements
- `x2` is the address where the minimum should be written
- `x3` is the address where the maximum should be written

The function reads the first element and uses it as both initial values:

```asm
ldrsh w4, [x0], #2
mov w5, w4
```

The `ldrsh` instruction reads a `short` that is `2` bytes wide and sign-extends it into a `w` register. This way the comparisons work correctly even for negative values, while the offset `#2` advances the pointer to the next array element.

In the loop each subsequent element is compared with the current minimum and maximum:

```asm
ldrsh w6, [x0], #2
cmp w6, w4
csel w4, w6, w4, lt
cmp w6, w5
csel w5, w6, w5, gt
```

At the end the results are written to memory:

```asm
strh w4, [x2]
strh w5, [x3]
```

The function therefore has no meaningful return value in `w0`; the result is the change of the contents at the addresses `x2` and `x3`.

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp minimax.s -o minimax
```

## Running

```sh
qemu-aarch64 ./minimax
```

Example interaction:

```text
5
7 2 9 1 4
1 9
```

## What to pay attention to

- C++ references arrive in the assembly as addresses
- `ldrsh` loads a two-byte `short` and preserves its sign in a `w` register
- `strh w4, [x2]` writes a two-byte `short` to the result address
- a single pass through the array updates both the minimum and the maximum
- the example assumes a non-empty array
- the function is a leaf function and so does not need a stack frame

## Navigation

- Previous: [Minimum of an array of `unsigned long` values](../03-min_long/README.md)
- Next: [String length](../05-string_length/README.md)
- Up: [Week 9](../README.md)
