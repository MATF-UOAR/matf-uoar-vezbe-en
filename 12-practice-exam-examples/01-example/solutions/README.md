# Solutions - Practice Exam 1

This directory contains detailed solutions for all four tasks from the first
practice exam.

## Task 1: More Even Digits (x86-64)

Reference C++ implementation:

```cpp
int more_even_digits(long *a, int n) {
    int count = 0;
    for (int i = 0; i < n; i++) {
        long num = a[i];
        int even_count = 0, odd_count = 0;

        do {
            int digit = num % 10;
            if (digit % 2 == 0)
                even_count++;
            else
                odd_count++;
            num /= 10;
        } while (num != 0);

        if (even_count > odd_count)
            count++;
    }
    return count;
}
```

## Task 2: Elements Between the Minimum and Maximum (x86-64)

Reference C++ implementation:

```cpp
int count_between_extremes(long *a, int n) {
    long min, max;

    minmax(a, n, &min, &max);

    int count = 0;
    for (int i = 0; i < n; i++) {
        if (a[i] > min && a[i] < max)
            count++;
    }
    return count;
}
```

## Task 3: Clean a String (ARM64)

Reference C++ implementation:

```cpp
int clean_string(char *s) {
    int count = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] >= '0' && s[i] <= '9') {
            s[i] = '#';
            count++;
        } else if (s[i] >= 'A' && s[i] <= 'Z') {
            s[i] = s[i] - 'A' + 'a';
            count++;
        }
    }
    return count;
}
```

## Task 4: Sum of Colorful Numbers (ARM64)

Reference C++ implementation:

```cpp
long sum_colorful(long *a, int n) {
    long sum = 0;
    for (int i = 0; i < n; i++) {
        if (is_colorful(a[i]) != 0)
            sum += a[i];
    }
    return sum;
}
```

