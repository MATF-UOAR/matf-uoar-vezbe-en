# Count of positives

This is the shortest natural continuation of the `Sum of array elements` example, except that instead of adding, each element is checked and a counter is increased as needed.

The function `count_positives` takes an array and its length and returns how many elements in the array have a value greater than zero. The goal is to reinforce:

- iterating over the whole array
- comparing each element with zero
- keeping the index and the result counter separately

A reference C++ version of the function might look like this:

```cpp
int count_positives(int* arr, int n) {
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (arr[i] > 0) {
            count++;
        }
    }
    return count;
}
```

## Files

- `main.cpp` reads the length of the array and its elements, and then prints the result
- `count_positives.s` contains the assembly implementation of the function

## What to watch for in the assembly

Here too we keep the same addressing pattern as in the main examples of the week:

```asm
    cmp dword ptr [rdi + 4*rcx], 0
```

`rdi` is the base address of the array, `ecx` is the index, and we hold the result in `eax`. The only new thing is that we do not add each element, but first compare it with zero and only then increment the counter as needed.

## Compilation

```sh
g++ main.cpp count_positives.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
5
-2 0 7 3 -1
2
```

## What to pay attention to

- zero does not count as a positive element
- access to an array element is still of the form `[rdi + 4 * index]`
- the main difference compared to `Sum of array elements` is that the result does not depend on the value of an element, but on the outcome of a comparison

## Navigation

- Previous: [Standalone mini-examples](../README.md)
- Next: [Minimum](../02-minimum/README.md)
