.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global factorial_recursive
# unsigned factorial_recursive(unsigned n)
# eax                          edi
factorial_recursive:
    enter 16, 0

    mov [rbp - 4], edi

    cmp edi, 1
    ja recursive_case

    mov eax, 1
    leave
    ret

recursive_case:
    dec edi
    call factorial_recursive
    imul dword ptr [rbp - 4]

    leave
    ret
