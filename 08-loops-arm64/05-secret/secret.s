.text

.align 2
.global secret

// unsigned secret(unsigned n)
//  w0                  w0
secret:
    mov w10, #10

outer_loop:
    cmp w0, #10
    b.lo end

    mov w1, #0

inner_loop:
    cmp w0, #0
    b.eq inner_loop_end

    udiv w2, w0, w10
    msub w3, w2, w10, w0

    mov w0, w2
    add w1, w1, w3

    b inner_loop

inner_loop_end:
    mov w0, w1
    b outer_loop

end:
    ret
