# Word count

In assembly, implement a function that counts the words in a string. Words are
non-empty parts of the string separated by spaces. Several consecutive spaces
count as a single separator.

Reference C++ version:

```cpp
unsigned word_count(const char *s) {
    unsigned count = 0;
    bool in_word = false;

    while (*s != '\0') {
        if (*s == ' ') {
            in_word = false;
        } else if (!in_word) {
            count++;
            in_word = true;
        }
        s++;
    }

    return count;
}
```

## Files

- `main.cpp` reads a whole line of text and prints the number of words
- `word_count.s` contains the ARM64 implementation of the function

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp word_count.s -o word_count
```

## Running

```sh
qemu-aarch64 ./word_count
```

Example:

```text
  arm64  vezbanje lepo radi
4
```

## What to pay attention to

- the string is read byte by byte with the `ldrb` instruction
- a separate register remembers whether we are currently inside a word
- the terminating byte `'\0'` marks the end of the loop

## Navigation

- Previous: [Swap minimum and maximum](../04-swap_min_and_max/README.md)
- Next: [Replace the largest digit](../06-replace_largest_digit/README.md)
- Up: [Week 11](../README.md)
