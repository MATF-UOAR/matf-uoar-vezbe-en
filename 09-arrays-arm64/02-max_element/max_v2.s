.text

.align 2
.global max_element

// int max_element(int *a, int n)
// w0              x0        w1
max_element:
    ldr w2, [x0]      // w2 = max = a[0]
loop:
    cmp w1, #1
    b.le end_loop

    ldr w3, [x0, #4]! // w3 = a[i]
    cmp w3, w2
    csel w2, w3, w2, gt

    sub w1, w1, #1
    b loop
end_loop:

    mov w0, w2
    ret
