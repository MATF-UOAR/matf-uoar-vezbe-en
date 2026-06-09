.text

.align 2
.global index_of_max

// unsigned index_of_max(unsigned *a, unsigned n)
//  w0                   x0          w1
index_of_max:
    cmp w1, #0
    b.eq empty_array

    mov w2, #0              // w2 = index of current maximum
    ldr w3, [x0]            // w3 = current maximum
    mov w4, #1              // w4 = i

loop:
    cmp w4, w1
    b.hs end

    ldr w5, [x0, x4, lsl #2]
    cmp w5, w3
    b.ls continue_loop

    mov w3, w5
    mov w2, w4

continue_loop:
    add w4, w4, #1
    b loop

empty_array:
    mov w2, #0

end:
    mov w0, w2
    ret
