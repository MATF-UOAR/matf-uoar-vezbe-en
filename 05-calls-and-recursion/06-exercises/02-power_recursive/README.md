# Recursive power

This is a short recursive example with two arguments.

## What the program does

The `power_recursive` function computes `a^n` by reducing the problem by one power to `a^(n - 1)`.

Reference C++ version:

```cpp
unsigned power_recursive(unsigned a, unsigned n) {
    if (n == 0) {
        return 1;
    }

    return a * power_recursive(a, n - 1);
}
```

## What to observe in the assembly

Before the recursive call we save the base `a`, because after returning we need to multiply the obtained result by exactly the original base. The old exponent `n` is no longer needed after the return.

A short trace for `2^3`:

```text
power(2, 3) waits for power(2, 2)
power(2, 2) waits for power(2, 1)
power(2, 1) waits for power(2, 0)
power(2, 0) returns 1
the results come back as 2, 4, 8
```

As an additional task, you can try the faster recursive version of exponentiation that you saw in Introduction to Algorithms: for an even `n`, `a^(n / 2)` is computed and then that result is squared, while for an odd `n` it is multiplied by `a` once more.

## Compilation

```sh
g++ main.cpp power_recursive.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
2 3
2^3 = 8
```

## What to pay attention to

- the base case is `n == 0`, since `a^0 = 1`
- the base `a` must be saved before the recursive call
- on return the recursion unwinds by multiplying the obtained result by the saved base `a`

## Navigation

- Previous: [Print several times](../01-print_times/README.md)
- Next: [Recursive array sum](../03-array_sum_recursive/README.md)
- Up: [Standalone mini-examples](../README.md)
