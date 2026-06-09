.text

.align 2
.global sum_two

// int sum_two(int a, int b)
// w0           w0     w1
sum_two:
    add w0, w0, w1
    ret
