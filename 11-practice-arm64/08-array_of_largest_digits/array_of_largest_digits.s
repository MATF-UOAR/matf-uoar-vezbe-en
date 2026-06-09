.text

.align 2
.global array_of_largest_digits

// void array_of_largest_digits(unsigned *a, unsigned *res, int n)
//                              x0           x1             w2
array_of_largest_digits:
    stp fp, lr, [sp, #-16]!
    mov fp, sp
    sub sp, sp, #32

    stp x19, x20, [sp]
    stp x21, x22, [sp, #16]

    mov x19, x0
    mov x20, x1
    mov w21, w2
    mov w22, #0

.loop:
    cmp w22, w21
    b.ge .loop_end

    ldr w0, [x19, x22, lsl #2]
    bl largest_digit
    str w0, [x20, x22, lsl #2]

    add w22, w22, #1
    b .loop

.loop_end:
    ldp x21, x22, [sp, #16]
    ldp x19, x20, [sp]
    mov sp, fp
    ldp fp, lr, [sp], #16
    ret
