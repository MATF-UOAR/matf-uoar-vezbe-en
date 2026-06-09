.text

.align 2
.global lcm

// unsigned lcm(unsigned a, unsigned b)
//  w0           w0          w1
lcm:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    sub sp, sp, #16
    str w0, [sp]
    str w1, [sp, #4]

    bl gcd

    cmp w0, #0
    b.eq both_zero

    mov w2, w0
    ldr w3, [sp]
    ldr w4, [sp, #4]

    udiv w5, w3, w2
    mul w0, w5, w4
    b end

both_zero:
    mov w0, #0

end:
    add sp, sp, #16
    ldp fp, lr, [sp], #16
    ret
