.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global euler

# unsigned euler(unsigned n)
# eax              edi
euler:
    enter 0, 0

    xor r9d, r9d    # r9d = count

    mov ecx, 1      # ecx = i
for_loop:
    cmp ecx, edi
    jae for_loop_end

    # save the values of the registers that
    # are important to us on the stack
    push r9
    push rcx
    push rdi
    push rdi  # the stack must be aligned to 16
              # we could also do sub rsp, 8
              # instead of push

    mov esi, edi    # second arg = n
    mov edi, ecx    # first arg = i
    call gcd        # eax = gcd(i, n)

    # restore the old register values
    pop rdi  # we could also use add rsp, 8 instead of pop
    pop rdi
    pop rcx
    pop r9

    cmp eax, 1
    jne not_coprime
    inc r9d

not_coprime:


    inc ecx
    jmp for_loop
for_loop_end:

    mov eax, r9d

    leave
    ret
