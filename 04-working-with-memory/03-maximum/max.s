.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global max

# int max(int* a, int n)
# eax      rdi     esi 
max:
    enter 0, 0

    cmp esi, 0
    jle empty_array

    mov r8d, [rdi]  # r8d - current_max = a[0]

    mov ecx, 1      # ecx = i
for_loop:
    cmp esi, ecx
    je loop_end

    mov r9d, [rdi+4*rcx]  # r9d = a[i]

    cmp r8d, r9d       # compare current_max and a[i]
    jg next
        mov r8d, r9d

next:

    inc ecx
    jmp for_loop
loop_end:

    mov eax, r8d
    jmp end

empty_array:
    mov eax, 0

end:
   
    leave
    ret
