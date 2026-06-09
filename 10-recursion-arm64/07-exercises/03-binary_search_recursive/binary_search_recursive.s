.text

.align 2
.global binary_search_recursive

// int binary_search_recursive(int *a, int left, int right, int x)
//  w0                          x0      w1        w2         w3
binary_search_recursive:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    cmp w1, w2
    b.gt not_found

    sub w4, w2, w1
    asr w4, w4, #1
    add w4, w1, w4       // middle = left + (right - left) / 2

    ldr w5, [x0, w4, sxtw #2]
    cmp w5, w3
    b.eq found
    b.lt search_right

    sub w2, w4, #1
    bl binary_search_recursive
    b end

search_right:
    add w1, w4, #1
    bl binary_search_recursive
    b end

found:
    mov w0, w4
    b end

not_found:
    mov w0, #-1

end:
    ldp fp, lr, [sp], #16
    ret
