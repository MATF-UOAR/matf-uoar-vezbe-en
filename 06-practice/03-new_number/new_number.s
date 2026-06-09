.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits


.text
.global new_number
new_number:
	enter 0, 0

	mov r8d, 10
	mov r9d, 1
	mov r10d, 0
main_loop:
	cmp edi, 0
	je done

	xor edx, edx
	mov eax, edi
	div r8d

	mov edi, eax

	test edx, 1
	je next

	mov eax, edx
	mul r9d

	add r10d, eax

	mov eax, r9d
	mul r8d

	mov r9d, eax
next:

	jmp main_loop
done:
	mov eax, r10d
	leave
	ret
