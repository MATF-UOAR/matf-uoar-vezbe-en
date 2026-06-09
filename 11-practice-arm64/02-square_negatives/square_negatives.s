.text

.align 2
.global square_negatives

// void square_negatives(int *a, int n)
//  -                    x0      w1
square_negatives:
    mov w2, #0

.loop:
    cmp w2, w1
    b.ge .done

    ldr w3, [x0, x2, lsl #2]
    cmp w3, #0
    b.ge .next

    mul w3, w3, w3
    str w3, [x0, x2, lsl #2]

.next:
    add w2, w2, #1
    b .loop

.done:
    ret
