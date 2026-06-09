.text

.align 2
.global word_count

// unsigned word_count(const char *s)
//  w0                 x0
word_count:
    mov w1, #0
    mov w2, #0

.loop:
    ldrb w3, [x0], #1
    cmp w3, #0
    b.eq .done

    cmp w3, #' '
    b.eq .space

    cmp w2, #0
    b.ne .loop

    add w1, w1, #1
    mov w2, #1
    b .loop

.space:
    mov w2, #0
    b .loop

.done:
    mov w0, w1
    ret
