# Factorial

This is the first ARM64 example with a loop this week. The function `factorial` takes one `unsigned` number and returns `n!`.

The reference C++ version of the iterative function is:

```cpp
unsigned factorial(unsigned n) {
    unsigned result = 1;
    for (unsigned i = 1; i <= n; i++) {
        result *= i;
    }
    return result;
}
```

## What to watch for in the assembly

The argument `n` arrives in `w0`, but we also need `w0` as the register for the return value. So at the start we copy it into `w2`, and place the accumulator in `w0`:

```asm
mov w2, w0
mov w0, #1
mov w1, #1
```

The condition `i <= n` is written as exiting the loop when `i > n`:

```asm
cmp w1, w2
b.hi loop_end
```

Since the values are `unsigned`, we use the unsigned condition `b.hi`.

The multiplication itself is done with the `mul` instruction:

```asm
mul w0, w0, w1
```

This instruction keeps the lower 32 bits of the product when working with `w` registers. For that lower part of the result there is no difference between signed and unsigned multiplication. The difference becomes important when we need the upper half of the product: for unsigned values there is `umulh`, and for signed values `smulh`.

## Recursive variant

The directory also contains `factorial_recursive.s`. It is not the main example for this week, but it is useful as a comparison with the later examples on calls and recursion. Both files define the same function `factorial`, so when compiling you pick one of them.

## Files

- `main.cpp` reads a number and prints `n!`
- `factorial.s` contains the iterative ARM64 implementation
- `factorial_recursive.s` contains the recursive variant of the same function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp factorial.s -o factorial
```

The recursive variant:

```sh
aarch64-linux-gnu-g++ main.cpp factorial_recursive.s -o factorial
```

## Running

```sh
qemu-aarch64 ./factorial
```

Example interaction:

```text
5
5! = 120
```

## What to pay attention to

- `0!` is `1`, so the accumulator starts from `1`
- `mul w0, w0, w1` multiplies the current result by the loop counter
- the iterative version is a leaf function and therefore does not need a stack frame

## Navigation

- Previous: [Week 8](../README.md)
- Next: [GCD](../02-gcd/README.md)
- Up: [Week 8](../README.md)
