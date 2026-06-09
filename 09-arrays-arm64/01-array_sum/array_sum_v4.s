.text

.align 2
.global array_sum

// int array_sum(int *a, int n)
// w0             x0      w1
array_sum:
    mov w2, #0  // w2 = sum
loop:
    cmp w1, #0
    b.le end_loop

    ldr w3, [x0], #4
    add w2, w2, w3

    sub w1, w1, #1
    b loop
end_loop:

    mov w0, w2
    ret
