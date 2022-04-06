BITS 64

; Deviant original : https://github.com/torvalds/linux/blob/master/tools/arch/x86/lib/memset_64.S

section .text

global ft_memset

ft_memset: ; fill block
	mov r9, rdi
	mov rcx, rdx
	and edx, 0x7
	shr rcx, 3
	movzx esi, sil
	mov rax, 0x0101010101010101
	imul rax, rsi
	rep stosq
	mov rcx, rdx
	rep stosb
	mov rax, r9
	ret