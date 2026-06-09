.text

.align 2
.global gcd_recursive

// unsigned gcd_recursive(unsigned a, unsigned b)
//  w0                     w0          w1
gcd_recursive:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    cmp w1, #0
    b.eq end

    udiv w2, w0, w1
    msub w2, w2, w1, w0   // w2 = a % b

    mov w0, w1
    mov w1, w2
    bl gcd_recursive

end:
    ldp fp, lr, [sp], #16
    ret
