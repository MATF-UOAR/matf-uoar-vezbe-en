.text

.align 2
.global is_prime

// unsigned is_prime(unsigned n)
//  w0                 w0
is_prime:
    cmp w0, #2
    b.hs check_divisors

    mov w0, #0
    ret

check_divisors:
    mov w1, w0  // w1 = n
    mov w2, #2  // w2 = d

for_loop:
    cmp w2, w1
    b.hs is_prime_label

    udiv w3, w1, w2       // w3 = n / d
    msub w4, w3, w2, w1   // w4 = n - (n / d) * d

    cmp w4, #0
    b.eq not_prime

    add w2, w2, #1
    b for_loop

not_prime:
    mov w0, #0
    ret

is_prime_label:
    mov w0, #1
    ret
