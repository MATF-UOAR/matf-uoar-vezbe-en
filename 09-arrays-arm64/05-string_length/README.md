# String length

This example shows that a string is an array of bytes that ends with a special value `0`, that is, the character `'\0'`. Unlike the previous examples, the function does not receive the length as a separate argument; instead it finds the end of the string itself.

## What the program does

The program reads a single word, passes the address of its C representation to the function `string_length`, and prints the number of characters before the terminating `'\0'`.

The reference C++ function is:

```cpp
int string_length(const char* s) {
    int length = 0;
    while (s[length] != '\0') {
        length++;
    }
    return length;
}
```

## Files

- `main.cpp` reads a `std::string` and calls `string_length` on `s.c_str()`
- `string_length.s` contains the ARM64 implementation of the function

## What to watch for in the assembly

The address of the first character arrives in `x0`. Since `w0` will be the return value, we move the base address into `x1`, and keep the current length in `w0`:

```asm
mov x1, x0
mov w0, #0
```

We read a character with the `ldrb` instruction:

```asm
ldrb w2, [x1, x0]
```

The suffix `b` means that one byte is read. That matches the type `char`. Since the element is one byte wide, the index does not need to be multiplied by `4` or `8`.

The end of the string is recognized by comparison with zero:

```asm
cmp w2, #0
b.eq end
```

When we reach `'\0'`, `w0` holds the number of characters read, and that is the return value of the function.

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp string_length.s -o string_length
```

## Running

```sh
qemu-aarch64 ./string_length
```

Example interaction:

```text
arm64
5
```

## What to pay attention to

- a string has no separate argument for its length; the end is found by a byte with the value `0`
- `ldrb` reads one byte and zero-extends it into `w2`
- for a string the element size is `1`, so the address of the next character grows by one byte
- `std::string::c_str()` gives the address of a C string that ends with `'\0'`
- the function is a leaf function and so does not need a stack frame

## Navigation

- Previous: [Minimum and maximum of `short` values](../04-minimax/README.md)
- Next: [Exercises](../06-exercises/README.md)
- Up: [Week 9](../README.md)
