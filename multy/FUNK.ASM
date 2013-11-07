.model tiny
public utils
.code
proc utils

fastPow:
	push bp
	mov bp, sp
	
	push ax
	mov ax, [bp+6]
	
	push dx
	mov dx, [bp+10]
	
	push si
	xor si,si
	
	mov dx, ax
	xor ax,ax
	
beginCount:
	cmp ax, dx
	
	inc si
	push dx
	mov ax, si
	mul ax
	pop dx
	jmp beginCount
	
newCallWithDoubling:

	jmp returnAsIs
	
newCallWithAdding:


returnAsIs:

	
	jmp endMult

returnGood:
	mov word ptr [bp+6], 0h
	
	jmp endMult

returnOverflow:
	mov word ptr [bp+6], 1h
	
	jmp endMult

exit:
	pop si
	pop dx
	pop ax
	pop bp
	ret
endp
end fastPow