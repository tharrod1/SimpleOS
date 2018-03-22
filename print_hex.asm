
;works
print_hex:
	pusha

	
	lea bx, [HEX_CHARS]
	mov cl, 0xc
	lop:
		mov ax, dx
		shl ax, cl
		shr ax, 12
		sub cl, 0x4
		xlat
		mov ah, 0x0e
		je rturn
		int 0x10

		cmp cl, 0
		je rturn
		jmp lop


	rturn:


		popa
		ret


Print_Hex_le:
	call print_hex
	xchg dl, dh
	call print_hex

HEX_OUT: db 0,0
HEX_CHARS: db "0123456789abcdef",0