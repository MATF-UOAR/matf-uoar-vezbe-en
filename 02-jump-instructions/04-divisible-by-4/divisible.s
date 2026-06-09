.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.section .rodata

message_divisible: .asciz "Divisible"
message_not_divisible: .asciz "Not divisible"

.text

.global divisible_by_4
# void divisible_by_4(int x)
#                     edi
divisible_by_4:
    push rbp
    mov rbp, rsp    # set up the stack
                    # after push rbp, rsp is divisible by 16

    mov esi, 4      # put what we divide by into esi
    mov eax, edi    # put what we divide into eax
    cdq             # fill edx so that edx:eax = edi
                    # since we work with SIGNED numbers
                    # we use cdq

    idiv esi        # eax = edi / 4  edx = edi % 4

    cmp edx, 0      # we care whether edx == 0
    jne else_branch

    lea rdi, [rip+message_divisible]
    call puts
    jmp after

else_branch:
    lea rdi, [rip+message_not_divisible]
    call puts

after:
    mov rsp, rbp    # end of function, restore the stack
    pop rbp
    ret
