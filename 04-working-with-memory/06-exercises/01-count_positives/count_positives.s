.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global count_positives

# int count_positives(int* a, int n)
# eax                 rdi     esi
count_positives:
    enter 0, 0

    mov eax, 0      # eax = count of positives

    cmp esi, 0
    jle end

    mov ecx, 0      # ecx = i
for_loop:
    cmp ecx, esi
    jge end

    cmp dword ptr [rdi + 4*rcx], 0
    jle next
        inc eax
next:
    inc ecx
    jmp for_loop

end:
    leave
    ret
