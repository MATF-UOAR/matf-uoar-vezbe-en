# Prime number

This example checks whether a number is prime. It is good as an additional exercise for the `for` loop, an early return from a function, and computing the remainder with `udiv` and `msub`.

The directory also contains a second variant that uses the Euler function we wrote earlier.

## What the program does

The program reads an `unsigned n` and prints whether the number is prime.

The reference C++ function is:

```cpp
unsigned is_prime(unsigned n) {
    if (n < 2) {
        return 0;
    }

    for (unsigned d = 2; d < n; d++) {
        if (n % d == 0) {
            return 0;
        }
    }

    return 1;
}
```

## What to watch for in the assembly

The numbers `0` and `1` are not prime, so we separate them out right away:

```asm
cmp w0, #2
b.hs check_divisors

mov w0, #0
ret
```

The loop checks divisors `d` from `2` up to `n - 1`. The condition `d < n` is written as exiting the loop when `d >= n`:

```asm
cmp w2, w1
b.hs is_prime_label
```

As in the `gcd` example, we obtain the remainder of a division through the quotient:

```asm
udiv w3, w1, w2
msub w4, w3, w2, w1
```

If the remainder is `0`, we have found a divisor and the function returns `0` immediately:

```asm
cmp w4, #0
b.eq not_prime
```

## Variant using Euler

For `n > 1` it holds that a number is prime if and only if `euler(n) = n - 1`. So the second variant checks the condition:

```cpp
unsigned is_prime(unsigned n) {
    if (n < 2) {
        return 0;
    }

    return euler(n) + 1 == n;
}
```

Since `is_prime_via_euler.s` calls the `euler` function, it must save `lr`, and it must also save the original `n`, because the return value from `euler` comes back in `w0`:

```asm
sub sp, sp, #16
str w0, [sp]

bl euler

ldr w1, [sp]
add sp, sp, #16
```

After the call, `euler(n) + 1` is compared with the saved `n`:

```asm
add w0, w0, #1
cmp w0, w1
b.eq is_prime_label
```

## Files

- `main.cpp` reads a number and prints whether it is prime
- `is_prime.s` contains the direct ARM64 implementation of the `is_prime` function
- `is_prime_via_euler.s` contains the variant that calls `euler`

Both `.s` files define the function `is_prime`, so when compiling you pick one of them.

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp is_prime.s -o is_prime
```

The variant using the Euler function:

```sh
aarch64-linux-gnu-g++ main.cpp is_prime_via_euler.s ../03-euler/euler.s ../03-euler/gcd.s -o is_prime
```

## Running

```sh
qemu-aarch64 ./is_prime
```

Example interaction:

```text
17
Number is prime
```

## What to pay attention to

- the direct variant `is_prime.s` is a leaf function and therefore does not need a stack frame
- `b.hs` matches the unsigned comparison `d >= n`
- the example has an early exit from the loop body when a divisor is found
- the variant using Euler is not a leaf function, since it does `bl euler`

## Navigation

- Previous: [Euler](../03-euler/README.md)
- Next: [Secret](../05-secret/README.md)
- Up: [Week 8](../README.md)
