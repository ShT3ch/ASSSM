.model tiny
public utils
.code
proc utils

isSqr:
	push bp
	mov bp, sp
	
	push ax
	mov ax, [bp+6]
	
	push dx
	xor dx,dx
	
	push si
	xor si,si
	
	mov dx, ax
	xor ax,ax
	
beginCount:
	cmp ax, dx
	je returnTrue
	jg returnFalse
	jo returnFalse
	inc si
	push dx
	mov ax, si
	mul ax
	pop dx
	jmp beginCount
	
returnTrue:
	mov word ptr [bp+6], 1h
	jmp endIsSqr

returnFalse:
	mov word ptr [bp+6], 0h
	jmp endIsSqr

endIsSqr:
	pop si
	pop dx
	pop ax
	pop bp
	ret
endp
end isSqr