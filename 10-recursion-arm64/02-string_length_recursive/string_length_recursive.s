.text

.align 2
.global string_length_recursive

// int string_length_recursive(const char *s)
//  w0                          x0
string_length_recursive:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    ldrb w1, [x0]
    cmp w1, #0
    b.ne recursive_case

    mov w0, #0
    b end

recursive_case:
    add x0, x0, #1
    bl string_length_recursive
    add w0, w0, #1

end:
    ldp fp, lr, [sp], #16
    ret
