.text

.align 2
.global array_sum_recursive

// int array_sum_recursive(int *a, int n)
//  w0                     x0     w1
array_sum_recursive:
    stp fp, lr, [sp, #-16]!
    mov fp, sp
    sub sp, sp, #16

    cmp w1, #0
    b.ne recursive_case

    mov w0, #0
    b end

recursive_case:
    ldr w2, [x0]
    str w2, [sp]

    add x0, x0, #4
    sub w1, w1, #1
    bl array_sum_recursive

    ldr w1, [sp]
    add w0, w0, w1

end:
    mov sp, fp
    ldp fp, lr, [sp], #16
    ret
