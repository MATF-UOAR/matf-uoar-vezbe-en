.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.text

.global max3
# int max3(int x, int y, int z)
# eax      edi    esi    edx
max3:
    push rbp
    mov rbp, rsp

    mov eax, edi

    cmp eax, esi
    jge check_z
    mov eax, esi

check_z:
    cmp eax, edx
    jge end
    mov eax, edx

end:
    mov rsp, rbp
    pop rbp
    ret
