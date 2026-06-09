.intel_syntax noprefix
.section .note.GNU-stack,"",@progbits

.text
.global is_fibonacci
is_fibonacci:
	enter 0, 0

	mov ecx, 2
	mov r8d, 0
	mov r9d, 1

	cmp edi, r8d
	je zero

	cmp edi, r9d
	je one


main_loop:
	cmp edi, r9d
	jl not_found

	xor r10d, r10d
	add r10d, r8d
	add r10d, r9d

	cmp r10d, edi
	jne next

	mov eax, ecx
	jmp done

next:
	mov r8d, r9d
	mov r9d, r10d
	inc ecx
	jmp main_loop
zero:
	mov eax, 0
	jmp done
one:
	mov eax, 1
	jmp done

not_found:
	mov eax, -1
done:
	leave
	ret
