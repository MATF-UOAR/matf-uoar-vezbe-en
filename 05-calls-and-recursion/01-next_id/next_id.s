.intel_syntax noprefix
.section .note.GNU-stack, "", @progbits

.bss
.align 4
last_id: .zero 4

.text

.global next_id
# unsigned next_id()
# eax            -
next_id:
    enter 0, 0

    add dword ptr [rip + last_id], 1
    mov eax, [rip + last_id]

    leave
    ret
