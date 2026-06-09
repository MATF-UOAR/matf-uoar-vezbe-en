.text

.align 2
.global largest_digit

// unsigned largest_digit(unsigned n)
//  w0                    w0
largest_digit:
    mov w1, #0
    mov w10, #10

.loop:
    cmp w0, #0
    b.eq .done

    udiv w2, w0, w10
    msub w3, w2, w10, w0

    cmp w3, w1
    csel w1, w3, w1, hi

    mov w0, w2
    b .loop

.done:
    mov w0, w1
    ret
