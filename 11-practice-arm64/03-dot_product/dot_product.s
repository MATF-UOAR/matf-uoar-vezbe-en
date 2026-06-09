.text

.align 2
.global dot_product

// int dot_product(int *a, int *b, int n)
//  w0              x0      x1      w2
dot_product:
    mov w3, #0
    mov w4, #0

.loop:
    cmp w4, w2
    b.ge .done

    ldr w5, [x0, x4, lsl #2]
    ldr w6, [x1, x4, lsl #2]
    mul w5, w5, w6
    add w3, w3, w5

    add w4, w4, #1
    b .loop

.done:
    mov w0, w3
    ret
