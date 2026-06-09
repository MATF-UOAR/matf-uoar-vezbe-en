.text

.align 2
.global max_element

// int max_element(int *a, int n)
// w0              x0        w1
max_element:
    ldr w2, [x0]  // w2 = max = a[0]
    mov w3, #1    // w3 = i
loop:
    cmp w3, w1
    b.ge end_loop

    ldr w4, [x0, x3, lsl #2]  // w4 = a[i]
    cmp w4, w2
    csel w2, w4, w2, gt

    add w3, w3, #1
    b loop
end_loop:

    mov w0, w2
    ret
