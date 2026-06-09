.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global dot_product

# int dot_product(int* a, int* b, int n)
# eax             rdi     rsi     edx
dot_product:
    enter 0, 0

    mov r8d, 0      # r8d = current sum
    mov eax, 0

    cmp edx, 0
    jle end

    mov ecx, 0      # ecx = i
for_loop:
    cmp ecx, edx
    jge loop_done

    mov eax, [rdi + 4*rcx]
    imul eax, dword ptr [rsi + 4*rcx]
    add r8d, eax

    inc ecx
    jmp for_loop

loop_done:
    mov eax, r8d

end:
    leave
    ret
