# Recursive factorial

This is the shortest recursive example in the materials, and a natural continuation of the iterative factorial from week 3.

## What the program does

The `factorial_recursive` function returns `n!` using the classic definition:

- if `n <= 1`, the result is `1`
- otherwise `n! = n * (n - 1)!`

A reference C++ version could look like this:

```cpp
unsigned factorial_recursive(unsigned n) {
    if (n <= 1) {
        return 1;
    }

    return n * factorial_recursive(n - 1);
}
```

## Files

- `main.cpp` reads a number and calls `factorial_recursive`
- `factorial_recursive.s` contains the assembly implementation of the function

## What to observe in the assembly

The stack frame size is a little larger than we would expect for just a single local value:

```asm
enter 16, 0
```

Essentially we need to save the original `n`, and the rest of the space keeps the recursive `call` in a tidy, aligned form. Even though we store only a single `int`, the function will itself call another function, so the stack frame must leave the stack in a form that respects the alignment rule.

### Descending into the recursion

Before the recursive call we save the original value of `n` in the stack frame:

```asm
mov [rbp - 4], edi
```

This matters because after the call we want to multiply the obtained result by the old value of `n`, not by `n - 1`.

The base case is straightforward:

```asm
cmp edi, 1
ja recursive_case

mov eax, 1
```

Since `n` is of type `unsigned`, the `ja` instruction here means "go to the recursive case if `n > 1`".

And in the recursive case we see that there is no special "recursive" instruction:

```asm
dec edi
call factorial_recursive
```

This is an ordinary `call`, except that the target symbol has the same name as the function we are already in. During that descent, each new stack frame remembers its own `n` and waits for the result of the deeper call.

### Returning and unwinding

After returning from the deeper call, `eax` does not yet hold the final result for the old `n`, but the factorial of `n - 1`. So only now do we use the saved original value:

```asm
mul dword ptr [rbp - 4]
```

This is the moment when the recursion "unwinds": each stack frame gets the result from the deeper frame, completes it with its own `n`, and then returns back.

A short trace for `n = 3` looks like this:

```text
f(3) waits for the result of f(2)
f(2) waits for the result of f(1)
f(1) returns 1
f(2) returns 2 * 1 = 2
f(3) returns 3 * 2 = 6
```

An animation is useful for following the concrete state of the stack frame and registers:

<video controls title="Stack and register state during the recursive factorial for n = 4">
  <source src="assets/factorial-recursion-stack-registers.mp4" type="video/mp4">
  <a href="assets/factorial-recursion-stack-registers.mp4">Watch the MP4 animation of the stack and register state.</a>
</video>


https://github.com/user-attachments/assets/bed8358c-188b-4c7d-8684-e044b726d49b


In the animation the addresses are symbolic. The important values are: `edi`, which holds the argument value, `[rbp - 4]`, which holds the old `n` in each frame, and `eax`, which holds the result on return.

## Compilation

```sh
g++ main.cpp factorial_recursive.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
5
5! = 120
```

## What to pay attention to

- `0!` and `1!` are `1`, which is why we use the condition `n <= 1`
- each recursive call creates a new stack frame
- storing the original `n` locally is the key detail that makes the multiplication possible after returning from the recursion

## Navigation

- Previous: [Find first](../03-find_first/README.md)
- Next: [Recursive palindrome](../05-is_palindrome_recursive/README.md)
- Up: [Week 5](../README.md)
