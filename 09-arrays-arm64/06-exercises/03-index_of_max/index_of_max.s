.text

.align 2
.global index_of_max

// int index_of_max(int *a, int n);
// w0                x0      w1
index_of_max:
    ldr w2, [x0]  // w2 = max = a[0]
    mov w3, #0    // w3 = index of max
    mov w4, #1    // w4 = i
loop:
    cmp w4, w1
    b.ge end_loop

    ldr w5, [x0, x4, lsl #2]
    cmp w5, w2
    b.le continue

    mov w2, w5
    mov w3, w4

continue:
    add w4, w4, #1
    b loop
end_loop:

    mov w0, w3
    ret
