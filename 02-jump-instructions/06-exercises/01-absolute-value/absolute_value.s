.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.text

.global absolute_value
# int absolute_value(int x)
# eax                edi
absolute_value:
    push rbp
    mov rbp, rsp

    cmp edi, 0
    jge nonnegative

    mov eax, edi
    neg eax
    jmp end

nonnegative:
    mov eax, edi

end:
    mov rsp, rbp
    pop rbp
    ret
