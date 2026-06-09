# Recursive array sum

This is an example in which recursion is used over an array, rather than over a single number or a string.

## What the program does

The `array_sum_recursive` function returns the sum of the first `n` elements of the array.

Reference C++ version:

```cpp
int array_sum_recursive(int* a, int n) {
    if (n == 0) {
        return 0;
    }

    return a[0] + array_sum_recursive(a + 1, n - 1);
}
```

## What to observe in the assembly

The expression `a + 1` in C++ means "the address of the next element", and since the elements are of type `int`, in assembly the array base moves by `4` bytes.

The value `a[0]` must be saved before the recursive call, because the return value of the deeper call will arrive in `eax`, and only after that do we add the saved first element.

A short trace for the array `[2, -5, 7]`:

```text
2 + sum([-5, 7])
-5 + sum([7])
7 + sum([])
0
7
2
4
```

## Compilation

```sh
g++ main.cpp array_sum_recursive.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
3
2 -5 7
4
```

## What to pay attention to

- the base case is `n == 0`, when the sum of the empty remainder of the array equals `0`
- after reading `a[0]` we move the base address to the next element
- the value of the first element must be saved before the recursive call and is added only during the unwinding

## Navigation

- Previous: [Recursive power](../02-power_recursive/README.md)
- Next: [Count via a predicate function](../04-count_predicate/README.md)
- Up: [Standalone mini-examples](../README.md)
