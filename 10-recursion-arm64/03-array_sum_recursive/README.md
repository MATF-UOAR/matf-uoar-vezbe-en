# Recursive array sum

This example applies recursion to an array: each call processes the first element
of the remaining part of the array and passes the next address to the deeper call.

## What the program does

The function `array_sum_recursive` returns the sum of the first `n` elements of
the array.

The reference C++ version is:

```cpp
int array_sum_recursive(int *a, int n) {
    if (n == 0) {
        return 0;
    }

    return a[0] + array_sum_recursive(a + 1, n - 1);
}
```

## Files

- `main.cpp` reads an array and calls `array_sum_recursive`
- `array_sum_recursive.s` contains the ARM64 implementation of the function

## What to watch in the assembly

The base case is an empty remainder of the array, whose sum is `0`. In the
recursive case the current element must be saved before the call, because the
result of the deeper call comes back in `w0`:

```asm
ldr w2, [x0]
str w2, [sp]
```

Since the element is of type `int`, the pointer to the next element is obtained
by advancing by `4` bytes:

```asm
add x0, x0, #4
sub w1, w1, #1
bl array_sum_recursive
```

Only while unwinding the calls is the saved element added to the sum of the rest
of the array:

```asm
ldr w1, [sp]
add w0, w0, w1
```

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp array_sum_recursive.s -o array_sum_recursive
```

## Running

```sh
qemu-aarch64 ./array_sum_recursive
```

Example interaction:

```text
3
2 -5 7
4
```

## What to pay attention to

- for `n == 0` the result is `0`
- `a + 1` for an `int` array means an address advanced by `4` bytes
- the value `a[0]` must survive the recursive call
- the function saves `lr`, because it itself runs `bl`

## Navigation

- Previous: [Recursive string length](../02-string_length_recursive/README.md)
- Next: [Fast recursive power](../04-power_recursive/README.md)
- Up: [Week 10](../README.md)
