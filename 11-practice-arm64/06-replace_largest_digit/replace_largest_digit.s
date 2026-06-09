.text

.align 2
.global replace_largest_digit

// unsigned replace_largest_digit(unsigned n, unsigned c)
//  w0                            w0          w1
replace_largest_digit:
    stp fp, lr, [sp, #-16]!
    mov fp, sp
    sub sp, sp, #16

    str w0, [sp]
    str w1, [sp, #4]

    bl largest_digit

    mov w9, w0
    ldr w2, [sp]
    ldr w3, [sp, #4]

    cmp w2, #0
    b.ne .prepare_loop

    mov w0, w3
    b .done

.prepare_loop:
    mov w4, #0
    mov w5, #1
    mov w10, #10

.loop:
    cmp w2, #0
    b.eq .result

    udiv w6, w2, w10
    msub w7, w6, w10, w2

    cmp w7, w9
    csel w7, w3, w7, eq

    mul w8, w7, w5
    add w4, w4, w8
    mul w5, w5, w10

    mov w2, w6
    b .loop

.result:
    mov w0, w4

.done:
    mov sp, fp
    ldp fp, lr, [sp], #16
    ret
