# LCM

This is the best short continuation of the `euler` example, since one assembly function calls another and then continues computing over the obtained result.

The `lcm` function returns the least common multiple of the numbers `a` and `b`. The goal is to reinforce:

- calling the helper function `gcd`
- saving the arguments that we still need after `call`
- the formula `a / gcd(a, b) * b`

A reference C++ version of the function could look like this:

```cpp
unsigned gcd(unsigned a, unsigned b);

unsigned lcm(unsigned a, unsigned b) {
    unsigned d = gcd(a, b);
    if (d == 0) {
        return 0;
    }
    return a / d * b;
}
```

## Files

- `main.cpp` reads two numbers and prints their LCM
- `lcm.s` contains the assembly implementation of the `lcm` function
- `gcd.s` contains the helper assembly function `gcd`

## Compilation

```sh
g++ main.cpp lcm.s gcd.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
12 18
lcm(12, 18) = 36
```

## What to pay attention to

- before `call gcd` we save `a` and `b`, since we still need them after the call
- the stack must remain correctly aligned before `call`
- we pay special attention to the case `a = 0` and `b = 0`, so that we do not divide by zero

## Navigation

- Previous: [Divisor count](../04-divisor-count/README.md)
- Up: [Self-study mini-examples](../README.md)
