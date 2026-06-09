# Sum of digits

This example combines a `while` loop with the ARM64 way of computing the remainder of a division.

The function `sum_of_digits` returns the sum of all digits of the number `n`.

The reference C++ version of the function is:

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

## What to watch for in the assembly

We keep the divisor `10` in a separate register:

```asm
mov w10, #10
```

In each iteration we obtain the quotient with the `udiv` instruction, and the remainder with the `msub` instruction:

```asm
udiv w2, w0, w10
msub w3, w2, w10, w0
```

After that we add the remainder to the sum, and replace the number with the quotient:

```asm
add w1, w1, w3
mov w0, w2
```

## Files

- `main.cpp` reads a number and prints the sum of its digits
- `sum_of_digits.s` contains the ARM64 implementation of the function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp sum_of_digits.s -o sum_of_digits
```

## Running

```sh
qemu-aarch64 ./sum_of_digits
```

Example interaction:

```text
50271
Sum of digits: 15
```

## What to pay attention to

- for `n = 0` the loop does not run and the result stays `0`
- `w0` gradually becomes `n / 10`, so the original number is not preserved
- the `udiv` + `msub` pattern is the same as in the `gcd`, `secret` and `is_prime` examples

## Navigation

- Previous: [Power](../01-power/README.md)
- Next: [Count of ones](../03-count_ones/README.md)
- Up: [Standalone mini-examples](../README.md)
