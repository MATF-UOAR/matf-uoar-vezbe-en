.text

.align 2
.global maximum_recursive

// int maximum_recursive(int *a, int n)
//  w0                   x0      w1
maximum_recursive:
    stp fp, lr, [sp, #-16]!
    mov fp, sp
    sub sp, sp, #16

    cmp w1, #0
    b.gt .non_empty

    mov w0, #0
    b .done

.non_empty:
    cmp w1, #1
    b.ne .recursive_case

    ldr w0, [x0]
    b .done

.recursive_case:
    ldr w2, [x0]
    str w2, [sp]

    add x0, x0, #4
    sub w1, w1, #1
    bl maximum_recursive

    ldr w2, [sp]
    cmp w2, w0
    csel w0, w2, w0, gt

.done:
    mov sp, fp
    ldp fp, lr, [sp], #16
    ret
