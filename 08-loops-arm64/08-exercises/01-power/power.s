.text

.align 2
.global power

// unsigned power(unsigned a, unsigned n)
//  w0             w0          w1
power:
    mov w2, w0  // w2 = a
    mov w0, #1  // w0 = result
    mov w3, #0  // w3 = i

for_loop:
    cmp w3, w1
    b.hs loop_end

    mul w0, w0, w2

    add w3, w3, #1
    b for_loop

loop_end:
    ret
