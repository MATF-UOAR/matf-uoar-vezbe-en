# two-messages

This is a short exercise based on the `Hello world` example.

The goal is to reinforce:

- storing constant strings in `.rodata`
- computing the address of a string with the `lea` instruction
- calling `puts` multiple times from the same function
- stack alignment before `call`

## Files

- `two-messages.s` contains the assembly implementation of the `main` function

## Compilation

```sh
g++ two-messages.s
```

## Running

```sh
./a.out
```

The expected output is:

```text
First message
Second message
```

## What to pay attention to

- both strings are in `.rodata`, since they are constant
- `lea rdi, [rip+msg1]` and `lea rdi, [rip+msg2]` compute the addresses of the strings
- `puts` itself adds a newline, so the strings do not contain `\n`
- `push rbp` / `mov rbp, rsp` are enough for the stack to be aligned before both calls to the `puts` function
