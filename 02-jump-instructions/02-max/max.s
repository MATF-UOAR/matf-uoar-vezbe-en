.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.text

.global max
# int max(int x, int y)
# eax     edi    esi
max:
    push rbp
    mov rbp, rsp          # set up the stack

    cmp edi, esi          # check the condition x > y
    jle else_branch       # if it does not hold,
                          # go to the else branch
    # if branch
    mov eax, edi          # set the return value to x

    jmp after             # skip the else branch

else_branch:
    mov eax, esi          # set the return value to y

after:

    mov rsp, rbp          # restore the stack, end of function
    pop rbp
    ret
