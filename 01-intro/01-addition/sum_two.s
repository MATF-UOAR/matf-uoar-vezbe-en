.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.text

.global sum_two

# int sum_two(int a, int b)
# eax          edi   esi
sum_two:
    add edi, esi
    mov eax, edi
    ret
