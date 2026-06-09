.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.text

.global is_leap_year
# int is_leap_year(int year)
# eax              edi
is_leap_year:
    push rbp
    mov rbp, rsp

    mov esi, 400
    mov eax, edi
    cdq
    idiv esi
    cmp edx, 0
    je is_leap

    mov esi, 100
    mov eax, edi
    cdq
    idiv esi
    cmp edx, 0
    je not_leap

    mov esi, 4
    mov eax, edi
    cdq
    idiv esi
    cmp edx, 0
    je is_leap

not_leap:
    mov eax, 0
    jmp end

is_leap:
    mov eax, 1

end:
    mov rsp, rbp
    pop rbp
    ret
