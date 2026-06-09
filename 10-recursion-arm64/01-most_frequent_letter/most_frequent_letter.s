.text

.align 2
.global most_frequent_letter

// char most_frequent_letter(const char *s)
//  w0                        x0
most_frequent_letter:
    stp fp, lr, [sp, #-16]!
    mov fp, sp
    sub sp, sp, #112

    mov x4, sp              // x4 = counters
    mov w5, #0              // w5 = i

init:
    cmp w5, #26
    b.hs counters_ready

    str wzr, [x4, x5, lsl #2]
    add w5, w5, #1
    b init

counters_ready:
    ldrb w5, [x0], #1
    cmp w5, #0
    b.eq find_most_frequent

    cmp w5, #'a'
    b.lo check_uppercase
    cmp w5, #'z'
    b.ls increment_counter

check_uppercase:
    cmp w5, #'A'
    b.lo counters_ready
    cmp w5, #'Z'
    b.hi counters_ready
    add w5, w5, #('a' - 'A')

increment_counter:
    sub w5, w5, #'a'       // letter index: s[i] - 'a'
    ldr w6, [x4, x5, lsl #2]
    add w6, w6, #1
    str w6, [x4, x5, lsl #2]
    b counters_ready

find_most_frequent:
    mov x0, x4
    mov w1, #26
    bl index_of_max

    add w0, w0, #'a'       // letter: 'a' + index

    mov sp, fp
    ldp fp, lr, [sp], #16
    ret
