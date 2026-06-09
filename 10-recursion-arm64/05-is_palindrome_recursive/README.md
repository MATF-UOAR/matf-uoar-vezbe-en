# Recursive palindrome

This example combines a pass through a string with a recursive helper function
that compares characters from the two ends of a range.

## What the program does

The function `is_palindrome_recursive` returns a nonzero value if the string is a
palindrome. The empty string and a string of length one are palindromes.

The reference C++ version is:

```cpp
int palindrome_range(const char *left, const char *right) {
    if (left >= right) {
        return 1;
    }
    if (*left != *right) {
        return 0;
    }
    return palindrome_range(left + 1, right - 1);
}

int is_palindrome_recursive(const char *s) {
    if (*s == '\0') {
        return 1;
    }

    const char *end = s;
    while (*end != '\0') {
        end++;
    }
    return palindrome_range(s, end - 1);
}
```

## Files

- `main.cpp` reads a string and prints whether it is a palindrome
- `is_palindrome_recursive.s` contains the public function and the helper function `palindrome_range`

## What to watch in the assembly

The public function first handles the empty string, and then with a loop finds
the terminating character `'\0'`. Only then does it build the address of the last
actual character:

```asm
sub x1, x1, #1
bl palindrome_range
```

In the helper function, `x0` and `x1` are the left and right pointers. Since they
are addresses within the same string, the condition that the pointers have met or
crossed is checked with an unsigned comparison:

```asm
cmp x0, x1
b.hs yes
```

If the end characters are equal, the pointers move toward the middle and the
helper function calls itself:

```asm
add x0, x0, #1
sub x1, x1, #1
bl palindrome_range
```

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp is_palindrome_recursive.s -o is_palindrome_recursive
```

## Running

```sh
qemu-aarch64 ./is_palindrome_recursive
```

Example interaction:

```text
racecar
palindrome
```

## What to pay attention to

- `palindrome_range` is not `.global`, because it is a helper function in the same file
- characters are read with the `ldrb` instruction
- the empty string is handled before computing the address `end - 1`
- both functions save `lr`, because they run `bl`

## Navigation

- Previous: [Fast recursive power](../04-power_recursive/README.md)
- Next: [Find first via a predicate function](../06-find_first/README.md)
- Up: [Week 10](../README.md)
