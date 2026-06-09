# Season

This is a short `switch` task that also uses `puts`.

The function `season` takes a month number and prints the corresponding season. The goal is to reinforce:

- that several `case` values can lead into the same block of code
- that the `default` branch can print a special message
- working with `.rodata`, `lea`, and `puts` in a function that branches execution

A reference C++ version of the function could look like this:

```cpp
void season(int month) {
    switch (month) {
    case 12:
    case 1:
    case 2:
        puts("Winter");
        break;
    case 3:
    case 4:
    case 5:
        puts("Spring");
        break;
    case 6:
    case 7:
    case 8:
        puts("Summer");
        break;
    case 9:
    case 10:
    case 11:
        puts("Autumn");
        break;
    default:
        puts("Invalid month");
    }
}
```

## Files

- `main.cpp` reads the month number and calls the function `season`
- `season.s` contains the assembly implementation of the function

## Compilation

```sh
g++ main.cpp season.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
4
Prolece
```

## What to pay attention to

- this is the same pattern as in the example with the number of days in a month, only now the `case` branches lead to different `puts` calls
- we load the addresses of the strings with `lea rdi, [rip+...]`
- after one print we need to skip the remaining branches and go to the end of the function

## Navigation

- Previous: [Leap year](../03-leap-year/README.md)
