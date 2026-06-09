.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global count_predicate

# int count_predicate(unsigned *a, int n, int (*pred)(unsigned))
# eax                 rdi           esi     rdx
count_predicate:
    enter 32, 0

    mov [rbp - 8], rdi
    mov [rbp - 16], rdx
    mov [rbp - 20], esi
    mov dword ptr [rbp - 24], 0
    mov dword ptr [rbp - 28], 0

for_loop:
    mov ecx, [rbp - 24]
    cmp ecx, [rbp - 20]
    jge for_loop_end

    mov rax, [rbp - 8]
    mov edi, [rax + 4 * rcx]
    call [rbp - 16]

    cmp eax, 0
    je no_match
    add dword ptr [rbp - 28], 1

no_match:
    add dword ptr [rbp - 24], 1
    jmp for_loop

for_loop_end:
    mov eax, [rbp - 28]

    leave
    ret
