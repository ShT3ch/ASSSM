	.model tiny
	.code
org 100h
old_09h dd 0 ; 
wasESC db 0
main:
	mov ax, cs
	mov ds,ax
	xor ax,ax

	xor si,si
	xor di,di
	jmp start
handler proc far

push ax
push bx
push cx
push dx
push ds
pushf
push cs
pop ds

in al,60h
and ax,00ffh
push ax
call print

call space


popf
pop ds
pop dx
pop cx
pop bx
pop ax

pushf
call dword ptr cs:old_09h 

iret
handler endp 

	
start:
cli
	
	mov al,9
	mov ah,35h
	int 21h ;es:bx
	push es
	push bx
	mov word ptr cs:old_09h,bx
	mov word ptr cs:old_09h+2,es 
	
	
	push cs
	pop ds
	mov dx, offset handler
	mov ax,2509h	;ah = 25 <-ds:dx
	int 21h
sti

waitESC:
	mov ah, 00h
	int 16h
	
	cmp al,27
	jne waitESC
	
cli
	pop dx
	pop ds
	mov ax,2509h	;ah = 25 <-ds:dx
	int 21h
	
sti
exit:
	mov ax,4c00h
	int 21h

	

print:
	pop bx
	pop ax
	push bx
	
	push -1
	mov cx,10d
print1:
	mov dx,0
	div cx
	push dx
	cmp ax,0
	jne print1
	mov ah,2h
print2:
	pop dx
	cmp dx,-1
	je print3
	add dl,'0'
	int 21h
	jmp print2
print3:
	ret
	
space:
	mov ah,2h
	mov dl," "
	int 21h
	ret
	
errorMessage db "Overflow was registred",13,10	, "$"

target dw 3;
power dw 4;
targetElementSize dw (type target)

end main