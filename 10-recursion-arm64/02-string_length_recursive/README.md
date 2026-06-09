# Recursive string length

This is a short example of recursion over a pointer to characters.

## What the program does

The function `string_length_recursive` returns the number of characters in the
string before the terminating byte `'\0'`.

The reference C++ version is:

```cpp
int string_length_recursive(const char *s) {
    if (*s == '\0') {
        return 0;
    }

    return 1 + string_length_recursive(s + 1);
}
```

## Files

- `main.cpp` reads a string and calls `string_length_recursive`
- `string_length_recursive.s` contains the ARM64 implementation of the function

## What to watch in the assembly

A character is a single byte, so it is read with the `ldrb` instruction:

```asm
ldrb w1, [x0]
cmp w1, #0
```

If the terminating byte has been reached, the result is `0`. Otherwise the
pointer is advanced by one byte, the length of the rest of the string is obtained
recursively, and `1` is added to it:

```asm
add x0, x0, #1
bl string_length_recursive
add w0, w0, #1
```

Unlike the recursive array sum, here we do not save an element before the call:
we always add the same constant `1`.

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp string_length_recursive.s -o string_length_recursive
```

## Running

```sh
qemu-aarch64 ./string_length_recursive
```

Example interaction:

```text
rekurzija
9
```

## What to pay attention to

- the base case is `*s == '\0'`
- `s + 1` means advancing the address by one byte
- after returning from the recursion only `1` is added, so there is no local
  value to save
- the function saves `lr`, because it itself runs `bl`

## Navigation

- Previous: [Most frequent letter](../01-most_frequent_letter/README.md)
- Next: [Recursive array sum](../03-array_sum_recursive/README.md)
- Up: [Week 10](../README.md)
