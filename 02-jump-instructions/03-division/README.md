# Division

The instructions `div` and `idiv` are used for integer division, but they have one feature that is important to notice right away: they have only one explicit operand. That operand is the divisor. The dividend is not given in the instruction itself; it is implied.

When we do 32-bit division, this means:

- `div esi` or `idiv esi` divide the value in `edx:eax` by `esi`
- the quotient ends up in `eax`
- the remainder ends up in `edx`

So the divisor is 32-bit, while the dividend is 64-bit. This is the place where assembly stops resembling C/C++. In C/C++ we write `a / b`, where `a` and `b` act like two ordinary 32-bit numbers. The processor, however, does not expect two operands of equal width: it expects a 64-bit dividend in `edx:eax` and a 32-bit divisor in the other operand. That is why, when dividing, we write the dividend into the lower bits (the `eax` register) and fill the higher bits (the `edx` register) in such a way that we do not change the value of the dividend.

This is easiest to see on a 4-bit example. If we want to divide the unsigned numbers `0101` and `0010`, the divisor is 4-bit, but the dividend has to be 8-bit. When we write the number `0101` on 8 binary digits, the division that is performed is:

```text
0000 0101 / 0010
```

The upper half is filled with zeros both in the `unsigned` case and in the `int` case.

Things change a little when we divide larger numbers, or when we try to divide negative numbers. Suppose we want to divide the 4-bit number `1011` by `0010`. If we treat them as the type `unsigned`, the division that is performed is:

```text
0000 1011 / 0010
```
If, on the other hand, we treat them as the type `int`, the dividend has the value `-5` and its representation on 8 bits is `1111 1011`. The division that is performed in this case is:
```text
1111 1011 / 0010
```

Here we see a clear difference between dividing different types:
- for an `unsigned` dividend we extend with zeros using `xor edx, edx` (or `mov edx, 0`)
- for an `int` dividend we extend with its sign using `cdq`

For this reason, in the correct versions of the code these 3 lines are exactly what matters:

```asm
mov eax, edi
cdq
idiv esi
```

and

```asm
mov eax, edi
xor edx, edx
div esi
```


One more small technical detail in this example is that the third and fourth parameters are references, so we receive them as addresses in the registers `rdx` and `rcx`. In order to preserve these values, we move them into `r8` and `r9`, and only then use `edx` as the upper half of the dividend.

## What the program does

- reads two `int` numbers and computes the quotient and remainder with the function `divide_int`
- reads two `unsigned` numbers and computes the quotient and remainder with the function `divide_unsigned`

## Files

- `main.cpp` reads the inputs and clearly separates the `int` and `unsigned` parts of the output
- `divide_int.s` is the correct assembly version for `int`
- `divide_unsigned.s` is the correct assembly version for `unsigned`
- `divide_int_wrong.s` is a deliberately incorrect version that uses `xor edx, edx` before `idiv`
- `divide_unsigned_wrong.s` is a deliberately incorrect version that uses `cdq` before `div`

## Compilation

```sh
g++ main.cpp divide_int.s divide_unsigned.s -o division_ok
```

## Running

```sh
./division_ok
```

Example interaction:

```text
[int]
Enter a and b: -7 3
Result: -7 / 3 = -2, -7 % 3 = -1

[unsigned]
Enter a and b: 17 5
Result: 17 / 5 = 3, 17 % 5 = 2
```

## Incorrect versions

### `divide_int_wrong.s`

Here `xor edx, edx` is done before `idiv`. If we go back to the 4-bit example, this means that the number `1011`, instead of being correctly extended to `1111 1011`, is extended to `0000 1011`. In other words, instead of `-5` we get `+11`. The same mistake happens in the 32-bit version: a negative `a` gets the wrong upper half, so `idiv` divides a completely different number.

Compilation:

```sh
g++ main.cpp divide_int_wrong.s divide_unsigned.s -o division_bad_int
```

Wrong input:

```text
[int]
Enter a and b: -7 3
Result: -7 / 3 = 1431655763, -7 % 3 = 0

[unsigned]
Enter a and b: 17 5
Result: 17 / 5 = 3, 17 % 5 = 2
```

Here the `unsigned` part is correct, while the `int` part gives a meaningless result, because the negative dividend behaves like a large positive number.

### `divide_unsigned_wrong.s`

Here `cdq` is done before `div`. If we go back to the 4-bit model, the number `1101` should become `0000 1101`, since it is `unsigned`. The incorrect version, however, makes the analogous `1111 1101`. For `div` this is a huge unsigned number, not `13`. When we then try to divide by `0010`, the resulting quotient no longer fits into the result register, so the processor reports an error.

Compilation:

```sh
g++ main.cpp divide_int.s divide_unsigned_wrong.s -o division_bad_unsigned
```

Wrong input:

```text
[int]
Enter a and b: 7 3
Result: 7 / 3 = 2, 7 % 3 = 1

[unsigned]
Enter a and b: 4000000000 3
```

After the last input the program is terminated before printing the `unsigned` result, with the message `Floating point exception`, and the cause is a `divide error` during the execution of the `div` instruction.

## Navigation

- Previous: [Maximum of two numbers](../02-max/README.md)
- Next: [Divisibility by 4](../04-divisible-by-4/README.md)
