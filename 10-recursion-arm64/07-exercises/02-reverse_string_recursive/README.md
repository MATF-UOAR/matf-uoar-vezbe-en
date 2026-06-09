# Recursive string reversal

This example is a natural continuation of the recursive palindrome: two pointers
move toward the middle of the string, but now we do not only read the characters
but also change them.

## What the program does

The function `reverse_string_recursive` reverses a string in place.

The reference C++ version is:

```cpp
void reverse_range(char *left, char *right) {
    if (left >= right) {
        return;
    }

    char tmp = *left;
    *left = *right;
    *right = tmp;
    reverse_range(left + 1, right - 1);
}

void reverse_string_recursive(char *s) {
    if (*s == '\0') {
        return;
    }

    char *end = s;
    while (*end != '\0') {
        end++;
    }
    reverse_range(s, end - 1);
}
```

## Files

- `main.cpp` reads a string, calls the function and prints the modified string
- `reverse_string_recursive.s` contains the public function and the helper function `reverse_range`

## What to watch in the assembly

The public function finds the last character with the same pass as the palindrome
example. In the helper function the characters are loaded and immediately swapped:

```asm
ldrb w2, [x0]
ldrb w3, [x1]
strb w3, [x0]
strb w2, [x1]
```

After the swap both pointers move toward the middle, and when `left >= right`
holds there is no more pair of characters left to swap.

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp reverse_string_recursive.s -o reverse_string_recursive
```

## Running

```sh
qemu-aarch64 ./reverse_string_recursive
```

Example interaction:

```text
rekurzija
ajizruker
```

## What to pay attention to

- the string is modified in place, so the function takes a `char *`, not a `const char *`
- `strb` writes one modified character into memory
- the helper function is recursive, while the public function first only finds the
  end of the string

## Navigation

- Previous: [Recursive GCD](../01-gcd_recursive/README.md)
- Next: [Recursive binary search](../03-binary_search_recursive/README.md)
- Up: [Practice exercises](../README.md)
