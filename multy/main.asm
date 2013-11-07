	.model tiny
	.code
org 100h

main:
	mov ax, cs
	mov ds,ax
	xor ax,ax

	xor si,si
	xor di,di
	
cycle:
	
	push target
	push power
	call pow		
	pop ax
	pop ax
	
	mov target, ax
	
	jmp returnAnswer

jmp exit
pow:
	push bp
	mov bp, sp
	
	push ax
	mov ax,[bp+4]
	
	push dx
	mov dx,[bp+6]

	push si
	xor si,si
	
	push cx
	xor cx,cx
	
	push bx
	xor bx,bx
powIF:
	cmp ax,1
	je returnAsIs
	mov si,ax
	test si, 0000000000000001b
	jnz addCall
doubleCall:
	mov si,ax
	mov ax,dx
	mul ax
	mov dx,ax
	mov ax,si ;dx square
	
	push dx
	xor dx,dx
	mov si, 2
	div si ;ax div 2
	pop dx
	
	push dx
	push ax
	call pow
	pop ax
	pop dx
	mov [bp+6], dx

	jmp exitFromPow
addCall:
	sub ax,1
		push dx
	
	push dx
	push ax
	call pow
	pop ax
	pop dx
	
		pop si
	mov ax, dx
	mul si
	mov [bp+6], ax
	jmp exitFromPow
	
returnAsIs:
exitFromPow:
	pop bx
	pop cx
	pop si
	pop dx
	pop ax
	pop bp
ret
	
	
returnAnswer:
	push target
	call print
	call space
jmp exit
	
errorMessagePrint:
	pop ax
	pop dx
	push ax
	mov ah,9h
	int 21h
exitFromFunc:
jmp exit

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
	add dl,21h
	int 21h
	ret

exception:
	push offset errorMessage
	call errorMessagePrint
	
exit:
	mov ax,4c00h
	int 21h

errorMessage db "Overflow was registred",13,10	, "$"

target dw 3;
power dw 4;
targetElementSize dw (type target)

end main