.text

.align 2

// int palindrome_range(const char *left, const char *right)
//  w0                   x0                x1
palindrome_range:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    cmp x0, x1
    b.hs yes

    ldrb w2, [x0]
    ldrb w3, [x1]
    cmp w2, w3
    b.ne no

    add x0, x0, #1
    sub x1, x1, #1
    bl palindrome_range
    b end_range

yes:
    mov w0, #1
    b end_range

no:
    mov w0, #0

end_range:
    ldp fp, lr, [sp], #16
    ret

.align 2
.global is_palindrome_recursive

// int is_palindrome_recursive(const char *s)
//  w0                          x0
is_palindrome_recursive:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    mov x1, x0
    ldrb w2, [x1]
    cmp w2, #0
    b.eq empty_string

find_end:
    ldrb w2, [x1]
    cmp w2, #0
    b.eq end_of_search
    add x1, x1, #1
    b find_end

end_of_search:
    sub x1, x1, #1
    bl palindrome_range
    b end_pal

empty_string:
    mov w0, #1

end_pal:
    ldp fp, lr, [sp], #16
    ret
