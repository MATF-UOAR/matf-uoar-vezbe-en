.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global minimum

# int minimum(int *a, int n)
# eax         rdi     esi
minimum:
    enter 0, 0

    mov eax, [rdi]
    mov ecx, 1

for_loop:
    cmp ecx, esi
    jge for_loop_end

    cmp [rdi + 4 * rcx], eax
    jge not_smaller
    mov eax, [rdi + 4 * rcx]

not_smaller:
    inc ecx
    jmp for_loop

for_loop_end:
    leave
    ret
