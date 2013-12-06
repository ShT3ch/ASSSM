
.model small
org 100h

.code

     string db 100,100 dup ('$')



start:

	mov ax, cs
	mov ds,ax

    mov ds, ax
    
    mov ah, 0ah
    lea dx, string
    int 21h 
    
    mov string+1, 0ah
    
    mov ah,9
    lea dx,string+1
    int 21h
    
    mov ah, 10h
    int 16h
 
    mov ax, 4c00h
    int 21h

end start