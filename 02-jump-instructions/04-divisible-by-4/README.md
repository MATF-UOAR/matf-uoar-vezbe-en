# Divisibility by 4

This example uses division in order to make a logical decision. That is why it is a good direct continuation of the `Division` example.

In it you can clearly see:

- how the remainder of a division is used as a condition
- how an assembly function can directly call `puts`
- how `cmp` and a conditional jump are combined after `idiv`

## What the program does

The program reads one `int` number and calls the function `divisible_by_4`, and the function itself prints the appropriate message from assembly.

A reference C++ version of the function would look like this:

```cpp
void divisible_by_4(int x) {
    if (x % 4 == 0) {
        puts("Divisible");
    }
    else {
        puts("Not divisible");
    }
    return;
}
```

## Files

- `main.cpp` reads the number and just calls `divisible_by_4`
- `divisible.s` contains the assembly implementation of the function `divisible_by_4`

## What to watch for in the assembly

The function first prepares the division:

```asm
mov esi, 4
mov eax, edi
cdq
idiv esi
```

After that the remainder is in `edx`. So it is enough to do:

```asm
cmp edx, 0
jne else_branch
```

If the remainder is zero, the function loads the address of the message into `rdi` and calls `puts`:

```asm
lea rdi, [rip+message_divisible]
call puts
```

Otherwise `puts` is called with the other message.

## Compilation

```sh
g++ main.cpp divisible.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
12
Divisible
```

## What to pay attention to

- for the type `int` we use signed division, which is why `cdq` appears
- the argument for `puts` goes into `rdi`, so we load the address of the string using `lea`
- the messages are stored in `.rodata`, as in the `hello world` example
- this is not the fastest way to check divisibility by `4`, but it is pedagogically useful because it reinforces working with the remainder
- after this example it is worth trying on your own the bitwise variant based on checking the two lowest bits

## Navigation

- Previous: [Division](../03-division/README.md)
- Next: [switch branching](../05-switch/README.md)
