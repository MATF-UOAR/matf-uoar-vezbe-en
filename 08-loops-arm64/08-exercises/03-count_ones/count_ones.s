.text

.align 2
.global count_ones

// unsigned count_ones(unsigned n)
//  w0                  w0
count_ones:
    mov w1, #0  // w1 = count of ones

while_loop:
    cmp w0, #0
    b.eq loop_end

    tst w0, #1
    b.eq skip
    add w1, w1, #1

skip:
    lsr w0, w0, #1
    b while_loop

loop_end:
    mov w0, w1
    ret
