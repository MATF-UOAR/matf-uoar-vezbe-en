.text

.align 2
.global sum_two

// int sum_two(int a, int b)
// w0           w0     w1
sum_two:
    // fp and lr are aliases for x29 and x30; either spelling works.
    stp fp, lr, [sp, #-16]!
    mov fp, sp
    sub sp, sp, #16

    str w0, [sp, 8]
    str w1, [sp, 12]

    ldr w2, [sp, 8]
    ldr w3, [sp, 12]
    add w0, w2, w3

    mov sp, fp
    ldp fp, lr, [sp], #16
    ret
