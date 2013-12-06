
.model tiny
.code
org 100h

path db "file.in ",0 ; ??? ????? ??? ????????
token db 100 dup ('$')
step dw (type token)
buf  db 1
string db 100 dup ('$')
lenString db 0               ; ????? ??????
len0 db 0               ; ????? ?????????
found db ?
offsetInSearch dw ?
 
begin:

	mov ax, cs
	mov es, ax

    	mov ds, ax


    mov ah, 0ah
    lea dx, string
    int 21h 

call strLenString
	mov ah,2h
	mov dl,13
	int 21h
	mov ah,2h
	mov dl,10
	int 21h

        
        mov ax,3d00h    ; ????????? ??? ??????
        lea dx,path             ; DS:dx ????????? ?? ??? ?????
        int 21h         ; ? ax ??c??????? ?????
        
        mov bx,ax               ; ???????? ? bx ????????? ?????
        xor cx,cx
        xor dx,dx
        mov ax,4200h
        int 21h         ; ???? ? ?????? ?????

	xor si,si
   out_str:
    	mov ah,3fh          ; ????? ?????? ?? ?????
        mov cx,1                ; 1 ????
        lea dx,buf              ; ? ?????? buf
        int 21h       	          
        cmp ax,cx               ; ???? ?????????? EoF ??? ?????? ??????
        jnz close   
	
	

        cmp buf,' '
        push si
	je Judge
	
	pop si

	mov al,buf
	mov byte ptr token[si], al
	inc si
        jmp out_str

   close:                       ; ????????? ????, ????? ??????
    mov ah,3eh
        int 21h
   exit:        
	call space
	call space
	call space
	
	lea dx, string+2
	mov ah,9h
	int 21h

    	mov ax,4c00h
        int 21h

Judge:
	pop si
	push si
	mov dx,word ptr lenString
	cmp si,dx
	jg beginSearch
	siMinimaze:
		jmp return
	
	beginSearch:
	mov offsetInSearch, 0
	
	searchIteration:
	push si
	sub si,dx
	cmp si,offsetInSearch
	jl return

	mov cx,dx

	lea si, token
	lea di, string
	add di,2
	add si, offsetInSearch
	cld
	repe cmpsb
        je WordPrint
	inc offsetInSearch
	pop si		
	jmp searchIteration

	
	jmp WordPrint	

WordPrint:
	lea dx, token
	mov ah,9h
	int 21h
	call space
	jmp return
return:
	pop si
	mov cx,si
	lea di, token
	mov al,'$'
	cld
	rep stosb
	xor si,si
	jmp out_str

space:
	mov ah,2h
	mov dl,'_'
	int 21h
	ret

strLenString:
    lea si, string
	inc si
	inc si
    push bp
    mov bp, sp
    xor cx, cx
    @Len_m1:
        lodsb
        cmp al, '$'
        je @Len_m1_end
        inc cx
    	jmp @Len_m1
    @Len_m1_end:
    pop bp
    dec cl
    mov lenString, cl
    ret 2



end begin