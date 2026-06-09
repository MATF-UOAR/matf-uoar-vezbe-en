# Addition

This is the first assembly example in the introductory part of the course. It shows in the simplest way:

- how function arguments arrive in the registers `edi` and `esi`
- how the return value is returned via the register `eax`
- that for a simple leaf function the stack is often not needed at all

## What the program does

The program in `main.cpp` reads two integers, calls the function `sum_two` and prints their sum.

A reference C++ version of the function would look like this:

```cpp
int sum_two(int a, int b) {
    return a + b;
}
```

## Files

- `main.cpp` contains the C++ code that calls the function `sum_two`
- `sum_two.s` is a minimal version of the function, without a stack frame
- `sum_two-with-stack-frame.s` is a version that builds a stack frame, stores the arguments in memory and then reads them back

## Connection to the C++ code

In `main.cpp` there is the declaration

```cpp
extern "C" int sum_two(int a, int b);
```

`extern "C"` is important because it tells the C++ compiler that the function name must not be altered by C++ name mangling. Thanks to that, the symbol in assembly really stays `sum_two`, so the linker can connect the C++ call with the assembly implementation.

## What to observe in the assembly

- The function's first argument `a` arrives in the register `edi`.
- The function's second argument `b` arrives in the register `esi`.
- Since `int` takes 4 bytes, here we naturally use the 32-bit registers `edi`, `esi` and `eax`.
- The instruction `add edi, esi` adds the values.
- Since the return value is returned via the register `eax`, we move the result into `eax` at the end.

This is a good example because there are no extra complications: no local variables, no memory access and no calls to other functions.

## Why there are two versions

The `sum_two.s` version is pedagogically the cleanest because it shows that a simple function can sometimes fit into just a few instructions:

```asm
sum_two:
    add edi, esi
    mov eax, edi
    ret
```

This is an example of a **leaf function**: it does not call other functions and does not use local variables on the stack. That is why it needs neither `push rbp`, nor `mov rbp, rsp`, nor reserving space on the stack.

The `sum_two-with-stack-frame.s` version introduces the standard function entry:

```asm
push rbp
mov rbp, rsp
```

After that the arguments are written into the stack frame:

```asm
sub rsp, 16
mov [rbp-4], edi
mov [rbp-8], esi
```

and then they are read back from memory:

```asm
mov edx, [rbp-4]
mov eax, [rbp-8]
add eax, edx
```

Here the offsets `-4` and `-8` are natural because each `int` takes 4 bytes. Although two `int` arguments only need 8 bytes of space, in the example we reserve 16 bytes in order to keep the stack correctly aligned.

That version is not needed for addition alone, but it is useful as preparation for later examples in which a function:

- has local variables
- preserves registers
- calls other functions
- must keep track of the stack and its alignment

## Compilation

The minimal version:

```sh
g++ main.cpp sum_two.s
```

The version with a stack frame:

```sh
g++ main.cpp sum_two-with-stack-frame.s
```

## Running

After compilation the program is run in the usual way:

```sh
./a.out
```

Example interaction:

```text
3 5
8
```
