.text

.align 2

.global count_in_range

// int count_in_range(unsigned long *a, int n, unsigned long l, unsigned long r);
// w0                 x0               w1        x2             x3
count_in_range:
    mov w4, #0    // w4 - count
    mov w5, #0    // w5 - i
for_loop:
    cmp w5, w1
    b.ge for_loop_end

        ldr x6, [x0, x5, lsl #3]
        cmp x6, x2
        b.lo next_element
        cmp x6, x3
        b.hi next_element
            add w4, w4, #1
    next_element:

    add w5, w5, #1
    b for_loop
for_loop_end:

    mov w0, w4
    ret

