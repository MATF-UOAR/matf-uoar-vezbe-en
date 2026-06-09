# Swapping two values

This is the shortest possible example in this week: the function does not return a result through `eax`, but instead modifies data directly in memory.

## What the program does

The program reads two `int` numbers, prints them, then calls `swap` and prints them again.

A reference C++ version of the function might look like this:

```cpp
void swap(int& a, int& b) {
    int tmp = a;
    a = b;
    b = tmp;
}
```

Although the parameters in the C++ signature are references, at the ABI level the function actually receives in registers the addresses of the variables to be swapped.

## Files

- `main.cpp` reads two numbers and prints them before and after the call
- `swap.s` reads and writes values through the addresses in `rdi` and `rsi`
- `main_set.cpp` reads two numbers and calls a variant that directly writes constants
- `set_01.s` shows why writing an immediate value requires a `dword ptr`

## What to watch for in the assembly

First we read the values at the addresses that arrived in `rdi` and `rsi`:

```asm
    mov ecx, [rdi]
    mov edx, [rsi]
```

Then we write them to the opposite addresses:

```asm
    mov [rdi], edx
    mov [rsi], ecx
```

This is a good first example of the difference between:

- the address in a register, for example `rdi`
- the value at that address, for example `[rdi]`

**Note**: A very common mistake when working with addresses is writing too large a piece of data to the address of a smaller one. For example: `mov [rdi], rdx`
writes 8 bytes into memory. If that address is meant for a four-byte value, this would overwrite adjacent data and corrupt memory.

## Optional addition: writing constants

If you only want the core idea of this week, go through `swap` first. The `set_01` variant is a short follow-up after that, since it introduces one more idea: how an immediate constant is written into memory.

The same folder therefore also contains the short `set_01` variant, which instead of swapping writes the fixed values `0` and `1`:

```cpp
void set_01(int& a, int& b) {
    a = 0;
    b = 1;
}
```

In assembly this looks like:

```asm
    mov dword ptr [rdi], 0
    mov dword ptr [rsi], 1
```

Here the important difference compared to `swap.s` is:

- in `mov [rdi], edx` the write width is clear from the register `edx`, so a separate `dword ptr` is not needed
- in `mov [rdi], 0` the constant `0` by itself does not say how many bytes to write, so we must state it explicitly using `dword ptr`

In other words, `[]` tells us which address we are accessing, but not always how many bytes we are writing, as already emphasized in the note of the previous section.

## Compilation

The version with the swap:

```sh
g++ main.cpp swap.s
```

The variant that writes constants:

```sh
g++ main_set.cpp set_01.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
3 7
a=3 b=7
a=7 b=3
```

Example interaction for `main_set.cpp`:

```text
8 9
a=8 b=9
a=0 b=1
```

## What to pay attention to

- this is deliberately a simple introductory example, since it is the first time we write directly to memory
- inside the function itself we can treat the references just like pointers: the registers hold addresses
- the function returns nothing, but it changes the program's state because it writes new values to existing addresses
- the `set_01` variant is deliberately left as a short addition, after the basic idea of swapping through addresses
- in `set_01` you first clearly see that the address and the width of a memory operand are not the same thing

## Navigation

- Previous: [Week 4](../README.md)
- Next: [Sum of array elements](../02-array-sum/README.md)
