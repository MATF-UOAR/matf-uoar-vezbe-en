.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.text

.global divide_int
# void divide_int(int a, int b, int &quotient, int &remainder)
#                 edi    esi   rdx             rcx
divide_int:
    push rbp
    mov rbp, rsp

    mov r8, rdx
    mov r9, rcx

    mov eax, edi
    cdq
    idiv esi

    mov [r8], eax
    mov [r9], edx

    mov rsp, rbp
    pop rbp
    ret
