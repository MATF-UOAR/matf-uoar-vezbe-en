.text

.align 2
.global is_prime

// unsigned is_prime(unsigned n)
//  w0                 w0
is_prime:
    cmp w0, #2
    b.hs check_euler

    mov w0, #0
    ret

check_euler:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    sub sp, sp, #16
    str w0, [sp]

    bl euler

    ldr w1, [sp]
    add sp, sp, #16

    add w0, w0, #1
    cmp w0, w1
    b.eq is_prime_label

    mov w0, #0
    b end

is_prime_label:
    mov w0, #1

end:
    ldp fp, lr, [sp], #16
    ret
