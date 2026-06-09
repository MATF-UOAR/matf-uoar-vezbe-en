.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits


.text

# arithmetic_mean:
# 	enter 0, 0

# 	mov ecx, 0
# 	xor eax, eax
# main_loop:
# 	cmp ecx, esi
# 	je func_done

# 	mov r8d, [rdi + 4*rcx]
# 	add eax, r8d

# 	inc ecx
# 	jmp main_loop

# func_done:
# 	xor edx, edx
# 	div esi
# 	leave
# 	ret




.global count_above_mean

count_above_mean:
	enter 0, 0

	call arithmetic_mean
	mov r8d, eax

	mov ecx, 0
for_loop:
	cmp ecx, esi
	je done

	mov r9d, [rdi + 4*rcx]
	cmp r9d, r8d
	jbe next

	mov eax, r9d
	mul r9d

	mov  [rdi + 4*rcx], eax

next:
	inc ecx
	jmp for_loop
done:
	leave
	ret
