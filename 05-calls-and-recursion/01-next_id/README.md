# Next ID

This is the shortest example of the week, and on it we see the cleanest form of a function with static state.

- a function can have its own static data that lives outside the stack
- the value of that data can change from call to call

## What the program does

The program calls the `next_id` function several times. That function remembers the last assigned number and returns the next one each time.

A reference C++ version could look like this:

```cpp
unsigned next_id() {
    static unsigned last_id = 0;
    last_id++;
    return last_id;
}
```

## Files

- `main.cpp` calls `next_id` several times and prints the return value
- `next_id.s` contains the assembly implementation of the function

## What to observe in the assembly

The static counter is not a local variable on the stack, but data with a static lifetime:

```asm
.bss
last_id: .zero 4
```

This is the assembly equivalent of a C++ local `static` variable: its scope is "tied" to the function, but its value survives across multiple calls.

The `.bss` section is used for data that has a static lifetime and an initial value of zero, so `last_id` already has the value `0` at the start of the program.

We also use the `.align 4` directive to make sure our static variable is located at an address divisible by 4. This is useful because it makes reading the data from memory easier, the so-called Aligned Access.
On each call we just increment that value in memory and then return it via `eax`:

```asm
add dword ptr [rip + last_id], 1
mov eax, [rip + last_id]
```

The form `[rip + last_id]` means the symbol is accessed relative to the current instruction. This is the usual way to fetch global or static data in 64-bit code.

Even though there is no call to another function here, we still keep `enter` and `leave` so the listing is uniform with the other examples this week.

## Compilation

```sh
g++ main.cpp next_id.s
```

## Running

```sh
./a.out
```

Example output:

```text
1
2
3
4
```

## What to pay attention to

- `last_id` is not on the stack, so it is not erased after `leave`
- an ordinary local value belongs to a single function call, while a static value belongs to the entire lifetime of the program
- `enter` and `leave` are not necessary here, but they keep the listing uniform with the rest of the week

## Navigation

- Previous: [Week 5](../README.md)
- Next: [Array range](../02-range/README.md)
- Up: [Week 5](../README.md)
