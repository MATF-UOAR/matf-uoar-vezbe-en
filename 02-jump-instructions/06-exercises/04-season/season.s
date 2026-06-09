.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.section .rodata

message_winter: .asciz "Winter"
message_spring: .asciz "Spring"
message_summer: .asciz "Summer"
message_autumn: .asciz "Autumn"
message_invalid: .asciz "Invalid month"

.text

.global season
# void season(int month)
#             edi
season:
    push rbp
    mov rbp, rsp

    cmp edi, 12
    je winter
    cmp edi, 1
    je winter
    cmp edi, 2
    je winter

    cmp edi, 3
    je spring
    cmp edi, 4
    je spring
    cmp edi, 5
    je spring

    cmp edi, 6
    je summer
    cmp edi, 7
    je summer
    cmp edi, 8
    je summer

    cmp edi, 9
    je autumn
    cmp edi, 10
    je autumn
    cmp edi, 11
    je autumn

    lea rdi, [rip+message_invalid]
    call puts
    jmp end

winter:
    lea rdi, [rip+message_winter]
    call puts
    jmp end

spring:
    lea rdi, [rip+message_spring]
    call puts
    jmp end

summer:
    lea rdi, [rip+message_summer]
    call puts
    jmp end

autumn:
    lea rdi, [rip+message_autumn]
    call puts

end:
    mov rsp, rbp
    pop rbp
    ret
