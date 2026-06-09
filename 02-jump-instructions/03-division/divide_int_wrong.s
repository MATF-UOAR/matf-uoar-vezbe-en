.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.text

.global divide_int
# Deliberately incorrect version: uses xor edx, edx before idiv.
divide_int:
    push rbp
    mov rbp, rsp

    mov r8, rdx
    mov r9, rcx

    mov eax, edi
    xor edx, edx
    idiv esi

    mov [r8], eax
    mov [r9], edx

    mov rsp, rbp
    pop rbp
    ret
