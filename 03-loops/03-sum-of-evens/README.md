# Sum of even numbers

This example adds up all even numbers from `1` to `n` and serves as an introduction to the `test` and `loop` instructions.

## What the program does

The program reads an `unsigned` number `n` and prints the sum of all even numbers in the interval `1..n`.

A reference C++ function could look like this:

```cpp
unsigned sum_of_evens(unsigned n) {
    unsigned s = 0;
    for (unsigned i = 1; i <= n; i++) {
        if (i % 2 == 0) {
            s += i;
        }
    }
    return s;
}
```

In this folder there are two assembly versions of the same function:

- `sum_of_evens_for.s` is an implementation similar to the `for`-loop implementation from the [second task](../02-sum/README.md)
- `sum_of_evens_loop.s` is an implementation of the same function using the `loop` instruction

## Version 1: classic loop

In the first version we go from `1` to `n`, as in the C++ code:

```asm
    xor eax, eax
    mov ecx, 1

for_loop:
    cmp edi, ecx
    jb  for_loop_end
```

We do not have to check parity by division, since it depends only on the lowest bit: for an even number it is `0`, and for an odd number it is `1`. That is why we use the `test` instruction here, which lets us check that with a bitwise operation:

```asm
    test ecx, 1
    jnz continue
    add eax, ecx
```

## Version 2: the `loop` instruction

The second version follows the idea:

```cpp
unsigned sum_of_evens(unsigned n) {
    unsigned s = 0;
    unsigned i = n;

    if (i == 0) {
        return 0;
    }

    do {
        if ((i & 1) == 0) {
            s += i;
        }
        i--;
    } while (i != 0);

    return s;
}
```

In assembly that looks like this:

```asm
    xor eax, eax
    mov ecx, edi
    test ecx, ecx
    je end

do_while_loop:
    test ecx, 1
    jnz continue
    add eax, ecx

continue:
    loop do_while_loop
```

The `loop` instruction is a shorthand for:

1. decrement `ecx`
2. if `ecx != 0`, jump back

That is why it is natural for this kind of descending loop. An important detail is the initial check `n == 0`: without it, `loop` would produce wrong behavior for zero, because after the decrement the counter would wrap around to a large unsigned value.

## Files

- `main.cpp` reads a number and calls `sum_of_evens`
- `sum_of_evens_for.s` contains the classic version with an explicit loop-condition check
- `sum_of_evens_loop.s` contains the descending do-while-style variant with `loop`

## Compilation

For the classic version:

```sh
g++ main.cpp sum_of_evens_for.s
```

For the `loop` version:

```sh
g++ main.cpp sum_of_evens_loop.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
10
30
```

## What to pay attention to

- `test reg, 1` is a convenient way to check whether a number is even
- `loop` implicitly uses the counter in `ecx`, so it is suitable only when that register is free for us to use
- a do-while-style loop naturally starts from the body, but with an `unsigned` counter we must pay special attention to the case `n = 0`

## Navigation

- Previous: [Sum](../02-sum/README.md)
- Next: [Euler](../04-euler/README.md)
- Up: [Week 3](../README.md)
