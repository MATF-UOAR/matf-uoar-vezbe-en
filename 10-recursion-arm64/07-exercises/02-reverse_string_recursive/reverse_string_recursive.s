.text

.align 2

// void reverse_range(char *left, char *right)
//  -                  x0          x1
reverse_range:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    cmp x0, x1
    b.hs end_of_range

    ldrb w2, [x0]
    ldrb w3, [x1]
    strb w3, [x0]
    strb w2, [x1]

    add x0, x0, #1
    sub x1, x1, #1
    bl reverse_range

end_of_range:
    ldp fp, lr, [sp], #16
    ret

.align 2
.global reverse_string_recursive

// void reverse_string_recursive(char *s)
//  -                              x0
reverse_string_recursive:
    stp fp, lr, [sp, #-16]!
    mov fp, sp

    mov x1, x0
    ldrb w2, [x1]
    cmp w2, #0
    b.eq end

find_end:
    ldrb w2, [x1]
    cmp w2, #0
    b.eq end_of_search
    add x1, x1, #1
    b find_end

end_of_search:
    sub x1, x1, #1
    bl reverse_range

end:
    ldp fp, lr, [sp], #16
    ret
