.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.global sum_of_evens

# unsigned sum_of_evens(unsigned n)
#   eax                  edi
sum_of_evens:
    enter 0, 0

    xor eax, eax        # eax = current sum
    mov ecx, edi        # ecx = i = n
    test ecx, ecx
    je end              # loop would cause a problem for n = 0

do_while_loop:
    test ecx, 1
    jnz continue
    add eax, ecx

continue:
    loop do_while_loop

end:

    leave
    ret
