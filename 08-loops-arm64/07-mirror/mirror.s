.text

.align 2
.global mirror

// unsigned mirror(unsigned n)
//  w0              w0
mirror:
    mov w1, #0

loop:
    cmp w0, #0
    b.eq end

    lsl w1, w1, #1

    tst w0, #1
    b.eq skip_one
    add w1, w1, #1

skip_one:
    lsr w0, w0, #1
    b loop

end:
    mov w0, w1
    ret
