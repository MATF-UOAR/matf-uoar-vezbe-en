# Maximum of two numbers

This example shows how the familiar `x86-64` pattern `cmp` + conditional jump reads on ARM64.

## What the program does

The program reads two `int` numbers, calls the function `max`, and prints the larger of the two numbers.

The reference C++ version of the function is:

```cpp
int max(int x, int y) {
    if (x >= y) {
        return x;
    }
    return y;
}
```

## Files

- `main.cpp` reads two numbers and calls `max`
- `max.s` contains the ARM64 implementation of the function

## Connection to the x86-64 example

On `x86-64` we had this form:

```asm
cmp edi, esi
jle else_branch
```

On ARM64 the arguments are in `w0` and `w1`, and conditional jumps have the form `b.<condition>`:

```asm
cmp w0, w1
b.ge end
mov w0, w1

end:
ret
```

The logic here is as follows:

- if `w0 >= w1`, the first argument is already in the return-value register, so we go to the end
- otherwise, the larger one is the second argument, so we write it into `w0`
- `ret` returns the value from `w0`

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp max.s -o max
```

## Running

```sh
qemu-aarch64 ./max
```

Example interaction:

```text
4 9
max(4, 9) = 9
```

## What to pay attention to

- `cmp w0, w1` compares the two `int` arguments
- `b.ge` is the conditional jump for the signed comparison `>=`
- no stack frame is needed, because `max` is a leaf function
- the return value must stay in `w0`

## Navigation

- Previous: [Hello world](../02-hello-world/README.md)
- Next: [Exercises](../04-exercises/README.md)
- Up: [Week 7](../README.md)
