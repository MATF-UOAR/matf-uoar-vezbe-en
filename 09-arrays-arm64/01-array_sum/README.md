# Sum of array elements

This is the first example in the week. The function iterates over an array of `int` values and returns their sum. The directory contains four assembly versions of the same function, so that different addressing styles can be compared.

## What the program does

The program reads the length of the array, then its elements, calls `array_sum`, and prints the sum.

The reference C++ function is:

```cpp
int array_sum(int* a, int n) {
    int sum = 0;
    for (int i = 0; i < n; i++) {
        sum += a[i];
    }
    return sum;
}
```

## Files

- `main.cpp` reads the array and calls `array_sum`
- `array_sum_v1.s` uses the base address, an index, and a scale
- `array_sum_v2.s` uses pre-index addressing
- `array_sum_v3.s` uses post-index addressing
- `array_sum_v4.s` uses post-index addressing and the count of remaining elements, without a separate index

All assembly files define the same function `array_sum`, so one of them is chosen at compile time.

## What to watch for in the assembly

In the first version the array base is in `x0`, the index is in `w3`, and an element is read like this:

```asm
ldr w4, [x0, x3, lsl #2]
```

Since the element is of type `int`, the element size is `4` bytes. That is why `lsl #2` multiplies the index by `4`.

The second version moves the pointer back by one element:

```asm
sub x0, x0, #4
ldr w4, [x0, #4]!
```

The `!` sign means that the updated address is written back into `x0`. After the read, `x0` already points to the element that was just read.

The third version uses the post-index form:

```asm
ldr w4, [x0], #4
```

First the element at the address `x0` is read, and then `x0` is advanced by `4` bytes, to the next element.

The fourth version keeps the post-index read but avoids a separate index `i`. Instead it uses `w1` as the number of elements that remain:

```asm
cmp w1, #0
b.le end_loop
ldr w3, [x0], #4
sub w1, w1, #1
```

This version is closest to the idea of "read the next element as long as there are any".

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp array_sum_v1.s -o array_sum
```

The other versions are compiled by replacing the name of the assembly file:

```sh
aarch64-linux-gnu-g++ main.cpp array_sum_v2.s -o array_sum
aarch64-linux-gnu-g++ main.cpp array_sum_v3.s -o array_sum
aarch64-linux-gnu-g++ main.cpp array_sum_v4.s -o array_sum
```

## Running

```sh
qemu-aarch64 ./array_sum
```

Example interaction:

```text
5
1 2 -3 4 5
9
```

## What to pay attention to

- `w2` is the accumulator for the sum
- in the index version the base stays in `x0` and the index changes
- in the pointer-advancing versions the address in `x0` itself changes
- the post-index form is natural when we read the array in order, element by element
- all versions are leaf functions and so do not need a stack frame

## Navigation

- Previous: [Week 9](../README.md)
- Next: [Maximum of an array](../02-max_element/README.md)
- Up: [Week 9](../README.md)
