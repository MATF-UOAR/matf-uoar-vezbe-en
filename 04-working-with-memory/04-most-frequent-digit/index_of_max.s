.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global index_of_max

# unsigned index_of_max(unsigned* a, unsigned n)
# eax                   rdi          esi
index_of_max:
    enter 0, 0

    cmp esi, 0
    je empty_array

    mov eax, 0       # eax = index of the current maximum
    mov r8d, [rdi]   # r8d = current maximum = a[0]
    mov ecx, 1       # ecx = i

for_loop:
    cmp ecx, esi
    jae loop_end

    mov r9d, [rdi + 4 * rcx]

    cmp r9d, r8d
    jbe next

    mov r8d, r9d
    mov eax, ecx

next:
    inc ecx
    jmp for_loop

empty_array:
    mov eax, 0

loop_end:
    leave
    ret
