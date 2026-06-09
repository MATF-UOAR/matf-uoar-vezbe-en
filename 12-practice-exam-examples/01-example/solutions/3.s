.text
.align 2

.global clean_string

// int clean_string(char *s);
// w0               x0
clean_string:
    mov w1, #0  // w1 - count
    mov w2, #0  // w2 - i
for_loop:
    ldrb w3, [x0, x2] // w3 - s[i]
    cmp w3, 0
    b.eq for_loop_end

        cmp w3, #'0'
        b.lt not_digit
        cmp w3, #'9'
        b.gt not_digit
            mov w3, #'#'
            strb w3, [x0, x2]
            add w1, w1, #1
        b next_char
    not_digit:
    cmp w3, #'A'
    b.lt not_uppercase
    cmp w3, #'Z'
    b.gt not_uppercase
        add w3, w3, #('a'-'A')
        strb w3, [x0, x2]
        add w1, w1, #1
not_uppercase:

next_char:
    add w2, w2, #1
    b for_loop
for_loop_end:

    mov w0, w1
    ret

