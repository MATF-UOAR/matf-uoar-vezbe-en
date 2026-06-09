.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.text

.global divide_unsigned
# Deliberately incorrect version: uses cdq before div.
divide_unsigned:
    push rbp
    mov rbp, rsp

    mov r8, rdx
    mov r9, rcx

    mov eax, edi
    cdq
    div esi

    mov [r8], eax
    mov [r9], edx

    mov rsp, rbp
    pop rbp
    ret
