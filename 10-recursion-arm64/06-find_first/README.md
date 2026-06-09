# Find first via a predicate function

This example introduces an indirect function call in ARM64. The function does not
know in advance which condition it checks over the elements of the array; it
receives the address of the predicate function as an argument and calls it for
each element until it finds the first match.

## What the program does

The function `find_first` walks through an array of `unsigned` values and returns
the index of the first element for which the passed predicate function returns a
nonzero value. If no such element exists, it returns `-1`.

A reference C++ version could look like this:

```cpp
int find_first(unsigned *a, int n, int (*pred)(unsigned)) {
    for (int i = 0; i < n; i++) {
        if (pred(a[i])) {
            return i;
        }
    }
    return -1;
}
```

The program calls the same assembly function with two different conditions: the
first call looks for an even element, and the second for the first element
greater than `99`.

## Files

- `main.cpp` reads an array, defines two predicate functions and calls `find_first`
- `find_first.s` contains the ARM64 implementation of the search and the indirect call

## What to watch in the assembly

The signature of the function is:

```cpp
int find_first(unsigned *a, int n, int (*pred)(unsigned));
```

In ARM64 the arguments arrive like this:

- `x0` is the address of the first element of the array
- `w1` is the number of elements
- `x2` is the address of the predicate function

The called predicate function may overwrite the caller-saved registers `x0`-`x17`.
That is why we keep the array, the function address, the length and the loop index
in the callee-saved registers `x19`-`x22`. If the function uses these registers, it
must save their old values and restore them before returning:

```asm
stp x19, x20, [sp]
stp x21, x22, [sp, #16]

mov x19, x0
mov w20, w1
mov x21, x2
mov w22, #0
```

In each iteration the current element becomes the first argument of the predicate
function. The address of the function is in register `x21`, so the indirect call
is made directly through it:

```asm
ldr w0, [x19, x22, lsl #2]
blr x21
```

The `blr` instruction corresponds to a call through a pointer to a function: like
`bl`, it writes the return address into `lr`, but the target of the call comes
from a register instead of a named label.

Before returning we restore the old values of the callee-saved registers:

```asm
ldp x21, x22, [sp, #16]
ldp x19, x20, [sp]
```

If the predicate returns nonzero, the saved index is returned and the search ends
immediately. Otherwise the index is incremented and processing continues:

```asm
cmp w0, #0
b.ne found
```

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp find_first.s -o find_first
```

## Running

```sh
qemu-aarch64 ./find_first
```

Example interaction:

```text
6
11 15 18 21 130 7
first even: index 2
first > 99: index 4
```

## What to pay attention to

- `blr` is the ARM64 form of an indirect call through an address in a register
- the loop state must survive every call to the predicate function
- registers `x19`-`x28` are callee-saved: the function may use them if it restores
  their old values before `ret`
- the predicate gets one `unsigned` argument in `w0` and returns the result in `w0`
- the result is the index of the first match, so the loop ends as soon as the
  condition succeeds
- `-1` means that no element satisfies the condition

## Navigation

- Previous: [Recursive palindrome](../05-is_palindrome_recursive/README.md)
- Next: [Practice exercises](../07-exercises/README.md)
- Up: [Week 10](../README.md)
