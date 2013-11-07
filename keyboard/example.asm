main: jmp start

start:

	; save 
	1)
	al=N
	ah=35h
	int21h-> es:bx
	2)
	ah = 25 <-ds:dx
	es=0; [es:4*N]<-4 baita (ip,cs)
	
wait(ah, int 16h)
	
	
0123	sti ;push-pop
	
	iret;
	
8	jmpfar ea


60h-send,61h-recieve buffers

20h controller
1)reading
in 61h, al1

2)ending
mov al, 20h
out 20h, al