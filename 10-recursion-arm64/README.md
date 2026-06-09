# Week 10: recursion and calls in ARM64

After working through loops, arrays and strings in ARM64, this week we first
combine a function call with more involved work in memory, and then functions
start calling themselves or other functions whose address is not known as a
fixed label. The main theme is what the stack frame must preserve while we wait
for the result of a call.

In this unit we will see:

- how a recursive function saves `lr` and the values needed while unwinding
- how fast exponentiation halves the exponent instead of decreasing it by one
- how recursion is applied to an array and a string
- how a local counter array on the stack can be passed to a helper function
- how a function is called through an address with the `blr` instruction

## Contents

- [Most frequent letter](./01-most_frequent_letter/README.md)
- [Recursive string length](./02-string_length_recursive/README.md)
- [Recursive array sum](./03-array_sum_recursive/README.md)
- [Fast recursive power](./04-power_recursive/README.md)
- [Recursive palindrome](./05-is_palindrome_recursive/README.md)
- [Find first via a predicate function](./06-find_first/README.md)
- [Practice exercises](./07-exercises/README.md)

## Recommended order

1. Start with [Most frequent letter](./01-most_frequent_letter/README.md), since it continues the work with strings from the previous week and adds a local counter array and a direct call to a helper function.
2. Then look at [Recursive string length](./02-string_length_recursive/README.md), the shortest example of recursion over a pointer that advances until `'\0'`.
3. After that do [Recursive array sum](./03-array_sum_recursive/README.md), which adds saving the current element before the call to the same form of recursion.
4. Continue with [Fast recursive power](./04-power_recursive/README.md), where while unwinding we use the parity of the exponent and squaring of the partial result.
5. Then go through [Recursive palindrome](./05-is_palindrome_recursive/README.md), where the public function calls a recursive helper function over two pointers.
6. Leave [Find first via a predicate function](./06-find_first/README.md) for last, since it adds an indirect call with the `blr` instruction.
7. Once you have gone through the main examples, try the [Practice exercises](./07-exercises/README.md), which combine recursion, string modification, binary search and repeated indirect calls.

## A reminder about calls

The `bl` instruction writes the return address into `lr`, that is `x30`. A
function that itself runs `bl` must save that address before the call:

```asm
stp fp, lr, [sp, #-16]!
mov fp, sp
...
ldp fp, lr, [sp], #16
ret
```

Registers `x0`-`x17` are caller-saved. This means a recursive or helper call
may overwrite the arguments and temporary values in those registers. That is
why we store the values we need after the call into the stack frame before the
`bl` instruction.

The `blr x8` instruction has the same effect on `lr` as `bl`, but it takes the
address of the target function from a register, here `x8`. We use that form
when the address of the function is passed as an argument.

We keep the stack aligned to `16` bytes before a call. That is why the frames in
these examples sometimes have more space than is needed only for the data we
save.

When, in addition to the saved `fp` and `lr`, a function needs space for local
data, we set that space apart with a separate instruction. For example, for `64`
bytes of local data we use:

```asm
stp fp, lr, [sp, #-16]!
mov fp, sp
sub sp, sp, #64
...
mov sp, fp
ldp fp, lr, [sp], #16
ret
```

## Navigation

- Previous: [Week 9](../09-arrays-arm64/README.md)
- Next: [Most frequent letter](./01-most_frequent_letter/README.md)
- Next practice: [Week 11](../11-practice-arm64/README.md)
