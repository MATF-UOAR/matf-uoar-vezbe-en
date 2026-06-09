.text

.align 2
.global count_predicate

// int count_predicate(unsigned *a, int n, int (*pred)(unsigned))
//  w0                 x0           w1     x2
count_predicate:
    stp fp, lr, [sp, #-16]!
    mov fp, sp
    sub sp, sp, #32

    str x0, [sp]            // a
    str x2, [sp, #8]        // pred
    str w1, [sp, #16]       // n
    str wzr, [sp, #20]      // i = 0
    str wzr, [sp, #24]      // count = 0

loop:
    ldr w3, [sp, #20]
    ldr w4, [sp, #16]
    cmp w3, w4
    b.ge end_of_loop

    ldr x4, [sp]
    ldr w0, [x4, w3, sxtw #2]
    ldr x8, [sp, #8]
    blr x8

    cmp w0, #0
    b.eq not_a_hit

    ldr w3, [sp, #24]
    add w3, w3, #1
    str w3, [sp, #24]

not_a_hit:
    ldr w3, [sp, #20]
    add w3, w3, #1
    str w3, [sp, #20]
    b loop

end_of_loop:
    ldr w0, [sp, #24]

    mov sp, fp
    ldp fp, lr, [sp], #16
    ret
