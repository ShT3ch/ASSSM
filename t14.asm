	.model tiny
	.code

org 100h

main:
	mov ax, cs
	mov ds,ax
	xor ax,ax
	
cicleBegin:	
	xor si,si
	xor bx,bx
cicleIf: 
	cmp si, n		; по массиву индексов
	jg afterCicle
	je afterCicle
	jl cicleBody
	cmp si, targetSize		; по массиву-источнику

cicleBody:
	mov di, indexes[si]
	add di,di
	cmp di, targetSize
	je exception
	jg exception
	mov ax,target[di]	
	mul	ax
	add bx,ax
	inc si
	inc si
	
	jmp cicleIf

afterCicle:
	push bx
	call print
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

errorMessage db "Index out of range.",13,10	, "$"

indexes dw 0000d,0001d, 0003d, 0004d
n dw $-indexes
indexSize dw (type target)

target dw 0010h,0009h,0008h,0001h,0002h,0003h,0004h
targetSize dw ($ - target)
targetElementSize dw (type target)

end main