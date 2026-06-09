.text

.align 2
.global maximum

// int maximum(int *a, int n)
//  w0         x0      w1
maximum:
    ldr w2, [x0], #4
    sub w1, w1, #1

.loop:
    cmp w1, #0
    b.eq .done

    ldr w3, [x0], #4
    cmp w3, w2
    csel w2, w3, w2, gt

    sub w1, w1, #1
    b .loop

.done:
    mov w0, w2
    ret
