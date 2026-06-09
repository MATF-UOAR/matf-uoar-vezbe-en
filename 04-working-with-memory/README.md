# Week 4

After week 3, in which we practiced loops and conditions, in the fourth week we keep that same control flow, but shift our attention to data that lives in memory. We move on to working directly with addresses: reading and writing through addresses, iterating over arrays, and the first examples in which a function builds a local array on the stack.

In this unit we will see:

- how references and pointers in assembly become plain addresses in registers
- how array elements are read using a base address and an index
- how new values are written into memory, without returning a result through `eax`
- how a local array can be placed on the stack and passed to another function
- how an array is modified "in place", without making a copy

## Contents

- [Swapping two values](./01-swap/README.md)
- [Sum of array elements](./02-array-sum/README.md)
- [Array maximum](./03-maximum/README.md)
- [Most frequent digit](./04-most-frequent-digit/README.md)
- [Reversing an array](./05-reverse-array/README.md)
- [Standalone mini-examples](./06-exercises/README.md)

## Recommended order

1. First look at [Swapping two values](./01-swap/README.md), since it is the shortest example of reading from and writing directly to memory through an address.
2. Then go through [Sum of array elements](./02-array-sum/README.md), since that is where you first see the standard `base + index * 4` pattern.
3. After that look at [Array maximum](./03-maximum/README.md), which uses the same pass over the array but adds conditional updating of the current result.
4. Then go through [Most frequent digit](./04-most-frequent-digit/README.md), since that is where we first build a local array of counters on the stack and pass it to a helper function.
5. Finally look at [Reversing an array](./05-reverse-array/README.md), where we no longer just read but also swap elements at two different positions.
6. Once you have gone through the basic examples, try the [Standalone mini-examples](./06-exercises/README.md) as well, which reinforce the same ideas on slightly different tasks.

## Note

This is the week in which it becomes important to always distinguish between:

- the value held in a register
- the address that the register points to
- the value itself that lives in memory at that address

In the examples that read an array from input we assume that `n > 0`, unless an example explicitly singles out a boundary case as part of the explanation.

That is why it is worth not only reading each example, but also manually tracing what happens to the addresses and to the contents of memory after every key instruction.

## Navigation

- Previous: [Week 3](../03-loops/README.md)
- Next: [Swapping two values](./01-swap/README.md)
