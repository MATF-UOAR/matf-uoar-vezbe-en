# Solutions - Practice Exam 2

This directory contains detailed solutions for all four tasks from the second
practice exam.

## Task 1: Number Weight (x86-64)

Reference C++ implementation:

```cpp
unsigned long weight(unsigned long x) {
    unsigned long sum = 0;
    while (x > 0) {
        unsigned long digit = x % 10;
        sum += digit * digit;
        x /= 10;
    }
    return sum;
}
```

## Task 2: Heaviest Element (x86-64)

Reference C++ implementation:

```cpp
unsigned long heaviest(unsigned long *a, int n) {
    unsigned long max_weight = 0;
    unsigned long result = 0;

    for (int i = 0; i < n; i++) {
        unsigned long w = weight(a[i]);
        if (w > max_weight) {
            max_weight = w;
            result = a[i];
        }
    }
    return result;
}
```

## Task 3: Number of Elements in a Range (ARM64)

Reference C++ implementation:

```cpp
int count_in_range(unsigned long *a, int n, unsigned long l, unsigned long r) {
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (a[i] >= l && a[i] <= r)
            count++;
    }
    return count;
}
```

## Task 4: Typical Elements (ARM64)

Reference C++ implementation:

```cpp
int count_typical(unsigned long *a, int n) {
    unsigned long mean, median;
    statistics(a, n, &mean, &median);

    unsigned long l = (mean < median) ? mean : median;
    unsigned long r = (mean > median) ? mean : median;

    return count_in_range(a, n, l, r);
}
```

