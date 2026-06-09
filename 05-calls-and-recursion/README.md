# Week 5

After working with loops, arrays, and local data on the stack, this week we move on to examples in which the function call itself is the main topic.

Instead of following a single loop or a single pass through memory, we now follow how control passes into another function, what must be preserved until the return, and how the same pattern becomes recursion when a function calls itself.

In this unit we will follow one clear sequence of ideas:

- how a function can remember state between calls using static data
- how a local value from the stack frame can survive one `call` and still be needed after another
- what an indirect function call through a pointer looks like
- how a recursive call uses the same `call` / `ret` pattern, just with several active stack frames
- how `enter` and `leave` help make the stack frame clearly visible in every example

## Reminder about the function call

In these examples we use the same calling convention as in previous weeks: the first arguments arrive in order in `rdi`, `rsi`, `rdx`, and an integer return value is returned in `eax`.

When a function itself performs a `call`, it must account for the fact that the called function is allowed to overwrite registers such as `rax`, `rcx`, `rdx`, `rdi`, `rsi`, `r8`-`r11`. That is why values that are still needed after the call are kept in the stack frame or in some other place we control.

The stack alignment rule also applies before a new `call`. That is why the stack frame sometimes has more bytes than would be needed for local variables alone. For example, a function that stores a single `int` may still use `enter 16, 0`, so that the space for the local value and the alignment stay tidy.

Recursion in assembly is not a special mechanism: the function simply performs an ordinary `call` again, except that the target of that call is the same function. Each active call gets its own stack frame and its own saved values.

## Contents

- [Next ID](./01-next_id/README.md)
- [Array range](./02-range/README.md)
- [Find first](./03-find_first/README.md)
- [Recursive factorial](./04-factorial_recursive/README.md)
- [Recursive palindrome](./05-is_palindrome_recursive/README.md)
- [Standalone mini-examples](./06-exercises/README.md)

## Recommended order

1. First look at [Next ID](./01-next_id/README.md), since it is the cleanest example of a function with static state.
2. Then go through [Array range](./02-range/README.md), since there a local value must survive one function call so it can be used after the next.
3. After that look at [Find first](./03-find_first/README.md), since there for the first time a function's address arrives as an argument and the call is made indirectly.
4. Then go through [Recursive factorial](./04-factorial_recursive/README.md), which is the simplest recursive example with a single base case.
5. Finally look at [Recursive palindrome](./05-is_palindrome_recursive/README.md), since there we combine recursion with pointers and working over a string.
6. Once you have gone through the main examples, try the [Standalone mini-examples](./06-exercises/README.md) too.

## Note

### `enter` and `leave`

This week we deliberately keep `enter` and `leave`, even where a function could fit in fewer instructions. The point is not for the code to be as short as possible, but for the stack frame, the local variables, and the place where the `call` happens to be as easy to follow as possible.

That does not mean a full stack frame is the only correct approach. When we only need to preserve one or two values that we use even after the `call` instruction, it would often be enough to do a `push` before the call and a `pop` after the return, while respecting the same stack alignment and the rules about registers. Here we still use a stack frame so that all examples have the same shape and so that it is clear what belongs to the current function call.

### Library functions

Calls to library functions such as `puts` are important, but this week we keep them mostly in the mini-examples, so that the main material stays focused on the structure of the calls themselves and on the stack.

## Navigation

- Previous: [Week 4](../04-working-with-memory/README.md)
- Next: [Next ID](./01-next_id/README.md)
