# Addition

This is the first ARM64 example of the week. It is deliberately the same as the first `x86-64` example from week one: the function takes two `int` arguments and returns their sum.

## What the program does

The program in `main.cpp` reads two integers, calls the function `sum_two`, and prints the result.

The reference C++ version of the function is:

```cpp
int sum_two(int a, int b) {
    return a + b;
}
```

## Files

- `main.cpp` contains the C++ code that calls the function `sum_two`
- `sum_two.s` is a minimal ARM64 leaf function
- `sum_two-with-stack-frame.s` is a longer version that builds a stack frame and stores the arguments in memory

## Connection to the x86-64 example

On `x86-64` the first two `int` arguments arrive in `edi` and `esi`, and the return value goes into `eax`.

On ARM64 the first two `int` arguments arrive in `w0` and `w1`, and the return value also goes into `w0`.

That is why the minimal function is very short:

```asm
sum_two:
    add w0, w0, w1
    ret
```

The instruction `add w0, w0, w1` adds the arguments and leaves the result directly in the return-value register.

## Why there is a version with a stack frame

The function `sum_two` does not need the stack, because it does not use local variables and does not call other functions. Still, the version `sum_two-with-stack-frame.s` shows the standard ARM64 form of saving `fp` and `lr`. The registers `fp` and `lr` are just more readable names for `x29` and `x30`, so this form would be correct as well:

```asm
stp fp, lr, [sp, #-16]!
mov fp, sp
sub sp, sp, #16

// function body

mov sp, fp
ldp fp, lr, [sp], #16
ret
```

This will matter in the `Hello world` example, because `main` calls `puts`, so it must save the return address from `lr`.

## Compilation

The minimal version:

```sh
aarch64-linux-gnu-g++ main.cpp sum_two.s -o sum_two
```

The version with a stack frame:

```sh
aarch64-linux-gnu-g++ main.cpp sum_two-with-stack-frame.s -o sum_two
```

## Running

```sh
qemu-aarch64 ./sum_two
```

Example interaction:

```text
3 5
8
```

## What to pay attention to

- `w0` has a double role: on entry it is the first argument, and on exit it is the return value
- `w1` is the second `int` argument
- a leaf function that does not call other functions can finish with just `ret`
- for 64-bit values we would use `x0`, `x1`, ... instead of `w0`, `w1`, ...

## Navigation

- Previous: [Moving from x86-64 to ARM64](../00-comparison-x86-64-and-arm64/README.md)
- Next: [Hello world](../02-hello-world/README.md)
- Up: [Week 7](../README.md)
