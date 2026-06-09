.text

.align 2
.global count_ones_recursive

// unsigned count_ones_recursive(unsigned n)
//  w0                           w0
count_ones_recursive:
    stp fp, lr, [sp, #-16]!
    mov fp, sp
    sub sp, sp, #16

    cmp w0, #0
    b.ne .recursive_case

    mov w0, #0
    b .done

.recursive_case:
    and w1, w0, #1
    str w1, [sp]

    lsr w0, w0, #1
    bl count_ones_recursive

    ldr w1, [sp]
    add w0, w0, w1

.done:
    mov sp, fp
    ldp fp, lr, [sp], #16
    ret
