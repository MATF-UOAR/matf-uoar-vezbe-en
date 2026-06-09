.text

.align 2
.global euler

// unsigned euler(unsigned n)
//  w0                 w0
euler:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    mov w1, w0  // w1 = n
    mov w2, #0  // w2 = count
    mov w3, #1  // w3 = i

for_loop:
    cmp w3, w1
    b.hs loop_end

    sub sp, sp, #16
    str w1, [sp]
    str w2, [sp, #4]
    str w3, [sp, #8]

    mov w0, w3
    bl gcd

    ldr w1, [sp]
    ldr w2, [sp, #4]
    ldr w3, [sp, #8]
    add sp, sp, #16

    cmp w0, #1
    b.ne not_coprime
    add w2, w2, #1

not_coprime:
    add w3, w3, #1
    b for_loop

loop_end:
    mov w0, w2

    ldp fp, lr, [sp], #16
    ret
