.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.text

.global divide_unsigned
# void divide_unsigned(unsigned a, unsigned b,
#                      unsigned &quotient, unsigned &remainder)
#                      edi         esi      rdx                 rcx
divide_unsigned:
    push rbp
    mov rbp, rsp

    mov r8, rdx
    mov r9, rcx

    mov eax, edi
    xor edx, edx
    div esi

    mov [r8], eax
    mov [r9], edx

    mov rsp, rbp
    pop rbp
    ret
