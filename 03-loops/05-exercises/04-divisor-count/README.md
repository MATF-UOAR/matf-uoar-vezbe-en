# Divisor count

This example combines a loop, the remainder of division, and one simple condition inside the loop body.

The `divisor_count` function returns the number of natural divisors of the number `n`. The goal is to reinforce:

- iterating over the whole interval `1..n`
- checking the condition `n % i == 0`
- keeping the original `n`, the current `i`, and the divisor counter separately

A reference C++ version of the function could look like this:

```cpp
unsigned divisor_count(unsigned n) {
    unsigned count = 0;
    for (unsigned i = 1; i <= n; i++) {
        if (n % i == 0) {
            count++;
        }
    }
    return count;
}
```

## Files

- `main.cpp` reads a number and prints the number of its divisors
- `divisor_count.s` contains the assembly implementation of the function

## Compilation

```sh
g++ main.cpp divisor_count.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
12
Divisor count: 6
```

## What to pay attention to

- we keep the original `n` separately, since `div` changes `eax` and `edx`
- inside the loop we have a small `if`: if the remainder is `0`, we increment the counter
- this version is intentionally simple and iterates over all numbers from `1` to `n`

## Navigation

- Previous: [Sum of digits](../03-sum-of-digits/README.md)
- Next: [LCM](../05-lcm/README.md)
