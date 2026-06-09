# Mirroring bits

This example reverses the order of the significant bits of a number. Leading zeros are not taken into account.

## What the program does

The program reads an `unsigned n`, prints its binary representation, then calls `mirror` and prints the binary representation of the resulting number.

The reference C++ function is:

```cpp
unsigned mirror(unsigned n) {
    unsigned result = 0;
    while (n != 0) {
        result <<= 1;
        if (n & 1) {
            result++;
        }
        n >>= 1;
    }
    return result;
}
```

For example, `13` is `1101` in binary, and after mirroring the significant bits we get `1011`, that is, `11`.

## What to watch for in the assembly

The result is shifted left in each iteration:

```asm
lsl w1, w1, #1
```

We check the last bit of the input number with `tst`:

```asm
tst w0, #1
b.eq skip_one
add w1, w1, #1
```

At the end of the iteration we shift the input number right:

```asm
lsr w0, w0, #1
```

When `w0` becomes `0`, the result is in `w1`, and we move it into `w0` as the return value.

## Files

- `main.cpp` reads a number and prints the bits before and after the call to `mirror`
- `mirror.s` contains the ARM64 implementation of the `mirror` function
- `print_bits.s` is a helper function for printing the binary representation

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp mirror.s print_bits.s -o mirror
```

## Running

```sh
qemu-aarch64 ./mirror
```

Example interaction:

```text
13
1101
1011
```

## What to pay attention to

- `mirror` is a leaf function and does not use the stack
- `print_bits` is compiled together with the example because `main.cpp` uses both functions
- the number `0` stays `0`, so `0` is printed both before and after mirroring

## Navigation

- Previous: [Printing bits](../06-print_bits/README.md)
- Next: [Standalone mini-examples](../08-exercises/README.md)
- Up: [Week 8](../README.md)
