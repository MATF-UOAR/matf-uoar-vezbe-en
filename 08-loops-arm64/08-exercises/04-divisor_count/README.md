# Divisor count

This example combines a loop, the remainder of a division, and one simple condition inside the loop body.

The function `divisor_count` returns the number of natural divisors of the number `n`.

The reference C++ version of the function is:

```cpp
unsigned divisor_count(unsigned n) {
    unsigned count = 0;
    for (unsigned d = 1; d <= n; d++) {
        if (n % d == 0) {
            count++;
        }
    }
    return count;
}
```

## What to watch for in the assembly

We keep the original number in `w1`, since we use `w0` as the divisor counter:

```asm
mov w1, w0
mov w0, #0
mov w2, #1
```

The condition `d <= n` is written as exiting when `d > n`:

```asm
cmp w2, w1
b.hi loop_end
```

We check divisibility through the remainder:

```asm
udiv w3, w1, w2
msub w4, w3, w2, w1

cmp w4, #0
b.ne continue_loop
add w0, w0, #1
```

## Files

- `main.cpp` reads a number and prints the number of its divisors
- `divisor_count.s` contains the ARM64 implementation of the function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp divisor_count.s -o divisor_count
```

## Running

```sh
qemu-aarch64 ./divisor_count
```

Example interaction:

```text
12
Divisor count: 6
```

## What to pay attention to

- for `n = 0` the loop does not run and the function returns `0`
- `b.hi` matches the unsigned condition `d > n`
- this example is deliberately direct and goes through all numbers from `1` to `n`

## Navigation

- Previous: [Count of ones](../03-count_ones/README.md)
- Next: [LCM](../05-lcm/README.md)
- Up: [Standalone mini-examples](../README.md)
