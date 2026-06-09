.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global set_01

# void set_01(int& a, int& b);
#  -           rdi      rsi
set_01:
    enter 0, 0

    mov dword ptr [rdi], 0
    mov dword ptr [rsi], 1

    leave
    ret
