.text

.align 2
.global array_sum

// int array_sum(int *a, int n)
// w0             x0      w1
array_sum:
    mov w2, #0  // w2 = sum
    mov w3, #0  // w3 = i
loop:
    cmp w3, w1
    b.ge end_loop

    ldr w4, [x0, x3, lsl #2]
    add w2, w2, w4

    add w3, w3, #1
    b loop
end_loop:

    mov w0, w2
    ret
