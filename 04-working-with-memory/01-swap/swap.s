.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global swap

# void swap(int& a, int& b);
#  -        rdi      rsi
swap:
    enter 0, 0

    mov ecx, [rdi]
    mov edx, [rsi]
    mov [rdi], edx
    mov [rsi], ecx
    
    leave
    ret
