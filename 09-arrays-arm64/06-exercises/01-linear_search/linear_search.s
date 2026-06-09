.text

.align 2
.global linear_search

// int linear_search(int *a, int n, int x);
// w0                 x0      w1     w2
linear_search:
    mov w3, #0  // w3 = i
loop:
    cmp w3, w1
    b.ge not_found

    ldr w4, [x0, x3, lsl #2]
    cmp w4, w2
    b.eq found

    add w3, w3, #1
    b loop

not_found:
    mov w0, #-1
    ret

found:
    mov w0, w3
    ret
