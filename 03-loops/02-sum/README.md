# Sum

In this example we see how a `for` loop is implemented and how the multiplication instruction `mul` is used.

## What the program does

The program reads an `unsigned` number `n` and prints the sum of the first `n` natural numbers.

A reference C++ function could look like this:

```cpp
unsigned sum_to_n(unsigned n) {
    unsigned current_sum = 0;
    for (unsigned i = 1; i <= n; i++) {
        current_sum += i;
    }
    return current_sum;
}
```

The structure of a `for` loop is almost the same as the structure of a `while` loop. The difference is that before the start we must initialize the index (`i = 1`), and at the end of the loop body we increment it (`i++`).

The following figure visually separates those four parts: initialization, condition check, loop body, and increment.

![Mapping of the parts of a `for` loop onto the assembly structure](assets/for-loop-assembly.png)

## What to watch for in the assembly

First we choose registers for the current sum and the index:

```asm
    xor eax, eax   # eax = current_sum
    mov ecx, 1     # ecx = i
```

Then at the start of each iteration we check whether it is time to leave the loop:

```asm
for_loop:
    cmp edi, ecx
    jb  for_loop_end
```

Here the condition is written as "if `n < i`, leave the loop", which is equivalent to the C++ condition `i <= n`.

In the loop body we add the current index to the sum, increment the index, and jump back:

```asm
    add eax, ecx
    add ecx, 1
    jmp for_loop
```

## Implementation without a loop

The sum of the first `n` natural numbers equals `n * (n + 1) / 2`, so we can try to get the same result without a loop.

For that we need the `mul` instruction. Like `div`, it also has a single explicit operand. It multiplies that operand by the value in `eax`, and places the full 64-bit product in `edx:eax`:

```asm
    mov eax, edi
    add edi, 1
    mul edi
```

An important detail here is that after `mul` we already have the whole product in `edx:eax`. That is why this time we must not do `xor edx, edx`: in the division examples we zeroed `edx` because we started from a 32-bit dividend in `eax`, but here that same instruction would wipe out the upper half of the already computed product.

A concrete example for `n = 65536` looks like this:

| Step | `edx` | `eax` | Together (`edx:eax`) |
| --- | --- | --- | --- |
| after `mov eax, edi` and `add edi, 1` | irrelevant | `0x00010000` | `eax = n`, and the other factor is `0x00010001` |
| after `mul edi` | `0x00000001` | `0x00010000` | `0x00000001_00010000` |

We can also read this as one 64-bit result:

```text
edx:eax = 0x00000001_00010000
             [edx]    [eax]
```

Since `n` and `n + 1` are consecutive numbers, one of them is always even. Therefore the product `n * (n + 1)` is always divisible by `2`, so dividing by `2` can be viewed as shifting the whole 64-bit result `edx:eax` one bit to the right:

```asm
    shrd eax, edx, 1
```

Since the function returns only an `unsigned` anyway, in the end only the `eax` register matters to us. That is why it is enough here that `shrd eax, edx, 1` computes the lower 32 bits of the value `n * (n + 1) / 2`.

For the same example it looks like this:

```text
before `shrd`:
    edx:eax = 0x00000001_00010000

after `shrd eax, edx, 1`:
    eax = 0x80008000
```

In other words, we do not divide only what is in `eax`, but the whole 64-bit number composed of `edx` and `eax`.

If after `mul` we did do `xor edx, edx`, we would lose the upper 32 bits of the product. In the example for `n = 65536`:

- the correct result is `2147516416` (`0x80008000`)
- if `edx` is set to zero after `mul`, we get `32768` (`0x00008000`)

We might also think it is enough to simply do `div 2` after `mul`, without zeroing `edx`. That would indeed divide the whole 64-bit product, but `div` requires the quotient to fit in `eax`. When the mathematical result exceeds `2^32 - 1`, the processor reports a `divide error`.

That is not desirable here, because the function returns an `unsigned` and it is natural for it to behave like the loop version, that is, for the result to simply overflow into 32 bits. For example, for `n = 100000` the loop version returns `705082704`; a direct `div` over the whole `edx:eax` would abort the program here instead of returning the lower 32 bits of the result.

Note: as with division, there is also a variant for signed numbers. `imul` is used for signed multiplication, while `mul` works with unsigned values.

## Files

- `main.cpp` reads one number and calls `sum_to_n`
- `sum_to_n.s` contains the assembly implementation of the function with a loop
- `sum_to_n_product.s` contains the assembly implementation of the function without a loop

## Compilation

For the loop version:

```sh
g++ main.cpp sum_to_n.s
```

For the version without a loop:

```sh
g++ main.cpp sum_to_n_product.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
5
15
```

## What to pay attention to

- the `for` loop here reduces to initialization, condition check, body, and increment
- `mul` writes the full product into `edx:eax`, so after multiplication we must not mechanically zero `edx`
- in division we zeroed `edx` in order to build a 64-bit dividend from a 32-bit value; here `edx` is already part of the correct multiplication result
- `xor edx, edx` then `div 2` gives a wrong result, and a direct `div 2` over the whole `edx:eax` may report a `divide error` when the quotient does not fit in `eax`
- that is why in the version without a loop we take the lower 32 bits of the quotient using `shrd`

## Navigation

- Previous: [GCD](../01-gcd/README.md)
- Next: [Sum of even numbers](../03-sum-of-evens/README.md)
