.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global sum_to_n
# unsigned sum_to_n(unsigned n)
#   eax             edi
sum_to_n:
    enter 0, 0

    xor eax, eax   # eax - current sum
    mov ecx, 1     # ecx - i

for_loop:
    cmp edi, ecx
    jb  for_loop_end

    add eax, ecx

    add ecx, 1
    jmp for_loop
for_loop_end:

    leave
    ret
