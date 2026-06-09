.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits




.text
.global square_negatives

square_negatives:
	enter 0, 0

	mov ecx, 0

for_loop:
	cmp ecx, esi
	je done

	mov r8d, [rdi + 4*rcx]

	cmp r8d, 0
	jge next


	mov eax, r8d
	mul r8d

	mov [rdi + 4*rcx], eax
next:
	inc ecx
	jmp for_loop
done:
	leave
	ret
