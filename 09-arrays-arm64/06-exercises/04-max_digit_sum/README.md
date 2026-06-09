# Largest digit sum

This example iterates over an array of `unsigned` numbers and returns the largest digit sum among the elements. It is a moderate extension: the outer loop iterates over the array, while the inner loop computes the digit sum of a single number.

## What the program does

The program reads the length of the array and the elements, calls `max_digit_sum`, and prints the largest digit sum.

The reference C++ function is:

```cpp
unsigned sum_of_digits(unsigned x) {
    unsigned sum = 0;
    while (x != 0) {
        sum += x % 10;
        x /= 10;
    }
    return sum;
}

unsigned max_digit_sum(unsigned* a, int n) {
    unsigned max_sum = 0;
    for (int i = 0; i < n; i++) {
        unsigned sum = sum_of_digits(a[i]);
        if (sum > max_sum) {
            max_sum = sum;
        }
    }
    return max_sum;
}
```

## What to watch for in the assembly

The outer loop reads one array element:

```asm
ldr w4, [x0, x3, lsl #2]
mov w5, #0
```

The inner loop extracts the last digit using `udiv` and `msub`, as in the tasks from the previous week:

```asm
udiv w6, w4, w10
msub w7, w6, w10, w4
add w5, w5, w7
mov w4, w6
```

When the digit sum of a single number is finished, we compare it with the largest one so far:

```asm
cmp w5, w2
csel w2, w5, w2, hi
```

Since the values are unsigned, the condition `hi` means the new sum is strictly larger.

## Files

- `main.cpp` reads the array of `unsigned` numbers and calls `max_digit_sum`
- `max_digit_sum.s` contains the ARM64 implementation of the function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp max_digit_sum.s -o max_digit_sum
```

## Running

```sh
qemu-aarch64 ./max_digit_sum
```

Example interaction:

```text
5
12 409 77 1000 95
14
```

## What to pay attention to

- the outer loop iterates over the array, and the inner loop over the digits of one number
- the number `0` has a digit sum of `0`
- `w10` keeps the constant `10`
- the function is a leaf function and so does not need a stack frame

## Navigation

- Previous: [Index of the maximum](../03-index_of_max/README.md)
- Up: [Exercises](../README.md)
