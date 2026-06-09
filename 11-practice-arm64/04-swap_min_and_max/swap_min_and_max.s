.text

.align 2
.global swap_min_and_max

// void swap_min_and_max(int *a, int n)
//  -                    x0      w1
swap_min_and_max:
    cmp w1, #1
    b.le .done

    mov w2, #0
    mov w3, #0
    ldr w4, [x0]
    mov w5, w4
    mov w6, #1

.loop:
    cmp w6, w1
    b.ge .swap

    ldr w7, [x0, x6, lsl #2]

    cmp w7, w4
    b.ge .check_maximum
    mov w4, w7
    mov w2, w6

.check_maximum:
    cmp w7, w5
    b.le .next
    mov w5, w7
    mov w3, w6

.next:
    add w6, w6, #1
    b .loop

.swap:
    ldr w6, [x0, x2, lsl #2]
    ldr w7, [x0, x3, lsl #2]
    str w7, [x0, x2, lsl #2]
    str w6, [x0, x3, lsl #2]

.done:
    ret
