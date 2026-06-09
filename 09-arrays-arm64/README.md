# Week 9: arrays and strings in ARM64

After week 8, where we wrote ARM64 loops over numbers and bits, here we move those same patterns onto data in memory. The main theme is addressing array elements: the base, the index, the element size, and advancing a pointer through memory.

In this unit we will see:

- how an `int` element is read through an address of the form `base + index * 4`
- how the same loop can be written by advancing a pointer
- what changes when an array element is `8` bytes wide
- how a signed `short` that is `2` bytes wide is loaded
- how a function writes its result through a C++ reference
- how a string is read as an array of bytes that ends with the character `'\0'`

## Contents

- [Sum of array elements](./01-array_sum/README.md)
- [Maximum of an array](./02-max_element/README.md)
- [Minimum of an array of `unsigned long` values](./03-min_long/README.md)
- [Minimum and maximum of `short` values](./04-minimax/README.md)
- [String length](./05-string_length/README.md)
- [Exercises](./06-exercises/README.md)

## Recommended order

1. Go through [Sum of array elements](./01-array_sum/README.md) first, because it has four versions of the same loop and makes it easiest to compare the addressing styles.
2. Then look at [Maximum of an array](./02-max_element/README.md), where the pass through the array gains a conditional update of the current result.
3. After that move on to [Minimum of an array of `unsigned long` values](./03-min_long/README.md), because there you can see the shift from `w` to `x` registers and from an offset of `4` to an offset of `8`.
4. Then do [Minimum and maximum of `short` values](./04-minimax/README.md), where you see two-byte elements, and the function writes its results to the addresses it received as arguments.
5. Finally look at [String length](./05-string_length/README.md), because a string is a special case of an array: the elements are bytes, and the end is recognized by the value `0`.
6. Once you have gone through the basic examples, try the [Exercises](./06-exercises/README.md), which reinforce smaller variations of iterating over an array.

## Reminder

When the first argument of a function is the address of an array, it arrives in `x0`. If the second argument is the number of elements of type `int`, it arrives in `w1`.

To access element `a[i]` we use the base address and the index. For an array of `int` values one element is `4` bytes, so the typical form is:

```asm
ldr w4, [x0, x3, lsl #2]
```

This reads the value at the address `x0 + x3 * 4`. For `unsigned long` elements we use `x` registers and the shift `lsl #3`, because one element is `8` bytes wide.

For a signed `short` we use `ldrsh`, which reads `2` bytes and sign-extends the value into a `w` register, together with the offset `#2` when iterating over the array.

ARM64 also has addressing forms that update the address while reading:

```asm
ldr w4, [x0], #4
```

This instruction reads the `int` at the address in `x0`, and then advances `x0` to the next element. That is useful when we no longer need the index as a separate value.

If a directory contains several `.s` files with the same symbol, only one variant is compiled at a time.

All examples in this week are leaf functions: they do not run `bl` and do not call other functions. That is why they do not need a stack frame; it is enough for them to leave the result in the appropriate register or to write it to the address they received and finish with `ret`.

## Note

In examples that take `a[0]` as the initial value, we assume the input array is non-empty, that is, that `n > 0`. This lets us focus on addressing and iterating over the array.

## Navigation

- Previous: [Week 8](../08-loops-arm64/README.md)
- Next: [Sum of array elements](./01-array_sum/README.md)
