[org 0x7c00]
KERNEL_OFFSET equ 0x1000
; A boot sector that enters 32-bit protected mode. 
	mov [BOOT_DRIVE], dl
	
	mov bp, 0x9000 ; Set the stack.	
	mov sp, bp
	mov bx, MSG_REAL_MODE
	call print_string
	call load_kernel
	call switch_to_pm ; Note that we never return from here.
	jmp $               
	 


%include "print_string.asm"
%include "print_string_pm.asm"
%include "switch_to_pm.asm"
%include "disk_load.asm"
%include "gdt.asm"
[bits 16]
load_kernel:
	mov bx, MSG_LOAD_KERNEL
	call print_string
	
	mov bx, KERNEL_OFFSET
	mov dh, 15
	mov dl, [BOOT_DRIVE]
	call disk_load
	ret
[bits 32]

; This is where we arrive after switching to and initialising protected mode.
BEGIN_PM:
	mov ebx, MSG_PROT_MODE 
	call print_string_pm ; Use our 32-bit print routine.
	call KERNEL_OFFSET
	
	jmp $ ; Hang.
	; Global variables 
BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0 	
MSG_PROT_MODE db "Successfully landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "loading kernel into memory.", 0


times 510-($-$$) db 0
dw 0xaa55