.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.text

.global days_in_month
# int days_in_month(int month)
# eax               edi
days_in_month:
    push rbp
    mov rbp, rsp

    cmp edi, 1
    je has_31
    cmp edi, 3
    je has_31
    cmp edi, 5
    je has_31
    cmp edi, 7
    je has_31
    cmp edi, 8
    je has_31
    cmp edi, 10
    je has_31
    cmp edi, 12
    je has_31

    cmp edi, 4
    je has_30
    cmp edi, 6
    je has_30
    cmp edi, 9
    je has_30
    cmp edi, 11
    je has_30

    cmp edi, 2
    je february

    mov eax, -1
    jmp end

has_31:
    mov eax, 31
    jmp end

has_30:
    mov eax, 30
    jmp end

february:
    mov eax, 28

end:
    mov rsp, rbp
    pop rbp
    ret
