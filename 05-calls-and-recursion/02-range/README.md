# Array range

This example shows a natural situation in which a local value must survive one function call so that we still need it after the next.

## What the program does

The program reads an array of integers, and the `range` function returns the difference between the maximum and minimum element.

We assume `n > 0`, since both `minimum` and `maximum` start from `a[0]` as the initial value.

A reference C++ version could look like this:

```cpp
int minimum(int* a, int n) {
    int min = a[0];
    for (int i = 1; i < n; i++) {
        if (a[i] < min) {
            min = a[i];
        }
    }
    return min;
}

int maximum(int* a, int n) {
    int max = a[0];
    for (int i = 1; i < n; i++) {
        if (a[i] > max) {
            max = a[i];
        }
    }
    return max;
}

int range(int* a, int n) {
    int min = minimum(a, n);
    int max = maximum(a, n);
    return max - min;
}
```

## Files

- `main.cpp` reads the array and calls `range`
- `minimum.s` finds the minimum of the array
- `maximum.s` finds the maximum of the array
- `range.s` calls both functions and returns their difference

## What to observe in the assembly

In `range`, three values must survive two separate calls: the array base `a`, the length `n`, and the minimum obtained from `minimum`.

| value | where we keep it | why it must survive |
| --- | --- | --- |
| `a` | `[rbp - 8]` | we need it as the first argument for `maximum` |
| `n` | `[rbp - 12]` | we need it as the second argument for `maximum` |
| `min` | `[rbp - 16]` | we need it after `maximum`, to compute `max - min` |

So on entry we save the arguments, and after the first call we also save the obtained minimum:

```asm
mov [rbp - 8], rdi
mov [rbp - 12], esi
...
mov [rbp - 16], eax
```

After `call minimum` we must not assume that `rdi`, `esi`, or `eax` kept their old values. `eax` currently holds the return value of the `minimum` function, but the next call will overwrite it, so we must move the minimum into the stack frame.

Only after that may we safely move on to the second call:

```asm
call minimum
...
call maximum
```

So the stack frame in `range` is not there because we pass the address of a local variable to some function, but because our most important values must remain available until the second `call` finishes.

Only after `call maximum` do we have both values we need, so we compute:

```asm
sub eax, [rbp - 16]
```

## Compilation

```sh
g++ main.cpp range.s minimum.s maximum.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
5
-2 7 3 9 -5
14
```

## What to pay attention to

- `range` has local variables not because we pass their address to someone, but because we need the values even after other `call` instructions
- `minimum` and `maximum` are functions that do not call other functions themselves, but we still keep `enter` and `leave` for clarity
- we assume `n > 0`, so the first element can serve as the initial minimum and maximum

## Navigation

- Previous: [Next ID](../01-next_id/README.md)
- Next: [Find first](../03-find_first/README.md)
- Up: [Week 5](../README.md)
