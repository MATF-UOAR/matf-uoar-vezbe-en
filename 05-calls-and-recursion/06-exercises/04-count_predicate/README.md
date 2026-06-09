# Count via a predicate function

This is a short example with an indirect `call`, but unlike `find_first` we do not stop at the first match; instead we go through the entire array.

## What the program does

The `count_predicate` function counts how many array elements give a nonzero result when the passed predicate function is called on them.

Reference C++ version:

```cpp
int count_predicate(unsigned* a, int n, int (*pred)(unsigned)) {
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (pred(a[i])) {
            count++;
        }
    }
    return count;
}
```

## What to observe in the assembly

The indirect-call mechanism is the same as in `find_first`: the function's address arrives as an argument, is saved in the stack frame, and is called via that address. The difference is in the control flow: here, after a match, we do not return the result immediately, but increment the counter and continue through the rest of the array.

| value | why it is saved |
| --- | --- |
| `a` | so that after each `call` we can fetch the next element |
| `pred` | so that on each iteration we can make the indirect call |
| `n` | so that we know where the loop ends |
| `i` | so that we continue the loop after returning from `pred` |
| `count` | so that the number of matches is not lost after the next `call` |

## Compilation

```sh
g++ main.cpp count_predicate.s
```

## Running

```sh
./a.out
```

Example interaction:

```text
6
11 15 18 21 130 7
even: 2
> 99: 1
```

## What to pay attention to

- the predicate function's address must remain available on every iteration
- the match counter must survive each indirect `call`
- unlike `find_first`, there is no early termination here: even after a match we keep going through the array

## Navigation

- Previous: [Recursive array sum](../03-array_sum_recursive/README.md)
- Next: [Recursive string length](../05-string_length_recursive/README.md)
- Up: [Standalone mini-examples](../README.md)
