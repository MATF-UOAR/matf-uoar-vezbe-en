# Recursive string length

This is a short example of recursion over a pointer to characters.

## What the program does

The `string_length_recursive` function returns the number of characters before the terminating `'\0'`.

Reference C++ version:

```cpp
int string_length_recursive(const char* s) {
    if (*s == '\0') {
        return 0;
    }

    return 1 + string_length_recursive(s + 1);
}
```

## What to observe in the assembly

Each recursive call gets a pointer to the next character, so the base case is reached when that pointer reaches `'\0'`.

Here we do not need to save a separate local value before the recursive `call`: after the return we only need the length of the rest of the string, to which we add `1`.

## Compilation

```sh
g++ main.cpp string_length_recursive.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
rekurzija
9
```

## What to pay attention to

- the base case is `*s == '\0'`, when there are no more characters to count
- the recursive call gets the address of the next character, that is, `s + 1`
- here we do not save a separate local value across the recursive `call`; after the return we only add `1`

## Navigation

- Previous: [Count via a predicate function](../04-count_predicate/README.md)
- Up: [Standalone mini-examples](../README.md)
