.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global find_first

# int find_first(unsigned *a, int n, int (*pred)(unsigned))
# eax            rdi           esi     rdx
find_first:
    enter 32, 0

    mov [rbp - 8], rdi
    mov [rbp - 16], rdx
    mov [rbp - 20], esi
    mov dword ptr [rbp - 24], 0

for_loop:
    mov ecx, [rbp - 24]
    cmp ecx, [rbp - 20]
    jge not_found

    mov rax, [rbp - 8]
    mov edi, [rax + 4 * rcx]
    call [rbp - 16]

    cmp eax, 0
    jne found

    add dword ptr [rbp - 24], 1
    jmp for_loop

found:
    mov eax, [rbp - 24]
    leave
    ret

not_found:
    mov eax, -1
    leave
    ret
