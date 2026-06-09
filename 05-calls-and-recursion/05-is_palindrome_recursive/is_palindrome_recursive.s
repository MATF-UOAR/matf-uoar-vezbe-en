.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

# int is_palindrome_range(const char *left, const char *right)
# eax                     rdi                rsi
is_palindrome_range:
    enter 0, 0

    cmp rdi, rsi
    jae yes

    mov al, [rdi]
    mov dl, [rsi]
    cmp al, dl
    jne no

    inc rdi
    dec rsi
    call is_palindrome_range

    leave
    ret

yes:
    mov eax, 1
    leave
    ret

no:
    mov eax, 0
    leave
    ret

.global is_palindrome_recursive
# int is_palindrome_recursive(const char *s)
# eax                         rdi
is_palindrome_recursive:
    enter 0, 0

    mov rsi, rdi
    cmp byte ptr [rsi], 0
    je empty_string

find_end:
    mov al, [rsi]
    cmp al, 0
    je end_found
    inc rsi
    jmp find_end

end_found:
    dec rsi
    call is_palindrome_range

    leave
    ret

empty_string:
    mov eax, 1
    leave
    ret
