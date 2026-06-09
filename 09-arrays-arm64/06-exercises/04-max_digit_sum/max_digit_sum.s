.text

.align 2
.global max_digit_sum

// unsigned max_digit_sum(unsigned *a, int n);
// w0                      x0          w1
max_digit_sum:
    mov w2, #0   // w2 = max digit sum
    mov w3, #0   // w3 = i
    mov w10, #10
outer_loop:
    cmp w3, w1
    b.ge end_outer_loop

    ldr w4, [x0, x3, lsl #2]  // w4 = a[i]
    mov w5, #0                // w5 = digit sum
inner_loop:
    cmp w4, #0
    b.eq end_inner_loop

    udiv w6, w4, w10
    msub w7, w6, w10, w4
    add w5, w5, w7
    mov w4, w6

    b inner_loop
end_inner_loop:
    cmp w5, w2
    csel w2, w5, w2, hi

    add w3, w3, #1
    b outer_loop
end_outer_loop:

    mov w0, w2
    ret
