# Print several times

This is a short example in which a single assembly function calls the library function `puts` several times.

## What the program does

The program reads a number `n` and a string, and the `print_times` function prints that string `n` times.

The focus is not on recursion, but on the fact that the string's address and the loop counter must survive several `call` instructions.

Reference C++ version:

```cpp
void print_times(const char* s, unsigned n) {
    while (n != 0) {
        puts(s);
        n--;
    }
}
```

## What to observe in the assembly

`puts` is an external call, so `print_times` must save the string's address and the loop counter itself if it needs them after returning from `puts`.

## Compilation

```sh
g++ main.cpp print_times.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
3
zdravo
zdravo
zdravo
zdravo
```

## What to pay attention to

- the string's address must survive several calls to `puts`
- the loop counter must also stay correct after each `call`
- the condition `n == 0` only determines the exit from the loop; the essence of the example is in the several consecutive calls to the same function

## Navigation

- Previous: [Standalone mini-examples](../README.md)
- Next: [Recursive power](../02-power_recursive/README.md)
- Up: [Standalone mini-examples](../README.md)
