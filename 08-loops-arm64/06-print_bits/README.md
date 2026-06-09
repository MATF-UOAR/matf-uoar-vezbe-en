# Printing bits

This example prints the binary representation of a number without leading zeros. For `0` a single zero is printed.

## What the program does

The program reads an `unsigned n` and calls the `print_bits` function, which prints the bits of the number using the library function `putchar`.

A reference C++ version of the function could look like this:

```cpp
void print_bits(unsigned n) {
    if (n == 0) {
        putchar('0');
        return;
    }

    unsigned mask = 1u << 31;
    while (mask > n) {
        mask >>= 1;
    }

    while (mask != 0) {
        putchar((n & mask) == 0 ? '0' : '1');
        mask >>= 1;
    }
}
```

## What to watch for in the assembly

The mask starts from the highest bit of the 32-bit number:

```asm
mov w1, #1
lsl w1, w1, #31
```

While the mask is greater than the number, we skip the leading zeros:

```asm
cmp w1, w0
b.hi continue_loop
```

When we need to print a single bit, we test it with the `tst` instruction:

```asm
tst w0, w1
csel w0, w2, w3, eq
bl putchar
```

`w2` holds the character `'0'`, and `w3` the character `'1'`. The `csel` instruction selects what goes into `w0`, that is, what the argument for `putchar` will be. As with other function calls, the first argument goes in `w0`, and the return value would also come back in `w0`.

## Saving values before `putchar`

Since `w0` and `w1` are part of the `caller-saved` registers, `putchar` is allowed to overwrite them. So before the call we save the number and the mask on the stack:

```asm
sub sp, sp, #16
str w0, [sp]
str w1, [sp, #4]
```

After `bl putchar` the values are restored and the loop continues.

## Files

- `main.cpp` reads a number and calls `print_bits`
- `print_bits.s` contains the ARM64 implementation of the function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp print_bits.s -o print_bits
```

## Running

```sh
qemu-aarch64 ./print_bits
```

Example interaction:

```text
13
1101
```

## What to pay attention to

- `tst w0, w1` checks whether the current bit is set
- `csel` allows choosing between `'0'` and `'1'` without an extra branch
- the stack stays aligned to `16` bytes before the call to `putchar`

## Navigation

- Previous: [Secret](../05-secret/README.md)
- Next: [Mirroring bits](../07-mirror/README.md)
- Up: [Week 8](../README.md)
