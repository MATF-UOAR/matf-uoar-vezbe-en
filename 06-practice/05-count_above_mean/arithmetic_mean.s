.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits


.text
.global arithmetic_mean
arithmetic_mean:
	enter 0, 0

	mov ecx, 0
	xor eax, eax
main_loop:
	cmp ecx, esi
	je done

	mov r8d, [rdi + 4*rcx]
	add eax, r8d

	inc ecx
	jmp main_loop

done:
	xor edx, edx
	div esi
	leave
	ret
