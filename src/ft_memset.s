BITS 64

; Deviant original : https://github.com/torvalds/linux/blob/master/tools/arch/x86/lib/memset_64.S

section .text

global ft_memset

;ft_memset: ; fill block
;	mov r9, rdi
;	mov rcx, rdx
;	and edx, 0x7
;	shr rcx, 3
;	movzx esi, sil
;	mov rax, 0x0101010101010101
;	imul rax, rsi
;	rep stosq
;	mov rcx, rdx
;	rep stosb
;	mov rax, r9
;	ret

ft_memset:
	endbr64
	vmovd xmm0, esi
	mov rax, rdi
	vpbroadcastb ymm0, xmm0
	cmp rdx, 0x20
	jb _below_32
	cmp rdx, 0x40
	ja _above_64
	vmovdqu yword [rdi + rdx - 0x20], ymm0
	vmovdqu yword [rdi], ymm0
	jmp _finish_memset

;	ABOVE 64
_above_64:
	cmp rdx, 0x800 ; 2048
	ja _above_2048
	cmp rdx, 0x80 ; 128
	ja _above_128
	vmovdqu yword [rdi], ymm0
	vmovdqu yword [rdi + 0x20], ymm0
	vmovdqu yword [rdi + rdx - 0x20], ymm0
	vmovdqu yword [rdi + rdx - 0x40], ymm0
	jmp _finish_memset

; ABOVE 128

_above_128:
	lea rcx, [rdi + 0x80]
	vmovdqu yword [rdi], ymm0
	and rcx, 0xffffffffffffff80
	vmovdqu yword [rdi + rdx - 0x20], ymm0
	vmovdqu yword [rdi + 0x20], ymm0
	vmovdqu yword [rdi + rdx - 0x40], ymm0
	vmovdqu yword [rdi + 0x40], ymm0
	vmovdqu yword [rdi + rdx - 0x60], ymm0
	vmovdqu yword [rdi + 0x60], ymm0
	vmovdqu yword [rdi + rdx - 0x80], ymm0
	add rdx, rdi
	and rdx, 0xffffffffffffff80
	cmp rcx, rdx
	je _finish_memset

; LOOP
_loop:
	vmovdqa yword [rcx], ymm0
	vmovdqa yword [rcx + 0x20], ymm0
	vmovdqa yword [rcx + 0x40], ymm0
	vmovdqa yword [rcx + 0x60], ymm0
	add rcx, 0x80
	cmp rdx, rcx
	jne _loop
	jmp _finish_memset

;   ABOVE 2048
_above_2048:
	mov rcx, rdx
	movzx eax, sil
	mov rdx, rdi
	mov byte [rdi], al
	rep stosb
	mov rax, rdx
	ret

; 	BELOW 32 Bytes

_below_32:
	cmp dl, 0x10
	jae __unk_label_4
	vmovq rcx, xmm0
	cmp dl, 8
	jae __unk_label_3
	cmp dl, 4
	jae __unk_label_2
	cmp dl, 1
	ja __unk_label_1
	jb _add_1


__unk_label_4:
	vmovdqu oword [rdi + rdx - 0x10], xmm0
	vmovdqu oword [rdi], xmm0
	jmp _finish_memset

__unk_label_3:
	mov qword [rdi + rdx - 8], rcx
	mov qword [rdi], rcx
	jmp _finish_memset

__unk_label_2:
	mov dword [rdi + rdx - 4], ecx
	mov dword [rdi], ecx
	jmp _finish_memset

__unk_label_1:
	mov word [rdi + rdx - 2], cx
	mov word [rdi], cx
	jmp _finish_memset

_add_1:
	mov byte [rdi], cl
	jmp _finish_memset

; FINISH MEMSET

_finish_memset:
	vzeroupper
	ret