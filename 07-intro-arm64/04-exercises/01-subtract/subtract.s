.text

.align 2
.global subtract

// int subtract(int a, int b)
// w0            w0     w1
subtract:
    sub w0, w0, w1
    ret
