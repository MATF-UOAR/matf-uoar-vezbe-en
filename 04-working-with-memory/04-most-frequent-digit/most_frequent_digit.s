.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.text

.extern index_of_max
.global most_frequent_digit

# unsigned most_frequent_digit(unsigned n)
# eax                          edi
most_frequent_digit:
    enter 48, 0

    mov ecx, 0
    mov eax, 0

init_array:
    cmp ecx, 10
    je counters_ready

    mov [rbp + 4 * rcx - 48], eax
    inc ecx
    jmp init_array

counters_ready:
    cmp edi, 0
    jne while_loop_setup

    mov dword ptr [rbp - 48], 1
    jmp find_most_frequent

while_loop_setup:
    mov r8d, 10

while_loop:
    cmp edi, 0
    je find_most_frequent

    mov eax, edi
    xor edx, edx
    div r8d

    add dword ptr [rbp + 4 * rdx - 48], 1
    mov edi, eax
    jmp while_loop

find_most_frequent:
    lea rdi, [rbp - 48]
    mov esi, 10
    call index_of_max

    leave
    ret
