.text

.align 2
.global power_recursive

// unsigned power_recursive(unsigned a, unsigned n)
//  w0                      w0          w1
power_recursive:
    stp fp, lr, [sp, #-16]!
    mov fp, sp
    sub sp, sp, #16

    str w0, [sp]           // a
    str w1, [sp, #4]       // n

    cmp w1, #0
    b.ne recursive_case

    mov w0, #1
    b end

recursive_case:
    lsr w1, w1, #1
    bl power_recursive

    mul w0, w0, w0         // p * p, where p = a^(n / 2)

    ldr w1, [sp, #4]
    tst w1, #1
    b.eq end

    ldr w1, [sp]
    mul w0, w0, w1         // a * p * p when n is odd

end:
    mov sp, fp
    ldp fp, lr, [sp], #16
    ret
