.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.text

.global count_between_extremes

# int count_between_extremes(long *a, int n);
# eax                        rdi      esi
count_between_extremes:
    enter 16, 0
    # -------- <- rsp = rbp - 16
    #          <- long max (at rbp - 16)
    #          <- long min (at rbp - 8)
    # -------- <- rbp

    push rdi
    push rsi

    lea rdx, [rbp - 8]
    lea rcx, [rbp - 16]
    call minmax # fills the local min and max variables

    pop rsi
    pop rdi

    mov r8, [rbp - 8]  # r8 - min, full register because the type is long
    mov r9, [rbp - 16] # r9 - max, full register because the type is long

    mov r10d, 0 # r10d - count
    mov ecx, 0  # ecx - i
for_loop:
    cmp ecx, esi
    jge for_loop_end

        mov rdx, [rdi + 8 * rcx] # rdx = a[i]
        cmp rdx, r8              # cmp a[i], min
        jle not_between
        cmp rdx, r9              # cmp a[i], max
        jge not_between
            inc r10d
    not_between:

    inc ecx
    jmp for_loop
for_loop_end:

    mov eax, r10d

    leave
    ret
