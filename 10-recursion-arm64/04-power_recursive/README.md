# Fast recursive power

This example introduces recursion through the fast exponentiation algorithm.
Instead of doing `n` multiplications for `a^n`, we halve the exponent at every
recursive step.

## What the program does

The function `power_recursive` computes `a^n` for `unsigned` values.

The reference C++ version is:

```cpp
unsigned power_recursive(unsigned a, unsigned n) {
    if (n == 0) {
        return 1;
    }

    unsigned p = power_recursive(a, n / 2);
    if (n % 2 == 0) {
        return p * p;
    }
    return a * p * p;
}
```

For an even exponent `a^n = (a^(n/2))^2` holds. For an odd exponent one more
factor `a` remains. This way the recursion depth and the number of
multiplications become `O(log n)` instead of `O(n)`.

## Files

- `main.cpp` reads the base and the exponent and prints the result
- `power_recursive.s` contains the ARM64 implementation of fast exponentiation

## What to watch in the assembly

The arguments `a` and `n` arrive in `w0` and `w1`. Since after the recursive call
`w0` holds the result `p`, and `w1` is no longer the old `n`, we save both
starting values that we might need into the stack frame:

```asm
str w0, [sp]
str w1, [sp, #4]
```

The base case `n == 0` returns `1`. In the recursive case we divide the exponent
by `2` with a logical shift right:

```asm
lsr w1, w1, #1
bl power_recursive
```

After returning, `w0` holds `p = a^(n / 2)`, so we first square the result:

```asm
mul w0, w0, w0
```

Then we check the lowest bit of the saved exponent. If `n` is odd, we multiply
the product by the base one more time:

```asm
ldr w1, [sp, #4]
tst w1, #1
b.eq end
ldr w1, [sp]
mul w0, w0, w1
```

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp power_recursive.s -o power_recursive
```

## Running

```sh
qemu-aarch64 ./power_recursive
```

Example interaction:

```text
3 5
3^5 = 243
```

## What to pay attention to

- the base case is `a^0 = 1`
- the recursive call gets `n / 2`, not `n - 1`
- `tst w1, #1` checks whether the saved exponent is odd
- the function saves `lr`, because it itself runs `bl`

## Navigation

- Previous: [Recursive array sum](../03-array_sum_recursive/README.md)
- Next: [Recursive palindrome](../05-is_palindrome_recursive/README.md)
- Up: [Week 10](../README.md)
