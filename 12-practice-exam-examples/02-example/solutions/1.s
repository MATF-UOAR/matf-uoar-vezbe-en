.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global weight

# unsigned long weight(unsigned long x);
#      rax                  rdi
weight:
    enter 0, 0

    mov rcx, 0  # rcx - sum
    mov r10, 10
digit_loop:
    cmp rdi, 0
    je digit_loop_end

    mov rax, rdi
    xor rdx, rdx
    div r10 # rax - x / 10, rdx - x % 10

    mov rdi, rax

    mov rax, rdx
    mov r11, rdx
    mul r11
    add rcx, rax

    jmp digit_loop
digit_loop_end:

    mov rax, rcx

    leave
    ret

