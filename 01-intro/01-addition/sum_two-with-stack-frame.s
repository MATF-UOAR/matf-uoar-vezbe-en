.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.text

.global sum_two

# int sum_two(int a, int b)
# eax          edi   esi
sum_two:
    push rbp
    mov rbp, rsp
    # Reserve 16 bytes on the stack.
    # Just two int arguments would only need 8 bytes,
    # but this way we keep the stack aligned to 16 bytes.
    sub rsp, 16

    # Store the arguments in memory, as local variables.
    mov [rbp-4], edi
    mov [rbp-8], esi

    # Load them back from memory and add them.
    mov edx, [rbp-4]
    mov eax, [rbp-8]
    add eax, edx

    mov rsp, rbp
    pop rbp
    ret
