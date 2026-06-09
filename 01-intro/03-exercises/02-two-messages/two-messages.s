.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.section .rodata
msg1: .asciz "First message"
msg2: .asciz "Second message"

.text
.global main

main:
    push rbp
    mov rbp, rsp
    # After push rbp, rsp is aligned to 16 bytes before call puts.

    lea rdi, [rip+msg1]
    call puts

    lea rdi, [rip+msg2]
    call puts

    mov eax, 0

    mov rsp, rbp
    pop rbp
    ret
