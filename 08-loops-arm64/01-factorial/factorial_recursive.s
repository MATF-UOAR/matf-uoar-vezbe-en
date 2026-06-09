.text

.align 2
.global factorial

// unsigned factorial(unsigned n)
//  w0                  w0
factorial:
    stp fp, lr, [sp, #-32]!
    mov fp, sp

    cmp w0, #0
    b.ne recursive_case

    mov w0, #1
    b end

recursive_case:
    str w0, [sp, #16]

    sub w0, w0, #1
    bl factorial

    ldr w1, [sp, #16]
    mul w0, w1, w0

end:
    ldp fp, lr, [sp], #32
    ret
