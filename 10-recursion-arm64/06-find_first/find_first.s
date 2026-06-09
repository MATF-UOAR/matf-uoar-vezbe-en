.text

.align 2
.global find_first

// int find_first(unsigned *a, int n, int (*pred)(unsigned))
//  w0            x0           w1     x2
find_first:
    stp fp, lr, [sp, #-16]!
    mov fp, sp
    sub sp, sp, #32

    stp x19, x20, [sp]
    stp x21, x22, [sp, #16]

    mov x19, x0             // a
    mov w20, w1             // n
    mov x21, x2             // pred
    mov w22, #0             // i = 0

loop:
    cmp w22, w20
    b.ge not_found

    ldr w0, [x19, x22, lsl #2]
    blr x21

    cmp w0, #0
    b.ne found

    add w22, w22, #1
    b loop

found:
    mov w0, w22
    b end

not_found:
    mov w0, #-1

end:
    ldp x21, x22, [sp, #16]
    ldp x19, x20, [sp]
    mov sp, fp
    ldp fp, lr, [sp], #16
    ret
