.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global array_sum_recursive

# int array_sum_recursive(int *a, int n)
# eax                     rdi     esi
array_sum_recursive:
    enter 16, 0

    cmp esi, 0
    jne recursive_case

    mov eax, 0
    leave
    ret

recursive_case:
    mov eax, [rdi]
    mov [rbp - 4], eax

    add rdi, 4
    sub esi, 1
    call array_sum_recursive

    add eax, [rbp - 4]

    leave
    ret
