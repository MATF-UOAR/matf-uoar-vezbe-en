# Sum of digits

This example combines the idea of the `while` loop from `gcd` with division and the remainder of division.

The `sum_of_digits` function returns the sum of all digits of the number `n`. The goal is to reinforce:

- a `while (n != 0)` loop
- repeated use of `div` with a divisor of `10`
- extracting the last digit via the remainder in `edx`

A reference C++ version of the function could look like this:

```cpp
unsigned sum_of_digits(unsigned n) {
    unsigned sum = 0;
    while (n != 0) {
        sum += n % 10;
        n /= 10;
    }
    return sum;
}
```

## Files

- `main.cpp` reads a number and prints the sum of its digits
- `sum_of_digits.s` contains the assembly implementation of the function

## Compilation

```sh
g++ main.cpp sum_of_digits.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
50271
Sum of digits: 15
```

## What to pay attention to

- before each `div` we rebuild the dividend in `edx:eax`
- the last digit arrives as the remainder in `edx`
- for `n = 0` the loop does not execute even once and the result remains `0`

## Navigation

- Previous: [Power](../02-power/README.md)
- Next: [Divisor count](../04-divisor-count/README.md)
