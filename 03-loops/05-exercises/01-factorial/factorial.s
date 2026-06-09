.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global factorial
# unsigned factorial(unsigned n)
#   eax                edi
factorial:
    enter 0, 0

    mov eax, 1
    mov ecx, 1

for_loop:
    cmp edi, ecx
    jb for_loop_end

    mul ecx

    add ecx, 1
    jmp for_loop
for_loop_end:

    leave
    ret
