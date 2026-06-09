# Leap year

This example combines division, the remainder, and several consecutive branches.

The function `is_leap_year` returns `1` if the year is a leap year, and `0` otherwise. The goal is to reinforce:

- reusing the pattern `mov eax, ...`, `cdq`, `idiv`
- how several conditions are checked one after another
- that the remainder from `edx` can be used several times in the same function

A reference C++ version of the function could look like this:

```cpp
int is_leap_year(int year) {
    if (year % 400 == 0) {
        return 1;
    }
    if (year % 100 == 0) {
        return 0;
    }
    if (year % 4 == 0) {
        return 1;
    }
    return 0;
}
```

## Files

- `main.cpp` reads the year and prints the result
- `leap_year.s` contains the assembly implementation of the function `is_leap_year`

## Compilation

```sh
g++ main.cpp leap_year.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
2024
Leap year
```

## What to pay attention to

- before each `idiv` we prepare `edx:eax` again
- the order of the checks matters: `400`, then `100`, then `4`
- this is a simplified rule for the Gregorian calendar and is quite enough for the exercise

## Navigation

- Previous: [Max3](../02-max3/README.md)
- Next: [Season](../04-season/README.md)
