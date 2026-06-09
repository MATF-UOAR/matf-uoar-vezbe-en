.text

.align 2
.global divisible_by_4

// int divisible_by_4(int x)
// w0                  w0
divisible_by_4:
    and w1, w0, #3
    mov w0, #0

    cmp w1, #0
    b.ne end
    mov w0, #1

end:
    ret
