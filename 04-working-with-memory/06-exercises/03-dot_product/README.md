# Dot product

This is a good short example in which a single loop simultaneously goes through two arrays and combines their elements.

The function `dot_product` takes two arrays of the same length and returns the sum of the products of the corresponding elements. The goal is to reinforce:

- working with two base addresses in the same loop
- reading `a[i]` and `b[i]` for the same index
- multiplying a pair of elements and adding into an accumulator

A reference C++ version of the function might look like this:

```cpp
int dot_product(int* a, int* b, int n) {
    int sum = 0;
    for (int i = 0; i < n; i++) {
        sum += a[i] * b[i];
    }
    return sum;
}
```

## Files

- `main.cpp` reads the length and two arrays, and then prints their dot product
- `dot_product.s` contains the assembly implementation of the function

## What to watch for in the assembly

Here, for the first time, we use two different base addresses in the same loop:

```asm
    mov eax, [rdi + 4*rcx]
    imul eax, dword ptr [rsi + 4*rcx]
```

The index `ecx` is the same for both arrays, but one element is read through `rdi`, and the other through `rsi`. After the multiplication we add the product to the running sum.

## Compilation

```sh
g++ main.cpp dot_product.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
3
1 2 3
4 5 6
32
```

## What to pay attention to

- the arguments arrive in `rdi`, `rsi`, and `edx`
- before multiplying we must load at least one operand into a register
- this is a good short example to see how a single index can address two different arrays at the same time

## Navigation

- Previous: [Minimum](../02-minimum/README.md)
- Next: [Swapping the minimum and maximum](../04-swap_min_and_max/README.md)
