.text

.align 2
.global string_length

// int string_length(const char *s);
// w0                 x0
string_length:
    mov x1, x0
    mov w0, #0
loop:
    ldrb w2, [x1, x0]
    cmp w2, #0
    b.eq end

    add w0, w0, #1
    b loop
end:
    ret
