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

	.model tiny
	public pnum
.code
proc pnum

print:
	push -1
	push bp
	mov bp, sp+2
	
	push bx
	mov bx, [bp+2]
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
endp
end print
