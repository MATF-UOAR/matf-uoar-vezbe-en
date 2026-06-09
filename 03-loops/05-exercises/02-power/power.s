.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global power
# unsigned power(unsigned a, unsigned n)
#   eax            edi        esi
power:
    enter 0, 0

    mov eax, 1
    xor ecx, ecx

for_loop:
    cmp ecx, esi
    jae for_loop_end

    mul edi

    add ecx, 1
    jmp for_loop
for_loop_end:

    leave
    ret
