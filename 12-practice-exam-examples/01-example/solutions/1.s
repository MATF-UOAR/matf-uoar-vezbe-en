.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.text

.global more_even_digits
# int more_even_digits(long *a, int n);
# eax                  rdi      esi
more_even_digits:
    enter 0, 0

    mov r8d, 0   # r8d - count
    mov ecx, 0   # ecx - i
for_loop:
    cmp ecx, esi
    jge for_loop_end

        mov rax, [rdi + 8 * rcx] # rax - num = a[i]

        mov r10, 10   # divisor
        mov r9d, 0    # r9d - even_count
        mov r11d, 0   # r11d - odd_count
    digit_loop:
        cqo
        idiv r10  # rax - num / 10, rdx - num % 10

        test rdx, 1 # test digit parity with bitwise AND by 1
        jz even_digit
            inc r11d
            jmp parity_done
    even_digit:
            inc r9d
    parity_done:

        cmp rax, 0
        jne digit_loop

    cmp r9d, r11d
    jle not_greater
        inc r8d
not_greater:

    inc ecx
    jmp for_loop
for_loop_end:

    mov eax, r8d

    leave
    ret

