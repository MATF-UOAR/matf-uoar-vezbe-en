.text

.align 2
.global absolute_value

// int absolute_value(int x)
// w0                  w0
absolute_value:
    cmp w0, #0
    b.ge end
    neg w0, w0

end:
    ret
