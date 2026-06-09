# Most frequent letter

This example connects working with strings from the previous week to a call to a
helper function. The function walks through a word, builds a local counter array
for the letters from `'a'` to `'z'` regardless of letter case, and then calls a
function that finds the index of the largest counter.

## What the program does

The program reads a string that contains at least one letter of the English
alphabet and prints the letter that appears in it the most times, without
distinguishing lowercase and uppercase letters. It ignores the other characters,
and always prints the result as a lowercase letter. If several letters have the
same maximum number of occurrences, it prints the letter that comes first in the
alphabet.

A reference C++ version could look like this:

```cpp
unsigned index_of_max(unsigned *a, unsigned n) {
    unsigned index = 0;
    for (unsigned i = 1; i < n; i++) {
        if (a[i] > a[index]) {
            index = i;
        }
    }
    return index;
}

char most_frequent_letter(const char *s) {
    unsigned counters[26] = {};

    while (*s != '\0') {
        char c = *s;
        if ('A' <= c && c <= 'Z') {
            c += 'a' - 'A';
        }
        if ('a' <= c && c <= 'z') {
            counters[c - 'a']++;
        }
        s++;
    }

    return 'a' + index_of_max(counters, 26);
}
```

## Files

- `main.cpp` reads a word and calls `most_frequent_letter`
- `most_frequent_letter.s` builds and fills the local counter array
- `index_of_max.s` finds the index of the first maximal counter

## What to watch in the assembly

The `counters` array has `26` elements of type `unsigned`, that is it takes up
`104` bytes. The function first saves `fp` and `lr`, and then sets aside `112`
bytes for local data. This way the frame has `128` bytes in total, and `sp`
stays aligned to `16` bytes before the call:

```asm
stp fp, lr, [sp, #-16]!
mov fp, sp
sub sp, sp, #112
mov x4, sp
```

Register `x4` points to the start of the local counter array. Each counter is
first zeroed with the instruction:

```asm
str wzr, [x4, x5, lsl #2]
```

A character is read as a single byte. If it is an uppercase letter, we convert
it to lowercase by adding the difference `'a' - 'A'`. If the character is not a
letter, we move on to the next one. For a lowercase letter, the difference
`s[i] - 'a'` is an index from `0` to `25`:

```asm
ldrb w5, [x0], #1
cmp w5, #'a'
b.lo check_uppercase
cmp w5, #'z'
b.ls increment_counter

check_uppercase:
cmp w5, #'A'
b.lo counters_ready
cmp w5, #'Z'
b.hi counters_ready
add w5, w5, #('a' - 'A')

increment_counter:
sub w5, w5, #'a'
ldr w6, [x4, x5, lsl #2]
add w6, w6, #1
str w6, [x4, x5, lsl #2]
```

In the address expression, `lsl #2` shifts the index left by `2` bits, that is
multiplies it by `4`, since each counter takes up `4` bytes. We use `x5`, the
64-bit form of the register, and the upper `32` bits are zeros because every
write to `w5` clears the upper half of the corresponding register `x5`.

After walking through the string, the address of the local array and its length
become the arguments of the helper function:

```asm
mov x0, x4
mov w1, #26
bl index_of_max
```

`index_of_max` changes the result only when it finds a strictly larger counter.
That is why on a tie the smaller index, that is the alphabetically earlier
letter, stays.

## Compilation

```sh
aarch64-linux-gnu-g++ main.cpp most_frequent_letter.s index_of_max.s -o most_frequent_letter
```

## Running

```sh
qemu-aarch64 ./most_frequent_letter
```

Example interaction:

```text
ProgRAMIRANJE
r
```

## What to pay attention to

- uppercase and lowercase letters are counted together, and the result is always
  a lowercase letter
- characters that are not letters of the English alphabet are ignored
- the string should contain at least one letter of the English alphabet
- a character is read with the `ldrb` instruction, while the counters are
  four-byte and are read and written with the `ldr` and `str` instructions
- the local array is in the stack frame, but its address is passed to the helper
  function just like the address of any other array
- `most_frequent_letter` is not a leaf function, so it must save `lr` before `bl`

## Navigation

- Previous: [Week 10](../README.md)
- Next: [Recursive string length](../02-string_length_recursive/README.md)
- Up: [Week 10](../README.md)
