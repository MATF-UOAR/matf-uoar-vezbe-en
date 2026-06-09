.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global print_times

# void print_times(const char *s, unsigned n)
# -                rdi             esi
print_times:
    enter 16, 0

    mov [rbp - 8], rdi
    mov [rbp - 12], esi

loop:
    cmp dword ptr [rbp - 12], 0
    je end

    mov rdi, [rbp - 8]
    call puts

    sub dword ptr [rbp - 12], 1
    jmp loop

end:
    leave
    ret
