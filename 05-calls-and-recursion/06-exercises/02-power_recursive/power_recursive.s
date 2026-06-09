.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global power_recursive

# unsigned power_recursive(unsigned a, unsigned n)
# eax                      edi         esi
power_recursive:
    enter 16, 0

    mov [rbp - 4], edi

    cmp esi, 0
    jne recursive_case

    mov eax, 1
    leave
    ret

recursive_case:
    sub esi, 1
    call power_recursive
    imul eax, [rbp - 4]

    leave
    ret
