.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global swap_min_and_max

# void swap_min_and_max(int* a, int n)
# -                     rdi     esi
swap_min_and_max:
    enter 0, 0

    cmp esi, 1
    jle end

    xor r8d, r8d      # r8d = i_min = 0
    xor r9d, r9d      # r9d = i_max = 0
    mov r10d, [rdi]   # r10d = current minimum
    mov r11d, [rdi]   # r11d = current maximum

    mov ecx, 1        # ecx = i
for_loop:
    cmp ecx, esi
    jge swap

    mov eax, [rdi + 4*rcx]  # eax = a[i]

    cmp eax, r10d
    jge check_maximum
        mov r10d, eax
        mov r8d, ecx

check_maximum:
    cmp eax, r11d
    jle next
        mov r11d, eax
        mov r9d, ecx

next:
    inc ecx
    jmp for_loop

swap:
    mov eax, [rdi + 4*r8]
    mov edx, [rdi + 4*r9]
    mov [rdi + 4*r8], edx
    mov [rdi + 4*r9], eax

end:
    leave
    ret
