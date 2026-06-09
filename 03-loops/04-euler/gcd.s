.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global gcd

# unsigned gcd(unsigned a, unsigned b)
#   eax           edi        esi
gcd:
    enter 0, 0

while_loop:
    cmp esi, 0
    je loop_end

    mov eax, edi
    xor edx, edx
    div esi       # eax = a / b edx = a % b

    mov edi, esi  # a = b
    mov esi, edx  # b = a % b

    jmp while_loop
loop_end:

    mov eax, edi

    leave
    ret
