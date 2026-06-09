# Recursive palindrome

This is the richest example of the week: it combines working with a string, pointers, and a recursive call.

## What the program does

The public function `is_palindrome_recursive` receives only the address of the start of the string. If the string is empty, it immediately returns `1`. Otherwise it first finds the end of the string, and then calls an internal helper function that compares the left and right ends and recursively moves toward the middle.

A reference C++ version could look like this:

```cpp
int is_palindrome_range(const char* left, const char* right) {
    if (left >= right) {
        return 1;
    }

    if (*left != *right) {
        return 0;
    }

    return is_palindrome_range(left + 1, right - 1);
}

int is_palindrome_recursive(const char* s) {
    if (*s == '\0') {
        return 1;
    }

    const char* end = s;
    while (*end != '\0') {
        end++;
    }

    return is_palindrome_range(s, end - 1);
}
```

## Files

- `main.cpp` reads a string and calls `is_palindrome_recursive`
- `is_palindrome_recursive.s` contains the public function and the internal helper function

## What to observe in the assembly

The public function first handles the special case of an empty string, so that we do not form the address `end - 1` before the start of the string itself:

```asm
mov rsi, rdi
cmp byte ptr [rsi], 0
je empty_string
```

Only after that do we walk through the string until we find `'\0'`. This is the same memory-traversal pattern we have already seen with arrays and pointers.

When that loop finishes, `end` points at the terminating `'\0'` character, and the last actual character is at the address `end - 1`. That is why the public function passes the helper function exactly the inclusive bounds of the range that still needs to be checked.

When the helper function receives two pointers, the base case reads:

```asm
cmp rdi, rsi
jae yes
```

Here we compare addresses, so it is natural to use unsigned comparison. The comparison makes sense because both pointers belong to the same string. If the left and right ends have met or crossed over each other, the remaining part of the string is a palindrome.

If the end characters are not equal, we immediately return `0`. Otherwise, we move both pointers and recursively call the helper function:

```asm
inc rdi
dec rsi
call is_palindrome_range
```

Here it is important that we move both pointers symmetrically: the left one goes right toward the middle, the right one goes left toward the middle, and the condition `left >= right` stops the recursion as soon as there are no more unchecked pairs of characters.

## Compilation

```sh
g++ main.cpp is_palindrome_recursive.s
```

## Running

```sh
./a.out
```

Example interaction when the input is a palindrome:

```text
racecar
palindrome
```

Example interaction when the input is not a palindrome:

```text
program
not a palindrome
```

## What to pay attention to

- the helper function is not marked `.global`, since it is not part of the public interface
- this is an example in which the recursion works over addresses, not over numbers
- the empty string is handled in the public function before forming `end - 1`
- a string of length `1` naturally falls into the base case of the helper function

## Navigation

- Previous: [Recursive factorial](../04-factorial_recursive/README.md)
- Next: [Standalone mini-examples](../06-exercises/README.md)
- Up: [Week 5](../README.md)
