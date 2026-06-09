.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global divisor_count
# unsigned divisor_count(unsigned n)
#   eax                    edi
divisor_count:
    enter 0, 0

    mov r8d, edi
    xor r9d, r9d
    mov ecx, 1

for_loop:
    cmp r8d, ecx
    jb for_loop_end

    mov eax, r8d
    xor edx, edx
    div ecx

    cmp edx, 0
    jne continue
    inc r9d

continue:
    add ecx, 1
    jmp for_loop
for_loop_end:

    mov eax, r9d

    leave
    ret
