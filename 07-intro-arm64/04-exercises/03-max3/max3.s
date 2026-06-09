.text

.align 2
.global max3

// int max3(int x, int y, int z)
// w0       w0     w1     w2
max3:
    cmp w0, w1
    b.ge check_z
    mov w0, w1

check_z:
    cmp w0, w2
    b.ge end
    mov w0, w2

end:
    ret
