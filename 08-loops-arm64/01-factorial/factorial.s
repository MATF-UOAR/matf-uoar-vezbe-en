.text

.align 2
.global factorial

// unsigned factorial(unsigned n)
//  w0                  w0
factorial:
    mov w2, w0  // w2 = n
    mov w0, #1  // w0 = result
    mov w1, #1  // w1 = i

for_loop:
    cmp w1, w2
    b.hi loop_end

    mul w0, w0, w1

    add w1, w1, #1
    b for_loop

loop_end:
    ret
