
.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits


.text
.global largest_digit
largest_digit:
	enter 0, 0

	mov r8d, 10
	mov r9d, 0

algorithm:
	cmp edi , 0
	je done

	mov eax, edi
	xor edx, edx
	div r8d

	cmp edx, r9d
	jb next

	mov r9d, edx

next:
	mov edi, eax
	jmp algorithm
done:
	mov eax, r9d
	leave
	ret
