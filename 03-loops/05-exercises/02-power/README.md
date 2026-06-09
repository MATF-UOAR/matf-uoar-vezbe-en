# Power

This example reinforces the same idea as `factorial`, but now the function has two arguments: the base and the number of repetitions.

The `power` function returns the value `a^n` using repeated multiplication. The goal is to reinforce:

- a `for` loop whose number of iterations is given by the second argument
- working with two `unsigned` arguments
- an initial result value of `1`

A reference C++ version of the function could look like this:

```cpp
unsigned power(unsigned a, unsigned n) {
    unsigned result = 1;
    for (unsigned i = 0; i < n; i++) {
        result *= a;
    }
    return result;
}
```

## Files

- `main.cpp` reads the base and the exponent and prints the result
- `power.s` contains the assembly implementation of the function

## Compilation

```sh
g++ main.cpp power.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
3 4
3^4 = 81
```

## What to pay attention to

- the arguments `a` and `n` arrive in `edi` and `esi`
- `a^0` is `1`, so the accumulator starts from `1`
- the condition `i < n` is written here in assembly as an unsigned comparison

## Navigation

- Previous: [Factorial](../01-factorial/README.md)
- Next: [Sum of digits](../03-sum-of-digits/README.md)
