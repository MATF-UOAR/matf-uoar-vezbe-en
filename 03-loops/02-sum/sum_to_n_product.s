.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global sum_to_n
# unsigned sum_to_n(unsigned n)
#   eax             edi
sum_to_n:
    enter 0, 0

    mov eax, edi
    add edi, 1
    mul edi              # edx:eax = n * (n+1)

    shrd eax, edx, 1     # lower 32 bits of (n * (n+1)) / 2

    leave
    ret
