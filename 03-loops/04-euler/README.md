# Euler

In this example we see how one assembly function calls another and what we must take care of when we do that.

## What the program does

The program reads an `unsigned` number and prints the value of Euler's totient function. For a given `n`, it returns the count of those values `k` for which `1 <= k < n` and `gcd(k, n) = 1` hold.

A reference C++ function could look like this:

```cpp
unsigned euler(unsigned n) {
    unsigned count = 0;
    for (unsigned i = 1; i < n; i++) {
        if (gcd(i, n) == 1) {
            count++;
        }
    }
    return count;
}
```

## What to watch for in the assembly

We keep the counter of values that are coprime with `n` in `r9d`, and the loop index in `ecx`:

```asm
    xor r9d, r9d    # r9d = count
    mov ecx, 1      # ecx = i
```

At the start of the loop we check the exit condition like this:

```asm
for_loop:
    cmp ecx, edi
    jae for_loop_end
```

Since we are working with `unsigned` values, for the condition `i < n` we use an unsigned comparison, that is, the `jae` jump.

In the loop body we call `gcd`, so before `call` we place the arguments into `edi` and `esi`:

```asm
    mov esi, edi    # second argument = n
    mov edi, ecx    # first argument = i
    call gcd        # eax = gcd(i, n)
```

After that we check whether the return value equals `1`. If it does, we increment the counter:

```asm
    cmp eax, 1
    jne not_coprime
    inc r9d

not_coprime:
    inc ecx
    jmp for_loop

for_loop_end:
    mov eax, r9d
```

## What we must save before `call`

When one function calls another, it is important to distinguish the registers that are saved by the calling function (`caller-saved`) from the registers that are saved by the called function (`callee-saved`).

A brief overview looks like this:

| Group | Registers | Practical rule |
| --- | --- | --- |
| `caller-saved` | `rax`, `rcx`, `rdx`, `rsi`, `rdi`, `r8`, `r9`, `r10`, `r11` | If you still need them after `call`, save them before the call. |
| `callee-saved` | `rbx`, `rbp`, `rsp`, `r12`, `r13`, `r14`, `r15` | If the called function changes them, it must restore their old values before `ret`. |

The same rule applies when we use their 32-bit parts, such as `edi`, `esi`, and `r9d`.

In this example the registers `r9`, `rcx`, and `rdi` are important to us before the `gcd` call, so we save them like this:

```asm
    push r9
    push rcx
    push rdi
    push rdi

    mov esi, edi
    mov edi, ecx
    call gcd

    pop rdi
    pop rdi
    pop rcx
    pop r9
```

The extra `push`/`pop` pair is not there to save another value, but for stack alignment. Immediately before the `call` instruction, `rsp` must be divisible by `16`. If we aligned the stack manually using `sub rsp, 8` and `add rsp, 8`, we would not need this extra pair, but some people find it easier to remember the rule as "before every `call` we have an even number of `push` instructions".

The figure below follows what happens to the registers we save and how `rsp` changes before the call, during `call`, and after returning from the function:

![Saving `r9`, `rcx`, and `rdi` on the stack before `call gcd`](assets/saving-values-on-stack.png)

## Files

- `main.cpp` reads one number and calls `euler`
- `gcd.s` contains the assembly implementation of the `gcd` function
- `euler.s` contains the assembly implementation of the `euler` function

## Compilation

```sh
g++ main.cpp euler.s gcd.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
87
56
```

## What to pay attention to

- this is the first example in which one assembly function calls another assembly function
- the registers saved by the calling function (`caller-saved`) must be saved if we still need them after `call`
- in a `for` loop with `unsigned` values, take care to use the appropriate conditional jump, here `jae`

## Navigation

- Previous: [Sum of even numbers](../03-sum-of-evens/README.md)
- Next: [Self-study mini-examples](../05-exercises/README.md)
- Up: [Week 3](../README.md)
