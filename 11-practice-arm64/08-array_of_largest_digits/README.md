# Array of largest digits

In assembly, implement a function that, for each element of the array `a`,
writes its largest digit into the array `res`. This task uses the helper
function `largest_digit` from the first task.

Reference C++ version:

```cpp
unsigned largest_digit(unsigned n);

void array_of_largest_digits(unsigned *a, unsigned *res, int n) {
    for (int i = 0; i < n; i++) {
        res[i] = largest_digit(a[i]);
    }
}
```

## Files

- `main.cpp` reads an array, calls the function, and prints the result
- `array_of_largest_digits.s` contains the main ARM64 function
- `largest_digit.s` contains the helper function (from task 01)

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp array_of_largest_digits.s largest_digit.s -o array_of_largest_digits
```

## Running

```sh
qemu-aarch64 ./array_of_largest_digits
```

Example:

```text
5
45316 297 8 1234 90
6 9 8 4 9
```

## What to pay attention to

- `array_of_largest_digits` does `bl largest_digit` inside the loop, so it must
  save `lr`
- the pointers `a` and `res`, the length `n`, and the counter `i` must survive
  the call, so they are kept in callee-saved registers
- the element `a[i]` is passed in `w0`, and the result of the call is written
  into `res[i]`

## Navigation

- Previous: [Array range](../07-array_range/README.md)
- Next: [Recursive count of ones](../09-count_ones_recursive/README.md)
- Up: [Week 11](../README.md)
