.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global array_sum

# int array_sum(int* a, int n)
# eax            rdi     esi
array_sum:
    enter 0, 0

    mov eax, 0      # eax = current sum

    mov ecx, 0      # ecx = i

for_loop:
    cmp esi, ecx
    je for_loop_end

    add eax, [rdi + 4*rcx]  # eax += *(rdi+4*rcx)

    inc ecx
    jmp for_loop
for_loop_end:

    leave
    ret
