.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global lcm
# unsigned lcm(unsigned a, unsigned b)
#   eax           edi        esi
lcm:
    enter 0, 0

    push rdi
    push rsi

    call gcd

    pop rsi
    pop rdi

    cmp eax, 0
    je both_zero

    mov ecx, eax
    mov eax, edi
    xor edx, edx
    div ecx
    mul esi
    jmp end

both_zero:
    xor eax, eax

end:
    leave
    ret
