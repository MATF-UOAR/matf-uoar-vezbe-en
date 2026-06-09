# Count of ones

This example counts how many ones there are in the binary representation of a number.

The function `count_ones` returns the number of set bits in the `unsigned` number `n`.

The reference C++ version of the function is:

```cpp
unsigned count_ones(unsigned n) {
    unsigned count = 0;
    while (n != 0) {
        if (n & 1) {
            count++;
        }
        n >>= 1;
    }
    return count;
}
```

## What to watch for in the assembly

We check the last bit with the `tst` instruction:

```asm
tst w0, #1
b.eq skip
add w1, w1, #1
```

After the check we shift the number right, so the next bit comes to the last position:

```asm
lsr w0, w0, #1
```

The loop ends when the number becomes `0`.

## Files

- `main.cpp` reads a number and prints the number of ones in the binary representation
- `count_ones.s` contains the ARM64 implementation of the function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp count_ones.s -o count_ones
```

## Running

```sh
qemu-aarch64 ./count_ones
```

Example interaction:

```text
13
Count of ones: 3
```

## What to pay attention to

- `13` is `1101` in binary, so it has three ones
- `tst w0, #1` checks only the lowest bit
- this example is close to the `print_bits` and `mirror` examples, but it does not call `putchar`

## Navigation

- Previous: [Sum of digits](../02-sum_of_digits/README.md)
- Next: [Divisor count](../04-divisor_count/README.md)
- Up: [Standalone mini-examples](../README.md)
