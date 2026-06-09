# Replace the largest digit

In assembly, implement a function that returns the number obtained by replacing
all occurrences of the largest digit of the number `n` with the digit `c`. This
task uses the helper function `largest_digit`.

Reference C++ version:

```cpp
unsigned largest_digit(unsigned n);

unsigned replace_largest_digit(unsigned n, unsigned c) {
    unsigned max = largest_digit(n);
    if (n == 0) {
        return c;
    }

    unsigned result = 0;
    unsigned position = 1;
    while (n != 0) {
        unsigned digit = n % 10;
        if (digit == max) {
            digit = c;
        }
        result += digit * position;
        position *= 10;
        n /= 10;
    }
    return result;
}
```

## Files

- `main.cpp` reads a number `n` and a digit `c`
- `replace_largest_digit.s` contains the main ARM64 function
- `largest_digit.s` contains the helper function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp replace_largest_digit.s largest_digit.s -o replace_largest_digit
```

## Running

```sh
qemu-aarch64 ./replace_largest_digit
```

Example:

```text
297693 4
247643
```

## What to pay attention to

- `replace_largest_digit` does `bl largest_digit`, so it must save `lr`
- the original number and the digit `c` must survive the call to the helper
  function
- the number is built from the last digit to the first using the variable
  `position`

## Navigation

- Previous: [Word count](../05-word_count/README.md)
- Next: [Array range](../07-array_range/README.md)
- Up: [Week 11](../README.md)
