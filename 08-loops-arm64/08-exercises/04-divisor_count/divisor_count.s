.text

.align 2
.global divisor_count

// unsigned divisor_count(unsigned n)
//  w0                     w0
divisor_count:
    mov w1, w0  // w1 = n
    mov w0, #0  // w0 = divisor count
    mov w2, #1  // w2 = d

for_loop:
    cmp w2, w1
    b.hi loop_end

    udiv w3, w1, w2       // w3 = n / d
    msub w4, w3, w2, w1   // w4 = n % d

    cmp w4, #0
    b.ne continue_loop
    add w0, w0, #1

continue_loop:
    cmp w2, w1
    b.eq loop_end

    add w2, w2, #1
    b for_loop

loop_end:
    ret
