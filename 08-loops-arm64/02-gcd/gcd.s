.text

.align 2
.global gcd

// unsigned gcd(unsigned a, unsigned b)
//  w0           w0          w1
gcd:
while_loop:
    cmp w1, #0
    b.eq loop_end

    udiv w2, w0, w1       // w2 = a / b
    msub w3, w2, w1, w0   // w3 = a - (a / b) * b

    mov w0, w1            // a = b
    mov w1, w3            // b = a % b

    b while_loop

loop_end:
    ret
