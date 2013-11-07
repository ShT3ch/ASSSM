	.model tiny
	.code
org 100h

main:
	mov ax, cs
	mov ds,ax
	xor ax,ax

	xor si,si
	xor di,di
	jmp start
handler:

ret
	
start:
	cli
	mov al,8
	mov ah,35h
	int 21h ;es:bx
	push es
	push bx
	
	push cs
	pop ds
	mov dx, offset handler
	mov ah,25h	;ah = 25 <-ds:dx
	int 21h
	
	sti
exit:
	mov ax,4c00h
	int 21h

errorMessage db "Overflow was registred",13,10	, "$"

target dw 3;
power dw 4;
targetElementSize dw (type target)

end main