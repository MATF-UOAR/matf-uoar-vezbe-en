.text

.align 2
.global sum_of_digits

// unsigned sum_of_digits(unsigned n)
//  w0                     w0
sum_of_digits:
    mov w1, #0   // w1 = sum
    mov w10, #10

while_loop:
    cmp w0, #0
    b.eq loop_end

    udiv w2, w0, w10      // w2 = n / 10
    msub w3, w2, w10, w0  // w3 = n % 10

    add w1, w1, w3
    mov w0, w2

    b while_loop

loop_end:
    mov w0, w1
    ret
