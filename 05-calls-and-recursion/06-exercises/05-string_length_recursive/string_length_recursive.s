.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global string_length_recursive

# int string_length_recursive(const char *s)
# eax                         rdi
string_length_recursive:
    enter 0, 0

    cmp byte ptr [rdi], 0
    jne recursive_case

    mov eax, 0
    leave
    ret

recursive_case:
    inc rdi
    call string_length_recursive
    add eax, 1

    leave
    ret
