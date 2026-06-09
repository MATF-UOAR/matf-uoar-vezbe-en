.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.text
.global subtract

# int subtract(int a, int b)
# eax           edi   esi
subtract:
    sub edi, esi
    mov eax, edi
    ret
