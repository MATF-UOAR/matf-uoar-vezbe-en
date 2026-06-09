.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global maximum

# int maximum(int *a, int n)
# eax         rdi     esi
maximum:
    enter 0, 0

    mov eax, [rdi]
    mov ecx, 1

for_loop:
    cmp ecx, esi
    jge for_loop_end

    cmp [rdi + 4 * rcx], eax
    jle not_greater
    mov eax, [rdi + 4 * rcx]

not_greater:
    inc ecx
    jmp for_loop

for_loop_end:
    leave
    ret
