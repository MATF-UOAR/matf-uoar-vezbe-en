.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global sum_of_evens
# unsigned sum_of_evens(unsigned n)
#   eax                  edi
sum_of_evens:
    enter 0, 0

    xor eax, eax   # eax = current sum
    mov ecx, 1     # ecx = i

for_loop:
    cmp edi, ecx
    jb  for_loop_end

    test ecx, 1
    jnz continue
    add eax, ecx

continue:
    add ecx, 1
    jmp for_loop
for_loop_end:

    leave
    ret
