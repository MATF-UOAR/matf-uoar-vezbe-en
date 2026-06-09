# GCD

This is the first example in which we see how a `while` loop is built manually using jump instructions.

## What the program does

The program reads two `unsigned` numbers and prints their greatest common divisor.

This can be done in several ways, but since the focus this week is on loops, we use Euclid's algorithm. A reference C++ function could look like this:

```cpp
unsigned gcd(unsigned a, unsigned b) {
    while (b != 0) {
        unsigned temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}
```

Although `x86-64` also has a special `loop` family of instructions, in practice loops are far more often written using a comparison, conditional jumps, and a single jump back to the start. In this example the loop consists of:

1. checking the condition `(b != 0)`
2. the loop body
3. a jump back to the start

That mapping between the C++ `while` loop and the assembly steps can be seen clearly in the following figure:

![Mapping of a `while` loop onto the condition check, body, and jump back](assets/while-loop-assembly.png)

## What to watch for in the assembly

We can write the condition check using `cmp` and `je`:

```asm
while_loop:
    cmp esi, 0
    je loop_end
```

When `b == 0`, we jump out of the loop.

The loop body uses the `div` instruction. Since we are working with `unsigned` values, before division we must set the upper half of the dividend to zero:

```asm
    mov eax, edi
    xor edx, edx
    div esi       # eax = a / b, edx = a % b

    mov edi, esi  # a = b
    mov esi, edx  # b = a % b
```

At the end of the loop body we return execution to the start with an unconditional jump:

```asm
    jmp while_loop
```

## Note on `enter` and `leave`

In the code you will notice that we did not write the usual function prologue and epilogue in the longer form. Instead of:

```asm
push rbp
mov rbp, rsp
sub rsp, N
```

we use:

```asm
enter N, 0
```

And instead of:

```asm
mov rsp, rbp
pop rbp
```

we use:

```asm
leave
```

`enter` and `leave` are useful here as a compact notation for the same idea. This does not mean they are necessarily the best choice in every real program; in practice you will often see an explicit prologue and epilogue as well.

## Files

- `main.cpp` reads two numbers and calls `gcd`
- `gcd.s` contains the assembly implementation of the `gcd` function

## Compilation

```sh
g++ main.cpp gcd.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
12 18
gcd(12, 18) = 6
```

## What to pay attention to

- `div` divides the dividend from `edx:eax`, so for `unsigned` division we manually fill `edx` with zeros
- a `while` loop in assembly reads naturally as "check the condition, body, jump back"
- `enter` and `leave` in this example only shorten the notation of the standard prologue and epilogue

## Navigation

- Previous: [Week 3](../README.md)
- Next: [Sum](../02-sum/README.md)
