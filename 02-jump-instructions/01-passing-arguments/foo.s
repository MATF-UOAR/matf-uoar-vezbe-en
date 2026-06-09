.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.text

.global foo

# int foo(int, int, int, int, int, int, int, int);
# eax     edi  esi  edx  ecx  r8d  r9d  ???  ???
foo:
    push rbp
    mov rbp, rsp

    # move the 8th argument into the eax register
    mov eax, [rbp + 24]

    mov rsp, rbp
    pop rbp
    ret
