.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global sum_of_digits
# unsigned sum_of_digits(unsigned n)
#   eax                    edi
sum_of_digits:
    enter 0, 0

    xor r8d, r8d
    mov ecx, 10

while_loop:
    cmp edi, 0
    je loop_end

    mov eax, edi
    xor edx, edx
    div ecx

    add r8d, edx
    mov edi, eax
    jmp while_loop
loop_end:

    mov eax, r8d

    leave
    ret
