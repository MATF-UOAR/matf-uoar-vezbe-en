.text

.align 2
.global count_occurrences

// int count_occurrences(int *a, int n, int x);
// w0                     x0      w1     w2
count_occurrences:
    mov w3, #0  // w3 = number of occurrences
    mov w4, #0  // w4 = i
loop:
    cmp w4, w1
    b.ge end_loop

    ldr w5, [x0, x4, lsl #2]
    cmp w5, w2
    b.ne continue

    add w3, w3, #1

continue:
    add w4, w4, #1
    b loop
end_loop:

    mov w0, w3
    ret
