.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.text
.global sum_three

# int sum_three(int a, int b, int c)
# eax            edi   esi   edx
sum_three:
    add edi, esi
    add edi, edx
    mov eax, edi
    ret
