.MODEL Tiny
.386
.CODE
ORG	100h

Start:

		mov	dx,120         ; Angle = 120
		mov	bx,-10         ; R = -10
		mov	ax,2           ; Y = 2

		finit                  ; Инициализируем сопроцессор (FPU)

		mov	Tmp,dx         ; Сохраняем Angle во временной переменной
		fild	Tmp            ; Загружаем Angle в стек FPU
		fmul	PiDiv180       ; Умножаем: st(0) = Angle * (Pi/180)

		fcos                   ; Косинус: st(0) = Cos(Angle*Pi/180) = -0.5

		mov	Tmp,bx         ; Сохраняем R во временной переменной
		fimul	Tmp            ; Умножаем: st(0) = R * Cos(Angle*Pi/180) = 5

		fistp	Tmp            ; Сохраняем результат во временной переменной
		fwait                  ; Синхронизируем работу CPU и FPU (i8087..i387)
                                       ; (т.к. далее используем Tmp, которое записывает FPU)
		add	ax,Tmp         ; ax = Y + Round(R * Cos(Angle*Pi/180)) = 7

		aam                    ; Делим al на 10 (трюк), частное в ah, остаток - в al
		xchg	al,ah          ; Теперь в al - младшая цифра, а в ah - старшая
		add	ax,'00'        ; Переводим число в десятичное
		int	29h            ; Выводим старшую цифру
		mov	al,ah
		int	29h            ; Выводим младшую цифру

		mov  ax,4C00h
		int	21h            ; Выходим из программы

PiDiv180	dd	0.017453292519943296 ; Pi/180 (думаю, точности dword достаточно)
Tmp		dw	?

END		Start