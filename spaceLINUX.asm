jmp menu



Msn1: string "play again? <y/n>"
Msn2: string "[ 1 ] Jogar SinglePlayer"
Msn3: string "[ 2 ] Jogar MultiPlayer Local"
Msn4: string "[ 0 ] Exit"
Msn5: string "P L A Y E R  1  W O N !!!"
Msn6: string "P L A Y E R  2  W O N !!!"
Msn7: string "G A M E   O V E R"
Msn8: string "Kills:"
Msn9: string "Bullets:"
Msn10: string "Horda:"

Letra: var #1		; Contem a letra que foi digitada

Kills: var #1
Cont_Deaths: var #1
auxKills: var #1
auxDigito: var #1

Bullets: var #1
addBullets: var #1
auxBullets: var #1
auxDigitoBullets: var #1

velAlien1: var #1
velAlien2: var #1
velAlien3: var #1
velAlien4: var #1

Horda: var #1
auxHorda: var #1
auxDigitoHorda: var #1


dirNave: var #1
dirTiro1: var #1     ;  0 = vertical   |  1 = horizontal
dirTiro2: var #1
dirTiro3: var #1
dirTiro_Recalculapos: var #1
dirTiro2_Recalculapos: var #1
dirTiro3_Recalculapos: var #1

posNave: var #1			; Contem a posicao atual da Nave
posAntNave: var #1		; Contem a posicao anterior da Nave
posNave2: var #1
posAntNave2: var #1

posAlien: var #1		; Contem a posicao atual do Alien
posAntAlien: var #1		; Contem a posicao anterior do Alien


Alien1Dead: var #1
desAlien1: var #1
posAlien1: var #1
posAntAlien1: var #1

Alien2Dead: var #1
desAlien2: var #1
posAlien2: var #1
posAntAlien2: var #1

Alien3Dead: var #1
desAlien3: var #1
posAlien3: var #1
posAntAlien3: var #1

Alien4Dead: var #1
desAlien4: var #1
posAlien4: var #1
posAntAlien4: var #1



posTiro: var #1			; Contem a posicao atual do Tiro
posAntTiro: var #1		; Contem a posicao anterior do Tiro
posTiro2: var #1			; Contem a posicao atual do Tiro
posAntTiro2: var #1		; Contem a posicao anterior do Tiro
posTiro3: var #1      ; Contem a posicao atual do Tiro
posAntTiro3: var #1   ; Contem a posicao anterior do Tiro
FlagTiro: var #1		; Flag para ver se Atirou ou nao (Barra de Espaco!!)
FlagTiro2: var #1
FlagTiro3: var #1


;------------------------------
menu:
	call ApagaTela
	call printtelamenuScreen
	loadn r0, #806
	loadn r1, #Msn2
	loadn r2, #1024
	call ImprimeStr
	loadn r0, #886
	loadn r1, #Msn3
	loadn r2, #1024
	call ImprimeStr
	loadn r0, #1046
	loadn r1, #Msn4
	loadn r2, #1024
	call ImprimeStr
	
	menu_loop:	
		call DigLetra
		loadn r0, #'1'
		load r1, Letra
		cmp r0, r1			
		jeq main	
		
		loadn r0, #'2'
		cmp r0, r1				
		jeq main2	
		
		loadn r0, #'0'
		cmp r0, r1
		jne menu_loop
	
	call ApagaTela
	halt
	



;------------------------------
;Codigo principal

main:
	call ApagaTela
	
	loadn R1, #tela1Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #1024  			; cor branca!
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira
    
	loadn R1, #tela2Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #1792  			; cor branca!
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira
    
	loadn r0, #1160
	loadn r1, #Msn9
	loadn r2, #3072
	call ImprimeStr
	
	loadn r0, #1189
	loadn r1, #Msn10
	loadn r2, #2304
	call ImprimeStr

	Loadn R0, #619			
	store posNave, R0		; Zera Posicao Atual da Nave
	store posAntNave, R0	; Zera Posicao Anterior da Nave
	
	;store FlagTiro, R0		; Zera o Flag para marcar que ainda nao Atirou!
	store posTiro, R0		; Zera Posicao Atual do Tiro
	store posAntTiro, R0	; Zera Posicao Anterior do Tiro
	;store FlagTiro2, R0		; Zera o Flag para marcar que ainda nao Atirou!
	store posTiro2, R0		; Zera Posicao Atual do Tiro
	store posAntTiro2, R0	; Zera Posicao Anterior do Tiro
	;store FlagTiro3, R0		; Zera o Flag para marcar que ainda nao Atirou!
	store posTiro3, R0		; Zera Posicao Atual do Tiro
	store posAntTiro3, R0	; Zera Posicao Anterior do Tiro
	
	
	loadn r0, #19
	store posAlien1, r0
	store posAntAlien1, r0
	
	loadn r0, #600
	store posAlien2, r0
	store posAntAlien2, r0
	
	loadn r0, #639
	store posAlien3, r0
	store posAntAlien3, r0
	
	loadn r0, #1179
	store posAlien4, r0
	store posAntAlien4, r0
	
	loadn R0, #12			;a nave começa com 12 balas
	store Bullets, r0
	
	loadn r0, #15			;padrao eh 5
	store velAlien1, r0		
	store velAlien4, r0
	
	loadn r0, #12			;padrao eh 4
	store velAlien2, r0
	
	loadn r0, #9			;padrao eh 3
	store velAlien3, r0
	
	loadn r0, #1
	store Horda, r0
	
	loadn r0, #8
	store addBullets, r0
	
	
	Loadn R0, #0			; Contador para os Mods	= 0
	loadn R2, #0			; Para verificar se (mod(c/10)==0
	
	store FlagTiro, R0		; Zera o Flag para marcar que ainda nao Atirou!
	store FlagTiro2, R0		; Zera o Flag para marcar que ainda nao Atirou!
	store FlagTiro3, R0		; Zera o Flag para marcar que ainda nao Atirou!
	
	store Kills, r0
	store Cont_Deaths, r0	
		
	store dirNave, R0
	store desAlien1, r0
	store Alien1Dead, r0
	
	store desAlien2, r0
	store Alien2Dead, r0
	
	store desAlien3, r0
	store Alien3Dead, r0
	
	store desAlien4, r0
	store Alien4Dead, r0
	
	store dirTiro1, R0   ;começa na vertical
	store dirTiro2, R0
	store dirTiro3, R0
	
	store dirTiro_Recalculapos, R0
	store dirTiro2_Recalculapos, R0
	store dirTiro3_Recalculapos, R0
	
	call MoveAlien1_Desenha
	call MoveAlien2_Desenha
	call MoveAlien3_Desenha
	call MoveAlien4_Desenha
	call MoveNave_Desenha
	
	
	call Print_Hordas
	call Print_Bullets
	
	Loop:
			
		loadn R1, #3    ;padrao eh 10
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/10)==0
		ceq MoveNave	; Chama Rotina de movimentacao da Nave
	
		load R1, velAlien1
		;loadn R1, #5   ;padrao eh 4
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien1	; Chama Rotina de movimentacao do Alien
		
		load R1, velAlien2
		;loadn R1, #4   ;padrao eh 3
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien2	; Chama Rotina de movimentacao do Alien
		
		load R1, velAlien3
		;loadn R1, #3   ;padrao eh 2
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien3	; Chama Rotina de movimentacao do Alien
		
		load R1, velAlien4
		;loadn R1, #5   ;padrao eh 4
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien4	; Chama Rotina de movimentacao do Alien
	
	
	
		loadn R1, #2	;padrao eh 2
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/2)==0
		ceq MoveTiro	; Chama Rotina de movimentacao do Tiro
		
		loadn R1, #2	;padrao eh 2
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/2)==0
		ceq MoveTiro_Dois	; Chama Rotina de movimentacao do Tiro
		
		loadn R1, #2	;padrao eh 2
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/2)==0
		ceq MoveTiro_Tres	; Chama Rotina de movimentacao do Tiro
		
		loadn r1, #150
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/2)==0
		ceq Reviver_Aliens
	
		call Delay
		inc R0 	;c++
		jmp Loop


main2:
	call ApagaTela
	call printcarregamentoScreen
	loadn r0, #0
	loadn r1, #5
	
	loadn r2, #0
	loadn r3, #3
	loadn r4, #1
	loadn r5, #2
	loadn r6, #3
	loadn r7, #4
	loop_load:
		inc r0
		call Delay
		cmp r0, r4
		ceq printcarreg1Screen
		cmp r0, r5
		ceq printcarreg2Screen
		cmp r0, r6
		ceq printcarreg3Screen
		cmp r0, r7
		ceq printcarreg4Screen
		cmp r0, r1
		ceq printcarreg5Screen
		
		
		cmp r0, r1
		jne loop_load
		
		loadn r0, #0
		inc r2
		cmp r2, r3
		jne loop_load
		
		
		;inc r0
		;cmp r0, r1
		;jne loop_load
	
	checkpoint:
	
	call ApagaTela
	loadn R1, #tela1Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #1024  			; cor branca!
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira
    
	loadn R1, #tela2Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #1792  			; cor branca!
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira
    
	loadn R1, #tela3Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor branca!
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira

	loadn R1, #tela4Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #256   			; cor branca!
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira

	loadn R0, #1020			
	store posNave, R0		; Zera Posicao Atual da Nave
	store posAntNave, R0	; Zera Posicao Anterior da Nave
	
	store FlagTiro, R0		; Zera o Flag para marcar que ainda nao Atirou!
	store posTiro, R0		; Zera Posicao Atual do Tiro
	store posAntTiro, R0	; Zera Posicao Anterior do Tiro
	
	;Loadn R0, #100
	;store posAlien, R0		; Zera Posicao Atual do Alien
	;store posAntAlien, R0	; Zera Posicao Anterior do Alien
	
	loadn R0, #100
	store posTiro2, R0
	store posAntTiro2, R0
	store FlagTiro2, R0
	store posNave2, R0
	store posAntNave2, R0
	
	Loadn R0, #0			; Contador para os Mods	= 0
	loadn R2, #0			; Para verificar se (mod(c/10)==0
	store dirNave, R0
	store dirTiro1, R0   ;começa na vertical
	store dirTiro2, R0
	store dirTiro3, R0
	store dirTiro_Recalculapos, R0
	
	
	call MoveNave_Desenha
	call MoveNave2_Desenha
	
	Loop2:
	
		loadn R1, #1    ;padrao eh 10
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/10)==0
		ceq MoveNave_Multi	; Chama Rotina de movimentacao da Nave
		
		
		loadn R1, #1    ;padrao eh 10
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/10)==0
		ceq MoveNave2	; Chama Rotina de movimentacao da Nave
	
		loadn R1, #1	;padrao eh 2
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/2)==0
		ceq MoveTiro_Multi	; Chama Rotina de movimentacao do Tiro
		
		
		loadn R1, #1	;padrao eh 2
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/2)==0
		ceq MoveTiro2	; Chama Rotina de movimentacao do Tiro
	
		call Delay
		inc R0 	;c++
		jmp Loop2








;Funcoes
;--------------------------

printtelamenuScreen:
  push R0
  push R1
  push R2
  push R3

  loadn R0, #telamenu
  loadn R1, #0
  loadn R2, #1200

  printtelamenuScreenLoop:

    add R3,R0,R1
    loadi R3, R3
    outchar R3, R1
    inc R1
    cmp R1, R2

    jne printtelamenuScreenLoop

  pop R3
  pop R2
  pop R1
  pop R0
  rts
;-----------------------------
printcarregamentoScreen:
  push R0
  push R1
  push R2
  push R3

  loadn R0, #carregamento
  loadn R1, #0
  loadn R2, #1200

  printcarregamentoScreenLoop:

    add R3,R0,R1
    loadi R3, R3
    outchar R3, R1
    inc R1
    cmp R1, R2

    jne printcarregamentoScreenLoop

  pop R3
  pop R2
  pop R1
  pop R0
  rts

printcarreg1Screen:
  push R0
  push R1
  push R2
  push R3
  
  
  loadn R0, #carreg1
  loadn R1, #0
  loadn R2, #1200

  printcarreg1ScreenLoop:

    add R3,R0,R1
    loadi R3, R3
    outchar R3, R1
    inc R1
    cmp R1, R2

    jne printcarreg1ScreenLoop

  pop R3
  pop R2
  pop R1
  pop R0
  rts

printcarreg2Screen:
  push R0
  push R1
  push R2
  push R3
  
  loadn R0, #carreg2
  loadn R1, #0
  loadn R2, #1200

  printcarreg2ScreenLoop:

    add R3,R0,R1
    loadi R3, R3
    outchar R3, R1
    inc R1
    cmp R1, R2

    jne printcarreg2ScreenLoop

  pop R3
  pop R2
  pop R1
  pop R0
  rts

printcarreg3Screen:
  push R0
  push R1
  push R2
  push R3
  
  loadn R0, #carreg3
  loadn R1, #0
  loadn R2, #1200

  printcarreg3ScreenLoop:

    add R3,R0,R1
    loadi R3, R3
    outchar R3, R1
    inc R1
    cmp R1, R2

    jne printcarreg3ScreenLoop

  pop R3
  pop R2
  pop R1
  pop R0
  rts

printcarreg4Screen:
  push R0
  push R1
  push R2
  push R3
  
  loadn R0, #carreg4
  loadn R1, #0
  loadn R2, #1200

  printcarreg4ScreenLoop:

    add R3,R0,R1
    loadi R3, R3
    outchar R3, R1
    inc R1
    cmp R1, R2

    jne printcarreg4ScreenLoop

  pop R3
  pop R2
  pop R1
  pop R0
  rts

printcarreg5Screen:
  push R0
  push R1
  push R2
  push R3
  
  loadn R0, #carreg5
  loadn R1, #0
  loadn R2, #1200

  printcarreg5ScreenLoop:

    add R3,R0,R1
    loadi R3, R3
    outchar R3, R1
    inc R1
    cmp R1, R2

    jne printcarreg5ScreenLoop

  pop R3
  pop R2
  pop R1
  pop R0
  rts




;------------------------------------------------------------------------------------

MoveNave:
	push r0
	push r1
	
	call MoveNave_RecalculaPos		; Recalcula Posicao da Nave

; So' Apaga e Redesenha se (pos != posAnt)
;	If (posNave != posAntNave)	{	
	load r0, posNave
	load r1, posAntNave
	cmp r0, r1
	jeq MoveNave_Skip
		call MoveNave_Apaga
		call MoveNave_Desenha		;}
  MoveNave_Skip:
	
	pop r1
	pop r0
	rts
	

MoveNave_Multi:
	push r0
	push r1
	;
	
	call MoveNave_RecalculaPos_Multi		; Recalcula Posicao da Nave

; So' Apaga e Redesenha se (pos != posAnt)
;	If (posNave != posAntNave)	{	
	load r0, posNave
	load r1, posAntNave
	cmp r0, r1
	jeq MoveNave_Multi_Skip
		call MoveNave_Apaga
		call MoveNave_Desenha		;}
		
	MoveNave_Multi_Skip:
			
		
		pop r1
		pop r0
		rts
	
;------------------------------
MoveNave2:
	push r0
	push r1
	push r2
	
	call MoveNave_RecalculaPos_Multi		; Recalcula Posicao da Nave

; So' Apaga e Redesenha se (pos != posAnt)
;	If (posNave != posAntNave)	{	
	load r0, posNave2
	load r1, posAntNave2
	load r2, posNave
	
	cmp r0, r2
	jeq MoveTiro2_RecalculaPos_Boom
	cmp r0, r1
	jeq MoveNave2_Skip
		call MoveNave2_Apaga
		call MoveNave2_Desenha		;}
		
	MoveNave2_Skip:
		
		pop r2
		pop r1
		pop r0
		rts

;--------------------------------
	
MoveNave_Apaga:		; Apaga a Nave preservando o Cenario!
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5

	load R0, posAntNave	; R0 = posAnt
	
	; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!

	loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
	loadn R4, #40
	div R3, R0, R4	; R3 = posAnt/40
	add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
	
	loadi R5, R2	; R5 = Char (Tela(posAnt))
	
	outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
	
	pop R5
	pop R4
	pop R3
	pop R2
	pop R1
	pop R0
	rts


MoveNave2_Apaga:		; Apaga a Nave preservando o Cenario!
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5

	load R0, posAntNave2	; R0 = posAnt
	
	; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!

	loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
	loadn R4, #40
	div R3, R0, R4	; R3 = posAnt/40
	add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
	
	loadi R5, R2	; R5 = Char (Tela(posAnt))
	
	outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
	
	pop R5
	pop R4
	pop R3
	pop R2
	pop R1
	pop R0
	rts
;----------------------------------	
	
MoveNave_RecalculaPos:		; Recalcula posicao da Nave em funcao das Teclas pressionadas
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5
	push R6

	load R0, posNave
	
	inchar R1				; Le Teclado para controlar a Nave
	loadn R2, #'a'
	cmp R1, R2
	jeq MoveNave_RecalculaPos_A
	
	loadn R2, #'d'
	cmp R1, R2
	jeq MoveNave_RecalculaPos_D
		
	loadn R2, #'w'
	cmp R1, R2
	jeq MoveNave_RecalculaPos_W
		
	loadn R2, #'s'
	cmp R1, R2
	jeq MoveNave_RecalculaPos_S
	
	loadn R2, #' '
	cmp R1, R2
	jeq MoveNave_RecalculaPos_Tiro
	
  MoveNave_RecalculaPos_Fim:	; Se nao for nenhuma tecla valida, vai embora
	store posNave, R0
	
	pop R6
	pop R5
	pop R4
	pop R3
	pop R2
	pop R1
	pop R0
	rts

  MoveNave_RecalculaPos_A:	; Move Nave para Esquerda
  	
  	call MoveNave_Apaga
  	loadn r5, #3
  	store dirNave, r5
  	loadn R1, #11	; Nave
	loadn R2, #2048
	add R1, R1, R2
	load R0, posNave
	outchar R1, R0
	
  	
  	jmp MoveNave_RecalculaPos_Fim
  	
	;loadn R1, #40
	;loadn R2, #0
	;mod R1, R0, R1		; Testa condicoes de Contorno 
	;cmp R1, R2
	;jeq MoveNave_RecalculaPos_Fim
	;dec R0	; pos = pos -1
	;jmp MoveNave_RecalculaPos_Fim
		
  MoveNave_RecalculaPos_D:	; Move Nave para Direita
  
  	call MoveNave_Apaga
  	loadn r5, #1
  	store dirNave, r5
  	loadn R1, #10	; Nave
	loadn R2, #2048
	add R1, R1, R2
	load R0, posNave
	outchar R1, R0
  	
	jmp MoveNave_RecalculaPos_Fim
	
  MoveNave_RecalculaPos_W:	; Move Nave para Cima
    call MoveNave_Apaga
    loadn r5, #0
  	store dirNave, r5
  	loadn R1, #8	; Nave
	loadn R2, #2048
	add R1, R1, R2
	load R0, posNave
	outchar R1, R0
    jmp MoveNave_RecalculaPos_Fim
	;loadn R1, #40
	;load r2, dirNave
	;loadn r3, #0
	;cmp r2, r3
	;jeq Mover_Cima
	
	;loadn r3, #1
	;cmp r2, r3
	;jeq Mover_Dir
	
	;loadn r3, #2
	;cmp r2, r3
	;jeq Mover_Baixo
	
	;loadn r3, #3
	;cmp r2, r3
	;jeq Mover_Esq
	
	
	;Mover_Cima:
    
    ;cmp R0, R1   ; Testa condicoes de Contorno 
    ;jle MoveNave_RecalculaPos_Fim
		;sub R0, R0, R1	; pos = pos - 40
		;jmp MoveNave_RecalculaPos_Fim
	;Mover_Baixo:
    ;loadn R2, #1159
    ;cmp R0, R2    ; Testa condicoes de Contorno 
    ;jgr MoveNave_RecalculaPos_Fim
		;add R0, R0, R1	; pos = pos + 40
		;jmp MoveNave_RecalculaPos_Fim
	;Mover_Dir:
    ;loadn R2, #39
    ;mod R1, R0, R1    ; Testa condicoes de Contorno 
    ;cmp R1, R2
    ;jeq MoveNave_RecalculaPos_Fim
		;inc R0
		;jmp MoveNave_RecalculaPos_Fim
	;Mover_Esq:
    ;loadn R2, #0
    ;mod R1, R0, R1    ; Testa condicoes de Contorno 
    ;cmp R1, R2
    ;jeq MoveNave_RecalculaPos_Fim
		;dec R0
		;jmp MoveNave_RecalculaPos_Fim

  MoveNave_RecalculaPos_S:	; Move Nave para Baixo
    call MoveNave_Apaga
    loadn r5, #2
  	store dirNave, r5
    loadn R1, #12	; Nave
	loadn R2, #2048
	add R1, R1, R2
	load R0, posNave
	outchar R1, R0
    jmp MoveNave_RecalculaPos_Fim
    
	;loadn R1, #40
	;load r2, dirNave
	;loadn r3, #0
	;cmp r3, r2
	;jeq Mover_Sul_Zero
	
	;loadn r3, #1
	;cmp r3, r2
	;jeq Mover_Sul_Um
	
	;loadn r3, #2
	;cmp r3, r2
	;jeq Mover_Sul_Dois
	
	;loadn r3, #3
	;cmp r3, r2
	;jeq Mover_Sul_Tres
	
	;Mover_Sul_Zero:
    ;loadn R2, #1159
    ;cmp R0, R2    ; Testa condicoes de Contorno 
    ;jgr MoveNave_RecalculaPos_Fim
		;add R0, R0, R1	; pos = pos + 40
		;jmp MoveNave_RecalculaPos_Fim	
	
	;Mover_Sul_Um:
    ;loadn R2, #0
    ;mod R1, R0, R1    ; Testa condicoes de Contorno 
    ;cmp R1, R2
    ;jeq MoveNave_RecalculaPos_Fim
    
		;dec r0
		;jmp MoveNave_RecalculaPos_Fim
	
	;Mover_Sul_Dois:
    ;cmp R0, R1   ; Testa condicoes de Contorno 
    ;jle MoveNave_RecalculaPos_Fim
		;sub r0, r0, r1
		;jmp MoveNave_RecalculaPos_Fim
	
	;Mover_Sul_Tres:
    ;loadn R2, #39
    ;mod R1, R0, R1    ; Testa condicoes de Contorno 
    ;cmp R1, R2
    ;jeq MoveNave_RecalculaPos_Fim
    
		;inc r0
		;jmp MoveNave_RecalculaPos_Fim

	
  MoveNave_RecalculaPos_Tiro:	
  	
  	loadn R1, #0
  	load R2, Bullets
  	cmp r1, r2
  	jeq MoveNave_RecalculaPos_Fim
  	
	loadn R1, #1			; Se Atirou:
	load r2, FlagTiro
	cmp r1, r2
	jne Tiro_Um
	
	load r2, FlagTiro2
	cmp r1, r2
	jne Tiro_Dois
	
	load r2, FlagTiro3
	cmp r1, r2
	jne Tiro_Tres
	
	jmp MoveNave_RecalculaPos_Fim
	
	Tiro_Um:
		
		load r3, Bullets
		sub r3, r3, r1
		store Bullets, r3
		
		call Print_Bullets
	
		store FlagTiro, R1		; FlagTiro = 1
		store posTiro, R0		; posTiro = posNave
		
		load r3, dirNave
		
		loadn r4, #0
		store dirTiro_Recalculapos, r4
		cmp r3, r4
		jeq Dir_Tiro_Vertical
		
		 
		loadn r4, #2
		store dirTiro_Recalculapos, r4
		cmp r3, r4
		jeq Dir_Tiro_Vertical
		
		loadn r4, #1
		store dirTiro_Recalculapos, r4
		cmp r3, r4
		jeq Dir_Tiro_Horizontal
		
		loadn r4, #3
		store dirTiro_Recalculapos, r4
		cmp r3, r4
		jeq Dir_Tiro_Horizontal
		
		Dir_Tiro_Vertical:
			loadn r4, #0
			store dirTiro1, r4
			jmp MoveNave_RecalculaPos_Fim
			
		Dir_Tiro_Horizontal:
			loadn r4, #1
			store dirTiro1, r4
			jmp MoveNave_RecalculaPos_Fim	
			
	
	Tiro_Dois:
	
		load r3, Bullets
		sub r3, r3, r1
		store Bullets, r3
		
		call Print_Bullets
	
		store FlagTiro2, R1		; FlagTiro = 1
		store posTiro2, R0		; posTiro = posNave
		
		load r3, dirNave
		
		loadn r4, #0
		store dirTiro2_Recalculapos, r4
		cmp r3, r4
		jeq Dir_Tiro_Vertical_2
		
		 
		loadn r4, #2
		store dirTiro2_Recalculapos, r4
		cmp r3, r4
		jeq Dir_Tiro_Vertical_2
		
		loadn r4, #1
		store dirTiro2_Recalculapos, r4
		cmp r3, r4
		jeq Dir_Tiro_Horizontal_2
		
		loadn r4, #3
		store dirTiro2_Recalculapos, r4
		cmp r3, r4
		jeq Dir_Tiro_Horizontal_2
		
		Dir_Tiro_Vertical_2:
			loadn r4, #0
			store dirTiro2, r4
			jmp MoveNave_RecalculaPos_Fim
			
		Dir_Tiro_Horizontal_2:
			loadn r4, #1
			store dirTiro2, r4
			jmp MoveNave_RecalculaPos_Fim	
	
	Tiro_Tres:
		
		load r3, Bullets
		sub r3, r3, r1
		store Bullets, r3
		
		call Print_Bullets
	
		store FlagTiro3, R1		; FlagTiro = 1
		store posTiro3, R0		; posTiro = posNave
		
		load r3, dirNave
		
		loadn r4, #0
		store dirTiro3_Recalculapos, r4
		cmp r3, r4
		jeq Dir_Tiro_Vertical_3
		
		 
		loadn r4, #2
		store dirTiro3_Recalculapos, r4
		cmp r3, r4
		jeq Dir_Tiro_Vertical_3
		
		loadn r4, #1
		store dirTiro3_Recalculapos, r4
		cmp r3, r4
		jeq Dir_Tiro_Horizontal_3
		
		loadn r4, #3
		store dirTiro3_Recalculapos, r4
		cmp r3, r4
		jeq Dir_Tiro_Horizontal_3
		
		Dir_Tiro_Vertical_3:
			loadn r4, #0
			store dirTiro3, r4
			jmp MoveNave_RecalculaPos_Fim
			
		Dir_Tiro_Horizontal_3:
			loadn r4, #1
			store dirTiro3, r4
			jmp MoveNave_RecalculaPos_Fim	
	

MoveNave_RecalculaPos_Multi:		; Recalcula posicao da Nave em funcao das Teclas pressionadas
	push R0
	push R1
	push R2
	push R3
	push R4

	load R0, posNave
	load R4, posNave2
	
	inchar R1				; Le Teclado para controlar a Nave
	loadn R2, #'a'
	cmp R1, R2
	jeq MoveNave_RecalculaPos_A_Multi
	
	loadn R2, #'j'
	cmp R1, R2
	jeq MoveNave2_RecalculaPos_A_Multi
	
	loadn R2, #'d'
	cmp R1, R2
	jeq MoveNave_RecalculaPos_D_Multi
	
	loadn R2, #'l'
	cmp R1, R2
	jeq MoveNave2_RecalculaPos_D_Multi
		
	loadn R2, #'w'
	cmp R1, R2
	jeq MoveNave_RecalculaPos_W_Multi
	
	loadn R2, #'i'
	cmp R1, R2
	jeq MoveNave2_RecalculaPos_W_Multi
		
	loadn R2, #'s'
	cmp R1, R2
	jeq MoveNave_RecalculaPos_S_Multi
	
	loadn R2, #'k'
	cmp R1, R2
	jeq MoveNave2_RecalculaPos_S_Multi
	
	loadn R2, #'e'
	cmp R1, R2
	jeq MoveNave_RecalculaPos_Tiro_Multi
	
	loadn R2, #'p'
	cmp R1, R2
	jeq MoveNave2_RecalculaPos_Tiro_Multi
	
	
  MoveNave_RecalculaPos_Fim_Multi:	; Se nao for nenhuma tecla valida, vai embora
	store posNave, R0
	store posNave2, R4
	pop R4
	pop R3
	pop R2
	pop R1
	pop R0
	rts

MoveNave_RecalculaPos_A_Multi:	; Move Nave para Esquerda
	loadn R1, #40
	loadn R2, #0
	mod R1, R0, R1		; Testa condicoes de Contorno 
	cmp R1, R2
	jeq MoveNave_RecalculaPos_Fim_Multi
	dec R0	; pos = pos -1
	jmp MoveNave_RecalculaPos_Fim_Multi

MoveNave2_RecalculaPos_A_Multi:	; Move Nave para Esquerda
	loadn R1, #40
	loadn R2, #0
	mod R1, R4, R1		; Testa condicoes de Contorno 
	cmp R1, R2
	jeq MoveNave_RecalculaPos_Fim_Multi
	dec R4	; pos = pos -1
	jmp MoveNave_RecalculaPos_Fim_Multi

;------------------
MoveNave_RecalculaPos_D_Multi:	; Move Nave para Direita	
	loadn R1, #40
	loadn R2, #39
	mod R1, R0, R1		; Testa condicoes de Contorno 
	cmp R1, R2
	jeq MoveNave_RecalculaPos_Fim_Multi
	inc R0	; pos = pos + 1
	jmp MoveNave_RecalculaPos_Fim_Multi
	
MoveNave2_RecalculaPos_D_Multi:	; Move Nave para Direita	
	loadn R1, #40
	loadn R2, #39
	mod R1, R4, R1		; Testa condicoes de Contorno 
	cmp R1, R2
	jeq MoveNave_RecalculaPos_Fim_Multi
	inc R4	; pos = pos + 1
	jmp MoveNave_RecalculaPos_Fim_Multi

;------------------
MoveNave_RecalculaPos_W_Multi:	; Move Nave para Cima
	loadn R1, #40
	cmp R0, R1		; Testa condicoes de Contorno 
	jle MoveNave_RecalculaPos_Fim_Multi
	sub R0, R0, R1	; pos = pos - 40
	jmp MoveNave_RecalculaPos_Fim_Multi
	
MoveNave2_RecalculaPos_W_Multi:	; Move Nave para Cima
	loadn R1, #40
	cmp R4, R1		; Testa condicoes de Contorno 
	jle MoveNave_RecalculaPos_Fim_Multi
	sub R4, R4, R1	; pos = pos - 40
	jmp MoveNave_RecalculaPos_Fim_Multi

;------------------
MoveNave_RecalculaPos_S_Multi:	; Move Nave para Baixo
	loadn R1, #1159
	cmp R0, R1		; Testa condicoes de Contorno 
	jgr MoveNave_RecalculaPos_Fim_Multi
	loadn R1, #40
	add R0, R0, R1	; pos = pos + 40
	jmp MoveNave_RecalculaPos_Fim_Multi

MoveNave2_RecalculaPos_S_Multi:	; Move Nave para Baixo
	loadn R1, #1159
	cmp R4, R1		; Testa condicoes de Contorno 
	jgr MoveNave_RecalculaPos_Fim_Multi
	loadn R1, #40
	add R4, R4, R1	; pos = pos + 40
	jmp MoveNave_RecalculaPos_Fim_Multi

;------------------
MoveNave_RecalculaPos_Tiro_Multi:	
	loadn R1, #1			; Se Atirou:
	store FlagTiro, R1		; FlagTiro = 1
	store posTiro, R0		; posTiro = posNave
	jmp MoveNave_RecalculaPos_Fim_Multi	

MoveNave2_RecalculaPos_Tiro_Multi:	
	loadn R1, #1			; Se Atirou:
	store FlagTiro2, R1		; FlagTiro = 1
	store posTiro2, R4		; posTiro = posNave
	jmp MoveNave_RecalculaPos_Fim_Multi	
	
	


;----------------------------------


;-------------------------------------------------

MoveNave_Desenha:	; Desenha caractere da Nave
	push R0
	push R1
	push R2
	push R3
	push R4
	
	load r3, dirNave
	loadn r4, #0
	cmp r3, r4
	jeq Desenhar_Zero
	
	loadn r4, #1
	cmp r3, r4
	jeq Desenhar_Um
	
	loadn r4, #2
	cmp r3, r4
	jeq Desenhar_Dois
	
	loadn r4, #3
	cmp r3, r4
	jeq Desenhar_Tres
	
	Desenhar_Zero:
		loadn R1, #8	; Nave
		jmp MoveNave_Desenha_Fim
	Desenhar_Um:
		loadn R1, #10	; Nave
		jmp MoveNave_Desenha_Fim
	Desenhar_Dois:
		loadn R1, #12	; Nave
		jmp MoveNave_Desenha_Fim
	Desenhar_Tres:
		loadn R1, #11	; Nave
		jmp MoveNave_Desenha_Fim
	
	MoveNave_Desenha_Fim:
		loadn R2, #2048
		add R1, R1, R2
		load R0, posNave
		outchar R1, R0
		store posAntNave, R0	; Atualiza Posicao Anterior da Nave = Posicao Atual
		
		pop R4
		pop R3
		pop R2
		pop R1
		pop R0
		rts




;--------------------------
MoveNave2_Desenha:	; Desenha caractere da Nave
	push R0
	push R1
	push R2
	
	Loadn R1, #9	; Nave
	loadn R2, #512
	add R1, R1, R2
	load R0, posNave2
	outchar R1, R0
	store posAntNave2, R0	; Atualiza Posicao Anterior da Nave = Posicao Atual
	
	pop R2
	pop R1
	pop R0
	rts
	
	
	
;----------------------------------
;----------------------------------
;----------------------------------


;----------------------------- ALIEN 1 -----------------------------
MoveAlien1:
	push r0
	push r1
	
	load r0, Alien1Dead
	loadn r1, #1
	cmp r0, r1
	jeq MoveAlien1_Skip
	
	call MoveAlien1_RecalculaPos
	
; So' Apaga e Redezenha se (pos != posAnt)
;	If (pos != posAnt)	{	
	load r0, posAlien1
	load r1, posAntAlien1
	cmp r0, r1
	jeq MoveAlien1_Skip
	
	call MoveAlien1_Apaga
	call MoveAlien1_Desenha		;}
  	
  	MoveAlien1_Skip:
		pop r1
		pop r0
		rts

;----------------------------------

MoveAlien1_Apaga:
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5
	push R6
	
	loadn R6, #2048
	load R0, posAntAlien1	; R0 == posAnt
	load R1, posAntNave		; R1 = posAnt
	cmp r0, r1
	jne MoveAlien1_Apaga_Skip
	
	loadn r5, #8		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
	add r5, r5, r6
	jmp MoveAlien1_Apaga_Fim

  	MoveAlien1_Apaga_Skip:	
  
		; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
		loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
		add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
		loadn R4, #40
		div R3, R0, R4	; R3 = posAnt/40
		add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
		
		loadi R5, R2	; R5 = Char (Tela(posAnt))
  
  	MoveAlien1_Apaga_Fim:	
		outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
		
		pop R6
		pop R5
		pop R4
		pop R3
		pop R2
		pop R1
		pop R0
		rts

;----------------------------------
MoveAlien1_RecalculaPos:
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5
	push R6
	push R7
	
	load r4, desAlien1
	loadn r5, #1
	cmp r4, r5
	jeq MoveAlien1_RecalculaPos_Volta
	
	load r2, FlagTiro
	loadn r3, #0
	cmp r2, r3
	jeq MoveAlien1_RecalculaPos_Continua
	
	load r2, dirTiro1
	loadn r3, #0
	cmp r2, r3
	jeq MoveAlien1_RecalculaPos_Desvia
	
	jmp MoveAlien1_RecalculaPos_Continua
	
	MoveAlien1_RecalculaPos_Desvia:
		load r0, posAlien1
		loadn r1, #41
		add r0, r0, r1
		store posAlien1, r0
		loadn r2, #1
		store desAlien1, r2
		jmp MoveAlien1_RecalculaPos_Fim
	
	MoveAlien1_RecalculaPos_Volta:
		load r0, posAlien1
		loadn r1, #1		;#1 padrao
		sub r0, r0, r1      ;sub padrao
		store posAlien1, r0
		loadn r2, #0
		store desAlien1, r2
		jmp MoveAlien1_RecalculaPos_Fim
	
	MoveAlien1_RecalculaPos_Continua:
		load r0, posAlien1
		loadn r1, #40
		add r0, r0, r1
		store posAlien1, r0
		jmp MoveAlien1_RecalculaPos_Fim
	
	
	
	MoveAlien1_RecalculaPos_Fim:
		
		pop R7
		pop R6
		pop R5
		pop R4
		pop R3
		pop R2
		pop R1
		pop R0
		rts

;---------------------------------

MoveAlien1_Desenha:
	push R0
	push R1
	push R2
	push R3
	
	Loadn R1, #9	; Alien
	loadn R2, #512
	add R1, R1, R2
	load R0, posAlien1
	outchar R1, R0
	store posAntAlien1, R0
	
	load r3, posNave
	cmp r3, r0
	jne MoveAlien1_Desenha_Fim
	
	
	
	jmp Game_Over
	
	
		
	MoveAlien1_Desenha_Fim:
		pop R3
		pop R2
		pop R1
		pop R0
		rts

;---------------------------------

;----------------------------- ALIEN 2 -----------------------------
MoveAlien2:
	push r0
	push r1
	
	load r0, Alien2Dead
	loadn r1, #1
	cmp r0, r1
	jeq MoveAlien3_Skip
	
	call MoveAlien2_RecalculaPos
	
; So' Apaga e Redezenha se (pos != posAnt)
;	If (pos != posAnt)	{	
	load r0, posAlien2
	load r1, posAntAlien2
	cmp r0, r1
	jeq MoveAlien2_Skip
	
	call MoveAlien2_Apaga
	call MoveAlien2_Desenha		;}
  	
  	MoveAlien2_Skip:
		pop r1
		pop r0
		rts

;----------------------------------

MoveAlien2_Apaga:
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5
	push R6
	
	loadn R6, #2048
	load R0, posAntAlien2	; R0 == posAnt
	load R1, posAntNave		; R1 = posAnt
	cmp r0, r1
	jne MoveAlien2_Apaga_Skip
	
	loadn r5, #8		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
	add r5, r5, r6
	jmp MoveAlien2_Apaga_Fim

  	MoveAlien2_Apaga_Skip:	
  
		; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
		loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
		add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
		loadn R4, #40
		div R3, R0, R4	; R3 = posAnt/40
		add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
		
		loadi R5, R2	; R5 = Char (Tela(posAnt))
  
  	MoveAlien2_Apaga_Fim:	
		outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
		
		pop R6
		pop R5
		pop R4
		pop R3
		pop R2
		pop R1
		pop R0
		rts

;----------------------------------
MoveAlien2_RecalculaPos:
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5
	push R6
	push R7
	
	load r4, desAlien2
	loadn r5, #1
	cmp r4, r5
	jeq MoveAlien2_RecalculaPos_Volta
	
	load r2, FlagTiro
	loadn r3, #1
	cmp r2, r3
	jeq MoveAlien2_RecalculaPos_Desvia
	
	jmp MoveAlien2_RecalculaPos_Continua
	
	MoveAlien2_RecalculaPos_Desvia:
		load r0, posAlien2
		loadn r1, #41
		add r0, r0, r1
		store posAlien2, r0
		loadn r2, #1
		store desAlien2, r2
		jmp MoveAlien2_RecalculaPos_Fim
	
	MoveAlien2_RecalculaPos_Volta:
		load r0, posAlien2
		loadn r1, #40
		sub r0, r0, r1
		store posAlien2, r0
		loadn r2, #0
		store desAlien2, r2
		jmp MoveAlien2_RecalculaPos_Fim
	
	MoveAlien2_RecalculaPos_Continua:
		load r0, posAlien2
		loadn r1, #1
		add r0, r0, r1
		store posAlien2, r0
		jmp MoveAlien2_RecalculaPos_Fim
	
	
	
	MoveAlien2_RecalculaPos_Fim:
		
		pop R7
		pop R6
		pop R5
		pop R4
		pop R3
		pop R2
		pop R1
		pop R0
		rts
		
;---------------------------------

MoveAlien2_Desenha:
	push R0
	push R1
	push R2
	
	Loadn R1, #9	; Alien Azul 
	loadn R2, #512   ;3072
	add R1, R1, R2
	load R0, posAlien2
	outchar R1, R0
	store posAntAlien2, R0
	
	load r3, posNave
	cmp r3, r0
	jne MoveAlien2_Desenha_Fim
	
	jmp Game_Over
	
	MoveAlien2_Desenha_Fim:
		pop R2
		pop R1
		pop R0
		rts


;----------------------------- ALIEN 3 -----------------------------
MoveAlien3:
	push r0
	push r1
	
	load r0, Alien3Dead
	loadn r1, #1
	cmp r0, r1
	jeq MoveAlien3_Skip
	
	call MoveAlien3_RecalculaPos
	
; So' Apaga e Redezenha se (pos != posAnt)
;	If (pos != posAnt)	{	
	load r0, posAlien3
	load r1, posAntAlien3
	cmp r0, r1
	jeq MoveAlien3_Skip
	
	call MoveAlien3_Apaga
	call MoveAlien3_Desenha		;}
  	
  	MoveAlien3_Skip:
		pop r1
		pop r0
		rts

;----------------------------------

MoveAlien3_Apaga:
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5
	push R6
	
	loadn R6, #2048
	load R0, posAntAlien3	; R0 == posAnt
	load R1, posAntNave		; R1 = posAnt
	cmp r0, r1
	jne MoveAlien3_Apaga_Skip
	
	loadn r5, #8		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
	add r5, r5, r6
	jmp MoveAlien3_Apaga_Fim

  	MoveAlien3_Apaga_Skip:	
  
		; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
		loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
		add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
		loadn R4, #40
		div R3, R0, R4	; R3 = posAnt/40
		add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
		
		loadi R5, R2	; R5 = Char (Tela(posAnt))
  
  	MoveAlien3_Apaga_Fim:	
		outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
		
		pop R6
		pop R5
		pop R4
		pop R3
		pop R2
		pop R1
		pop R0
		rts

;----------------------------------
MoveAlien3_RecalculaPos:
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5
	push R6
	push R7
	
	load r4, desAlien3
	loadn r5, #1
	cmp r4, r5
	jeq MoveAlien3_RecalculaPos_Volta
	
	load r2, FlagTiro2
	loadn r3, #1
	cmp r2, r3
	jeq MoveAlien3_RecalculaPos_Desvia
	
	jmp MoveAlien3_RecalculaPos_Continua
	
	MoveAlien3_RecalculaPos_Desvia:
		load r0, posAlien3
		loadn r1, #40
		sub r0, r0, r1
		store posAlien3, r0
		loadn r2, #1
		store desAlien3, r2
		jmp MoveAlien3_RecalculaPos_Fim
	
	MoveAlien3_RecalculaPos_Volta:
		load r0, posAlien3
		loadn r1, #40
		add r0, r0, r1
		store posAlien3, r0
		loadn r2, #0
		store desAlien3, r2
		jmp MoveAlien3_RecalculaPos_Fim
	
	MoveAlien3_RecalculaPos_Continua:
		load r0, posAlien3
		loadn r1, #1
		sub r0, r0, r1
		store posAlien3, r0
		jmp MoveAlien3_RecalculaPos_Fim
	
	
	
	MoveAlien3_RecalculaPos_Fim:
		pop R7
		pop R6
		pop R5
		pop R4
		pop R3
		pop R2
		pop R1
		pop R0
		rts

;---------------------------------

MoveAlien3_Desenha:
	push R0
	push R1
	push R2
	
	Loadn R1, #9	; Alien vermelho
	loadn R2, #512   ;2304
	add R1, R1, R2
	load R0, posAlien3
	outchar R1, R0
	store posAntAlien3, R0
	
	load r3, posNave
	cmp r3, r0
	jne MoveAlien3_Desenha_Fim
	
	jmp Game_Over
	
	MoveAlien3_Desenha_Fim:
		pop R2
		pop R1
		pop R0
		rts


;----------------------------- ALIEN 4 -----------------------------
MoveAlien4:
	push r0
	push r1
	
	load r0, Alien4Dead
	loadn r1, #1
	cmp r0, r1
	jeq MoveAlien4_Skip
	
	call MoveAlien4_RecalculaPos
	
; So' Apaga e Redezenha se (pos != posAnt)
;	If (pos != posAnt)	{	
	load r0, posAlien4
	load r1, posAntAlien4
	cmp r0, r1
	jeq MoveAlien4_Skip
	
	call MoveAlien4_Apaga
	call MoveAlien4_Desenha		;}
  	
  	MoveAlien4_Skip:
		pop r1
		pop r0
		rts

;----------------------------------

MoveAlien4_Apaga:
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5
	push R6
	
	loadn R6, #2048
	load R0, posAntAlien4	; R0 == posAnt
	load R1, posAntNave		; R1 = posAnt
	cmp r0, r1
	jne MoveAlien4_Apaga_Skip
	
	loadn r5, #8		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
	add r5, r5, r6
	jmp MoveAlien4_Apaga_Fim

  	MoveAlien4_Apaga_Skip:	
  
		; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
		loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
		add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
		loadn R4, #40
		div R3, R0, R4	; R3 = posAnt/40
		add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
		
		loadi R5, R2	; R5 = Char (Tela(posAnt))
  
  	MoveAlien4_Apaga_Fim:	
		outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
		
		pop R6
		pop R5
		pop R4
		pop R3
		pop R2
		pop R1
		pop R0
		rts

;----------------------------------
MoveAlien4_RecalculaPos:
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5
	push R6
	push R7
	
	load r4, desAlien4
	loadn r5, #1
	cmp r4, r5
	jeq MoveAlien4_RecalculaPos_Volta
	
	load r2, FlagTiro2
	loadn r3, #1
	cmp r2, r3
	jeq MoveAlien4_RecalculaPos_Desvia
	
	jmp MoveAlien4_RecalculaPos_Continua
	
	MoveAlien4_RecalculaPos_Desvia:
		load r0, posAlien4
		loadn r1, #39
		sub r0, r0, r1
		store posAlien4, r0
		loadn r2, #1
		store desAlien4, r2
		jmp MoveAlien4_RecalculaPos_Fim
	
	MoveAlien4_RecalculaPos_Volta:
		load r0, posAlien4
		loadn r1, #1
		sub r0, r0, r1
		store posAlien4, r0
		loadn r2, #0
		store desAlien4, r2
		jmp MoveAlien4_RecalculaPos_Fim
	
	MoveAlien4_RecalculaPos_Continua:
		load r0, posAlien4
		loadn r1, #40
		sub r0, r0, r1
		store posAlien4, r0
		jmp MoveAlien4_RecalculaPos_Fim
	
	
	
	MoveAlien4_RecalculaPos_Fim:
		pop R7
		pop R6
		pop R5
		pop R4
		pop R3
		pop R2
		pop R1
		pop R0
		rts

;---------------------------------

MoveAlien4_Desenha:
	push R0
	push R1
	push R2
	
	Loadn R1, #9	; Alien Amarelo
	loadn R2, #512  ;2816
	add R1, R1, R2
	load R0, posAlien4
	outchar R1, R0
	store posAntAlien4, R0
	
	load r3, posNave
	cmp r3, r0
	jne MoveAlien4_Desenha_Fim
	
	jmp Game_Over
	
	MoveAlien4_Desenha_Fim:
		pop R2
		pop R1
		pop R0
		rts
		
		
;----------------------------------------------------------------------------
Reviver_Aliens:
	push r0
	push r1
	
	load r0, Cont_Deaths
	loadn r1, #4
	cmp r0, r1
	jne Reviver_Aliens_Fim
	
	
	call MoveAlien1_Apaga
	call MoveAlien2_Apaga
	call MoveAlien3_Apaga
	call MoveAlien4_Apaga
	
	load r0, Bullets
	load r1, addBullets
	add r0, r0, r1
	store Bullets, r0
	
	call Print_Bullets
	
	loadn r0, #0
	store desAlien1, r0
	store desAlien2, r0
	store desAlien3, r0
	store desAlien4, r0
	store Alien1Dead, r0
	store Alien2Dead, r0
	store Alien3Dead, r0
	store Alien4Dead, r0
	store Cont_Deaths, r0
	
	loadn r0, #19
	store posAlien1, r0
	store posAntAlien1, r0
	
	loadn r0, #600
	store posAlien2, r0
	store posAntAlien2, r0
	
	loadn r0, #639
	store posAlien3, r0
	store posAntAlien3, r0
	
	loadn r0, #1179
	store posAlien4, r0
	store posAntAlien4, r0
	
	load r0, Horda
	inc r0
	store Horda, r0
	
	call Print_Hordas
	
	loadn r1, #10
	cmp r0, r1
	jeq Horda_Dez
	
	loadn r1, #20
	cmp r0, r1
	jeq Horda_Vinte
	
	loadn r1, #30
	cmp r0, r1
	jeq Horda_Trinta
	
	jmp Reviver_Aliens_Fim
	
	Horda_Dez:
		loadn r0, #10
		store velAlien1, r0
		store velAlien4, r0
		
		loadn r0, #8
		store velAlien2, r0
		
		loadn r0, #6
		store velAlien3, r0
		
		jmp Reviver_Aliens_Fim
		
	Horda_Vinte:
		loadn r0, #6
		store addBullets, r0
		
		jmp Reviver_Aliens_Fim
		
	Horda_Trinta:
		loadn r0, #5
		store addBullets, r0
		
		jmp Reviver_Aliens_Fim
	
	Reviver_Aliens_Fim:
		pop r1
		pop r0
		rts


;---------------------------------- GAME-OVER -------------------------------
Game_Over:	
	push R0
	push R1
	push R2
	; Limpa a Tela !!
  	loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #0  			; cor branca!
	call ImprimeTela   		;  Rotina de Impresao de Cenario na Tela Inteira
  
	;imprime Voce perdeu !!!
	loadn r0, #893
	loadn r1, #Msn8
	loadn r2, #2304
	call ImprimeStr
	
	loadn r0, #973
	loadn r1, #Msn10
	loadn r2, #2304
	call ImprimeStr
	
	
	call Print_Kills
	
	
	loadn r0, #530
	loadn r1, #Msn7
	loadn r2, #2304
	call ImprimeStr
	
	;imprime quer jogar novamente
	loadn r0, #610
	loadn r1, #Msn1
	loadn r2, #2304
	call ImprimeStr

	Game_Over_Loop:	
		call DigLetra
		loadn r0, #'n'
		load r1, Letra
		cmp r0, r1				; tecla == 'n' ?
		jeq Game_Over_FimJogo	; tecla e' 'n'
		
		loadn r0, #'y'
		cmp r0, r1				; tecla == 's' ?
		jne Game_Over_Loop	; tecla nao e' 's'
	
	
	
	; Se quiser jogar novamente...
	call ApagaTela
	
	pop r2
	pop r1
	pop r0
	pop r0	; Da um Pop a mais para acertar o ponteiro da pilha, pois nao vai dar o RTS !!
	jmp main

 	Game_Over_FimJogo:
		jmp menu

;---------------------------------- IMPRIMIR KILLS ----------------------------------
Print_Kills:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	;383 -> para 999
	;384 -> para 9999

	load r0, Kills
	loadn r1, #10
	
	mod r2, r0, r1
	store auxKills, r2
	loadn r3, #903
	store auxDigito, r3
	call Print_Kills_Numeros		;printa a casa das unidades
	
	loadn r1, #10
	load r0, Kills
	div r2, r0, r1
	mod r2, r2, r1
	store auxKills, r2
	loadn r3, #902
	store auxDigito, r3
	call Print_Kills_Numeros		;printa a casa das dezenas
	
	loadn r1, #100
	load r0, Kills
	div r2, r0, r1
	mod r2, r2, r1
	store auxKills, r2
	loadn r3, #901
	store auxDigito, r3
	call Print_Kills_Numeros		;printa a casa das centenas
	
	loadn r1, #1000
	load r0, Kills
	div r2, r0, r1
	mod r2, r2, r1
	store auxKills, r2
	loadn r3, #900
	store auxDigito, r3
	call Print_Kills_Numeros		;printa a casa das centenas

	
	load r0, Horda
	loadn r1, #10
	
	mod r2, r0, r1
	store auxHorda, r2
	loadn r3, #983
	store auxDigitoHorda, r3
	call Print_Hordas_Numeros		;printa a casa das unidades
	
	loadn r1, #10
	load r0, Horda
	div r2, r0, r1
	mod r2, r2, r1
	store auxHorda, r2
	loadn r3, #982
	store auxDigitoHorda, r3
	call Print_Hordas_Numeros		;printa a casa das dezenas
	
	loadn r1, #100
	load r0, Horda
	div r2, r0, r1
	mod r2, r2, r1
	store auxHorda, r2
	loadn r3, #981
	store auxDigitoHorda, r3
	call Print_Hordas_Numeros		;printa a casa das centenas
	
	loadn r1, #1000
	load r0, Horda
	div r2, r0, r1
	mod r2, r2, r1
	store auxHorda, r2
	loadn r3, #980
	store auxDigitoHorda, r3
	call Print_Hordas_Numeros		;printa a casa das centenas


	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;----------------------------------
Print_Kills_Numeros:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	load r0, auxKills
	
	loadn r1, #0
	cmp r0, r1
	jeq Numero_Zero
	
	loadn r1, #1
	cmp r0, r1
	jeq Numero_Um
	
	loadn r1, #2
	cmp r0, r1
	jeq Numero_Dois
	
	loadn r1, #3
	cmp r0, r1
	jeq Numero_Tres
	
	loadn r1, #4
	cmp r0, r1
	jeq Numero_Quatro
	
	loadn r1, #5
	cmp r0, r1
	jeq Numero_Cinco
	
	loadn r1, #6
	cmp r0, r1
	jeq Numero_Seis
	
	loadn r1, #7
	cmp r0, r1
	jeq Numero_Sete
	
	loadn r1, #8
	cmp r0, r1
	jeq Numero_Oito
	
	loadn r1, #9
	cmp r0, r1
	jeq Numero_Nove
	
	
	Numero_Zero:
		load r2, auxDigito
		loadn r3, #48
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Kills_Numeros_Fim
	
	Numero_Um:
		load r2, auxDigito
		loadn r3, #49
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Kills_Numeros_Fim
		
	Numero_Dois:
		load r2, auxDigito
		loadn r3, #50
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Kills_Numeros_Fim
	
	Numero_Tres:
		load r2, auxDigito
		loadn r3, #51
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Kills_Numeros_Fim
		
	Numero_Quatro:
		load r2, auxDigito
		loadn r3, #52
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Kills_Numeros_Fim
	
	Numero_Cinco:
		load r2, auxDigito
		loadn r3, #53
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Kills_Numeros_Fim
	
	Numero_Seis:
		load r2, auxDigito
		loadn r3, #54
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Kills_Numeros_Fim
		
	Numero_Sete:
		load r2, auxDigito
		loadn r3, #55
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Kills_Numeros_Fim
		
	Numero_Oito:
		load r2, auxDigito
		loadn r3, #56
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Kills_Numeros_Fim
		
	Numero_Nove:
		load r2, auxDigito
		loadn r3, #57
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Kills_Numeros_Fim
	
	
	
	Print_Kills_Numeros_Fim:
		pop r7
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts
		
		
;---------------------------------- PRINT MUNIÇÕES ----------------------------
Print_Bullets:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	;383 -> para 999
	;384 -> para 9999

	load r0, Bullets
	loadn r1, #10
	
	mod r2, r0, r1
	store auxBullets, r2
	loadn r3, #1171
	store auxDigitoBullets, r3
	call Print_Bullets_Numeros		;printa a casa das unidades
	
	loadn r1, #10
	load r0, Bullets
	div r2, r0, r1
	mod r2, r2, r1
	store auxBullets, r2
	loadn r3, #1170
	store auxDigitoBullets, r3
	call Print_Bullets_Numeros		;printa a casa das dezenas
	
	loadn r1, #100
	load r0, Bullets
	div r2, r0, r1
	mod r2, r2, r1
	store auxBullets, r2
	loadn r3, #1169
	store auxDigitoBullets, r3
	call Print_Bullets_Numeros		;printa a casa das centenas
	

	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;----------------------------------
Print_Bullets_Numeros:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	load r0, auxBullets
	
	loadn r1, #0
	cmp r0, r1
	jeq Numero_Zero2
	
	loadn r1, #1
	cmp r0, r1
	jeq Numero_Um2
	
	loadn r1, #2
	cmp r0, r1
	jeq Numero_Dois2
	
	loadn r1, #3
	cmp r0, r1
	jeq Numero_Tres2
	
	loadn r1, #4
	cmp r0, r1
	jeq Numero_Quatro2
	
	loadn r1, #5
	cmp r0, r1
	jeq Numero_Cinco2
	
	loadn r1, #6
	cmp r0, r1
	jeq Numero_Seis2
	
	loadn r1, #7
	cmp r0, r1
	jeq Numero_Sete2
	
	loadn r1, #8
	cmp r0, r1
	jeq Numero_Oito2
	
	loadn r1, #9
	cmp r0, r1
	jeq Numero_Nove2
	
	
	Numero_Zero2:
		load r2, auxDigitoBullets
		loadn r3, #48
		loadn r4, #3072
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Bullets_Numeros_Fim
	
	Numero_Um2:
		load r2, auxDigitoBullets
		loadn r3, #49
		loadn r4, #3072
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Bullets_Numeros_Fim
		
	Numero_Dois2:
		load r2, auxDigitoBullets
		loadn r3, #50
		loadn r4, #3072
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Bullets_Numeros_Fim
	
	Numero_Tres2:
		load r2, auxDigitoBullets
		loadn r3, #51
		loadn r4, #3072
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Bullets_Numeros_Fim
		
	Numero_Quatro2:
		load r2, auxDigitoBullets
		loadn r3, #52
		loadn r4, #3072
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Bullets_Numeros_Fim
	
	Numero_Cinco2:
		load r2, auxDigitoBullets
		loadn r3, #53
		loadn r4, #3072
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Bullets_Numeros_Fim
	
	Numero_Seis2:
		load r2, auxDigitoBullets
		loadn r3, #54
		loadn r4, #3072
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Bullets_Numeros_Fim
		
	Numero_Sete2:
		load r2, auxDigitoBullets
		loadn r3, #55
		loadn r4, #3072
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Bullets_Numeros_Fim
		
	Numero_Oito2:
		load r2, auxDigitoBullets
		loadn r3, #56
		loadn r4, #3072
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Bullets_Numeros_Fim
		
	Numero_Nove2:
		load r2, auxDigitoBullets
		loadn r3, #57
		loadn r4, #3072
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Bullets_Numeros_Fim
	
	
	
	Print_Bullets_Numeros_Fim:
		pop r7
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts


;---------------------------------- PRINT HORDAS ----------------------------
Print_Hordas:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	;383 -> para 999
	;384 -> para 9999

	load r0, Horda
	loadn r1, #10
	
	mod r2, r0, r1
	store auxHorda, r2
	loadn r3, #1199
	store auxDigitoHorda, r3
	call Print_Hordas_Numeros		;printa a casa das unidades
	
	loadn r1, #10
	load r0, Horda
	div r2, r0, r1
	mod r2, r2, r1
	store auxHorda, r2
	loadn r3, #1198
	store auxDigitoHorda, r3
	call Print_Hordas_Numeros		;printa a casa das dezenas
	
	loadn r1, #100
	load r0, Horda
	div r2, r0, r1
	mod r2, r2, r1
	store auxHorda, r2
	loadn r3, #1197
	store auxDigitoHorda, r3
	call Print_Hordas_Numeros		;printa a casa das centenas
	
	loadn r1, #1000
	load r0, Horda
	div r2, r0, r1
	mod r2, r2, r1
	store auxHorda, r2
	loadn r3, #1196
	store auxDigitoHorda, r3
	call Print_Hordas_Numeros		;printa a casa das centenas
	

	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;----------------------------------
Print_Hordas_Numeros:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	load r0, auxHorda
	
	loadn r1, #0
	cmp r0, r1
	jeq Numero_Zero3
	
	loadn r1, #1
	cmp r0, r1
	jeq Numero_Um3
	
	loadn r1, #2
	cmp r0, r1
	jeq Numero_Dois3
	
	loadn r1, #3
	cmp r0, r1
	jeq Numero_Tres3
	
	loadn r1, #4
	cmp r0, r1
	jeq Numero_Quatro3
	
	loadn r1, #5
	cmp r0, r1
	jeq Numero_Cinco3
	
	loadn r1, #6
	cmp r0, r1
	jeq Numero_Seis3
	
	loadn r1, #7
	cmp r0, r1
	jeq Numero_Sete3
	
	loadn r1, #8
	cmp r0, r1
	jeq Numero_Oito3
	
	loadn r1, #9
	cmp r0, r1
	jeq Numero_Nove3
	
	
	Numero_Zero3:
		load r2, auxDigitoHorda
		loadn r3, #48
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Hordas_Numeros_Fim
	
	Numero_Um3:
		load r2, auxDigitoHorda
		loadn r3, #49
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Hordas_Numeros_Fim
		
	Numero_Dois3:
		load r2, auxDigitoHorda
		loadn r3, #50
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Hordas_Numeros_Fim
	
	Numero_Tres3:
		load r2, auxDigitoHorda
		loadn r3, #51
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Hordas_Numeros_Fim
		
	Numero_Quatro3:
		load r2, auxDigitoHorda
		loadn r3, #52
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Hordas_Numeros_Fim
	
	Numero_Cinco3:
		load r2, auxDigitoHorda
		loadn r3, #53
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Hordas_Numeros_Fim
	
	Numero_Seis3:
		load r2, auxDigitoHorda
		loadn r3, #54
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Hordas_Numeros_Fim
		
	Numero_Sete3:
		load r2, auxDigitoHorda
		loadn r3, #55
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Hordas_Numeros_Fim
		
	Numero_Oito3:
		load r2, auxDigitoHorda
		loadn r3, #56
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Hordas_Numeros_Fim
		
	Numero_Nove3:
		load r2, auxDigitoHorda
		loadn r3, #57
		loadn r4, #2304
		add r3, r3, r4
		outchar r3, r2
		jmp Print_Hordas_Numeros_Fim
	
	
	
	Print_Hordas_Numeros_Fim:
		pop r7
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts
	
	
;----------------------------------
;----------------------------------
;--------------------------

MoveTiro:
	push r0
	push r1
	push r2
	push r3
	
	call MoveTiro_RecalculaPos

; So' Apaga e Redezenha se (pos != posAnt)
;	If (pos != posAnt)	{	
	load r0, posTiro
	load r1, posAntTiro
	cmp r0, r1
	jeq MoveTiro_Skip
	call MoveTiro_Apaga
	call MoveTiro_Desenha
	
	load r1, posAlien1
	cmp r0, r1
	jeq Tiro1_Alien1
	
	load r1, posAlien2
	cmp r0, r1
	jeq Tiro1_Alien2
	
	load r1, posAlien3
	cmp r0, r1
	jeq Tiro1_Alien3
	
	load r1, posAlien4
	cmp r0, r1
	jeq Tiro1_Alien4
	
	jmp MoveTiro_Skip
	
	Tiro1_Alien1:
		loadn r1, #1
		store Alien1Dead, r1
		loadn r0, #0
		store FlagTiro, r0
		store posAlien1, r0
		
		load r2, Kills
		inc r2
		store Kills, r2
		
		load r3, Cont_Deaths
		inc r3
		store Cont_Deaths, r3
		
		call MoveTiro_Apaga
		jmp MoveTiro_Skip
	
	Tiro1_Alien2:
		loadn r1, #1
		store Alien2Dead, r1
		loadn r0, #0
		store FlagTiro, r0
		store posAlien2, r0
		
		load r2, Kills
		inc r2
		store Kills, r2
		
		load r3, Cont_Deaths
		inc r3
		store Cont_Deaths, r3
		
		call MoveTiro_Apaga
		jmp MoveTiro_Skip
		
	Tiro1_Alien3:
		loadn r1, #1
		store Alien3Dead, r1
		loadn r0, #0
		store FlagTiro, r0
		store posAlien3, r0
		
		load r2, Kills
		inc r2
		store Kills, r2
		
		load r3, Cont_Deaths
		inc r3
		store Cont_Deaths, r3
		
		call MoveTiro_Apaga
		
		jmp MoveTiro_Skip
	
	Tiro1_Alien4:
		loadn r1, #1
		store Alien4Dead, r1
		loadn r0, #0
		store FlagTiro, r0
		store posAlien4, r0
		
		load r2, Kills
		inc r2
		store Kills, r2
		
		load r3, Cont_Deaths
		inc r3
		store Cont_Deaths, r3
		
		call MoveTiro_Apaga
		jmp MoveTiro_Skip
	
  MoveTiro_Skip:
	
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;---------------------
MoveTiro_Dois:
	push r0
	push r1
	push r2
	push r3
	
	call MoveTiro_RecalculaPos_Dois

; So' Apaga e Redezenha se (pos != posAnt)
;	If (pos != posAnt)	{	
	load r0, posTiro2
	load r1, posAntTiro2
	cmp r0, r1
	jeq MoveTiro_Skip_Dois
	call MoveTiro_Apaga_Dois
	call MoveTiro_Desenha_Dois		;}
	
	load r1, posAlien1
	cmp r0, r1
	jeq Tiro2_Alien1
	
	load r1, posAlien2
	cmp r0, r1
	jeq Tiro2_Alien2
	
	load r1, posAlien3
	cmp r0, r1
	jeq Tiro2_Alien3
	
	load r1, posAlien4
	cmp r0, r1
	jeq Tiro2_Alien4
	
	jmp MoveTiro_Skip_Dois
	
	Tiro2_Alien1:
		loadn r1, #1
		store Alien1Dead, r1
		loadn r0, #0
		store FlagTiro2, r0
		store posAlien1, r0
		
		load r2, Kills
		inc r2
		store Kills, r2
		
		load r3, Cont_Deaths
		inc r3
		store Cont_Deaths, r3
		
		call MoveTiro_Apaga_Dois
		jmp MoveTiro_Skip_Dois
	
	Tiro2_Alien2:
		loadn r1, #1
		store Alien2Dead, r1
		loadn r0, #0
		store FlagTiro2, r0
		store posAlien2, r0
		
		load r2, Kills
		inc r2
		store Kills, r2
		
		load r3, Cont_Deaths
		inc r3
		store Cont_Deaths, r3
		
		call MoveTiro_Apaga_Dois
		jmp MoveTiro_Skip_Dois
		
	Tiro2_Alien3:
		loadn r1, #1
		store Alien3Dead, r1
		loadn r0, #0
		store FlagTiro2, r0
		store posAlien3, r0
		
		load r2, Kills
		inc r2
		store Kills, r2
		
		load r3, Cont_Deaths
		inc r3
		store Cont_Deaths, r3
		
		call MoveTiro_Apaga_Dois
		jmp MoveTiro_Skip_Dois
	
	Tiro2_Alien4:
		loadn r1, #1
		store Alien4Dead, r1
		loadn r0, #0
		store FlagTiro2, r0
		store posAlien4, r0
		
		load r2, Kills
		inc r2
		store Kills, r2
		
		load r3, Cont_Deaths
		inc r3
		store Cont_Deaths, r3
		
		call MoveTiro_Apaga_Dois
		jmp MoveTiro_Skip_Dois
		
		
  MoveTiro_Skip_Dois:
	
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;--------------------
MoveTiro_Tres:
	push r0
	push r1
	push r2
	push r3
	
	call MoveTiro_RecalculaPos_Tres

; So' Apaga e Redezenha se (pos != posAnt)
;	If (pos != posAnt)	{	
	load r0, posTiro3
	load r1, posAntTiro3
	cmp r0, r1
	jeq MoveTiro_Skip_Tres
	call MoveTiro_Apaga_Tres
	call MoveTiro_Desenha_Tres		;}
	
	load r1, posAlien1
	cmp r0, r1
	jeq Tiro3_Alien1
	
	load r1, posAlien2
	cmp r0, r1
	jeq Tiro3_Alien2
	
	load r1, posAlien3
	cmp r0, r1
	jeq Tiro3_Alien3
	
	load r1, posAlien4
	cmp r0, r1
	jeq Tiro3_Alien4
	
	jmp MoveTiro_Skip_Tres
	
	Tiro3_Alien1:
		loadn r1, #1
		store Alien1Dead, r1
		loadn r0, #0
		store FlagTiro3, r0
		store posAlien1, r0
		
		load r2, Kills
		inc r2
		store Kills, r2
		
		load r3, Cont_Deaths
		inc r3
		store Cont_Deaths, r3
		
		call MoveTiro_Apaga_Tres
		jmp MoveTiro_Skip_Tres
	
	Tiro3_Alien2:
		loadn r1, #1
		store Alien2Dead, r1
		loadn r0, #0
		store FlagTiro3, r0
		store posAlien2, r0
		
		load r2, Kills
		inc r2
		store Kills, r2
		
		load r3, Cont_Deaths
		inc r3
		store Cont_Deaths, r3
		
		call MoveTiro_Apaga_Tres
		jmp MoveTiro_Skip_Tres
		
	Tiro3_Alien3:
		loadn r1, #1
		store Alien3Dead, r1
		loadn r0, #0
		store FlagTiro3, r0
		store posAlien3, r0
		
		load r2, Kills
		inc r2
		store Kills, r2
		
		load r3, Cont_Deaths
		inc r3
		store Cont_Deaths, r3
		
		call MoveTiro_Apaga_Tres
		jmp MoveTiro_Skip_Tres
	
	Tiro3_Alien4:
		loadn r1, #1
		store Alien4Dead, r1
		loadn r0, #0
		store FlagTiro3, r0
		store posAlien4, r0
		
		load r2, Kills
		inc r2
		store Kills, r2
		
		load r3, Cont_Deaths
		inc r3
		store Cont_Deaths, r3
		
		call MoveTiro_Apaga_Tres
		jmp MoveTiro_Skip_Tres
	
  MoveTiro_Skip_Tres:
	
	
	pop r3
	pop r2
	pop r1
	pop r0
	rts



;---------------------
MoveTiro_Multi:
	push r0
	push r1
	
	call MoveTiro_RecalculaPos_Multi

; So' Apaga e Redezenha se (pos != posAnt)
;	If (pos != posAnt)	{	
	load r0, posTiro
	load r1, posAntTiro
	cmp r0, r1
	jeq MoveTiro_Multi_Skip
	
	call MoveTiro_Apaga
	call MoveTiro_Desenha	
		
	MoveTiro_Multi_Skip:
		pop r1
		pop r0
		rts

;--------------------------------

MoveTiro2:
	push r0
	push r1
	
	call MoveTiro2_RecalculaPos

; So' Apaga e Redezenha se (pos != posAnt)
;	If (pos != posAnt)	{	
	load r0, posTiro2
	load r1, posAntTiro2
	cmp r0, r1
	jeq MoveTiro2_Skip
		call MoveTiro2_Apaga
		call MoveTiro2_Desenha		;}
  MoveTiro2_Skip:
	
	pop r1
	pop r0
	rts

;-----------------------------
	
MoveTiro_Apaga:
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5
	push R6

	; Compara Se (posAntTiro == posAntNave)
	load R0, posAntTiro	; R0 = posAnt
	load R1, posAntNave	; R1 = posAnt
	loadn R6, #2048
	cmp r0, r1
	jne MoveTiro_Apaga_Skip1
	
	load r2, dirNave
	loadn r3, #0
	cmp r2, r3
	jeq ApagaNave_0
	
	loadn r3, #1
	cmp r2, r3
	jeq ApagaNave_1
	
	loadn r3, #2
	cmp r2, r3
	jeq ApagaNave_2
	
	loadn r3, #3
	cmp r2, r3
	jeq ApagaNave_3
	
	ApagaNave_0:
		loadn r5, #8		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		add r5, r5, r6
		jmp MoveTiro_Apaga_Fim
		
	ApagaNave_1:
		loadn r5, #10		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		add r5, r5, r6
		jmp MoveTiro_Apaga_Fim
		
	ApagaNave_2:
		loadn r5, #12		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		add r5, r5, r6
		jmp MoveTiro_Apaga_Fim
		
	ApagaNave_3:
		loadn r5, #11		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		add r5, r5, r6
		jmp MoveTiro_Apaga_Fim
		
  MoveTiro_Apaga_Skip1:	
	; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
	loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
	loadn R4, #40
	div R3, R0, R4	; R3 = posAnt/40
	add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
	
	loadi R5, R2	; R5 = Char (Tela(posAnt))

  MoveTiro_Apaga_Fim:	
	outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
	
	pop R6
	pop R5
	pop R4
	pop R3
	pop R2
	pop R1
	pop R0
	rts

;---------------------------------
MoveTiro_Apaga_Dois:
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5
	push R6

	; Compara Se (posAntTiro == posAntNave)
	load R0, posAntTiro2	; R0 = posAnt
	load R1, posAntNave	; R1 = posAnt
	loadn R6, #2048
	cmp r0, r1
	jne MoveTiro_Apaga_Skip1_Dois
	
	load r2, dirNave
	loadn r3, #0
	cmp r2, r3
	jeq ApagaNave2_0
	
	loadn r3, #1
	cmp r2, r3
	jeq ApagaNave2_1
	
	loadn r3, #2
	cmp r2, r3
	jeq ApagaNave2_2
	
	loadn r3, #3
	cmp r2, r3
	jeq ApagaNave2_3
	
	ApagaNave2_0:
		loadn r5, #8		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		add r5, r5, r6
		jmp MoveTiro_Apaga_Fim_Dois
		
	ApagaNave2_1:
		loadn r5, #10		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		add r5, r5, r6
		jmp MoveTiro_Apaga_Fim_Dois
		
	ApagaNave2_2:
		loadn r5, #12		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		add r5, r5, r6
		jmp MoveTiro_Apaga_Fim_Dois
		
	ApagaNave2_3:
		loadn r5, #11		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		add r5, r5, r6
		jmp MoveTiro_Apaga_Fim_Dois
		
  MoveTiro_Apaga_Skip1_Dois:	
	; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
	loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
	loadn R4, #40
	div R3, R0, R4	; R3 = posAnt/40
	add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
	
	loadi R5, R2	; R5 = Char (Tela(posAnt))

  MoveTiro_Apaga_Fim_Dois:	
	outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
	
	pop R6
	pop R5
	pop R4
	pop R3
	pop R2
	pop R1
	pop R0
	rts

;----------------------------------
MoveTiro_Apaga_Tres:
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5
	push R6

	; Compara Se (posAntTiro == posAntNave)
	load R0, posAntTiro3	; R0 = posAnt
	load R1, posAntNave	; R1 = posAnt
	loadn R6, #2048
	cmp r0, r1
	jne MoveTiro_Apaga_Skip1_Tres
	load r2, dirNave
	loadn r3, #0
	cmp r2, r3
	jeq ApagaNave3_0
	
	loadn r3, #1
	cmp r2, r3
	jeq ApagaNave3_1
	
	loadn r3, #2
	cmp r2, r3
	jeq ApagaNave3_2
	
	loadn r3, #3
	cmp r2, r3
	jeq ApagaNave3_3
	
	ApagaNave3_0:
		loadn r5, #8		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		add r5, r5, r6
		jmp MoveTiro_Apaga_Fim_Tres
		
	ApagaNave3_1:
		loadn r5, #10		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		add r5, r5, r6
		jmp MoveTiro_Apaga_Fim_Tres
		
	ApagaNave3_2:
		loadn r5, #12		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		add r5, r5, r6
		jmp MoveTiro_Apaga_Fim_Tres
		
	ApagaNave3_3:
		loadn r5, #11		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		add r5, r5, r6
		jmp MoveTiro_Apaga_Fim_Tres
		
  MoveTiro_Apaga_Skip1_Tres:	
	; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
	loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
	loadn R4, #40
	div R3, R0, R4	; R3 = posAnt/40
	add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
	
	loadi R5, R2	; R5 = Char (Tela(posAnt))

  MoveTiro_Apaga_Fim_Tres:	
	outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
	
	pop R6
	pop R5
	pop R4
	pop R3
	pop R2
	pop R1
	pop R0
	rts

;----------------------------------	

MoveTiro2_Apaga:
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5
	push R6

	; Compara Se (posAntTiro == posAntNave)
	load R0, posAntTiro2	; R0 = posAnt
	load R1, posAntNave2	; R1 = posAnt
	loadn R6, #512
	cmp r0, r1
	jne MoveTiro2_Apaga_Skip1
		loadn r5, #9		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		add r5, r5, r6
		jmp MoveTiro2_Apaga_Fim
		
  MoveTiro2_Apaga_Skip1:	
	; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
	loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
	loadn R4, #40
	div R3, R0, R4	; R3 = posAnt/40
	add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
	
	loadi R5, R2	; R5 = Char (Tela(posAnt))

  MoveTiro2_Apaga_Fim:	
	outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
	
	pop R6
	pop R5
	pop R4
	pop R3
	pop R2
	pop R1
	pop R0
	rts
;----------------------------------
	
; if TiroFlag = 1
;	posTiro++
;	
	
MoveTiro_RecalculaPos:
	push R0
	push R1
	push R2
	push R3
	push R4
	
	load R1, FlagTiro	; Se Atirou, movimenta o tiro!
	loadn R2, #1
	cmp R1, R2			; If FlagTiro == 1  Movimenta o Tiro
	jne MoveTiro_RecalculaPos_Fim2	; Se nao vai embora!
	
	load R0, posTiro	; TEsta se o Tiro Pegou no Alien
	load R1, posAlien
	cmp R0, R1			; IF posTiro == posAlien  BOOM!!
	jeq MoveTiro_RecalculaPos_Boom
	
	
	load r2, dirTiro_Recalculapos
	loadn r3, #0
	cmp r2, r3
	jeq PararTiro_Zero
	
	loadn r3, #1
	cmp r2, r3
	jeq PararTiro_Um
	
	loadn r3, #2
	cmp r2, r3
	jeq PararTiro_Dois
	
	loadn r3, #3
	cmp r2, r3
	jeq PararTiro_Tres
	
	
	PararTiro_Zero:
		loadn R1, #40		; Testa condicoes de Contorno 
		mod R1, R0, R1		
		cmp R1, R0		; Se tiro chegou na ultima linha
		jne MoveTiro_RecalculaPos_Fim
		jmp PararTiro_Fim
	PararTiro_Um:
		loadn R1, #40		; Testa condicoes de Contorno 
		loadn r2, #39
		mod R1, R0, R1		
		cmp R1, R2			; Se tiro chegou na ultima linha
		jne MoveTiro_RecalculaPos_Fim
		jmp PararTiro_Fim
	PararTiro_Dois:
		loadn R1, #1160		; Testa condicoes de Contorno 
		mod R1, R0, R1
		loadn R4, #1160
		add R1, R1, R4		
		cmp R1, R0			; Se tiro chegou na ultima linha
		jne MoveTiro_RecalculaPos_Fim
		jmp PararTiro_Fim
	PararTiro_Tres:
		loadn r1, #40
		loadn r2, #0
		mod r1, r0, r1
		cmp r1, r2
		jne MoveTiro_RecalculaPos_Fim
		jmp PararTiro_Fim
	
	PararTiro_Fim:
	
	
	
	call MoveTiro_Apaga
	loadn R0, #0
	store FlagTiro, R0	; Zera FlagTiro
	store posTiro, R0	; Zera e iguala posTiro e posAntTiro
	store posAntTiro, R0
	jmp MoveTiro_RecalculaPos_Fim2	
	
  MoveTiro_RecalculaPos_Fim:
	;inc R0
	loadn R1, #40
	load r2, dirTiro_Recalculapos    ;criar um dirTiro!!!
	loadn r3, #0
	cmp r2, r3
	jeq MoverTiro_Zero
	
	loadn r3, #1
	cmp r2, r3
	jeq MoverTiro_Um
	
	loadn r3, #2
	cmp r2, r3
	jeq MoverTiro_Dois
	
	loadn r3, #3
	cmp r2, r3
	jeq MoverTiro_Tres
	
	
	MoverTiro_Zero:
		sub R0, R0, R1
		store posTiro, R0
		jmp MoveTiro_RecalculaPos_Fim2
	MoverTiro_Um:
		inc r0
		store posTiro, R0
		jmp MoveTiro_RecalculaPos_Fim2
	MoverTiro_Dois:
		add r0, r0, r1
		store posTiro, R0
		jmp MoveTiro_RecalculaPos_Fim2
	MoverTiro_Tres:
		dec r0
		store posTiro, R0
		jmp MoveTiro_RecalculaPos_Fim2
		
	
	
  MoveTiro_RecalculaPos_Fim2:	
    pop R4
    pop R3
	  pop R2
	  pop R1
	  pop R0
	  rts

  MoveTiro_RecalculaPos_Boom:	
	; Limpa a Tela !!
  	loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #0  			; cor branca!
	call ImprimeTela   		;  Rotina de Impresao de Cenario na Tela Inteira
  
	;imprime Voce Venceu !!!
	
	
	;imprime quer jogar novamente
	loadn r0, #610
	loadn r1, #Msn1
	loadn r2, #2048
	call ImprimeStr

	MoveTiro_RecalculaPos_Boom_Loop:	
	call DigLetra
	loadn r0, #'n'
	load r1, Letra
	cmp r0, r1				; tecla == 'n' ?
	jeq MoveTiro_RecalculaPos_Boom_FimJogo	; tecla e' 'n'
	
	loadn r0, #'s'
	cmp r0, r1				; tecla == 's' ?
	jne MoveTiro_RecalculaPos_Boom_Loop	; tecla nao e' 's'
	
	
	
	; Se quiser jogar novamente...
	call ApagaTela
	
	pop r2
	pop r1
	pop r0

	pop r0	; Da um Pop a mais para acertar o ponteiro da pilha, pois nao vai dar o RTS !!
	jmp main

 MoveTiro_RecalculaPos_Boom_FimJogo:
 	jmp menu
	;call ApagaTela
	;halt
;--------------------------------------------

MoveTiro_RecalculaPos_Dois:
	push R0
	push R1
	push R2
	push R3
	push R4
	
	load R1, FlagTiro2	; Se Atirou, movimenta o tiro!
	loadn R2, #1
	cmp R1, R2			; If FlagTiro == 1  Movimenta o Tiro
	jne MoveTiro_RecalculaPos_Fim2_Dois	; Se nao vai embora!
	
	load R0, posTiro2	; TEsta se o Tiro Pegou no Alien
	load R1, posAlien
	cmp R0, R1			; IF posTiro == posAlien  BOOM!!
	jeq MoveTiro_RecalculaPos_Boom_Dois
	
	
	load r2, dirTiro2_Recalculapos
	loadn r3, #0
	cmp r2, r3
	jeq PararTiro_Zero_2
	
	loadn r3, #1
	cmp r2, r3
	jeq PararTiro_Um_2
	
	loadn r3, #2
	cmp r2, r3
	jeq PararTiro_Dois_2
	
	loadn r3, #3
	cmp r2, r3
	jeq PararTiro_Tres_2
	
	
	PararTiro_Zero_2:
		loadn R1, #40		; Testa condicoes de Contorno 
		mod R1, R0, R1		
		cmp R1, R0		; Se tiro chegou na ultima linha
		jne MoveTiro_RecalculaPos_Fim_Dois
		jmp PararTiro_Fim_2
	PararTiro_Um_2:
		loadn R1, #40		; Testa condicoes de Contorno 
		loadn r2, #39
		mod R1, R0, R1		
		cmp R1, R2			; Se tiro chegou na ultima linha
		jne MoveTiro_RecalculaPos_Fim_Dois
		jmp PararTiro_Fim_2
	PararTiro_Dois_2:
		loadn R1, #1160		; Testa condicoes de Contorno 
		mod R1, R0, R1
		loadn R4, #1160
		add R1, R1, R4		
		cmp R1, R0			; Se tiro chegou na ultima linha
		jne MoveTiro_RecalculaPos_Fim_Dois
		jmp PararTiro_Fim_2
	PararTiro_Tres_2:
		loadn r1, #40
		loadn r2, #0
		mod r1, r0, r1
		cmp r1, r2
		jne MoveTiro_RecalculaPos_Fim_Dois
		jmp PararTiro_Fim_2
	
	PararTiro_Fim_2:
	
	
	
	call MoveTiro_Apaga_Dois
	loadn R0, #0
	store FlagTiro2, R0	; Zera FlagTiro
	store posTiro2, R0	; Zera e iguala posTiro e posAntTiro
	store posAntTiro2, R0
	jmp MoveTiro_RecalculaPos_Fim2_Dois	
	
  MoveTiro_RecalculaPos_Fim_Dois:
	;inc R0
	loadn R1, #40
	load r2, dirTiro2_Recalculapos    ;criar um dirTiro!!!
	loadn r3, #0
	cmp r2, r3
	jeq MoverTiro_Zero_2
	
	loadn r3, #1
	cmp r2, r3
	jeq MoverTiro_Um_2
	
	loadn r3, #2
	cmp r2, r3
	jeq MoverTiro_Dois_2
	
	loadn r3, #3
	cmp r2, r3
	jeq MoverTiro_Tres_2
	
	
	MoverTiro_Zero_2:
		sub R0, R0, R1
		store posTiro2, R0
		jmp MoveTiro_RecalculaPos_Fim2_Dois
	MoverTiro_Um_2:
		inc r0
		store posTiro2, R0
		jmp MoveTiro_RecalculaPos_Fim2_Dois
	MoverTiro_Dois_2:
		add r0, r0, r1
		store posTiro2, R0
		jmp MoveTiro_RecalculaPos_Fim2_Dois
	MoverTiro_Tres_2:
		dec r0
		store posTiro2, R0
		jmp MoveTiro_RecalculaPos_Fim2_Dois
		
	
	
  MoveTiro_RecalculaPos_Fim2_Dois:	
    pop R4
    pop R3
	  pop R2
	  pop R1
	  pop R0
	  rts

  MoveTiro_RecalculaPos_Boom_Dois:	
	; Limpa a Tela !!
  	loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #0  			; cor branca!
	call ImprimeTela   		;  Rotina de Impresao de Cenario na Tela Inteira
  
	
	
	;imprime quer jogar novamente
	loadn r0, #610
	loadn r1, #Msn1
	loadn r2, #2048
	call ImprimeStr

	MoveTiro_RecalculaPos_Boom_Loop_Dois:	
	call DigLetra
	loadn r0, #'n'
	load r1, Letra
	cmp r0, r1				; tecla == 'n' ?
	jeq MoveTiro_RecalculaPos_Boom_FimJogo_Dois	; tecla e' 'n'
	
	loadn r0, #'s'
	cmp r0, r1				; tecla == 's' ?
	jne MoveTiro_RecalculaPos_Boom_Loop_Dois	; tecla nao e' 's'
	
	
	
	; Se quiser jogar novamente...
	call ApagaTela
	
	pop r2
	pop r1
	pop r0

	pop r0	; Da um Pop a mais para acertar o ponteiro da pilha, pois nao vai dar o RTS !!
	jmp main

 MoveTiro_RecalculaPos_Boom_FimJogo_Dois:
 	jmp menu
	;call ApagaTela
	;halt

;-------------------------------------------------

MoveTiro_RecalculaPos_Tres:
	push R0
	push R1
	push R2
	push R3
	push R4
	
	load R1, FlagTiro3	; Se Atirou, movimenta o tiro!
	loadn R2, #1
	cmp R1, R2			; If FlagTiro == 1  Movimenta o Tiro
	jne MoveTiro_RecalculaPos_Fim2_Tres	; Se nao vai embora!
	
	load R0, posTiro3	; TEsta se o Tiro Pegou no Alien
	load R1, posAlien
	cmp R0, R1			; IF posTiro == posAlien  BOOM!!
	jeq MoveTiro_RecalculaPos_Boom_Tres
	
	
	load r2, dirTiro3_Recalculapos
	loadn r3, #0
	cmp r2, r3
	jeq PararTiro_Zero_3
	
	loadn r3, #1
	cmp r2, r3
	jeq PararTiro_Um_3
	
	loadn r3, #2
	cmp r2, r3
	jeq PararTiro_Dois_3

	loadn r3, #3
	cmp r2, r3
	jeq PararTiro_Tres_3
	
	
	PararTiro_Zero_3:
		loadn R1, #40		; Testa condicoes de Contorno 
		mod R1, R0, R1		
		cmp R1, R0		; Se tiro chegou na ultima linha
		jne MoveTiro_RecalculaPos_Fim_Tres
		jmp PararTiro_Fim_3
	PararTiro_Um_3:
		loadn R1, #40		; Testa condicoes de Contorno 
		loadn r2, #39
		mod R1, R0, R1		
		cmp R1, R2			; Se tiro chegou na ultima linha
		jne MoveTiro_RecalculaPos_Fim_Tres
		jmp PararTiro_Fim_3
	PararTiro_Dois_3:
		loadn R1, #1160		; Testa condicoes de Contorno 
		mod R1, R0, R1
		loadn R4, #1160
		add R1, R1, R4		
		cmp R1, R0			; Se tiro chegou na ultima linha
		jne MoveTiro_RecalculaPos_Fim_Tres
		jmp PararTiro_Fim_3
	PararTiro_Tres_3:
		loadn r1, #40
		loadn r2, #0
		mod r1, r0, r1
		cmp r1, r2
		jne MoveTiro_RecalculaPos_Fim_Tres
		jmp PararTiro_Fim_3
	
	PararTiro_Fim_3:
	
	
	
	call MoveTiro_Apaga_Tres
	loadn R0, #0
	store FlagTiro3, R0	; Zera FlagTiro
	store posTiro3, R0	; Zera e iguala posTiro e posAntTiro
	store posAntTiro3, R0
	jmp MoveTiro_RecalculaPos_Fim2_Tres	
	
  MoveTiro_RecalculaPos_Fim_Tres:
	;inc R0
	loadn R1, #40
	load r2, dirTiro3_Recalculapos    ;criar um dirTiro!!!
	loadn r3, #0
	cmp r2, r3
	jeq MoverTiro_Zero_3
	
	loadn r3, #1
	cmp r2, r3
	jeq MoverTiro_Um_3
	
	loadn r3, #2
	cmp r2, r3
	jeq MoverTiro_Dois_3
	
	loadn r3, #3
	cmp r2, r3
	jeq MoverTiro_Tres_3
	
	
	MoverTiro_Zero_3:
		sub R0, R0, R1
		store posTiro3, R0
		jmp MoveTiro_RecalculaPos_Fim2_Tres
	MoverTiro_Um_3:
		inc r0
		store posTiro3, R0
		jmp MoveTiro_RecalculaPos_Fim2_Tres
	MoverTiro_Dois_3:
		add r0, r0, r1
		store posTiro3, R0
		jmp MoveTiro_RecalculaPos_Fim2_Tres
	MoverTiro_Tres_3:
		dec r0
		store posTiro3, R0
		jmp MoveTiro_RecalculaPos_Fim2_Tres
		
	
	
  	MoveTiro_RecalculaPos_Fim2_Tres:	
    	pop R4
    	pop R3
	  	pop R2
	  	pop R1
	  	pop R0
	  	rts

  MoveTiro_RecalculaPos_Boom_Tres:	
	; Limpa a Tela !!
  	loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #0  			; cor branca!
	call ImprimeTela   		;  Rotina de Impresao de Cenario na Tela Inteira
  
	;imprime Voce Venceu !!!
	
	
	;imprime quer jogar novamente
	loadn r0, #610
	loadn r1, #Msn1
	loadn r2, #2048
	call ImprimeStr

	MoveTiro_RecalculaPos_Boom_Loop_Tres:	
	call DigLetra
	loadn r0, #'n'
	load r1, Letra
	cmp r0, r1				; tecla == 'n' ?
	jeq MoveTiro_RecalculaPos_Boom_FimJogo_Tres	; tecla e' 'n'
	
	loadn r0, #'s'
	cmp r0, r1				; tecla == 's' ?
	jne MoveTiro_RecalculaPos_Boom_Loop_Tres	; tecla nao e' 's'
	
	
	
	; Se quiser jogar novamente...
	call ApagaTela
	
	pop r2
	pop r1
	pop r0

	pop r0	; Da um Pop a mais para acertar o ponteiro da pilha, pois nao vai dar o RTS !!
	jmp main

 MoveTiro_RecalculaPos_Boom_FimJogo_Tres:
 	jmp menu
	;call ApagaTela
	;halt



;-------------------------------
MoveTiro_RecalculaPos_Multi:
	push R0
	push R1
	push R2
	push R3
	
	
	load R1, FlagTiro	; Se Atirou, movimenta o tiro!
	loadn R2, #1
	cmp R1, R2			; If FlagTiro == 1  Movimenta o Tiro
	jne MoveTiro_RecalculaPos_Fim2_Multi	; Se nao vai embora!
	
	load R0, posTiro	; TEsta se o Tiro Pegou no Alien
	load R1, posAntNave2
	cmp R0, R1			; IF posTiro == posAlien  BOOM!!
	jeq MoveTiro_RecalculaPos_Boom_Multi
	
	loadn R1, #40		; Testa condicoes de Contorno 
	load R2, posTiro
	
	mod R1, R0, R1    ;R1 = R0 % 40
	cmp R1, R2			; Se tiro chegou na ultima linha
	jne MoveTiro_RecalculaPos_Fim_Multi
	call MoveTiro_Apaga
	loadn R0, #0
	store FlagTiro, R0	; Zera FlagTiro
	store posTiro, R0	; Zera e iguala posTiro e posAntTiro
	store posAntTiro, R0
	jmp MoveTiro_RecalculaPos_Fim2_Multi	
	
  MoveTiro_RecalculaPos_Fim_Multi:
	;inc R0
	
	loadn R3, #40
	sub R0, R0, R3
	;add R0, R3, R0
	
	store posTiro, R0
	
  MoveTiro_RecalculaPos_Fim2_Multi:	
  	
  	pop R3
	pop R2
	pop R1
	pop R0
	rts

  MoveTiro_RecalculaPos_Boom_Multi:	
	; Limpa a Tela !!
  	loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #0  			; cor branca!
	call ImprimeTela   		;  Rotina de Impresao de Cenario na Tela Inteira
  
	;imprime Voce Venceu !!!

	loadn r0, #526
	loadn r1, #Msn5
	loadn r2, #0
	call ImprimeStr
	
	;imprime quer jogar novamente
	loadn r0, #610
	loadn r1, #Msn1
	loadn r2, #0
	call ImprimeStr

	MoveTiro_RecalculaPos_Boom_Loop_Multi:	
	call DigLetra
	loadn r0, #'n'
	load r1, Letra
	cmp r0, r1				; tecla == 'n' ?
	jeq MoveTiro_RecalculaPos_Boom_FimJogo_Multi	; tecla e' 'n'
	
	loadn r0, #'y'
	cmp r0, r1				; tecla == 's' ?
	jne MoveTiro_RecalculaPos_Boom_Loop_Multi	; tecla nao e' 's'
	
	
	
	; Se quiser jogar novamente...
	call ApagaTela
	
	pop r2
	pop r1
	pop r0

	pop r0	; Da um Pop a mais para acertar o ponteiro da pilha, pois nao vai dar o RTS !!
	jmp checkpoint

 MoveTiro_RecalculaPos_Boom_FimJogo_Multi:
	jmp menu


;----------------------------------

MoveTiro2_RecalculaPos:
	push R0
	push R1
	push R2
	push R3
	push R4
	
	load R1, FlagTiro2	; Se Atirou, movimenta o tiro!
	loadn R2, #1
	cmp R1, R2			; If FlagTiro == 1  Movimenta o Tiro
	jne MoveTiro2_RecalculaPos_Fim2	; Se nao vai embora!
	
	load R0, posTiro2	; TEsta se o Tiro Pegou na nave1
	load R1, posAntNave
	cmp R0, R1			; IF posTiro == posAlien  BOOM!!
	jeq MoveTiro2_RecalculaPos_Boom
	
	loadn R1, #1160		; Testa condicoes de Contorno 
	load R2, posTiro2
	mod R1, R0, R1
	loadn R4, #1160
	add R1, R1, R4		
	cmp R1, R2			; Se tiro chegou na ultima linha
	jne MoveTiro2_RecalculaPos_Fim
	
	
	call MoveTiro2_Apaga
	loadn R0, #0
	store FlagTiro2, R0	; Zera FlagTiro
	store posTiro2, R0	; Zera e iguala posTiro e posAntTiro
	store posAntTiro2, R0
	jmp MoveTiro2_RecalculaPos_Fim2	
	
  MoveTiro2_RecalculaPos_Fim:
	;inc R0
	
	loadn R3, #40
	add R0, R0, R3
	;add R0, R3, R0
	
	store posTiro2, R0
	
  MoveTiro2_RecalculaPos_Fim2:	
  	pop R4
  	pop R3
	pop R2
	pop R1
	pop R0
	rts

  MoveTiro2_RecalculaPos_Boom:	
	; Limpa a Tela !!
  	loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #0  			; cor branca!
	call ImprimeTela   		;  Rotina de Impresao de Cenario na Tela Inteira
  
	;imprime Voce Venceu !!!
	loadn r0, #526
	loadn r1, #Msn6
	loadn r2, #512
	call ImprimeStr
	
	;imprime quer jogar novamente
	loadn r0, #610
	loadn r1, #Msn1
	loadn r2, #512
	call ImprimeStr

	MoveTiro2_RecalculaPos_Boom_Loop:	
	call DigLetra
	loadn r0, #'n'
	load r1, Letra
	cmp r0, r1				; tecla == 'n' ?
	jeq MoveTiro2_RecalculaPos_Boom_FimJogo	; tecla e' 'n'
	
	loadn r0, #'y'
	cmp r0, r1				; tecla == 's' ?
	jne MoveTiro2_RecalculaPos_Boom_Loop	; tecla nao e' 's'
	
	
	
	; Se quiser jogar novamente...
	call ApagaTela
	
	pop r2
	pop r1
	pop r0

	pop r0	; Da um Pop a mais para acertar o ponteiro da pilha, pois nao vai dar o RTS !!
	jmp checkpoint

 MoveTiro2_RecalculaPos_Boom_FimJogo:
	jmp menu

;----------------------------------

;----------------------------------
MoveTiro_Desenha:
	push R0
	push R1
	push R2
	push R3
	push R4
	
	load r3, dirTiro1
	loadn r4, #1
	cmp r3, r4
	jeq MoveTiro_Desenha_Horizontal
	
	loadn R1, #'|'	; Tiro
	jmp MoveTiro_Desenha_Fim
	
	MoveTiro_Desenha_Horizontal:
		loadn R1, #13		;tiro horizontal
		jmp MoveTiro_Desenha_Fim
		
	MoveTiro_Desenha_Fim:
		loadn R2, #1536
		add R1, R1, R2
		load R0, posTiro
		outchar R1, R0
		store posAntTiro, R0
	
		pop R4
		pop R3
		pop R2
		pop R1
		pop R0
		rts

;-------------------------------
MoveTiro_Desenha_Dois:
	push R0
	push R1
	push R2
	push R3
	push R4
	
	load r3, dirTiro2
	loadn r4, #1
	cmp r3, r4
	jeq MoveTiro_Desenha_Horizontal_2
	
	loadn R1, #'|'	; Tiro
	jmp MoveTiro_Desenha_Fim_2
	
	MoveTiro_Desenha_Horizontal_2:
		loadn R1, #13		;tiro horizontal
		jmp MoveTiro_Desenha_Fim_2
		
	MoveTiro_Desenha_Fim_2:
		loadn R2, #1536
		add R1, R1, R2
		load R0, posTiro2
		outchar R1, R0
		store posAntTiro2, R0
	
		pop R4
		pop R3
		pop R2
		pop R1
		pop R0
		rts
;-------------------

MoveTiro_Desenha_Tres:
	push R0
	push R1
	push R2
	push R3
	push R4
	
	load r3, dirTiro3
	loadn r4, #1
	cmp r3, r4
	jeq MoveTiro_Desenha_Horizontal_3
	
	loadn R1, #'|'	; Tiro
	jmp MoveTiro_Desenha_Fim_3
	
	MoveTiro_Desenha_Horizontal_3:
		loadn R1, #13		;tiro horizontal
		jmp MoveTiro_Desenha_Fim_3
		
	MoveTiro_Desenha_Fim_3:
		loadn R2, #1536
		add R1, R1, R2
		load R0, posTiro3
		outchar R1, R0
		store posAntTiro3, R0
	
		pop R4
		pop R3
		pop R2
		pop R1
		pop R0
		rts

;----------------------------

MoveTiro2_Desenha:
	push R0
	push R1
	push R2
	
	loadn R2, #2304
	loadn R1, #'|'	; Tiro
	add R1, R1, R2
	load R0, posTiro2
	outchar R1, R0
	store posAntTiro2, R0
	
	pop R2
	pop R1
	pop R0
	rts

;----------------------------------

;********************************************************
;                       DELAY
;********************************************************		


Delay:
						;Utiliza Push e Pop para nao afetar os Ristradores do programa principal
	Push R0
	Push R1
	
	Loadn R1, #50  ; a
   Delay_volta2:				;Quebrou o contador acima em duas partes (dois loops de decremento)
	Loadn R0, #3000	; b
   Delay_volta: 
	Dec R0					; (4*a + 6)b = 1000000  == 1 seg  em um clock de 1MHz
	JNZ Delay_volta	
	Dec R1
	JNZ Delay_volta2
	
	Pop R1
	Pop R0
	
	RTS							;return

;-------------------------------

Delay2:
						;Utiliza Push e Pop para nao afetar os Ristradores do programa principal
	push R0
	push R1
	
	loadn R1, #2 ; a
   Delay_volta2:				;Quebrou o contador acima em duas partes (dois loops de decremento)
	loadn R0, #10	; b
   Delay_volta: 
	dec R0					; (4*a + 6)b = 1000000  == 1 seg  em um clock de 1MHz
	jnz Delay_volta	
	dec R1
	jnz Delay_volta2
	
	pop R1
	pop R0
	
	rts						;return


;********************************************************
;                       IMPRIME TELA
;********************************************************	

ImprimeTela: 	;  Rotina de Impresao de Cenario na Tela Inteira
		;  r1 = endereco onde comeca a primeira linha do Cenario
		;  r2 = cor do Cenario para ser impresso

	push r0	; protege o r3 na pilha para ser usado na subrotina
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r4 na pilha para ser usado na subrotina

	loadn R0, #0  	; posicao inicial tem que ser o comeco da tela!
	loadn R3, #40  	; Incremento da posicao da tela!
	loadn R4, #41  	; incremento do ponteiro das linhas da tela
	loadn R5, #1200 ; Limite da tela!
	
   ImprimeTela_Loop:
		call ImprimeStr
		add r0, r0, r3  	; incrementaposicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5			; Compara r0 com 1200
		jne ImprimeTela_Loop	; Enquanto r0 < 1200

	pop r5	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
				
;---------------------

;---------------------------	
;********************************************************
;                   IMPRIME STRING
;********************************************************
	
ImprimeStr:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	
	loadn r3, #'\0'	; Criterio de parada

   ImprimeStr_Loop:	
		loadi r4, r1
		cmp r4, r3		; If (Char == \0)  vai Embora
		jeq ImprimeStr_Sai
		add r4, r2, r4	; Soma a Cor
		outchar r4, r0	; Imprime o caractere na tela
		inc r0			; Incrementa a posicao na tela
		inc r1			; Incrementa o ponteiro da String
		jmp ImprimeStr_Loop
	
   ImprimeStr_Sai:	
	pop r4	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
;------------------------	
	

;-------------------------------


;********************************************************
;                       IMPRIME TELA2
;********************************************************	

ImprimeTela2: 	;  Rotina de Impresao de Cenario na Tela Inteira
		;  r1 = endereco onde comeca a primeira linha do Cenario
		;  r2 = cor do Cenario para ser impresso

	push r0	; protege o r3 na pilha para ser usado na subrotina
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r5 na pilha para ser usado na subrotina
	push r6	; protege o r6 na pilha para ser usado na subrotina

	loadn R0, #0  	; posicao inicial tem que ser o comeco da tela!
	loadn R3, #40  	; Incremento da posicao da tela!
	loadn R4, #41  	; incremento do ponteiro das linhas da tela
	loadn R5, #1200 ; Limite da tela!
	loadn R6, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	
   ImprimeTela2_Loop:
		call ImprimeStr2
		add r0, r0, r3  	; incrementaposicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		add r6, r6, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5			; Compara r0 com 1200
		jne ImprimeTela2_Loop	; Enquanto r0 < 1200

	pop r6	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
				
;---------------------

;---------------------------	
;********************************************************
;                   IMPRIME STRING2
;********************************************************
	
ImprimeStr2:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r5 na pilha para ser usado na subrotina
	push r6	; protege o r6 na pilha para ser usado na subrotina
	
	
	loadn r3, #'\0'	; Criterio de parada
	loadn r5, #' '	; Espaco em Branco

   ImprimeStr2_Loop:	
		loadi r4, r1
		cmp r4, r3		; If (Char == \0)  vai Embora
		jeq ImprimeStr2_Sai
		cmp r4, r5		; If (Char == ' ')  vai Pula outchar do espaco para na apagar outros caracteres
		jeq ImprimeStr2_Skip
		add r4, r2, r4	; Soma a Cor
		outchar r4, r0	; Imprime o caractere na tela
   		storei r6, r4
   ImprimeStr2_Skip:
		inc r0			; Incrementa a posicao na tela
		inc r1			; Incrementa o ponteiro da String
		inc r6
		jmp ImprimeStr2_Loop
	
   ImprimeStr2_Sai:	
	pop r6	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	

;------------------------		
;********************************************************
;                   DIGITE UMA LETRA
;********************************************************

DigLetra:	; Espera que uma tecla seja digitada e salva na variavel global "Letra"
	push r0
	push r1
	loadn r1, #255	; Se nao digitar nada vem 255

   DigLetra_Loop:
		inchar r0			; Le o teclado, se nada for digitado = 255
		cmp r0, r1			;compara r0 com 255
		jeq DigLetra_Loop	; Fica lendo ate' que digite uma tecla valida

	store Letra, r0			; Salva a tecla na variavel global "Letra"

	pop r1
	pop r0
	rts



;----------------
	
;********************************************************
;                       APAGA TELA
;********************************************************
ApagaTela:
	push r0
	push r1
	
	loadn r0, #1200		; apaga as 1200 posicoes da Tela
	loadn r1, #' '		; com "espaco"
	
	   ApagaTela_Loop:	;;label for(r0=1200;r3>0;r3--)
		dec r0
		outchar r1, r0
		jnz ApagaTela_Loop
 
	pop r1
	pop r0
	rts	
	
;------------------------	
; Declara uma tela vazia para ser preenchida em tempo de execussao:

tela0Linha0  : string "                                        "
tela0Linha1  : string "                                        "
tela0Linha2  : string "                                        "
tela0Linha3  : string "                                        "
tela0Linha4  : string "                                        "
tela0Linha5  : string "                                        "
tela0Linha6  : string "                                        "
tela0Linha7  : string "                                        "
tela0Linha8  : string "                                        "
tela0Linha9  : string "                                        "
tela0Linha10 : string "                                        "
tela0Linha11 : string "                                        "
tela0Linha12 : string "                                        "
tela0Linha13 : string "                                        "
tela0Linha14 : string "                                        "
tela0Linha15 : string "                                        "
tela0Linha16 : string "                                        "
tela0Linha17 : string "                                        "
tela0Linha18 : string "                                        "
tela0Linha19 : string "                                        "
tela0Linha20 : string "                                        "
tela0Linha21 : string "                                        "
tela0Linha22 : string "                                        "
tela0Linha23 : string "                                        "
tela0Linha24 : string "                                        "
tela0Linha25 : string "                                        "
tela0Linha26 : string "                                        "
tela0Linha27 : string "                                        "
tela0Linha28 : string "                                        "
tela0Linha29 : string "                                        "	

; Declara e preenche tela linha por linha (40 caracteres):
tela1Linha0  : string "           .                       .    "
tela1Linha1  : string "     .                         .       ."
tela1Linha2  : string "         .         .                .   "
tela1Linha3  : string "    .                                   "
tela1Linha4  : string "   .                  .              .  "
tela1Linha5  : string "             .               .          "
tela1Linha6  : string "     .                                  "
tela1Linha7  : string "                     .                  "
tela1Linha8  : string "              .                    .    "
tela1Linha9  : string "     .                   .              "
tela1Linha10 : string "                                        "
tela1Linha11 : string "       .                                "
tela1Linha12 : string "                 .                   .  "
tela1Linha13 : string "                             .          "
tela1Linha14 : string "   .   .                   .            "
tela1Linha15 : string "                               .     .  "
tela1Linha16 : string "             .                          "
tela1Linha17 : string "    .                 .     .           "
tela1Linha18 : string "                  .                     "
tela1Linha19 : string "              .                 .       "
tela1Linha20 : string "    .    .                 .            "
tela1Linha21 : string "   .                    .             . "
tela1Linha22 : string "              .                 .       "
tela1Linha23 : string "                                        "
tela1Linha24 : string "  .                               .     "
tela1Linha25 : string "          .      .            .         "
tela1Linha26 : string "                                        "
tela1Linha27 : string "        .                    .      .   "
tela1Linha28 : string "                                  .     "
tela1Linha29 : string "    .               .                   "


tela2Linha0  : string "                                        "
tela2Linha1  : string "                                        "
tela2Linha2  : string "                                        "
tela2Linha3  : string "                                        "
tela2Linha4  : string "                                        "
tela2Linha5  : string "                                        "
tela2Linha6  : string "                                        "
tela2Linha7  : string "                                        "
tela2Linha8  : string "                                        "
tela2Linha9  : string "                                        "
tela2Linha10 : string "                                        "
tela2Linha11 : string "                                        "
tela2Linha12 : string "                                        "
tela2Linha13 : string "                                        "
tela2Linha14 : string "                                        "
tela2Linha15 : string "                                        "
tela2Linha16 : string "                                        "
tela2Linha17 : string "                                        "
tela2Linha18 : string "                                        "
tela2Linha19 : string "                                        "
tela2Linha20 : string "                                        "
tela2Linha21 : string "                                        "
tela2Linha22 : string "                                        "
tela2Linha23 : string "                                        "
tela2Linha24 : string "                                        "
tela2Linha25 : string "                                        "
tela2Linha26 : string "                                        "
tela2Linha27 : string "                                        "
tela2Linha28 : string "                                        "
tela2Linha29 : string "                                        "	


tela3Linha0  : string "                                        "
tela3Linha1  : string "                                        "
tela3Linha2  : string "                                        "
tela3Linha3  : string "                                        "
tela3Linha4  : string "                                        "
tela3Linha5  : string "                                        "
tela3Linha6  : string "                                        "
tela3Linha7  : string "                                        "
tela3Linha8  : string "                                        "
tela3Linha9  : string "                                        "
tela3Linha10 : string "                                        "
tela3Linha11 : string "                                        "
tela3Linha12 : string "                                        "
tela3Linha13 : string "                                        "
tela3Linha14 : string "                                        "
tela3Linha15 : string "                                        "
tela3Linha16 : string "                                        "
tela3Linha17 : string "                                        "
tela3Linha18 : string "                                        "
tela3Linha19 : string "                                        "
tela3Linha20 : string "                                        "
tela3Linha21 : string "                                        "
tela3Linha22 : string "                                        "
tela3Linha23 : string "                                        "
tela3Linha24 : string "                                        "
tela3Linha25 : string "                                        "
tela3Linha26 : string "                                        "
tela3Linha27 : string "                                        "
tela3Linha28 : string "                                        "
tela3Linha29 : string "                                        "	





tela4Linha0  : string "                                        "
tela4Linha1  : string "                                        "
tela4Linha2  : string "                                        "
tela4Linha3  : string "                                        "
tela4Linha4  : string "                                        "
tela4Linha5  : string "                                        "
tela4Linha6  : string "                                        "
tela4Linha7  : string "                                        "
tela4Linha8  : string "                                        "
tela4Linha9  : string "                                        "
tela4Linha10 : string "                                        "
tela4Linha11 : string "                                        "
tela4Linha12 : string "                                        "
tela4Linha13 : string "                                        "
tela4Linha14 : string "                                        "
tela4Linha15 : string "                                        "
tela4Linha16 : string "                                        "
tela4Linha17 : string "                                        "
tela4Linha18 : string "                                        "
tela4Linha19 : string "                                        "
tela4Linha20 : string "                                        "
tela4Linha21 : string "                                        "
tela4Linha22 : string "                                        "
tela4Linha23 : string "                                        "
tela4Linha24 : string "                                        "
tela4Linha25 : string "                                        "
tela4Linha26 : string "                                        "
tela4Linha27 : string "                                        "
tela4Linha28 : string "                                        "
tela4Linha29 : string "                                        "	


telamenu : var #1200
  ;Linha 0
  static telamenu + #0, #3967
  static telamenu + #1, #3967
  static telamenu + #2, #1070
  static telamenu + #3, #3967
  static telamenu + #4, #3967
  static telamenu + #5, #3967
  static telamenu + #6, #3967
  static telamenu + #7, #3967
  static telamenu + #8, #3967
  static telamenu + #9, #3967
  static telamenu + #10, #3967
  static telamenu + #11, #3967
  static telamenu + #12, #3967
  static telamenu + #13, #3967
  static telamenu + #14, #3967
  static telamenu + #15, #3967
  static telamenu + #16, #3967
  static telamenu + #17, #3967
  static telamenu + #18, #3967
  static telamenu + #19, #3967
  static telamenu + #20, #3967
  static telamenu + #21, #3967
  static telamenu + #22, #3967
  static telamenu + #23, #3967
  static telamenu + #24, #3967
  static telamenu + #25, #3967
  static telamenu + #26, #3967
  static telamenu + #27, #1070
  static telamenu + #28, #3967
  static telamenu + #29, #3967
  static telamenu + #30, #3967
  static telamenu + #31, #3967
  static telamenu + #32, #3967
  static telamenu + #33, #3967
  static telamenu + #34, #3967
  static telamenu + #35, #3967
  static telamenu + #36, #3967
  static telamenu + #37, #3967
  static telamenu + #38, #3967
  static telamenu + #39, #3967

  ;Linha 1
  static telamenu + #40, #1070
  static telamenu + #41, #3967
  static telamenu + #42, #3967
  static telamenu + #43, #3967
  static telamenu + #44, #3967
  static telamenu + #45, #1070
  static telamenu + #46, #3967
  static telamenu + #47, #3967
  static telamenu + #48, #3967
  static telamenu + #49, #3967
  static telamenu + #50, #3967
  static telamenu + #51, #3967
  static telamenu + #52, #3967
  static telamenu + #53, #1070
  static telamenu + #54, #3967
  static telamenu + #55, #3967
  static telamenu + #56, #3967
  static telamenu + #57, #3967
  static telamenu + #58, #3967
  static telamenu + #59, #3967
  static telamenu + #60, #3967
  static telamenu + #61, #3967
  static telamenu + #62, #1070
  static telamenu + #63, #3967
  static telamenu + #64, #3967
  static telamenu + #65, #3967
  static telamenu + #66, #3967
  static telamenu + #67, #3967
  static telamenu + #68, #3967
  static telamenu + #69, #3967
  static telamenu + #70, #3967
  static telamenu + #71, #3967
  static telamenu + #72, #3967
  static telamenu + #73, #1070
  static telamenu + #74, #3967
  static telamenu + #75, #3967
  static telamenu + #76, #3967
  static telamenu + #77, #1070
  static telamenu + #78, #3967
  static telamenu + #79, #3967

  ;Linha 2
  static telamenu + #80, #3967
  static telamenu + #81, #3967
  static telamenu + #82, #3967
  static telamenu + #83, #3967
  static telamenu + #84, #3967
  static telamenu + #85, #3967
  static telamenu + #86, #3967
  static telamenu + #87, #3967
  static telamenu + #88, #3967
  static telamenu + #89, #3967
  static telamenu + #90, #3967
  static telamenu + #91, #3967
  static telamenu + #92, #3967
  static telamenu + #93, #3967
  static telamenu + #94, #3967
  static telamenu + #95, #3967
  static telamenu + #96, #3967
  static telamenu + #97, #3967
  static telamenu + #98, #3967
  static telamenu + #99, #3967
  static telamenu + #100, #3967
  static telamenu + #101, #1070
  static telamenu + #102, #3967
  static telamenu + #103, #3967
  static telamenu + #104, #3967
  static telamenu + #105, #3967
  static telamenu + #106, #3967
  static telamenu + #107, #3967
  static telamenu + #108, #3967
  static telamenu + #109, #3967
  static telamenu + #110, #3967
  static telamenu + #111, #3967
  static telamenu + #112, #3967
  static telamenu + #113, #3967
  static telamenu + #114, #3967
  static telamenu + #115, #3967
  static telamenu + #116, #3967
  static telamenu + #117, #3967
  static telamenu + #118, #3967
  static telamenu + #119, #3967

  ;Linha 3
  static telamenu + #120, #3967
  static telamenu + #121, #3967
  static telamenu + #122, #3967
  static telamenu + #123, #3967
  static telamenu + #124, #3967
  static telamenu + #125, #3967
  static telamenu + #126, #3967
  static telamenu + #127, #3967
  static telamenu + #128, #3967
  static telamenu + #129, #1070
  static telamenu + #130, #3967
  static telamenu + #131, #3967
  static telamenu + #132, #3967
  static telamenu + #133, #3967
  static telamenu + #134, #3967
  static telamenu + #135, #3967
  static telamenu + #136, #3967
  static telamenu + #137, #3967
  static telamenu + #138, #3967
  static telamenu + #139, #3967
  static telamenu + #140, #3967
  static telamenu + #141, #3967
  static telamenu + #142, #3967
  static telamenu + #143, #3967
  static telamenu + #144, #1070
  static telamenu + #145, #3967
  static telamenu + #146, #3967
  static telamenu + #147, #3967
  static telamenu + #148, #3967
  static telamenu + #149, #3967
  static telamenu + #150, #3967
  static telamenu + #151, #3967
  static telamenu + #152, #3967
  static telamenu + #153, #3967
  static telamenu + #154, #3967
  static telamenu + #155, #3967
  static telamenu + #156, #3967
  static telamenu + #157, #3967
  static telamenu + #158, #1070
  static telamenu + #159, #3967

  ;Linha 4
  static telamenu + #160, #3967
  static telamenu + #161, #3967
  static telamenu + #162, #3967
  static telamenu + #163, #3967
  static telamenu + #164, #3967
  static telamenu + #165, #3967
  static telamenu + #166, #1070
  static telamenu + #167, #3967
  static telamenu + #168, #3967
  static telamenu + #169, #3967
  static telamenu + #170, #3967
  static telamenu + #171, #3967
  static telamenu + #172, #3967
  static telamenu + #173, #3967
  static telamenu + #174, #3967
  static telamenu + #175, #1070
  static telamenu + #176, #3967
  static telamenu + #177, #3967
  static telamenu + #178, #3967
  static telamenu + #179, #3967
  static telamenu + #180, #3967
  static telamenu + #181, #3967
  static telamenu + #182, #3967
  static telamenu + #183, #3967
  static telamenu + #184, #3967
  static telamenu + #185, #3967
  static telamenu + #186, #3967
  static telamenu + #187, #3967
  static telamenu + #188, #3967
  static telamenu + #189, #3967
  static telamenu + #190, #3967
  static telamenu + #191, #1070
  static telamenu + #192, #3967
  static telamenu + #193, #3967
  static telamenu + #194, #3967
  static telamenu + #195, #3967
  static telamenu + #196, #3967
  static telamenu + #197, #3967
  static telamenu + #198, #3967
  static telamenu + #199, #3967

  ;Linha 5
  static telamenu + #200, #3967
  static telamenu + #201, #1070
  static telamenu + #202, #3967
  static telamenu + #203, #3967
  static telamenu + #204, #3967
  static telamenu + #205, #3967
  static telamenu + #206, #3967
  static telamenu + #207, #3967
  static telamenu + #208, #3967
  static telamenu + #209, #3967
  static telamenu + #210, #3967
  static telamenu + #211, #3967
  static telamenu + #212, #3967
  static telamenu + #213, #3967
  static telamenu + #214, #3967
  static telamenu + #215, #3967
  static telamenu + #216, #3967
  static telamenu + #217, #3967
  static telamenu + #218, #3967
  static telamenu + #219, #3967
  static telamenu + #220, #1070
  static telamenu + #221, #3967
  static telamenu + #222, #3967
  static telamenu + #223, #3967
  static telamenu + #224, #3967
  static telamenu + #225, #3967
  static telamenu + #226, #3967
  static telamenu + #227, #3967
  static telamenu + #228, #3967
  static telamenu + #229, #3967
  static telamenu + #230, #3967
  static telamenu + #231, #3967
  static telamenu + #232, #3967
  static telamenu + #233, #3967
  static telamenu + #234, #3967
  static telamenu + #235, #3967
  static telamenu + #236, #3967
  static telamenu + #237, #3967
  static telamenu + #238, #3967
  static telamenu + #239, #3967

  ;Linha 6
  static telamenu + #240, #3967
  static telamenu + #241, #3967
  static telamenu + #242, #3967
  static telamenu + #243, #3967
  static telamenu + #244, #3967
  static telamenu + #245, #3967
  static telamenu + #246, #3967
  static telamenu + #247, #3967
  static telamenu + #248, #3967
  static telamenu + #249, #3967
  static telamenu + #250, #3967
  static telamenu + #251, #3967
  static telamenu + #252, #3967
  static telamenu + #253, #3967
  static telamenu + #254, #3967
  static telamenu + #255, #3967
  static telamenu + #256, #3967
  static telamenu + #257, #3967
  static telamenu + #258, #3967
  static telamenu + #259, #3967
  static telamenu + #260, #3967
  static telamenu + #261, #3967
  static telamenu + #262, #3967
  static telamenu + #263, #3967
  static telamenu + #264, #3967
  static telamenu + #265, #3967
  static telamenu + #266, #3967
  static telamenu + #267, #3967
  static telamenu + #268, #3967
  static telamenu + #269, #3967
  static telamenu + #270, #3967
  static telamenu + #271, #3967
  static telamenu + #272, #3967
  static telamenu + #273, #3967
  static telamenu + #274, #3967
  static telamenu + #275, #3967
  static telamenu + #276, #3967
  static telamenu + #277, #3967
  static telamenu + #278, #3967
  static telamenu + #279, #3967

  ;Linha 7
  static telamenu + #280, #3967
  static telamenu + #281, #3967
  static telamenu + #282, #3967
  static telamenu + #283, #3967
  static telamenu + #284, #3967
  static telamenu + #285, #3967
  static telamenu + #286, #3967
  static telamenu + #287, #3967
  static telamenu + #288, #1024
  static telamenu + #289, #1024
  static telamenu + #290, #3967
  static telamenu + #291, #3967
  static telamenu + #292, #3967
  static telamenu + #293, #1024
  static telamenu + #294, #1024
  static telamenu + #295, #3967
  static telamenu + #296, #3967
  static telamenu + #297, #3967
  static telamenu + #298, #1024
  static telamenu + #299, #1024
  static telamenu + #300, #3967
  static telamenu + #301, #3967
  static telamenu + #302, #3967
  static telamenu + #303, #1024
  static telamenu + #304, #1024
  static telamenu + #305, #3967
  static telamenu + #306, #3967
  static telamenu + #307, #3967
  static telamenu + #308, #1024
  static telamenu + #309, #1024
  static telamenu + #310, #3967
  static telamenu + #311, #3967
  static telamenu + #312, #3967
  static telamenu + #313, #3967
  static telamenu + #314, #3967
  static telamenu + #315, #3967
  static telamenu + #316, #3967
  static telamenu + #317, #1070
  static telamenu + #318, #3967
  static telamenu + #319, #3967

  ;Linha 8
  static telamenu + #320, #3967
  static telamenu + #321, #3967
  static telamenu + #322, #3967
  static telamenu + #323, #3967
  static telamenu + #324, #3967
  static telamenu + #325, #3967
  static telamenu + #326, #3967
  static telamenu + #327, #1024
  static telamenu + #328, #3967
  static telamenu + #329, #3967
  static telamenu + #330, #1024
  static telamenu + #331, #3967
  static telamenu + #332, #1024
  static telamenu + #333, #3967
  static telamenu + #334, #3967
  static telamenu + #335, #1024
  static telamenu + #336, #3967
  static telamenu + #337, #1024
  static telamenu + #338, #3967
  static telamenu + #339, #3967
  static telamenu + #340, #1024
  static telamenu + #341, #3967
  static telamenu + #342, #1024
  static telamenu + #343, #3967
  static telamenu + #344, #3967
  static telamenu + #345, #1024
  static telamenu + #346, #3967
  static telamenu + #347, #1024
  static telamenu + #348, #3967
  static telamenu + #349, #3967
  static telamenu + #350, #1024
  static telamenu + #351, #3967
  static telamenu + #352, #3967
  static telamenu + #353, #3967
  static telamenu + #354, #3967
  static telamenu + #355, #3967
  static telamenu + #356, #3967
  static telamenu + #357, #3967
  static telamenu + #358, #3967
  static telamenu + #359, #3967

  ;Linha 9
  static telamenu + #360, #3967
  static telamenu + #361, #3967
  static telamenu + #362, #3967
  static telamenu + #363, #3967
  static telamenu + #364, #3967
  static telamenu + #365, #1070
  static telamenu + #366, #3967
  static telamenu + #367, #1024
  static telamenu + #368, #3967
  static telamenu + #369, #3967
  static telamenu + #370, #3967
  static telamenu + #371, #3967
  static telamenu + #372, #1024
  static telamenu + #373, #3967
  static telamenu + #374, #3967
  static telamenu + #375, #1024
  static telamenu + #376, #3967
  static telamenu + #377, #1024
  static telamenu + #378, #3967
  static telamenu + #379, #3967
  static telamenu + #380, #1024
  static telamenu + #381, #3967
  static telamenu + #382, #1024
  static telamenu + #383, #3967
  static telamenu + #384, #3967
  static telamenu + #385, #1024
  static telamenu + #386, #3967
  static telamenu + #387, #1024
  static telamenu + #388, #3967
  static telamenu + #389, #3967
  static telamenu + #390, #3967
  static telamenu + #391, #3967
  static telamenu + #392, #1070
  static telamenu + #393, #3967
  static telamenu + #394, #3967
  static telamenu + #395, #3967
  static telamenu + #396, #3967
  static telamenu + #397, #3967
  static telamenu + #398, #3967
  static telamenu + #399, #3967

  ;Linha 10
  static telamenu + #400, #1070
  static telamenu + #401, #3967
  static telamenu + #402, #3967
  static telamenu + #403, #3967
  static telamenu + #404, #3967
  static telamenu + #405, #3967
  static telamenu + #406, #3967
  static telamenu + #407, #3967
  static telamenu + #408, #1024
  static telamenu + #409, #1024
  static telamenu + #410, #3967
  static telamenu + #411, #3967
  static telamenu + #412, #1024
  static telamenu + #413, #1024
  static telamenu + #414, #1024
  static telamenu + #415, #3967
  static telamenu + #416, #3967
  static telamenu + #417, #1024
  static telamenu + #418, #1024
  static telamenu + #419, #1024
  static telamenu + #420, #1024
  static telamenu + #421, #3967
  static telamenu + #422, #1024
  static telamenu + #423, #3967
  static telamenu + #424, #3967
  static telamenu + #425, #3967
  static telamenu + #426, #3967
  static telamenu + #427, #1024
  static telamenu + #428, #1024
  static telamenu + #429, #1024
  static telamenu + #430, #3967
  static telamenu + #431, #3967
  static telamenu + #432, #3967
  static telamenu + #433, #3967
  static telamenu + #434, #3967
  static telamenu + #435, #3967
  static telamenu + #436, #3967
  static telamenu + #437, #3967
  static telamenu + #438, #3967
  static telamenu + #439, #3967

  ;Linha 11
  static telamenu + #440, #3967
  static telamenu + #441, #3967
  static telamenu + #442, #1070
  static telamenu + #443, #3967
  static telamenu + #444, #3967
  static telamenu + #445, #3967
  static telamenu + #446, #3967
  static telamenu + #447, #3967
  static telamenu + #448, #3967
  static telamenu + #449, #3967
  static telamenu + #450, #1024
  static telamenu + #451, #3967
  static telamenu + #452, #1024
  static telamenu + #453, #3967
  static telamenu + #454, #3967
  static telamenu + #455, #3967
  static telamenu + #456, #3967
  static telamenu + #457, #1024
  static telamenu + #458, #3967
  static telamenu + #459, #3967
  static telamenu + #460, #1024
  static telamenu + #461, #3967
  static telamenu + #462, #1024
  static telamenu + #463, #3967
  static telamenu + #464, #3967
  static telamenu + #465, #1024
  static telamenu + #466, #3967
  static telamenu + #467, #1024
  static telamenu + #468, #3967
  static telamenu + #469, #3967
  static telamenu + #470, #3967
  static telamenu + #471, #3967
  static telamenu + #472, #3967
  static telamenu + #473, #3967
  static telamenu + #474, #3967
  static telamenu + #475, #3967
  static telamenu + #476, #3967
  static telamenu + #477, #3967
  static telamenu + #478, #3967
  static telamenu + #479, #1070

  ;Linha 12
  static telamenu + #480, #3967
  static telamenu + #481, #3967
  static telamenu + #482, #3967
  static telamenu + #483, #3967
  static telamenu + #484, #3967
  static telamenu + #485, #3967
  static telamenu + #486, #3967
  static telamenu + #487, #1024
  static telamenu + #488, #3967
  static telamenu + #489, #3967
  static telamenu + #490, #1024
  static telamenu + #491, #3967
  static telamenu + #492, #1024
  static telamenu + #493, #3967
  static telamenu + #494, #3967
  static telamenu + #495, #3967
  static telamenu + #496, #3967
  static telamenu + #497, #1024
  static telamenu + #498, #3967
  static telamenu + #499, #3967
  static telamenu + #500, #1024
  static telamenu + #501, #3967
  static telamenu + #502, #1024
  static telamenu + #503, #3967
  static telamenu + #504, #3967
  static telamenu + #505, #1024
  static telamenu + #506, #3967
  static telamenu + #507, #1024
  static telamenu + #508, #3967
  static telamenu + #509, #3967
  static telamenu + #510, #1024
  static telamenu + #511, #3967
  static telamenu + #512, #3967
  static telamenu + #513, #3967
  static telamenu + #514, #3967
  static telamenu + #515, #3967
  static telamenu + #516, #3967
  static telamenu + #517, #3967
  static telamenu + #518, #3967
  static telamenu + #519, #3967

  ;Linha 13
  static telamenu + #520, #3967
  static telamenu + #521, #3967
  static telamenu + #522, #3967
  static telamenu + #523, #3967
  static telamenu + #524, #3967
  static telamenu + #525, #3967
  static telamenu + #526, #3967
  static telamenu + #527, #3967
  static telamenu + #528, #1024
  static telamenu + #529, #1024
  static telamenu + #530, #3967
  static telamenu + #531, #3967
  static telamenu + #532, #1024
  static telamenu + #533, #3967
  static telamenu + #534, #3967
  static telamenu + #535, #3967
  static telamenu + #536, #3967
  static telamenu + #537, #1024
  static telamenu + #538, #3967
  static telamenu + #539, #3967
  static telamenu + #540, #1024
  static telamenu + #541, #3967
  static telamenu + #542, #3967
  static telamenu + #543, #1024
  static telamenu + #544, #1024
  static telamenu + #545, #3967
  static telamenu + #546, #3967
  static telamenu + #547, #3967
  static telamenu + #548, #1024
  static telamenu + #549, #1024
  static telamenu + #550, #3967
  static telamenu + #551, #3967
  static telamenu + #552, #3967
  static telamenu + #553, #3967
  static telamenu + #554, #3967
  static telamenu + #555, #3967
  static telamenu + #556, #3967
  static telamenu + #557, #3967
  static telamenu + #558, #3967
  static telamenu + #559, #3967

  ;Linha 14
  static telamenu + #560, #3967
  static telamenu + #561, #3967
  static telamenu + #562, #3967
  static telamenu + #563, #3967
  static telamenu + #564, #3967
  static telamenu + #565, #3967
  static telamenu + #566, #3967
  static telamenu + #567, #3967
  static telamenu + #568, #3967
  static telamenu + #569, #3967
  static telamenu + #570, #3967
  static telamenu + #571, #3967
  static telamenu + #572, #3967
  static telamenu + #573, #3967
  static telamenu + #574, #3967
  static telamenu + #575, #3967
  static telamenu + #576, #3967
  static telamenu + #577, #3967
  static telamenu + #578, #3967
  static telamenu + #579, #3967
  static telamenu + #580, #3967
  static telamenu + #581, #3967
  static telamenu + #582, #3967
  static telamenu + #583, #3967
  static telamenu + #584, #3967
  static telamenu + #585, #3967
  static telamenu + #586, #3967
  static telamenu + #587, #3967
  static telamenu + #588, #3967
  static telamenu + #589, #3967
  static telamenu + #590, #3967
  static telamenu + #591, #1070
  static telamenu + #592, #3967
  static telamenu + #593, #3967
  static telamenu + #594, #3967
  static telamenu + #595, #3967
  static telamenu + #596, #3967
  static telamenu + #597, #3967
  static telamenu + #598, #1070
  static telamenu + #599, #3967

  ;Linha 15
  static telamenu + #600, #3967
  static telamenu + #601, #3967
  static telamenu + #602, #3967
  static telamenu + #603, #1070
  static telamenu + #604, #3967
  static telamenu + #605, #3967
  static telamenu + #606, #3967
  static telamenu + #607, #3967
  static telamenu + #608, #3967
  static telamenu + #609, #3967
  static telamenu + #610, #3967
  static telamenu + #611, #3967
  static telamenu + #612, #3967
  static telamenu + #613, #3967
  static telamenu + #614, #3967
  static telamenu + #615, #3967
  static telamenu + #616, #3967
  static telamenu + #617, #3967
  static telamenu + #618, #3967
  static telamenu + #619, #3967
  static telamenu + #620, #3967
  static telamenu + #621, #3967
  static telamenu + #622, #3967
  static telamenu + #623, #3967
  static telamenu + #624, #3967
  static telamenu + #625, #3967
  static telamenu + #626, #3967
  static telamenu + #627, #3967
  static telamenu + #628, #3967
  static telamenu + #629, #3967
  static telamenu + #630, #3967
  static telamenu + #631, #3967
  static telamenu + #632, #3967
  static telamenu + #633, #3967
  static telamenu + #634, #3967
  static telamenu + #635, #3967
  static telamenu + #636, #3967
  static telamenu + #637, #3967
  static telamenu + #638, #3967
  static telamenu + #639, #3967

  ;Linha 16
  static telamenu + #640, #3967
  static telamenu + #641, #3967
  static telamenu + #642, #3967
  static telamenu + #643, #3967
  static telamenu + #644, #3967
  static telamenu + #645, #3967
  static telamenu + #646, #3967
  static telamenu + #647, #3967
  static telamenu + #648, #3967
  static telamenu + #649, #3967
  static telamenu + #650, #1070
  static telamenu + #651, #3967
  static telamenu + #652, #3967
  static telamenu + #653, #3967
  static telamenu + #654, #3967
  static telamenu + #655, #3967
  static telamenu + #656, #3967
  static telamenu + #657, #3967
  static telamenu + #658, #3967
  static telamenu + #659, #3967
  static telamenu + #660, #3967
  static telamenu + #661, #3967
  static telamenu + #662, #3967
  static telamenu + #663, #1070
  static telamenu + #664, #3967
  static telamenu + #665, #3967
  static telamenu + #666, #3967
  static telamenu + #667, #3967
  static telamenu + #668, #3967
  static telamenu + #669, #3967
  static telamenu + #670, #3967
  static telamenu + #671, #3967
  static telamenu + #672, #3967
  static telamenu + #673, #3967
  static telamenu + #674, #1070
  static telamenu + #675, #3967
  static telamenu + #676, #3967
  static telamenu + #677, #1070
  static telamenu + #678, #3967
  static telamenu + #679, #3967

  ;Linha 17
  static telamenu + #680, #3967
  static telamenu + #681, #3967
  static telamenu + #682, #3967
  static telamenu + #683, #3967
  static telamenu + #684, #3967
  static telamenu + #685, #3967
  static telamenu + #686, #3967
  static telamenu + #687, #3967
  static telamenu + #688, #3967
  static telamenu + #689, #3967
  static telamenu + #690, #3967
  static telamenu + #691, #3967
  static telamenu + #692, #3967
  static telamenu + #693, #3967
  static telamenu + #694, #3967
  static telamenu + #695, #3967
  static telamenu + #696, #3967
  static telamenu + #697, #3967
  static telamenu + #698, #3967
  static telamenu + #699, #3967
  static telamenu + #700, #3967
  static telamenu + #701, #3967
  static telamenu + #702, #3967
  static telamenu + #703, #3967
  static telamenu + #704, #3967
  static telamenu + #705, #3967
  static telamenu + #706, #3967
  static telamenu + #707, #3967
  static telamenu + #708, #3967
  static telamenu + #709, #3967
  static telamenu + #710, #3967
  static telamenu + #711, #3967
  static telamenu + #712, #3967
  static telamenu + #713, #3967
  static telamenu + #714, #3967
  static telamenu + #715, #3967
  static telamenu + #716, #3967
  static telamenu + #717, #3967
  static telamenu + #718, #3967
  static telamenu + #719, #3967

  ;Linha 18
  static telamenu + #720, #3967
  static telamenu + #721, #3967
  static telamenu + #722, #3967
  static telamenu + #723, #3967
  static telamenu + #724, #3967
  static telamenu + #725, #3967
  static telamenu + #726, #1070
  static telamenu + #727, #3967
  static telamenu + #728, #3967
  static telamenu + #729, #3967
  static telamenu + #730, #3967
  static telamenu + #731, #3967
  static telamenu + #732, #3967
  static telamenu + #733, #3967
  static telamenu + #734, #3967
  static telamenu + #735, #3967
  static telamenu + #736, #3967
  static telamenu + #737, #3967
  static telamenu + #738, #3967
  static telamenu + #739, #3967
  static telamenu + #740, #3967
  static telamenu + #741, #3967
  static telamenu + #742, #3967
  static telamenu + #743, #1070
  static telamenu + #744, #3967
  static telamenu + #745, #3967
  static telamenu + #746, #3967
  static telamenu + #747, #3967
  static telamenu + #748, #1070
  static telamenu + #749, #3967
  static telamenu + #750, #3967
  static telamenu + #751, #3967
  static telamenu + #752, #3967
  static telamenu + #753, #3967
  static telamenu + #754, #3967
  static telamenu + #755, #3967
  static telamenu + #756, #3967
  static telamenu + #757, #3967
  static telamenu + #758, #3967
  static telamenu + #759, #3967

  ;Linha 19
  static telamenu + #760, #1070
  static telamenu + #761, #3967
  static telamenu + #762, #3967
  static telamenu + #763, #3967
  static telamenu + #764, #1070
  static telamenu + #765, #3967
  static telamenu + #766, #3967
  static telamenu + #767, #3967
  static telamenu + #768, #3967
  static telamenu + #769, #3967
  static telamenu + #770, #3967
  static telamenu + #771, #3967
  static telamenu + #772, #3967
  static telamenu + #773, #1070
  static telamenu + #774, #3967
  static telamenu + #775, #3967
  static telamenu + #776, #3967
  static telamenu + #777, #3967
  static telamenu + #778, #1070
  static telamenu + #779, #3967
  static telamenu + #780, #3967
  static telamenu + #781, #3967
  static telamenu + #782, #3967
  static telamenu + #783, #3967
  static telamenu + #784, #3967
  static telamenu + #785, #3967
  static telamenu + #786, #3967
  static telamenu + #787, #3967
  static telamenu + #788, #3967
  static telamenu + #789, #3967
  static telamenu + #790, #3967
  static telamenu + #791, #3967
  static telamenu + #792, #3967
  static telamenu + #793, #3967
  static telamenu + #794, #3967
  static telamenu + #795, #3967
  static telamenu + #796, #3967
  static telamenu + #797, #1070
  static telamenu + #798, #3967
  static telamenu + #799, #3967

  ;Linha 20
  static telamenu + #800, #3967
  static telamenu + #801, #3967
  static telamenu + #802, #3967
  static telamenu + #803, #3967
  static telamenu + #804, #3967
  static telamenu + #805, #3967
  static telamenu + #806, #3967
  static telamenu + #807, #3967
  static telamenu + #808, #3967
  static telamenu + #809, #3967
  static telamenu + #810, #3967
  static telamenu + #811, #3967
  static telamenu + #812, #3967
  static telamenu + #813, #3967
  static telamenu + #814, #3967
  static telamenu + #815, #3967
  static telamenu + #816, #3967
  static telamenu + #817, #3967
  static telamenu + #818, #3967
  static telamenu + #819, #3967
  static telamenu + #820, #3967
  static telamenu + #821, #3967
  static telamenu + #822, #3967
  static telamenu + #823, #3967
  static telamenu + #824, #3967
  static telamenu + #825, #3967
  static telamenu + #826, #3967
  static telamenu + #827, #3967
  static telamenu + #828, #3967
  static telamenu + #829, #3967
  static telamenu + #830, #3967
  static telamenu + #831, #3967
  static telamenu + #832, #3967
  static telamenu + #833, #3967
  static telamenu + #834, #3967
  static telamenu + #835, #3967
  static telamenu + #836, #3967
  static telamenu + #837, #3967
  static telamenu + #838, #3967
  static telamenu + #839, #3967

  ;Linha 21
  static telamenu + #840, #3967
  static telamenu + #841, #3967
  static telamenu + #842, #3967
  static telamenu + #843, #3967
  static telamenu + #844, #3967
  static telamenu + #845, #3967
  static telamenu + #846, #3967
  static telamenu + #847, #3967
  static telamenu + #848, #3967
  static telamenu + #849, #3967
  static telamenu + #850, #1070
  static telamenu + #851, #3967
  static telamenu + #852, #3967
  static telamenu + #853, #3967
  static telamenu + #854, #3967
  static telamenu + #855, #3967
  static telamenu + #856, #3967
  static telamenu + #857, #3967
  static telamenu + #858, #3967
  static telamenu + #859, #3967
  static telamenu + #860, #1070
  static telamenu + #861, #3967
  static telamenu + #862, #3967
  static telamenu + #863, #3967
  static telamenu + #864, #3967
  static telamenu + #865, #3967
  static telamenu + #866, #3967
  static telamenu + #867, #3967
  static telamenu + #868, #3967
  static telamenu + #869, #3967
  static telamenu + #870, #3967
  static telamenu + #871, #1070
  static telamenu + #872, #3967
  static telamenu + #873, #3967
  static telamenu + #874, #3967
  static telamenu + #875, #3967
  static telamenu + #876, #3967
  static telamenu + #877, #3967
  static telamenu + #878, #3967
  static telamenu + #879, #3967

  ;Linha 22
  static telamenu + #880, #3967
  static telamenu + #881, #3967
  static telamenu + #882, #3967
  static telamenu + #883, #3967
  static telamenu + #884, #3967
  static telamenu + #885, #3967
  static telamenu + #886, #3967
  static telamenu + #887, #3967
  static telamenu + #888, #3967
  static telamenu + #889, #3967
  static telamenu + #890, #3967
  static telamenu + #891, #3967
  static telamenu + #892, #3967
  static telamenu + #893, #3967
  static telamenu + #894, #3967
  static telamenu + #895, #3967
  static telamenu + #896, #3967
  static telamenu + #897, #3967
  static telamenu + #898, #3967
  static telamenu + #899, #3967
  static telamenu + #900, #3967
  static telamenu + #901, #3967
  static telamenu + #902, #3967
  static telamenu + #903, #3967
  static telamenu + #904, #3967
  static telamenu + #905, #3967
  static telamenu + #906, #1070
  static telamenu + #907, #3967
  static telamenu + #908, #3967
  static telamenu + #909, #3967
  static telamenu + #910, #3967
  static telamenu + #911, #3967
  static telamenu + #912, #3967
  static telamenu + #913, #3967
  static telamenu + #914, #3967
  static telamenu + #915, #3967
  static telamenu + #916, #3967
  static telamenu + #917, #3967
  static telamenu + #918, #3967
  static telamenu + #919, #3967

  ;Linha 23
  static telamenu + #920, #3967
  static telamenu + #921, #3967
  static telamenu + #922, #3967
  static telamenu + #923, #3967
  static telamenu + #924, #3967
  static telamenu + #925, #3967
  static telamenu + #926, #3967
  static telamenu + #927, #1070
  static telamenu + #928, #3967
  static telamenu + #929, #3967
  static telamenu + #930, #3967
  static telamenu + #931, #3967
  static telamenu + #932, #3967
  static telamenu + #933, #3967
  static telamenu + #934, #1070
  static telamenu + #935, #3967
  static telamenu + #936, #3967
  static telamenu + #937, #3967
  static telamenu + #938, #3967
  static telamenu + #939, #3967
  static telamenu + #940, #3967
  static telamenu + #941, #3967
  static telamenu + #942, #3967
  static telamenu + #943, #3967
  static telamenu + #944, #3967
  static telamenu + #945, #3967
  static telamenu + #946, #3967
  static telamenu + #947, #3967
  static telamenu + #948, #3967
  static telamenu + #949, #3967
  static telamenu + #950, #3967
  static telamenu + #951, #3967
  static telamenu + #952, #3967
  static telamenu + #953, #3967
  static telamenu + #954, #1070
  static telamenu + #955, #3967
  static telamenu + #956, #3967
  static telamenu + #957, #3967
  static telamenu + #958, #3967
  static telamenu + #959, #1070

  ;Linha 24
  static telamenu + #960, #3967
  static telamenu + #961, #1070
  static telamenu + #962, #3967
  static telamenu + #963, #3967
  static telamenu + #964, #3967
  static telamenu + #965, #3967
  static telamenu + #966, #3967
  static telamenu + #967, #3967
  static telamenu + #968, #3967
  static telamenu + #969, #3967
  static telamenu + #970, #3967
  static telamenu + #971, #3967
  static telamenu + #972, #3967
  static telamenu + #973, #3967
  static telamenu + #974, #3967
  static telamenu + #975, #3967
  static telamenu + #976, #3967
  static telamenu + #977, #3967
  static telamenu + #978, #3967
  static telamenu + #979, #3967
  static telamenu + #980, #1070
  static telamenu + #981, #3967
  static telamenu + #982, #3967
  static telamenu + #983, #3967
  static telamenu + #984, #3967
  static telamenu + #985, #3967
  static telamenu + #986, #3967
  static telamenu + #987, #3967
  static telamenu + #988, #3967
  static telamenu + #989, #3967
  static telamenu + #990, #3967
  static telamenu + #991, #3967
  static telamenu + #992, #3967
  static telamenu + #993, #3967
  static telamenu + #994, #3967
  static telamenu + #995, #3967
  static telamenu + #996, #3967
  static telamenu + #997, #3967
  static telamenu + #998, #3967
  static telamenu + #999, #3967

  ;Linha 25
  static telamenu + #1000, #3967
  static telamenu + #1001, #3967
  static telamenu + #1002, #3967
  static telamenu + #1003, #3967
  static telamenu + #1004, #3967
  static telamenu + #1005, #3967
  static telamenu + #1006, #3967
  static telamenu + #1007, #3967
  static telamenu + #1008, #3967
  static telamenu + #1009, #3967
  static telamenu + #1010, #3967
  static telamenu + #1011, #3967
  static telamenu + #1012, #3967
  static telamenu + #1013, #3967
  static telamenu + #1014, #3967
  static telamenu + #1015, #3967
  static telamenu + #1016, #3967
  static telamenu + #1017, #3967
  static telamenu + #1018, #3967
  static telamenu + #1019, #3967
  static telamenu + #1020, #3967
  static telamenu + #1021, #3967
  static telamenu + #1022, #3967
  static telamenu + #1023, #3967
  static telamenu + #1024, #1070
  static telamenu + #1025, #3967
  static telamenu + #1026, #3967
  static telamenu + #1027, #3967
  static telamenu + #1028, #3967
  static telamenu + #1029, #3967
  static telamenu + #1030, #3967
  static telamenu + #1031, #3967
  static telamenu + #1032, #3967
  static telamenu + #1033, #3967
  static telamenu + #1034, #3967
  static telamenu + #1035, #3967
  static telamenu + #1036, #3967
  static telamenu + #1037, #3967
  static telamenu + #1038, #3967
  static telamenu + #1039, #3967

  ;Linha 26
  static telamenu + #1040, #3967
  static telamenu + #1041, #3967
  static telamenu + #1042, #3967
  static telamenu + #1043, #3967
  static telamenu + #1044, #3967
  static telamenu + #1045, #1070
  static telamenu + #1046, #3967
  static telamenu + #1047, #3967
  static telamenu + #1048, #3967
  static telamenu + #1049, #3967
  static telamenu + #1050, #3967
  static telamenu + #1051, #3967
  static telamenu + #1052, #3967
  static telamenu + #1053, #3967
  static telamenu + #1054, #3967
  static telamenu + #1055, #3967
  static telamenu + #1056, #3967
  static telamenu + #1057, #3967
  static telamenu + #1058, #3967
  static telamenu + #1059, #3967
  static telamenu + #1060, #3967
  static telamenu + #1061, #3967
  static telamenu + #1062, #3967
  static telamenu + #1063, #3967
  static telamenu + #1064, #3967
  static telamenu + #1065, #3967
  static telamenu + #1066, #3967
  static telamenu + #1067, #3967
  static telamenu + #1068, #3967
  static telamenu + #1069, #3967
  static telamenu + #1070, #3967
  static telamenu + #1071, #3967
  static telamenu + #1072, #1070
  static telamenu + #1073, #3967
  static telamenu + #1074, #3967
  static telamenu + #1075, #3967
  static telamenu + #1076, #3967
  static telamenu + #1077, #3967
  static telamenu + #1078, #3967
  static telamenu + #1079, #3967

  ;Linha 27
  static telamenu + #1080, #3967
  static telamenu + #1081, #3967
  static telamenu + #1082, #3967
  static telamenu + #1083, #3967
  static telamenu + #1084, #3967
  static telamenu + #1085, #3967
  static telamenu + #1086, #3967
  static telamenu + #1087, #3967
  static telamenu + #1088, #3967
  static telamenu + #1089, #3967
  static telamenu + #1090, #1070
  static telamenu + #1091, #3967
  static telamenu + #1092, #3967
  static telamenu + #1093, #3967
  static telamenu + #1094, #3967
  static telamenu + #1095, #3967
  static telamenu + #1096, #3967
  static telamenu + #1097, #3967
  static telamenu + #1098, #3967
  static telamenu + #1099, #1070
  static telamenu + #1100, #3967
  static telamenu + #1101, #3967
  static telamenu + #1102, #1070
  static telamenu + #1103, #3967
  static telamenu + #1104, #3967
  static telamenu + #1105, #3967
  static telamenu + #1106, #3967
  static telamenu + #1107, #3967
  static telamenu + #1108, #3967
  static telamenu + #1109, #3967
  static telamenu + #1110, #3967
  static telamenu + #1111, #3967
  static telamenu + #1112, #3967
  static telamenu + #1113, #3967
  static telamenu + #1114, #3967
  static telamenu + #1115, #3967
  static telamenu + #1116, #3967
  static telamenu + #1117, #3967
  static telamenu + #1118, #3967
  static telamenu + #1119, #3967

  ;Linha 28
  static telamenu + #1120, #1070
  static telamenu + #1121, #3967
  static telamenu + #1122, #3967
  static telamenu + #1123, #3967
  static telamenu + #1124, #3967
  static telamenu + #1125, #3967
  static telamenu + #1126, #3967
  static telamenu + #1127, #3967
  static telamenu + #1128, #3967
  static telamenu + #1129, #3967
  static telamenu + #1130, #3967
  static telamenu + #1131, #3967
  static telamenu + #1132, #3967
  static telamenu + #1133, #3967
  static telamenu + #1134, #3967
  static telamenu + #1135, #3967
  static telamenu + #1136, #3967
  static telamenu + #1137, #3967
  static telamenu + #1138, #3967
  static telamenu + #1139, #3967
  static telamenu + #1140, #3967
  static telamenu + #1141, #3967
  static telamenu + #1142, #3967
  static telamenu + #1143, #3967
  static telamenu + #1144, #3967
  static telamenu + #1145, #3967
  static telamenu + #1146, #3967
  static telamenu + #1147, #3967
  static telamenu + #1148, #1070
  static telamenu + #1149, #3967
  static telamenu + #1150, #3967
  static telamenu + #1151, #3967
  static telamenu + #1152, #3967
  static telamenu + #1153, #1070
  static telamenu + #1154, #3967
  static telamenu + #1155, #3967
  static telamenu + #1156, #3967
  static telamenu + #1157, #3967
  static telamenu + #1158, #3967
  static telamenu + #1159, #3967

  ;Linha 29
  static telamenu + #1160, #3967
  static telamenu + #1161, #3967
  static telamenu + #1162, #3967
  static telamenu + #1163, #3967
  static telamenu + #1164, #3967
  static telamenu + #1165, #3967
  static telamenu + #1166, #3967
  static telamenu + #1167, #1070
  static telamenu + #1168, #3967
  static telamenu + #1169, #3967
  static telamenu + #1170, #3967
  static telamenu + #1171, #3967
  static telamenu + #1172, #3967
  static telamenu + #1173, #3967
  static telamenu + #1174, #3967
  static telamenu + #1175, #1070
  static telamenu + #1176, #3967
  static telamenu + #1177, #3967
  static telamenu + #1178, #3967
  static telamenu + #1179, #3967
  static telamenu + #1180, #3967
  static telamenu + #1181, #3967
  static telamenu + #1182, #3967
  static telamenu + #1183, #3967
  static telamenu + #1184, #3967
  static telamenu + #1185, #3967
  static telamenu + #1186, #3967
  static telamenu + #1187, #3967
  static telamenu + #1188, #3967
  static telamenu + #1189, #3967
  static telamenu + #1190, #3967
  static telamenu + #1191, #3967
  static telamenu + #1192, #3967
  static telamenu + #1193, #3967
  static telamenu + #1194, #3967
  static telamenu + #1195, #3967
  static telamenu + #1196, #3967
  static telamenu + #1197, #3967
  static telamenu + #1198, #3967
  static telamenu + #1199, #3967

carregamento : var #1200
  ;Linha 0
  static carregamento + #0, #3967
  static carregamento + #1, #3967
  static carregamento + #2, #3967
  static carregamento + #3, #3967
  static carregamento + #4, #3967
  static carregamento + #5, #3967
  static carregamento + #6, #3967
  static carregamento + #7, #3967
  static carregamento + #8, #3967
  static carregamento + #9, #3967
  static carregamento + #10, #3967
  static carregamento + #11, #3967
  static carregamento + #12, #3967
  static carregamento + #13, #3967
  static carregamento + #14, #3967
  static carregamento + #15, #3967
  static carregamento + #16, #3967
  static carregamento + #17, #3967
  static carregamento + #18, #3967
  static carregamento + #19, #3967
  static carregamento + #20, #3967
  static carregamento + #21, #3967
  static carregamento + #22, #3967
  static carregamento + #23, #1070
  static carregamento + #24, #3967
  static carregamento + #25, #3967
  static carregamento + #26, #3967
  static carregamento + #27, #3967
  static carregamento + #28, #3967
  static carregamento + #29, #3967
  static carregamento + #30, #3967
  static carregamento + #31, #3967
  static carregamento + #32, #3967
  static carregamento + #33, #3967
  static carregamento + #34, #3967
  static carregamento + #35, #3967
  static carregamento + #36, #3967
  static carregamento + #37, #3967
  static carregamento + #38, #3967
  static carregamento + #39, #3967

  ;Linha 1
  static carregamento + #40, #3967
  static carregamento + #41, #3967
  static carregamento + #42, #3967
  static carregamento + #43, #1070
  static carregamento + #44, #3967
  static carregamento + #45, #2128
  static carregamento + #46, #2097
  static carregamento + #47, #3967
  static carregamento + #48, #3967
  static carregamento + #49, #3967
  static carregamento + #50, #3967
  static carregamento + #51, #3967
  static carregamento + #52, #3967
  static carregamento + #53, #3967
  static carregamento + #54, #3967
  static carregamento + #55, #1070
  static carregamento + #56, #3967
  static carregamento + #57, #3967
  static carregamento + #58, #3967
  static carregamento + #59, #3967
  static carregamento + #60, #3967
  static carregamento + #61, #3967
  static carregamento + #62, #3967
  static carregamento + #63, #3967
  static carregamento + #64, #3967
  static carregamento + #65, #3967
  static carregamento + #66, #3967
  static carregamento + #67, #3967
  static carregamento + #68, #1070
  static carregamento + #69, #3967
  static carregamento + #70, #3967
  static carregamento + #71, #3967
  static carregamento + #72, #3967
  static carregamento + #73, #592
  static carregamento + #74, #562
  static carregamento + #75, #3967
  static carregamento + #76, #3967
  static carregamento + #77, #1070
  static carregamento + #78, #3967
  static carregamento + #79, #3967

  ;Linha 2
  static carregamento + #80, #3967
  static carregamento + #81, #1070
  static carregamento + #82, #3967
  static carregamento + #83, #3967
  static carregamento + #84, #3967
  static carregamento + #85, #3967
  static carregamento + #86, #3967
  static carregamento + #87, #3967
  static carregamento + #88, #3967
  static carregamento + #89, #3967
  static carregamento + #90, #3967
  static carregamento + #91, #1070
  static carregamento + #92, #3967
  static carregamento + #93, #3967
  static carregamento + #94, #3967
  static carregamento + #95, #3967
  static carregamento + #96, #3967
  static carregamento + #97, #3967
  static carregamento + #98, #3967
  static carregamento + #99, #3967
  static carregamento + #100, #3967
  static carregamento + #101, #3967
  static carregamento + #102, #3967
  static carregamento + #103, #3967
  static carregamento + #104, #3967
  static carregamento + #105, #3967
  static carregamento + #106, #3967
  static carregamento + #107, #3967
  static carregamento + #108, #3967
  static carregamento + #109, #3967
  static carregamento + #110, #3967
  static carregamento + #111, #3967
  static carregamento + #112, #3967
  static carregamento + #113, #3967
  static carregamento + #114, #3967
  static carregamento + #115, #3967
  static carregamento + #116, #3967
  static carregamento + #117, #3967
  static carregamento + #118, #3967
  static carregamento + #119, #3967

  ;Linha 3
  static carregamento + #120, #3967
  static carregamento + #121, #3967
  static carregamento + #122, #3967
  static carregamento + #123, #3967
  static carregamento + #124, #3967
  static carregamento + #125, #2048
  static carregamento + #126, #2048
  static carregamento + #127, #3967
  static carregamento + #128, #1070
  static carregamento + #129, #3967
  static carregamento + #130, #3967
  static carregamento + #131, #3967
  static carregamento + #132, #3967
  static carregamento + #133, #3967
  static carregamento + #134, #3967
  static carregamento + #135, #3967
  static carregamento + #136, #3967
  static carregamento + #137, #3967
  static carregamento + #138, #3967
  static carregamento + #139, #3967
  static carregamento + #140, #3967
  static carregamento + #141, #3967
  static carregamento + #142, #3967
  static carregamento + #143, #3967
  static carregamento + #144, #3967
  static carregamento + #145, #3967
  static carregamento + #146, #1070
  static carregamento + #147, #3967
  static carregamento + #148, #3967
  static carregamento + #149, #3967
  static carregamento + #150, #512
  static carregamento + #151, #512
  static carregamento + #152, #3967
  static carregamento + #153, #3967
  static carregamento + #154, #3967
  static carregamento + #155, #3967
  static carregamento + #156, #512
  static carregamento + #157, #512
  static carregamento + #158, #3967
  static carregamento + #159, #3967

  ;Linha 4
  static carregamento + #160, #3967
  static carregamento + #161, #3967
  static carregamento + #162, #3967
  static carregamento + #163, #3967
  static carregamento + #164, #3967
  static carregamento + #165, #2048
  static carregamento + #166, #2048
  static carregamento + #167, #3967
  static carregamento + #168, #3967
  static carregamento + #169, #3967
  static carregamento + #170, #3967
  static carregamento + #171, #3967
  static carregamento + #172, #3967
  static carregamento + #173, #3967
  static carregamento + #174, #3967
  static carregamento + #175, #3967
  static carregamento + #176, #3967
  static carregamento + #177, #1070
  static carregamento + #178, #3967
  static carregamento + #179, #3967
  static carregamento + #180, #3967
  static carregamento + #181, #3967
  static carregamento + #182, #3967
  static carregamento + #183, #3967
  static carregamento + #184, #3967
  static carregamento + #185, #3967
  static carregamento + #186, #3967
  static carregamento + #187, #3967
  static carregamento + #188, #3967
  static carregamento + #189, #3967
  static carregamento + #190, #3967
  static carregamento + #191, #3967
  static carregamento + #192, #512
  static carregamento + #193, #3967
  static carregamento + #194, #3967
  static carregamento + #195, #512
  static carregamento + #196, #3967
  static carregamento + #197, #3967
  static carregamento + #198, #1070
  static carregamento + #199, #3967

  ;Linha 5
  static carregamento + #200, #3967
  static carregamento + #201, #3967
  static carregamento + #202, #3967
  static carregamento + #203, #3967
  static carregamento + #204, #3967
  static carregamento + #205, #2048
  static carregamento + #206, #2048
  static carregamento + #207, #3967
  static carregamento + #208, #3967
  static carregamento + #209, #3967
  static carregamento + #210, #3967
  static carregamento + #211, #3967
  static carregamento + #212, #3967
  static carregamento + #213, #3967
  static carregamento + #214, #3967
  static carregamento + #215, #3967
  static carregamento + #216, #3967
  static carregamento + #217, #3967
  static carregamento + #218, #3967
  static carregamento + #219, #3967
  static carregamento + #220, #3967
  static carregamento + #221, #3967
  static carregamento + #222, #3967
  static carregamento + #223, #1070
  static carregamento + #224, #3967
  static carregamento + #225, #3967
  static carregamento + #226, #3967
  static carregamento + #227, #3967
  static carregamento + #228, #3967
  static carregamento + #229, #3967
  static carregamento + #230, #3967
  static carregamento + #231, #3967
  static carregamento + #232, #512
  static carregamento + #233, #512
  static carregamento + #234, #512
  static carregamento + #235, #512
  static carregamento + #236, #3967
  static carregamento + #237, #3967
  static carregamento + #238, #3967
  static carregamento + #239, #3967

  ;Linha 6
  static carregamento + #240, #3967
  static carregamento + #241, #3967
  static carregamento + #242, #2048
  static carregamento + #243, #3967
  static carregamento + #244, #3967
  static carregamento + #245, #2048
  static carregamento + #246, #2048
  static carregamento + #247, #3967
  static carregamento + #248, #3967
  static carregamento + #249, #2048
  static carregamento + #250, #3967
  static carregamento + #251, #3967
  static carregamento + #252, #3967
  static carregamento + #253, #3967
  static carregamento + #254, #3967
  static carregamento + #255, #3967
  static carregamento + #256, #3967
  static carregamento + #257, #3967
  static carregamento + #258, #3967
  static carregamento + #259, #3967
  static carregamento + #260, #3967
  static carregamento + #261, #3967
  static carregamento + #262, #3967
  static carregamento + #263, #3967
  static carregamento + #264, #3967
  static carregamento + #265, #3967
  static carregamento + #266, #3967
  static carregamento + #267, #3967
  static carregamento + #268, #3967
  static carregamento + #269, #3967
  static carregamento + #270, #3967
  static carregamento + #271, #512
  static carregamento + #272, #3967
  static carregamento + #273, #512
  static carregamento + #274, #512
  static carregamento + #275, #3967
  static carregamento + #276, #512
  static carregamento + #277, #3967
  static carregamento + #278, #3967
  static carregamento + #279, #3967

  ;Linha 7
  static carregamento + #280, #3967
  static carregamento + #281, #3967
  static carregamento + #282, #2048
  static carregamento + #283, #3967
  static carregamento + #284, #2048
  static carregamento + #285, #2048
  static carregamento + #286, #2048
  static carregamento + #287, #2048
  static carregamento + #288, #3967
  static carregamento + #289, #2048
  static carregamento + #290, #3967
  static carregamento + #291, #3967
  static carregamento + #292, #3967
  static carregamento + #293, #3967
  static carregamento + #294, #3967
  static carregamento + #295, #3967
  static carregamento + #296, #3967
  static carregamento + #297, #3967
  static carregamento + #298, #3967
  static carregamento + #299, #3967
  static carregamento + #300, #3967
  static carregamento + #301, #3967
  static carregamento + #302, #3967
  static carregamento + #303, #3967
  static carregamento + #304, #3967
  static carregamento + #305, #3967
  static carregamento + #306, #3967
  static carregamento + #307, #3967
  static carregamento + #308, #3967
  static carregamento + #309, #3967
  static carregamento + #310, #512
  static carregamento + #311, #512
  static carregamento + #312, #512
  static carregamento + #313, #512
  static carregamento + #314, #512
  static carregamento + #315, #512
  static carregamento + #316, #512
  static carregamento + #317, #512
  static carregamento + #318, #3967
  static carregamento + #319, #3967

  ;Linha 8
  static carregamento + #320, #3967
  static carregamento + #321, #3967
  static carregamento + #322, #2048
  static carregamento + #323, #2048
  static carregamento + #324, #2048
  static carregamento + #325, #2048
  static carregamento + #326, #2048
  static carregamento + #327, #2048
  static carregamento + #328, #2048
  static carregamento + #329, #2048
  static carregamento + #330, #3967
  static carregamento + #331, #3967
  static carregamento + #332, #3967
  static carregamento + #333, #3967
  static carregamento + #334, #3967
  static carregamento + #335, #3967
  static carregamento + #336, #3967
  static carregamento + #337, #3967
  static carregamento + #338, #3967
  static carregamento + #339, #3967
  static carregamento + #340, #3967
  static carregamento + #341, #3967
  static carregamento + #342, #3967
  static carregamento + #343, #3967
  static carregamento + #344, #3967
  static carregamento + #345, #3967
  static carregamento + #346, #3967
  static carregamento + #347, #3967
  static carregamento + #348, #3967
  static carregamento + #349, #3967
  static carregamento + #350, #512
  static carregamento + #351, #3967
  static carregamento + #352, #512
  static carregamento + #353, #512
  static carregamento + #354, #512
  static carregamento + #355, #512
  static carregamento + #356, #3967
  static carregamento + #357, #512
  static carregamento + #358, #3967
  static carregamento + #359, #3967

  ;Linha 9
  static carregamento + #360, #3967
  static carregamento + #361, #3967
  static carregamento + #362, #2048
  static carregamento + #363, #2048
  static carregamento + #364, #3967
  static carregamento + #365, #2048
  static carregamento + #366, #2048
  static carregamento + #367, #3967
  static carregamento + #368, #2048
  static carregamento + #369, #2048
  static carregamento + #370, #3967
  static carregamento + #371, #3967
  static carregamento + #372, #3967
  static carregamento + #373, #3967
  static carregamento + #374, #3967
  static carregamento + #375, #1024
  static carregamento + #376, #3967
  static carregamento + #377, #1070
  static carregamento + #378, #3967
  static carregamento + #379, #1024
  static carregamento + #380, #3967
  static carregamento + #381, #3967
  static carregamento + #382, #1024
  static carregamento + #383, #1024
  static carregamento + #384, #3967
  static carregamento + #385, #3967
  static carregamento + #386, #1070
  static carregamento + #387, #3967
  static carregamento + #388, #3967
  static carregamento + #389, #3967
  static carregamento + #390, #512
  static carregamento + #391, #3967
  static carregamento + #392, #512
  static carregamento + #393, #3967
  static carregamento + #394, #3967
  static carregamento + #395, #512
  static carregamento + #396, #3967
  static carregamento + #397, #512
  static carregamento + #398, #3967
  static carregamento + #399, #3967

  ;Linha 10
  static carregamento + #400, #1070
  static carregamento + #401, #3967
  static carregamento + #402, #2048
  static carregamento + #403, #3967
  static carregamento + #404, #3967
  static carregamento + #405, #3967
  static carregamento + #406, #3967
  static carregamento + #407, #3967
  static carregamento + #408, #3967
  static carregamento + #409, #2048
  static carregamento + #410, #3967
  static carregamento + #411, #3967
  static carregamento + #412, #1070
  static carregamento + #413, #3967
  static carregamento + #414, #3967
  static carregamento + #415, #1024
  static carregamento + #416, #3967
  static carregamento + #417, #3967
  static carregamento + #418, #3967
  static carregamento + #419, #1024
  static carregamento + #420, #3967
  static carregamento + #421, #1024
  static carregamento + #422, #3967
  static carregamento + #423, #3967
  static carregamento + #424, #1024
  static carregamento + #425, #3967
  static carregamento + #426, #3967
  static carregamento + #427, #3967
  static carregamento + #428, #3967
  static carregamento + #429, #3967
  static carregamento + #430, #3967
  static carregamento + #431, #3967
  static carregamento + #432, #512
  static carregamento + #433, #3967
  static carregamento + #434, #3967
  static carregamento + #435, #512
  static carregamento + #436, #3967
  static carregamento + #437, #3967
  static carregamento + #438, #3967
  static carregamento + #439, #3967

  ;Linha 11
  static carregamento + #440, #3967
  static carregamento + #441, #3967
  static carregamento + #442, #3967
  static carregamento + #443, #3967
  static carregamento + #444, #1070
  static carregamento + #445, #3967
  static carregamento + #446, #3967
  static carregamento + #447, #3967
  static carregamento + #448, #3967
  static carregamento + #449, #3967
  static carregamento + #450, #3967
  static carregamento + #451, #3967
  static carregamento + #452, #3967
  static carregamento + #453, #3967
  static carregamento + #454, #3967
  static carregamento + #455, #1024
  static carregamento + #456, #3967
  static carregamento + #457, #3967
  static carregamento + #458, #3967
  static carregamento + #459, #1024
  static carregamento + #460, #3967
  static carregamento + #461, #1024
  static carregamento + #462, #3967
  static carregamento + #463, #3967
  static carregamento + #464, #3967
  static carregamento + #465, #3967
  static carregamento + #466, #3967
  static carregamento + #467, #3967
  static carregamento + #468, #3967
  static carregamento + #469, #3967
  static carregamento + #470, #3967
  static carregamento + #471, #3967
  static carregamento + #472, #3967
  static carregamento + #473, #3967
  static carregamento + #474, #3967
  static carregamento + #475, #3967
  static carregamento + #476, #3967
  static carregamento + #477, #3967
  static carregamento + #478, #3967
  static carregamento + #479, #3967

  ;Linha 12
  static carregamento + #480, #3967
  static carregamento + #481, #3967
  static carregamento + #482, #3967
  static carregamento + #483, #3967
  static carregamento + #484, #3967
  static carregamento + #485, #3967
  static carregamento + #486, #3967
  static carregamento + #487, #3967
  static carregamento + #488, #3967
  static carregamento + #489, #3967
  static carregamento + #490, #3967
  static carregamento + #491, #3967
  static carregamento + #492, #3967
  static carregamento + #493, #3967
  static carregamento + #494, #3967
  static carregamento + #495, #1024
  static carregamento + #496, #3967
  static carregamento + #497, #3967
  static carregamento + #498, #3967
  static carregamento + #499, #1024
  static carregamento + #500, #3967
  static carregamento + #501, #3967
  static carregamento + #502, #1024
  static carregamento + #503, #1024
  static carregamento + #504, #3967
  static carregamento + #505, #3967
  static carregamento + #506, #3967
  static carregamento + #507, #3967
  static carregamento + #508, #3967
  static carregamento + #509, #3967
  static carregamento + #510, #3967
  static carregamento + #511, #3967
  static carregamento + #512, #3967
  static carregamento + #513, #3967
  static carregamento + #514, #3967
  static carregamento + #515, #3967
  static carregamento + #516, #3967
  static carregamento + #517, #3967
  static carregamento + #518, #3967
  static carregamento + #519, #3967

  ;Linha 13
  static carregamento + #520, #3967
  static carregamento + #521, #3967
  static carregamento + #522, #3967
  static carregamento + #523, #3967
  static carregamento + #524, #3967
  static carregamento + #525, #3967
  static carregamento + #526, #3967
  static carregamento + #527, #3967
  static carregamento + #528, #3967
  static carregamento + #529, #3967
  static carregamento + #530, #3967
  static carregamento + #531, #3967
  static carregamento + #532, #3967
  static carregamento + #533, #3967
  static carregamento + #534, #3967
  static carregamento + #535, #1024
  static carregamento + #536, #3967
  static carregamento + #537, #3967
  static carregamento + #538, #3967
  static carregamento + #539, #1024
  static carregamento + #540, #3967
  static carregamento + #541, #3967
  static carregamento + #542, #3967
  static carregamento + #543, #3967
  static carregamento + #544, #1024
  static carregamento + #545, #3967
  static carregamento + #546, #3967
  static carregamento + #547, #3967
  static carregamento + #548, #3967
  static carregamento + #549, #1070
  static carregamento + #550, #3967
  static carregamento + #551, #3967
  static carregamento + #552, #3967
  static carregamento + #553, #3967
  static carregamento + #554, #3967
  static carregamento + #555, #3967
  static carregamento + #556, #3967
  static carregamento + #557, #3967
  static carregamento + #558, #1070
  static carregamento + #559, #3967

  ;Linha 14
  static carregamento + #560, #3967
  static carregamento + #561, #1070
  static carregamento + #562, #3967
  static carregamento + #563, #3967
  static carregamento + #564, #2125
  static carregamento + #565, #2159
  static carregamento + #566, #2166
  static carregamento + #567, #2106
  static carregamento + #568, #3967
  static carregamento + #569, #1070
  static carregamento + #570, #3967
  static carregamento + #571, #3967
  static carregamento + #572, #3967
  static carregamento + #573, #3967
  static carregamento + #574, #3967
  static carregamento + #575, #3967
  static carregamento + #576, #1024
  static carregamento + #577, #3967
  static carregamento + #578, #1024
  static carregamento + #579, #3967
  static carregamento + #580, #3967
  static carregamento + #581, #1024
  static carregamento + #582, #3967
  static carregamento + #583, #3967
  static carregamento + #584, #1024
  static carregamento + #585, #3967
  static carregamento + #586, #3967
  static carregamento + #587, #3967
  static carregamento + #588, #3967
  static carregamento + #589, #3967
  static carregamento + #590, #3967
  static carregamento + #591, #3967
  static carregamento + #592, #589
  static carregamento + #593, #623
  static carregamento + #594, #630
  static carregamento + #595, #570
  static carregamento + #596, #3967
  static carregamento + #597, #3967
  static carregamento + #598, #3967
  static carregamento + #599, #3967

  ;Linha 15
  static carregamento + #600, #3967
  static carregamento + #601, #3967
  static carregamento + #602, #3967
  static carregamento + #603, #3967
  static carregamento + #604, #3967
  static carregamento + #605, #3967
  static carregamento + #606, #3967
  static carregamento + #607, #3967
  static carregamento + #608, #3967
  static carregamento + #609, #3967
  static carregamento + #610, #3967
  static carregamento + #611, #3967
  static carregamento + #612, #3967
  static carregamento + #613, #1070
  static carregamento + #614, #3967
  static carregamento + #615, #3967
  static carregamento + #616, #3967
  static carregamento + #617, #1024
  static carregamento + #618, #3967
  static carregamento + #619, #3967
  static carregamento + #620, #3967
  static carregamento + #621, #3967
  static carregamento + #622, #1024
  static carregamento + #623, #1024
  static carregamento + #624, #3967
  static carregamento + #625, #3967
  static carregamento + #626, #3967
  static carregamento + #627, #1070
  static carregamento + #628, #3967
  static carregamento + #629, #3967
  static carregamento + #630, #3967
  static carregamento + #631, #3967
  static carregamento + #632, #3967
  static carregamento + #633, #3967
  static carregamento + #634, #3967
  static carregamento + #635, #3967
  static carregamento + #636, #3967
  static carregamento + #637, #3967
  static carregamento + #638, #3967
  static carregamento + #639, #3967

  ;Linha 16
  static carregamento + #640, #3967
  static carregamento + #641, #3967
  static carregamento + #642, #3967
  static carregamento + #643, #3967
  static carregamento + #644, #3967
  static carregamento + #645, #3967
  static carregamento + #646, #3967
  static carregamento + #647, #3967
  static carregamento + #648, #3967
  static carregamento + #649, #3967
  static carregamento + #650, #3967
  static carregamento + #651, #3967
  static carregamento + #652, #3967
  static carregamento + #653, #3967
  static carregamento + #654, #3967
  static carregamento + #655, #3967
  static carregamento + #656, #3967
  static carregamento + #657, #3967
  static carregamento + #658, #3967
  static carregamento + #659, #3967
  static carregamento + #660, #3967
  static carregamento + #661, #3967
  static carregamento + #662, #3967
  static carregamento + #663, #3967
  static carregamento + #664, #3967
  static carregamento + #665, #3967
  static carregamento + #666, #3967
  static carregamento + #667, #3967
  static carregamento + #668, #3967
  static carregamento + #669, #3967
  static carregamento + #670, #3967
  static carregamento + #671, #3967
  static carregamento + #672, #3967
  static carregamento + #673, #3967
  static carregamento + #674, #3967
  static carregamento + #675, #3967
  static carregamento + #676, #3967
  static carregamento + #677, #3967
  static carregamento + #678, #3967
  static carregamento + #679, #3967

  ;Linha 17
  static carregamento + #680, #3967
  static carregamento + #681, #3967
  static carregamento + #682, #3967
  static carregamento + #683, #3967
  static carregamento + #684, #3967
  static carregamento + #685, #2135
  static carregamento + #686, #3967
  static carregamento + #687, #3967
  static carregamento + #688, #3967
  static carregamento + #689, #3967
  static carregamento + #690, #3967
  static carregamento + #691, #3967
  static carregamento + #692, #3967
  static carregamento + #693, #3967
  static carregamento + #694, #3967
  static carregamento + #695, #3967
  static carregamento + #696, #3967
  static carregamento + #697, #3967
  static carregamento + #698, #3967
  static carregamento + #699, #3967
  static carregamento + #700, #3967
  static carregamento + #701, #1070
  static carregamento + #702, #3967
  static carregamento + #703, #3967
  static carregamento + #704, #1070
  static carregamento + #705, #3967
  static carregamento + #706, #3967
  static carregamento + #707, #3967
  static carregamento + #708, #3967
  static carregamento + #709, #3967
  static carregamento + #710, #3967
  static carregamento + #711, #3967
  static carregamento + #712, #3967
  static carregamento + #713, #3967
  static carregamento + #714, #585
  static carregamento + #715, #3967
  static carregamento + #716, #3967
  static carregamento + #717, #1070
  static carregamento + #718, #3967
  static carregamento + #719, #3967

  ;Linha 18
  static carregamento + #720, #3967
  static carregamento + #721, #3967
  static carregamento + #722, #3967
  static carregamento + #723, #3967
  static carregamento + #724, #3967
  static carregamento + #725, #3967
  static carregamento + #726, #3967
  static carregamento + #727, #3967
  static carregamento + #728, #3967
  static carregamento + #729, #3967
  static carregamento + #730, #3967
  static carregamento + #731, #3967
  static carregamento + #732, #3967
  static carregamento + #733, #1070
  static carregamento + #734, #3967
  static carregamento + #735, #1069
  static carregamento + #736, #1069
  static carregamento + #737, #1069
  static carregamento + #738, #1069
  static carregamento + #739, #1069
  static carregamento + #740, #1069
  static carregamento + #741, #1069
  static carregamento + #742, #1069
  static carregamento + #743, #1069
  static carregamento + #744, #1069
  static carregamento + #745, #3967
  static carregamento + #746, #3967
  static carregamento + #747, #3967
  static carregamento + #748, #3967
  static carregamento + #749, #3967
  static carregamento + #750, #3967
  static carregamento + #751, #3967
  static carregamento + #752, #3967
  static carregamento + #753, #3967
  static carregamento + #754, #3967
  static carregamento + #755, #3967
  static carregamento + #756, #3967
  static carregamento + #757, #3967
  static carregamento + #758, #3967
  static carregamento + #759, #3967

  ;Linha 19
  static carregamento + #760, #3967
  static carregamento + #761, #3967
  static carregamento + #762, #3967
  static carregamento + #763, #2113
  static carregamento + #764, #3967
  static carregamento + #765, #2131
  static carregamento + #766, #3967
  static carregamento + #767, #2116
  static carregamento + #768, #3967
  static carregamento + #769, #3967
  static carregamento + #770, #3967
  static carregamento + #771, #3967
  static carregamento + #772, #3967
  static carregamento + #773, #3967
  static carregamento + #774, #3967
  static carregamento + #775, #1091
  static carregamento + #776, #1089
  static carregamento + #777, #1106
  static carregamento + #778, #1106
  static carregamento + #779, #1093
  static carregamento + #780, #1095
  static carregamento + #781, #1089
  static carregamento + #782, #1102
  static carregamento + #783, #1092
  static carregamento + #784, #1103
  static carregamento + #785, #3967
  static carregamento + #786, #3967
  static carregamento + #787, #3967
  static carregamento + #788, #3967
  static carregamento + #789, #3967
  static carregamento + #790, #3967
  static carregamento + #791, #3967
  static carregamento + #792, #586
  static carregamento + #793, #3967
  static carregamento + #794, #587
  static carregamento + #795, #3967
  static carregamento + #796, #588
  static carregamento + #797, #3967
  static carregamento + #798, #3967
  static carregamento + #799, #3967

  ;Linha 20
  static carregamento + #800, #3967
  static carregamento + #801, #3967
  static carregamento + #802, #3967
  static carregamento + #803, #3967
  static carregamento + #804, #3967
  static carregamento + #805, #3967
  static carregamento + #806, #3967
  static carregamento + #807, #3967
  static carregamento + #808, #3967
  static carregamento + #809, #3967
  static carregamento + #810, #3967
  static carregamento + #811, #3967
  static carregamento + #812, #3967
  static carregamento + #813, #3967
  static carregamento + #814, #3967
  static carregamento + #815, #1069
  static carregamento + #816, #1069
  static carregamento + #817, #1069
  static carregamento + #818, #1069
  static carregamento + #819, #1069
  static carregamento + #820, #1069
  static carregamento + #821, #1069
  static carregamento + #822, #1069
  static carregamento + #823, #1069
  static carregamento + #824, #1069
  static carregamento + #825, #3967
  static carregamento + #826, #3967
  static carregamento + #827, #3967
  static carregamento + #828, #1070
  static carregamento + #829, #3967
  static carregamento + #830, #3967
  static carregamento + #831, #3967
  static carregamento + #832, #3967
  static carregamento + #833, #3967
  static carregamento + #834, #3967
  static carregamento + #835, #3967
  static carregamento + #836, #3967
  static carregamento + #837, #3967
  static carregamento + #838, #3967
  static carregamento + #839, #3967

  ;Linha 21
  static carregamento + #840, #3967
  static carregamento + #841, #1070
  static carregamento + #842, #3967
  static carregamento + #843, #3967
  static carregamento + #844, #1070
  static carregamento + #845, #3967
  static carregamento + #846, #3967
  static carregamento + #847, #3967
  static carregamento + #848, #3967
  static carregamento + #849, #3967
  static carregamento + #850, #3967
  static carregamento + #851, #3967
  static carregamento + #852, #3967
  static carregamento + #853, #3967
  static carregamento + #854, #3967
  static carregamento + #855, #3967
  static carregamento + #856, #3967
  static carregamento + #857, #3967
  static carregamento + #858, #3967
  static carregamento + #859, #3967
  static carregamento + #860, #3967
  static carregamento + #861, #3967
  static carregamento + #862, #3967
  static carregamento + #863, #3967
  static carregamento + #864, #3967
  static carregamento + #865, #3967
  static carregamento + #866, #3967
  static carregamento + #867, #3967
  static carregamento + #868, #3967
  static carregamento + #869, #3967
  static carregamento + #870, #3967
  static carregamento + #871, #3967
  static carregamento + #872, #3967
  static carregamento + #873, #3967
  static carregamento + #874, #1070
  static carregamento + #875, #3967
  static carregamento + #876, #3967
  static carregamento + #877, #3967
  static carregamento + #878, #3967
  static carregamento + #879, #1070

  ;Linha 22
  static carregamento + #880, #3967
  static carregamento + #881, #3967
  static carregamento + #882, #3967
  static carregamento + #883, #3967
  static carregamento + #884, #3967
  static carregamento + #885, #3967
  static carregamento + #886, #3967
  static carregamento + #887, #3967
  static carregamento + #888, #3967
  static carregamento + #889, #3967
  static carregamento + #890, #3967
  static carregamento + #891, #1070
  static carregamento + #892, #3967
  static carregamento + #893, #3967
  static carregamento + #894, #3967
  static carregamento + #895, #3967
  static carregamento + #896, #3967
  static carregamento + #897, #3967
  static carregamento + #898, #3967
  static carregamento + #899, #3967
  static carregamento + #900, #1070
  static carregamento + #901, #3967
  static carregamento + #902, #3967
  static carregamento + #903, #3967
  static carregamento + #904, #3967
  static carregamento + #905, #3967
  static carregamento + #906, #3967
  static carregamento + #907, #3967
  static carregamento + #908, #3967
  static carregamento + #909, #3967
  static carregamento + #910, #3967
  static carregamento + #911, #3967
  static carregamento + #912, #3967
  static carregamento + #913, #3967
  static carregamento + #914, #3967
  static carregamento + #915, #3967
  static carregamento + #916, #3967
  static carregamento + #917, #3967
  static carregamento + #918, #3967
  static carregamento + #919, #3967

  ;Linha 23
  static carregamento + #920, #3967
  static carregamento + #921, #3967
  static carregamento + #922, #3967
  static carregamento + #923, #2131
  static carregamento + #924, #2152
  static carregamento + #925, #2159
  static carregamento + #926, #2159
  static carregamento + #927, #2164
  static carregamento + #928, #2106
  static carregamento + #929, #3967
  static carregamento + #930, #3967
  static carregamento + #931, #3967
  static carregamento + #932, #3967
  static carregamento + #933, #3967
  static carregamento + #934, #3967
  static carregamento + #935, #3967
  static carregamento + #936, #3967
  static carregamento + #937, #3967
  static carregamento + #938, #3967
  static carregamento + #939, #3967
  static carregamento + #940, #3967
  static carregamento + #941, #3967
  static carregamento + #942, #3967
  static carregamento + #943, #3967
  static carregamento + #944, #3967
  static carregamento + #945, #1070
  static carregamento + #946, #3967
  static carregamento + #947, #3967
  static carregamento + #948, #3967
  static carregamento + #949, #3967
  static carregamento + #950, #3967
  static carregamento + #951, #595
  static carregamento + #952, #616
  static carregamento + #953, #623
  static carregamento + #954, #623
  static carregamento + #955, #628
  static carregamento + #956, #570
  static carregamento + #957, #3967
  static carregamento + #958, #3967
  static carregamento + #959, #3967

  ;Linha 24
  static carregamento + #960, #3967
  static carregamento + #961, #3967
  static carregamento + #962, #3967
  static carregamento + #963, #3967
  static carregamento + #964, #3967
  static carregamento + #965, #3967
  static carregamento + #966, #3967
  static carregamento + #967, #3967
  static carregamento + #968, #3967
  static carregamento + #969, #3967
  static carregamento + #970, #3967
  static carregamento + #971, #3967
  static carregamento + #972, #3967
  static carregamento + #973, #3967
  static carregamento + #974, #3967
  static carregamento + #975, #3967
  static carregamento + #976, #3967
  static carregamento + #977, #3967
  static carregamento + #978, #3967
  static carregamento + #979, #3967
  static carregamento + #980, #3967
  static carregamento + #981, #3967
  static carregamento + #982, #3967
  static carregamento + #983, #3967
  static carregamento + #984, #3967
  static carregamento + #985, #3967
  static carregamento + #986, #1070
  static carregamento + #987, #3967
  static carregamento + #988, #3967
  static carregamento + #989, #3967
  static carregamento + #990, #3967
  static carregamento + #991, #3967
  static carregamento + #992, #3967
  static carregamento + #993, #3967
  static carregamento + #994, #3967
  static carregamento + #995, #3967
  static carregamento + #996, #3967
  static carregamento + #997, #3967
  static carregamento + #998, #3967
  static carregamento + #999, #3967

  ;Linha 25
  static carregamento + #1000, #3967
  static carregamento + #1001, #3967
  static carregamento + #1002, #3967
  static carregamento + #1003, #3967
  static carregamento + #1004, #3967
  static carregamento + #1005, #3967
  static carregamento + #1006, #3967
  static carregamento + #1007, #3967
  static carregamento + #1008, #3967
  static carregamento + #1009, #3967
  static carregamento + #1010, #3967
  static carregamento + #1011, #3967
  static carregamento + #1012, #3967
  static carregamento + #1013, #3967
  static carregamento + #1014, #1070
  static carregamento + #1015, #3967
  static carregamento + #1016, #3967
  static carregamento + #1017, #3967
  static carregamento + #1018, #3967
  static carregamento + #1019, #3967
  static carregamento + #1020, #3967
  static carregamento + #1021, #3967
  static carregamento + #1022, #3967
  static carregamento + #1023, #3967
  static carregamento + #1024, #3967
  static carregamento + #1025, #3967
  static carregamento + #1026, #3967
  static carregamento + #1027, #3967
  static carregamento + #1028, #3967
  static carregamento + #1029, #3967
  static carregamento + #1030, #3967
  static carregamento + #1031, #3967
  static carregamento + #1032, #3967
  static carregamento + #1033, #3967
  static carregamento + #1034, #3967
  static carregamento + #1035, #3967
  static carregamento + #1036, #3967
  static carregamento + #1037, #3967
  static carregamento + #1038, #3967
  static carregamento + #1039, #3967

  ;Linha 26
  static carregamento + #1040, #3967
  static carregamento + #1041, #3967
  static carregamento + #1042, #3967
  static carregamento + #1043, #3967
  static carregamento + #1044, #3967
  static carregamento + #1045, #2117
  static carregamento + #1046, #3967
  static carregamento + #1047, #3967
  static carregamento + #1048, #3967
  static carregamento + #1049, #3967
  static carregamento + #1050, #3967
  static carregamento + #1051, #3967
  static carregamento + #1052, #3967
  static carregamento + #1053, #3967
  static carregamento + #1054, #3967
  static carregamento + #1055, #3967
  static carregamento + #1056, #3967
  static carregamento + #1057, #3967
  static carregamento + #1058, #1070
  static carregamento + #1059, #3967
  static carregamento + #1060, #3967
  static carregamento + #1061, #3967
  static carregamento + #1062, #3967
  static carregamento + #1063, #3967
  static carregamento + #1064, #3967
  static carregamento + #1065, #3967
  static carregamento + #1066, #3967
  static carregamento + #1067, #3967
  static carregamento + #1068, #3967
  static carregamento + #1069, #3967
  static carregamento + #1070, #3967
  static carregamento + #1071, #3967
  static carregamento + #1072, #3967
  static carregamento + #1073, #3967
  static carregamento + #1074, #592
  static carregamento + #1075, #3967
  static carregamento + #1076, #3967
  static carregamento + #1077, #3967
  static carregamento + #1078, #1070
  static carregamento + #1079, #3967

  ;Linha 27
  static carregamento + #1080, #3967
  static carregamento + #1081, #3967
  static carregamento + #1082, #1070
  static carregamento + #1083, #3967
  static carregamento + #1084, #3967
  static carregamento + #1085, #3967
  static carregamento + #1086, #3967
  static carregamento + #1087, #3967
  static carregamento + #1088, #3967
  static carregamento + #1089, #3967
  static carregamento + #1090, #3967
  static carregamento + #1091, #3967
  static carregamento + #1092, #3967
  static carregamento + #1093, #3967
  static carregamento + #1094, #3967
  static carregamento + #1095, #3967
  static carregamento + #1096, #3967
  static carregamento + #1097, #3967
  static carregamento + #1098, #3967
  static carregamento + #1099, #3967
  static carregamento + #1100, #3967
  static carregamento + #1101, #3967
  static carregamento + #1102, #3967
  static carregamento + #1103, #3967
  static carregamento + #1104, #3967
  static carregamento + #1105, #3967
  static carregamento + #1106, #3967
  static carregamento + #1107, #3967
  static carregamento + #1108, #1070
  static carregamento + #1109, #3967
  static carregamento + #1110, #3967
  static carregamento + #1111, #3967
  static carregamento + #1112, #3967
  static carregamento + #1113, #3967
  static carregamento + #1114, #3967
  static carregamento + #1115, #3967
  static carregamento + #1116, #3967
  static carregamento + #1117, #3967
  static carregamento + #1118, #3967
  static carregamento + #1119, #3967

  ;Linha 28
  static carregamento + #1120, #3967
  static carregamento + #1121, #3967
  static carregamento + #1122, #3967
  static carregamento + #1123, #3967
  static carregamento + #1124, #3967
  static carregamento + #1125, #3967
  static carregamento + #1126, #3967
  static carregamento + #1127, #3967
  static carregamento + #1128, #3967
  static carregamento + #1129, #3967
  static carregamento + #1130, #3967
  static carregamento + #1131, #1070
  static carregamento + #1132, #3967
  static carregamento + #1133, #3967
  static carregamento + #1134, #3967
  static carregamento + #1135, #3967
  static carregamento + #1136, #3967
  static carregamento + #1137, #3967
  static carregamento + #1138, #3967
  static carregamento + #1139, #3967
  static carregamento + #1140, #3967
  static carregamento + #1141, #3967
  static carregamento + #1142, #1070
  static carregamento + #1143, #3967
  static carregamento + #1144, #3967
  static carregamento + #1145, #3967
  static carregamento + #1146, #3967
  static carregamento + #1147, #3967
  static carregamento + #1148, #3967
  static carregamento + #1149, #3967
  static carregamento + #1150, #3967
  static carregamento + #1151, #3967
  static carregamento + #1152, #3967
  static carregamento + #1153, #3967
  static carregamento + #1154, #3967
  static carregamento + #1155, #3967
  static carregamento + #1156, #3967
  static carregamento + #1157, #3967
  static carregamento + #1158, #3967
  static carregamento + #1159, #3967

  ;Linha 29
  static carregamento + #1160, #3967
  static carregamento + #1161, #3967
  static carregamento + #1162, #3967
  static carregamento + #1163, #3967
  static carregamento + #1164, #3967
  static carregamento + #1165, #3967
  static carregamento + #1166, #3967
  static carregamento + #1167, #3967
  static carregamento + #1168, #3967
  static carregamento + #1169, #3967
  static carregamento + #1170, #3967
  static carregamento + #1171, #3967
  static carregamento + #1172, #3967
  static carregamento + #1173, #3967
  static carregamento + #1174, #3967
  static carregamento + #1175, #3967
  static carregamento + #1176, #3967
  static carregamento + #1177, #3967
  static carregamento + #1178, #3967
  static carregamento + #1179, #3967
  static carregamento + #1180, #3967
  static carregamento + #1181, #3967
  static carregamento + #1182, #3967
  static carregamento + #1183, #3967
  static carregamento + #1184, #3967
  static carregamento + #1185, #3967
  static carregamento + #1186, #3967
  static carregamento + #1187, #3967
  static carregamento + #1188, #3967
  static carregamento + #1189, #3967
  static carregamento + #1190, #3967
  static carregamento + #1191, #3967
  static carregamento + #1192, #3967
  static carregamento + #1193, #3967
  static carregamento + #1194, #3967
  static carregamento + #1195, #3967
  static carregamento + #1196, #1070
  static carregamento + #1197, #3967
  static carregamento + #1198, #3967
  static carregamento + #1199, #3967

carreg1 : var #1200
  ;Linha 0
  static carreg1 + #0, #3967
  static carreg1 + #1, #3967
  static carreg1 + #2, #3967
  static carreg1 + #3, #3967
  static carreg1 + #4, #3967
  static carreg1 + #5, #3967
  static carreg1 + #6, #3967
  static carreg1 + #7, #3967
  static carreg1 + #8, #3967
  static carreg1 + #9, #3967
  static carreg1 + #10, #3967
  static carreg1 + #11, #3967
  static carreg1 + #12, #3967
  static carreg1 + #13, #3967
  static carreg1 + #14, #3967
  static carreg1 + #15, #3967
  static carreg1 + #16, #3967
  static carreg1 + #17, #3967
  static carreg1 + #18, #3967
  static carreg1 + #19, #3967
  static carreg1 + #20, #3967
  static carreg1 + #21, #3967
  static carreg1 + #22, #3967
  static carreg1 + #23, #1070
  static carreg1 + #24, #3967
  static carreg1 + #25, #3967
  static carreg1 + #26, #3967
  static carreg1 + #27, #3967
  static carreg1 + #28, #3967
  static carreg1 + #29, #3967
  static carreg1 + #30, #3967
  static carreg1 + #31, #3967
  static carreg1 + #32, #3967
  static carreg1 + #33, #3967
  static carreg1 + #34, #3967
  static carreg1 + #35, #3967
  static carreg1 + #36, #3967
  static carreg1 + #37, #3967
  static carreg1 + #38, #3967
  static carreg1 + #39, #3967

  ;Linha 1
  static carreg1 + #40, #3967
  static carreg1 + #41, #3967
  static carreg1 + #42, #3967
  static carreg1 + #43, #1070
  static carreg1 + #44, #3967
  static carreg1 + #45, #2128
  static carreg1 + #46, #2097
  static carreg1 + #47, #3967
  static carreg1 + #48, #3967
  static carreg1 + #49, #3967
  static carreg1 + #50, #3967
  static carreg1 + #51, #3967
  static carreg1 + #52, #3967
  static carreg1 + #53, #3967
  static carreg1 + #54, #3967
  static carreg1 + #55, #1070
  static carreg1 + #56, #3967
  static carreg1 + #57, #3967
  static carreg1 + #58, #3967
  static carreg1 + #59, #3967
  static carreg1 + #60, #3967
  static carreg1 + #61, #3967
  static carreg1 + #62, #3967
  static carreg1 + #63, #3967
  static carreg1 + #64, #3967
  static carreg1 + #65, #3967
  static carreg1 + #66, #3967
  static carreg1 + #67, #3967
  static carreg1 + #68, #1070
  static carreg1 + #69, #3967
  static carreg1 + #70, #3967
  static carreg1 + #71, #3967
  static carreg1 + #72, #3967
  static carreg1 + #73, #592
  static carreg1 + #74, #562
  static carreg1 + #75, #3967
  static carreg1 + #76, #3967
  static carreg1 + #77, #1070
  static carreg1 + #78, #3967
  static carreg1 + #79, #3967

  ;Linha 2
  static carreg1 + #80, #3967
  static carreg1 + #81, #1070
  static carreg1 + #82, #3967
  static carreg1 + #83, #3967
  static carreg1 + #84, #3967
  static carreg1 + #85, #3967
  static carreg1 + #86, #3967
  static carreg1 + #87, #3967
  static carreg1 + #88, #3967
  static carreg1 + #89, #3967
  static carreg1 + #90, #3967
  static carreg1 + #91, #1070
  static carreg1 + #92, #3967
  static carreg1 + #93, #3967
  static carreg1 + #94, #3967
  static carreg1 + #95, #3967
  static carreg1 + #96, #3967
  static carreg1 + #97, #3967
  static carreg1 + #98, #3967
  static carreg1 + #99, #3967
  static carreg1 + #100, #3967
  static carreg1 + #101, #3967
  static carreg1 + #102, #3967
  static carreg1 + #103, #3967
  static carreg1 + #104, #3967
  static carreg1 + #105, #3967
  static carreg1 + #106, #3967
  static carreg1 + #107, #3967
  static carreg1 + #108, #3967
  static carreg1 + #109, #3967
  static carreg1 + #110, #3967
  static carreg1 + #111, #3967
  static carreg1 + #112, #3967
  static carreg1 + #113, #3967
  static carreg1 + #114, #3967
  static carreg1 + #115, #3967
  static carreg1 + #116, #3967
  static carreg1 + #117, #3967
  static carreg1 + #118, #3967
  static carreg1 + #119, #3967

  ;Linha 3
  static carreg1 + #120, #3967
  static carreg1 + #121, #3967
  static carreg1 + #122, #3967
  static carreg1 + #123, #3967
  static carreg1 + #124, #3967
  static carreg1 + #125, #2048
  static carreg1 + #126, #2048
  static carreg1 + #127, #3967
  static carreg1 + #128, #1070
  static carreg1 + #129, #3967
  static carreg1 + #130, #3967
  static carreg1 + #131, #3967
  static carreg1 + #132, #3967
  static carreg1 + #133, #3967
  static carreg1 + #134, #3967
  static carreg1 + #135, #3967
  static carreg1 + #136, #3967
  static carreg1 + #137, #3967
  static carreg1 + #138, #3967
  static carreg1 + #139, #3967
  static carreg1 + #140, #3967
  static carreg1 + #141, #3967
  static carreg1 + #142, #3967
  static carreg1 + #143, #3967
  static carreg1 + #144, #3967
  static carreg1 + #145, #3967
  static carreg1 + #146, #1070
  static carreg1 + #147, #3967
  static carreg1 + #148, #3967
  static carreg1 + #149, #3967
  static carreg1 + #150, #512
  static carreg1 + #151, #512
  static carreg1 + #152, #3967
  static carreg1 + #153, #3967
  static carreg1 + #154, #3967
  static carreg1 + #155, #3967
  static carreg1 + #156, #512
  static carreg1 + #157, #512
  static carreg1 + #158, #3967
  static carreg1 + #159, #3967

  ;Linha 4
  static carreg1 + #160, #3967
  static carreg1 + #161, #3967
  static carreg1 + #162, #3967
  static carreg1 + #163, #3967
  static carreg1 + #164, #3967
  static carreg1 + #165, #2048
  static carreg1 + #166, #2048
  static carreg1 + #167, #3967
  static carreg1 + #168, #3967
  static carreg1 + #169, #3967
  static carreg1 + #170, #3967
  static carreg1 + #171, #3967
  static carreg1 + #172, #3967
  static carreg1 + #173, #3967
  static carreg1 + #174, #3967
  static carreg1 + #175, #3967
  static carreg1 + #176, #3967
  static carreg1 + #177, #1070
  static carreg1 + #178, #3967
  static carreg1 + #179, #3967
  static carreg1 + #180, #3967
  static carreg1 + #181, #3967
  static carreg1 + #182, #3967
  static carreg1 + #183, #3967
  static carreg1 + #184, #3967
  static carreg1 + #185, #3967
  static carreg1 + #186, #3967
  static carreg1 + #187, #3967
  static carreg1 + #188, #3967
  static carreg1 + #189, #3967
  static carreg1 + #190, #3967
  static carreg1 + #191, #3967
  static carreg1 + #192, #512
  static carreg1 + #193, #3967
  static carreg1 + #194, #3967
  static carreg1 + #195, #512
  static carreg1 + #196, #3967
  static carreg1 + #197, #3967
  static carreg1 + #198, #1070
  static carreg1 + #199, #3967

  ;Linha 5
  static carreg1 + #200, #3967
  static carreg1 + #201, #3967
  static carreg1 + #202, #3967
  static carreg1 + #203, #3967
  static carreg1 + #204, #3967
  static carreg1 + #205, #2048
  static carreg1 + #206, #2048
  static carreg1 + #207, #3967
  static carreg1 + #208, #3967
  static carreg1 + #209, #3967
  static carreg1 + #210, #3967
  static carreg1 + #211, #3967
  static carreg1 + #212, #3967
  static carreg1 + #213, #3967
  static carreg1 + #214, #3967
  static carreg1 + #215, #3967
  static carreg1 + #216, #3967
  static carreg1 + #217, #3967
  static carreg1 + #218, #3967
  static carreg1 + #219, #3967
  static carreg1 + #220, #3967
  static carreg1 + #221, #3967
  static carreg1 + #222, #3967
  static carreg1 + #223, #1070
  static carreg1 + #224, #3967
  static carreg1 + #225, #3967
  static carreg1 + #226, #3967
  static carreg1 + #227, #3967
  static carreg1 + #228, #3967
  static carreg1 + #229, #3967
  static carreg1 + #230, #3967
  static carreg1 + #231, #3967
  static carreg1 + #232, #512
  static carreg1 + #233, #512
  static carreg1 + #234, #512
  static carreg1 + #235, #512
  static carreg1 + #236, #3967
  static carreg1 + #237, #3967
  static carreg1 + #238, #3967
  static carreg1 + #239, #3967

  ;Linha 6
  static carreg1 + #240, #3967
  static carreg1 + #241, #3967
  static carreg1 + #242, #2048
  static carreg1 + #243, #3967
  static carreg1 + #244, #3967
  static carreg1 + #245, #2048
  static carreg1 + #246, #2048
  static carreg1 + #247, #3967
  static carreg1 + #248, #3967
  static carreg1 + #249, #2048
  static carreg1 + #250, #3967
  static carreg1 + #251, #3967
  static carreg1 + #252, #3967
  static carreg1 + #253, #3967
  static carreg1 + #254, #3967
  static carreg1 + #255, #3967
  static carreg1 + #256, #3967
  static carreg1 + #257, #3967
  static carreg1 + #258, #3967
  static carreg1 + #259, #3967
  static carreg1 + #260, #3967
  static carreg1 + #261, #3967
  static carreg1 + #262, #3967
  static carreg1 + #263, #3967
  static carreg1 + #264, #3967
  static carreg1 + #265, #3967
  static carreg1 + #266, #3967
  static carreg1 + #267, #3967
  static carreg1 + #268, #3967
  static carreg1 + #269, #3967
  static carreg1 + #270, #3967
  static carreg1 + #271, #512
  static carreg1 + #272, #3967
  static carreg1 + #273, #512
  static carreg1 + #274, #512
  static carreg1 + #275, #3967
  static carreg1 + #276, #512
  static carreg1 + #277, #3967
  static carreg1 + #278, #3967
  static carreg1 + #279, #3967

  ;Linha 7
  static carreg1 + #280, #3967
  static carreg1 + #281, #3967
  static carreg1 + #282, #2048
  static carreg1 + #283, #3967
  static carreg1 + #284, #2048
  static carreg1 + #285, #2048
  static carreg1 + #286, #2048
  static carreg1 + #287, #2048
  static carreg1 + #288, #3967
  static carreg1 + #289, #2048
  static carreg1 + #290, #3967
  static carreg1 + #291, #3967
  static carreg1 + #292, #3967
  static carreg1 + #293, #3967
  static carreg1 + #294, #3967
  static carreg1 + #295, #3967
  static carreg1 + #296, #3967
  static carreg1 + #297, #3967
  static carreg1 + #298, #3967
  static carreg1 + #299, #3967
  static carreg1 + #300, #3967
  static carreg1 + #301, #3967
  static carreg1 + #302, #3967
  static carreg1 + #303, #3967
  static carreg1 + #304, #3967
  static carreg1 + #305, #3967
  static carreg1 + #306, #3967
  static carreg1 + #307, #3967
  static carreg1 + #308, #3967
  static carreg1 + #309, #3967
  static carreg1 + #310, #512
  static carreg1 + #311, #512
  static carreg1 + #312, #512
  static carreg1 + #313, #512
  static carreg1 + #314, #512
  static carreg1 + #315, #512
  static carreg1 + #316, #512
  static carreg1 + #317, #512
  static carreg1 + #318, #3967
  static carreg1 + #319, #3967

  ;Linha 8
  static carreg1 + #320, #3967
  static carreg1 + #321, #3967
  static carreg1 + #322, #2048
  static carreg1 + #323, #2048
  static carreg1 + #324, #2048
  static carreg1 + #325, #2048
  static carreg1 + #326, #2048
  static carreg1 + #327, #2048
  static carreg1 + #328, #2048
  static carreg1 + #329, #2048
  static carreg1 + #330, #3967
  static carreg1 + #331, #3967
  static carreg1 + #332, #3967
  static carreg1 + #333, #3967
  static carreg1 + #334, #3967
  static carreg1 + #335, #3967
  static carreg1 + #336, #3967
  static carreg1 + #337, #3967
  static carreg1 + #338, #3967
  static carreg1 + #339, #3967
  static carreg1 + #340, #3967
  static carreg1 + #341, #3967
  static carreg1 + #342, #3967
  static carreg1 + #343, #3967
  static carreg1 + #344, #3967
  static carreg1 + #345, #3967
  static carreg1 + #346, #3967
  static carreg1 + #347, #3967
  static carreg1 + #348, #3967
  static carreg1 + #349, #3967
  static carreg1 + #350, #512
  static carreg1 + #351, #3967
  static carreg1 + #352, #512
  static carreg1 + #353, #512
  static carreg1 + #354, #512
  static carreg1 + #355, #512
  static carreg1 + #356, #3967
  static carreg1 + #357, #512
  static carreg1 + #358, #3967
  static carreg1 + #359, #3967

  ;Linha 9
  static carreg1 + #360, #3967
  static carreg1 + #361, #3967
  static carreg1 + #362, #2048
  static carreg1 + #363, #2048
  static carreg1 + #364, #3967
  static carreg1 + #365, #2048
  static carreg1 + #366, #2048
  static carreg1 + #367, #3967
  static carreg1 + #368, #2048
  static carreg1 + #369, #2048
  static carreg1 + #370, #3967
  static carreg1 + #371, #3967
  static carreg1 + #372, #3967
  static carreg1 + #373, #3967
  static carreg1 + #374, #3967
  static carreg1 + #375, #1024
  static carreg1 + #376, #3967
  static carreg1 + #377, #1070
  static carreg1 + #378, #3967
  static carreg1 + #379, #1024
  static carreg1 + #380, #3967
  static carreg1 + #381, #3967
  static carreg1 + #382, #1024
  static carreg1 + #383, #1024
  static carreg1 + #384, #3967
  static carreg1 + #385, #3967
  static carreg1 + #386, #1070
  static carreg1 + #387, #3967
  static carreg1 + #388, #3967
  static carreg1 + #389, #3967
  static carreg1 + #390, #512
  static carreg1 + #391, #3967
  static carreg1 + #392, #512
  static carreg1 + #393, #3967
  static carreg1 + #394, #3967
  static carreg1 + #395, #512
  static carreg1 + #396, #3967
  static carreg1 + #397, #512
  static carreg1 + #398, #3967
  static carreg1 + #399, #3967

  ;Linha 10
  static carreg1 + #400, #1070
  static carreg1 + #401, #3967
  static carreg1 + #402, #2048
  static carreg1 + #403, #3967
  static carreg1 + #404, #3967
  static carreg1 + #405, #3967
  static carreg1 + #406, #3967
  static carreg1 + #407, #3967
  static carreg1 + #408, #3967
  static carreg1 + #409, #2048
  static carreg1 + #410, #3967
  static carreg1 + #411, #3967
  static carreg1 + #412, #1070
  static carreg1 + #413, #3967
  static carreg1 + #414, #3967
  static carreg1 + #415, #1024
  static carreg1 + #416, #3967
  static carreg1 + #417, #3967
  static carreg1 + #418, #3967
  static carreg1 + #419, #1024
  static carreg1 + #420, #3967
  static carreg1 + #421, #1024
  static carreg1 + #422, #3967
  static carreg1 + #423, #3967
  static carreg1 + #424, #1024
  static carreg1 + #425, #3967
  static carreg1 + #426, #3967
  static carreg1 + #427, #3967
  static carreg1 + #428, #3967
  static carreg1 + #429, #3967
  static carreg1 + #430, #3967
  static carreg1 + #431, #3967
  static carreg1 + #432, #512
  static carreg1 + #433, #3967
  static carreg1 + #434, #3967
  static carreg1 + #435, #512
  static carreg1 + #436, #3967
  static carreg1 + #437, #3967
  static carreg1 + #438, #3967
  static carreg1 + #439, #3967

  ;Linha 11
  static carreg1 + #440, #3967
  static carreg1 + #441, #3967
  static carreg1 + #442, #3967
  static carreg1 + #443, #3967
  static carreg1 + #444, #1070
  static carreg1 + #445, #3967
  static carreg1 + #446, #3967
  static carreg1 + #447, #3967
  static carreg1 + #448, #3967
  static carreg1 + #449, #3967
  static carreg1 + #450, #3967
  static carreg1 + #451, #3967
  static carreg1 + #452, #3967
  static carreg1 + #453, #3967
  static carreg1 + #454, #3967
  static carreg1 + #455, #1024
  static carreg1 + #456, #3967
  static carreg1 + #457, #3967
  static carreg1 + #458, #3967
  static carreg1 + #459, #1024
  static carreg1 + #460, #3967
  static carreg1 + #461, #1024
  static carreg1 + #462, #3967
  static carreg1 + #463, #3967
  static carreg1 + #464, #3967
  static carreg1 + #465, #3967
  static carreg1 + #466, #3967
  static carreg1 + #467, #3967
  static carreg1 + #468, #3967
  static carreg1 + #469, #3967
  static carreg1 + #470, #3967
  static carreg1 + #471, #3967
  static carreg1 + #472, #3967
  static carreg1 + #473, #3967
  static carreg1 + #474, #3967
  static carreg1 + #475, #3967
  static carreg1 + #476, #3967
  static carreg1 + #477, #3967
  static carreg1 + #478, #3967
  static carreg1 + #479, #3967

  ;Linha 12
  static carreg1 + #480, #3967
  static carreg1 + #481, #3967
  static carreg1 + #482, #3967
  static carreg1 + #483, #3967
  static carreg1 + #484, #3967
  static carreg1 + #485, #3967
  static carreg1 + #486, #3967
  static carreg1 + #487, #3967
  static carreg1 + #488, #3967
  static carreg1 + #489, #3967
  static carreg1 + #490, #3967
  static carreg1 + #491, #3967
  static carreg1 + #492, #3967
  static carreg1 + #493, #3967
  static carreg1 + #494, #3967
  static carreg1 + #495, #1024
  static carreg1 + #496, #3967
  static carreg1 + #497, #3967
  static carreg1 + #498, #3967
  static carreg1 + #499, #1024
  static carreg1 + #500, #3967
  static carreg1 + #501, #3967
  static carreg1 + #502, #1024
  static carreg1 + #503, #1024
  static carreg1 + #504, #3967
  static carreg1 + #505, #3967
  static carreg1 + #506, #3967
  static carreg1 + #507, #3967
  static carreg1 + #508, #3967
  static carreg1 + #509, #3967
  static carreg1 + #510, #3967
  static carreg1 + #511, #3967
  static carreg1 + #512, #3967
  static carreg1 + #513, #3967
  static carreg1 + #514, #3967
  static carreg1 + #515, #3967
  static carreg1 + #516, #3967
  static carreg1 + #517, #3967
  static carreg1 + #518, #3967
  static carreg1 + #519, #3967

  ;Linha 13
  static carreg1 + #520, #3967
  static carreg1 + #521, #3967
  static carreg1 + #522, #3967
  static carreg1 + #523, #3967
  static carreg1 + #524, #3967
  static carreg1 + #525, #3967
  static carreg1 + #526, #3967
  static carreg1 + #527, #3967
  static carreg1 + #528, #3967
  static carreg1 + #529, #3967
  static carreg1 + #530, #3967
  static carreg1 + #531, #3967
  static carreg1 + #532, #3967
  static carreg1 + #533, #3967
  static carreg1 + #534, #3967
  static carreg1 + #535, #1024
  static carreg1 + #536, #3967
  static carreg1 + #537, #3967
  static carreg1 + #538, #3967
  static carreg1 + #539, #1024
  static carreg1 + #540, #3967
  static carreg1 + #541, #3967
  static carreg1 + #542, #3967
  static carreg1 + #543, #3967
  static carreg1 + #544, #1024
  static carreg1 + #545, #3967
  static carreg1 + #546, #3967
  static carreg1 + #547, #3967
  static carreg1 + #548, #3967
  static carreg1 + #549, #1070
  static carreg1 + #550, #3967
  static carreg1 + #551, #3967
  static carreg1 + #552, #3967
  static carreg1 + #553, #3967
  static carreg1 + #554, #3967
  static carreg1 + #555, #3967
  static carreg1 + #556, #3967
  static carreg1 + #557, #3967
  static carreg1 + #558, #1070
  static carreg1 + #559, #3967

  ;Linha 14
  static carreg1 + #560, #3967
  static carreg1 + #561, #1070
  static carreg1 + #562, #3967
  static carreg1 + #563, #3967
  static carreg1 + #564, #2125
  static carreg1 + #565, #2159
  static carreg1 + #566, #2166
  static carreg1 + #567, #2106
  static carreg1 + #568, #3967
  static carreg1 + #569, #1070
  static carreg1 + #570, #3967
  static carreg1 + #571, #3967
  static carreg1 + #572, #3967
  static carreg1 + #573, #3967
  static carreg1 + #574, #3967
  static carreg1 + #575, #3967
  static carreg1 + #576, #1024
  static carreg1 + #577, #3967
  static carreg1 + #578, #1024
  static carreg1 + #579, #3967
  static carreg1 + #580, #3967
  static carreg1 + #581, #1024
  static carreg1 + #582, #3967
  static carreg1 + #583, #3967
  static carreg1 + #584, #1024
  static carreg1 + #585, #3967
  static carreg1 + #586, #3967
  static carreg1 + #587, #3967
  static carreg1 + #588, #3967
  static carreg1 + #589, #3967
  static carreg1 + #590, #3967
  static carreg1 + #591, #3967
  static carreg1 + #592, #589
  static carreg1 + #593, #623
  static carreg1 + #594, #630
  static carreg1 + #595, #570
  static carreg1 + #596, #3967
  static carreg1 + #597, #3967
  static carreg1 + #598, #3967
  static carreg1 + #599, #3967

  ;Linha 15
  static carreg1 + #600, #3967
  static carreg1 + #601, #3967
  static carreg1 + #602, #3967
  static carreg1 + #603, #3967
  static carreg1 + #604, #3967
  static carreg1 + #605, #3967
  static carreg1 + #606, #3967
  static carreg1 + #607, #3967
  static carreg1 + #608, #3967
  static carreg1 + #609, #3967
  static carreg1 + #610, #3967
  static carreg1 + #611, #3967
  static carreg1 + #612, #3967
  static carreg1 + #613, #1070
  static carreg1 + #614, #3967
  static carreg1 + #615, #3967
  static carreg1 + #616, #3967
  static carreg1 + #617, #1024
  static carreg1 + #618, #3967
  static carreg1 + #619, #3967
  static carreg1 + #620, #3967
  static carreg1 + #621, #3967
  static carreg1 + #622, #1024
  static carreg1 + #623, #1024
  static carreg1 + #624, #3967
  static carreg1 + #625, #3967
  static carreg1 + #626, #3967
  static carreg1 + #627, #1070
  static carreg1 + #628, #3967
  static carreg1 + #629, #3967
  static carreg1 + #630, #3967
  static carreg1 + #631, #3967
  static carreg1 + #632, #3967
  static carreg1 + #633, #3967
  static carreg1 + #634, #3967
  static carreg1 + #635, #3967
  static carreg1 + #636, #3967
  static carreg1 + #637, #3967
  static carreg1 + #638, #3967
  static carreg1 + #639, #3967

  ;Linha 16
  static carreg1 + #640, #3967
  static carreg1 + #641, #3967
  static carreg1 + #642, #3967
  static carreg1 + #643, #3967
  static carreg1 + #644, #3967
  static carreg1 + #645, #3967
  static carreg1 + #646, #3967
  static carreg1 + #647, #3967
  static carreg1 + #648, #3967
  static carreg1 + #649, #3967
  static carreg1 + #650, #3967
  static carreg1 + #651, #3967
  static carreg1 + #652, #3967
  static carreg1 + #653, #3967
  static carreg1 + #654, #3967
  static carreg1 + #655, #3967
  static carreg1 + #656, #3967
  static carreg1 + #657, #3967
  static carreg1 + #658, #3967
  static carreg1 + #659, #3967
  static carreg1 + #660, #3967
  static carreg1 + #661, #3967
  static carreg1 + #662, #3967
  static carreg1 + #663, #3967
  static carreg1 + #664, #3967
  static carreg1 + #665, #3967
  static carreg1 + #666, #3967
  static carreg1 + #667, #3967
  static carreg1 + #668, #3967
  static carreg1 + #669, #3967
  static carreg1 + #670, #3967
  static carreg1 + #671, #3967
  static carreg1 + #672, #3967
  static carreg1 + #673, #3967
  static carreg1 + #674, #3967
  static carreg1 + #675, #3967
  static carreg1 + #676, #3967
  static carreg1 + #677, #3967
  static carreg1 + #678, #3967
  static carreg1 + #679, #3967

  ;Linha 17
  static carreg1 + #680, #3967
  static carreg1 + #681, #3967
  static carreg1 + #682, #3967
  static carreg1 + #683, #3967
  static carreg1 + #684, #3967
  static carreg1 + #685, #2135
  static carreg1 + #686, #3967
  static carreg1 + #687, #3967
  static carreg1 + #688, #3967
  static carreg1 + #689, #3967
  static carreg1 + #690, #3967
  static carreg1 + #691, #3967
  static carreg1 + #692, #3967
  static carreg1 + #693, #3967
  static carreg1 + #694, #3967
  static carreg1 + #695, #3967
  static carreg1 + #696, #3967
  static carreg1 + #697, #3967
  static carreg1 + #698, #3967
  static carreg1 + #699, #3967
  static carreg1 + #700, #3967
  static carreg1 + #701, #1070
  static carreg1 + #702, #3967
  static carreg1 + #703, #3967
  static carreg1 + #704, #1070
  static carreg1 + #705, #3967
  static carreg1 + #706, #3967
  static carreg1 + #707, #3967
  static carreg1 + #708, #3967
  static carreg1 + #709, #3967
  static carreg1 + #710, #3967
  static carreg1 + #711, #3967
  static carreg1 + #712, #3967
  static carreg1 + #713, #3967
  static carreg1 + #714, #585
  static carreg1 + #715, #3967
  static carreg1 + #716, #3967
  static carreg1 + #717, #1070
  static carreg1 + #718, #3967
  static carreg1 + #719, #3967

  ;Linha 18
  static carreg1 + #720, #3967
  static carreg1 + #721, #3967
  static carreg1 + #722, #3967
  static carreg1 + #723, #3967
  static carreg1 + #724, #3967
  static carreg1 + #725, #3967
  static carreg1 + #726, #3967
  static carreg1 + #727, #3967
  static carreg1 + #728, #3967
  static carreg1 + #729, #3967
  static carreg1 + #730, #3967
  static carreg1 + #731, #3967
  static carreg1 + #732, #3967
  static carreg1 + #733, #1070
  static carreg1 + #734, #3967
  static carreg1 + #735, #1069
  static carreg1 + #736, #1069
  static carreg1 + #737, #1069
  static carreg1 + #738, #1069
  static carreg1 + #739, #1069
  static carreg1 + #740, #1069
  static carreg1 + #741, #1069
  static carreg1 + #742, #1069
  static carreg1 + #743, #3117
  static carreg1 + #744, #3117
  static carreg1 + #745, #3967
  static carreg1 + #746, #3967
  static carreg1 + #747, #3967
  static carreg1 + #748, #3967
  static carreg1 + #749, #3967
  static carreg1 + #750, #3967
  static carreg1 + #751, #3967
  static carreg1 + #752, #3967
  static carreg1 + #753, #3967
  static carreg1 + #754, #3967
  static carreg1 + #755, #3967
  static carreg1 + #756, #3967
  static carreg1 + #757, #3967
  static carreg1 + #758, #3967
  static carreg1 + #759, #3967

  ;Linha 19
  static carreg1 + #760, #3967
  static carreg1 + #761, #3967
  static carreg1 + #762, #3967
  static carreg1 + #763, #2113
  static carreg1 + #764, #3967
  static carreg1 + #765, #2131
  static carreg1 + #766, #3967
  static carreg1 + #767, #2116
  static carreg1 + #768, #3967
  static carreg1 + #769, #3967
  static carreg1 + #770, #3967
  static carreg1 + #771, #3967
  static carreg1 + #772, #3967
  static carreg1 + #773, #3967
  static carreg1 + #774, #3967
  static carreg1 + #775, #1091
  static carreg1 + #776, #1089
  static carreg1 + #777, #1106
  static carreg1 + #778, #1106
  static carreg1 + #779, #1093
  static carreg1 + #780, #1095
  static carreg1 + #781, #1089
  static carreg1 + #782, #1102
  static carreg1 + #783, #3140
  static carreg1 + #784, #3151
  static carreg1 + #785, #3967
  static carreg1 + #786, #3967
  static carreg1 + #787, #3967
  static carreg1 + #788, #3967
  static carreg1 + #789, #3967
  static carreg1 + #790, #3967
  static carreg1 + #791, #3967
  static carreg1 + #792, #586
  static carreg1 + #793, #3967
  static carreg1 + #794, #587
  static carreg1 + #795, #3967
  static carreg1 + #796, #588
  static carreg1 + #797, #3967
  static carreg1 + #798, #3967
  static carreg1 + #799, #3967

  ;Linha 20
  static carreg1 + #800, #3967
  static carreg1 + #801, #3967
  static carreg1 + #802, #3967
  static carreg1 + #803, #3967
  static carreg1 + #804, #3967
  static carreg1 + #805, #3967
  static carreg1 + #806, #3967
  static carreg1 + #807, #3967
  static carreg1 + #808, #3967
  static carreg1 + #809, #3967
  static carreg1 + #810, #3967
  static carreg1 + #811, #3967
  static carreg1 + #812, #3967
  static carreg1 + #813, #3967
  static carreg1 + #814, #3967
  static carreg1 + #815, #1069
  static carreg1 + #816, #1069
  static carreg1 + #817, #1069
  static carreg1 + #818, #1069
  static carreg1 + #819, #1069
  static carreg1 + #820, #1069
  static carreg1 + #821, #1069
  static carreg1 + #822, #1069
  static carreg1 + #823, #3117
  static carreg1 + #824, #3117
  static carreg1 + #825, #3967
  static carreg1 + #826, #3967
  static carreg1 + #827, #3967
  static carreg1 + #828, #1070
  static carreg1 + #829, #3967
  static carreg1 + #830, #3967
  static carreg1 + #831, #3967
  static carreg1 + #832, #3967
  static carreg1 + #833, #3967
  static carreg1 + #834, #3967
  static carreg1 + #835, #3967
  static carreg1 + #836, #3967
  static carreg1 + #837, #3967
  static carreg1 + #838, #3967
  static carreg1 + #839, #3967

  ;Linha 21
  static carreg1 + #840, #3967
  static carreg1 + #841, #1070
  static carreg1 + #842, #3967
  static carreg1 + #843, #3967
  static carreg1 + #844, #1070
  static carreg1 + #845, #3967
  static carreg1 + #846, #3967
  static carreg1 + #847, #3967
  static carreg1 + #848, #3967
  static carreg1 + #849, #3967
  static carreg1 + #850, #3967
  static carreg1 + #851, #3967
  static carreg1 + #852, #3967
  static carreg1 + #853, #3967
  static carreg1 + #854, #3967
  static carreg1 + #855, #3967
  static carreg1 + #856, #3967
  static carreg1 + #857, #3967
  static carreg1 + #858, #3967
  static carreg1 + #859, #3967
  static carreg1 + #860, #3967
  static carreg1 + #861, #3967
  static carreg1 + #862, #3967
  static carreg1 + #863, #3967
  static carreg1 + #864, #3967
  static carreg1 + #865, #3967
  static carreg1 + #866, #3967
  static carreg1 + #867, #3967
  static carreg1 + #868, #3967
  static carreg1 + #869, #3967
  static carreg1 + #870, #3967
  static carreg1 + #871, #3967
  static carreg1 + #872, #3967
  static carreg1 + #873, #3967
  static carreg1 + #874, #1070
  static carreg1 + #875, #3967
  static carreg1 + #876, #3967
  static carreg1 + #877, #3967
  static carreg1 + #878, #3967
  static carreg1 + #879, #1070

  ;Linha 22
  static carreg1 + #880, #3967
  static carreg1 + #881, #3967
  static carreg1 + #882, #3967
  static carreg1 + #883, #3967
  static carreg1 + #884, #3967
  static carreg1 + #885, #3967
  static carreg1 + #886, #3967
  static carreg1 + #887, #3967
  static carreg1 + #888, #3967
  static carreg1 + #889, #3967
  static carreg1 + #890, #3967
  static carreg1 + #891, #1070
  static carreg1 + #892, #3967
  static carreg1 + #893, #3967
  static carreg1 + #894, #3967
  static carreg1 + #895, #3967
  static carreg1 + #896, #3967
  static carreg1 + #897, #3967
  static carreg1 + #898, #3967
  static carreg1 + #899, #3967
  static carreg1 + #900, #1070
  static carreg1 + #901, #3967
  static carreg1 + #902, #3967
  static carreg1 + #903, #3967
  static carreg1 + #904, #3967
  static carreg1 + #905, #3967
  static carreg1 + #906, #3967
  static carreg1 + #907, #3967
  static carreg1 + #908, #3967
  static carreg1 + #909, #3967
  static carreg1 + #910, #3967
  static carreg1 + #911, #3967
  static carreg1 + #912, #3967
  static carreg1 + #913, #3967
  static carreg1 + #914, #3967
  static carreg1 + #915, #3967
  static carreg1 + #916, #3967
  static carreg1 + #917, #3967
  static carreg1 + #918, #3967
  static carreg1 + #919, #3967

  ;Linha 23
  static carreg1 + #920, #3967
  static carreg1 + #921, #3967
  static carreg1 + #922, #3967
  static carreg1 + #923, #2131
  static carreg1 + #924, #2152
  static carreg1 + #925, #2159
  static carreg1 + #926, #2159
  static carreg1 + #927, #2164
  static carreg1 + #928, #2106
  static carreg1 + #929, #3967
  static carreg1 + #930, #3967
  static carreg1 + #931, #3967
  static carreg1 + #932, #3967
  static carreg1 + #933, #3967
  static carreg1 + #934, #3967
  static carreg1 + #935, #3967
  static carreg1 + #936, #3967
  static carreg1 + #937, #3967
  static carreg1 + #938, #3967
  static carreg1 + #939, #3967
  static carreg1 + #940, #3967
  static carreg1 + #941, #3967
  static carreg1 + #942, #3967
  static carreg1 + #943, #3967
  static carreg1 + #944, #3967
  static carreg1 + #945, #1070
  static carreg1 + #946, #3967
  static carreg1 + #947, #3967
  static carreg1 + #948, #3967
  static carreg1 + #949, #3967
  static carreg1 + #950, #3967
  static carreg1 + #951, #595
  static carreg1 + #952, #616
  static carreg1 + #953, #623
  static carreg1 + #954, #623
  static carreg1 + #955, #628
  static carreg1 + #956, #570
  static carreg1 + #957, #3967
  static carreg1 + #958, #3967
  static carreg1 + #959, #3967

  ;Linha 24
  static carreg1 + #960, #3967
  static carreg1 + #961, #3967
  static carreg1 + #962, #3967
  static carreg1 + #963, #3967
  static carreg1 + #964, #3967
  static carreg1 + #965, #3967
  static carreg1 + #966, #3967
  static carreg1 + #967, #3967
  static carreg1 + #968, #3967
  static carreg1 + #969, #3967
  static carreg1 + #970, #3967
  static carreg1 + #971, #3967
  static carreg1 + #972, #3967
  static carreg1 + #973, #3967
  static carreg1 + #974, #3967
  static carreg1 + #975, #3967
  static carreg1 + #976, #3967
  static carreg1 + #977, #3967
  static carreg1 + #978, #3967
  static carreg1 + #979, #3967
  static carreg1 + #980, #3967
  static carreg1 + #981, #3967
  static carreg1 + #982, #3967
  static carreg1 + #983, #3967
  static carreg1 + #984, #3967
  static carreg1 + #985, #3967
  static carreg1 + #986, #1070
  static carreg1 + #987, #3967
  static carreg1 + #988, #3967
  static carreg1 + #989, #3967
  static carreg1 + #990, #3967
  static carreg1 + #991, #3967
  static carreg1 + #992, #3967
  static carreg1 + #993, #3967
  static carreg1 + #994, #3967
  static carreg1 + #995, #3967
  static carreg1 + #996, #3967
  static carreg1 + #997, #3967
  static carreg1 + #998, #3967
  static carreg1 + #999, #3967

  ;Linha 25
  static carreg1 + #1000, #3967
  static carreg1 + #1001, #3967
  static carreg1 + #1002, #3967
  static carreg1 + #1003, #3967
  static carreg1 + #1004, #3967
  static carreg1 + #1005, #3967
  static carreg1 + #1006, #3967
  static carreg1 + #1007, #3967
  static carreg1 + #1008, #3967
  static carreg1 + #1009, #3967
  static carreg1 + #1010, #3967
  static carreg1 + #1011, #3967
  static carreg1 + #1012, #3967
  static carreg1 + #1013, #3967
  static carreg1 + #1014, #1070
  static carreg1 + #1015, #3967
  static carreg1 + #1016, #3967
  static carreg1 + #1017, #3967
  static carreg1 + #1018, #3967
  static carreg1 + #1019, #3967
  static carreg1 + #1020, #3967
  static carreg1 + #1021, #3967
  static carreg1 + #1022, #3967
  static carreg1 + #1023, #3967
  static carreg1 + #1024, #3967
  static carreg1 + #1025, #3967
  static carreg1 + #1026, #3967
  static carreg1 + #1027, #3967
  static carreg1 + #1028, #3967
  static carreg1 + #1029, #3967
  static carreg1 + #1030, #3967
  static carreg1 + #1031, #3967
  static carreg1 + #1032, #3967
  static carreg1 + #1033, #3967
  static carreg1 + #1034, #3967
  static carreg1 + #1035, #3967
  static carreg1 + #1036, #3967
  static carreg1 + #1037, #3967
  static carreg1 + #1038, #3967
  static carreg1 + #1039, #3967

  ;Linha 26
  static carreg1 + #1040, #3967
  static carreg1 + #1041, #3967
  static carreg1 + #1042, #3967
  static carreg1 + #1043, #3967
  static carreg1 + #1044, #3967
  static carreg1 + #1045, #2117
  static carreg1 + #1046, #3967
  static carreg1 + #1047, #3967
  static carreg1 + #1048, #3967
  static carreg1 + #1049, #3967
  static carreg1 + #1050, #3967
  static carreg1 + #1051, #3967
  static carreg1 + #1052, #3967
  static carreg1 + #1053, #3967
  static carreg1 + #1054, #3967
  static carreg1 + #1055, #3967
  static carreg1 + #1056, #3967
  static carreg1 + #1057, #3967
  static carreg1 + #1058, #1070
  static carreg1 + #1059, #3967
  static carreg1 + #1060, #3967
  static carreg1 + #1061, #3967
  static carreg1 + #1062, #3967
  static carreg1 + #1063, #3967
  static carreg1 + #1064, #3967
  static carreg1 + #1065, #3967
  static carreg1 + #1066, #3967
  static carreg1 + #1067, #3967
  static carreg1 + #1068, #3967
  static carreg1 + #1069, #3967
  static carreg1 + #1070, #3967
  static carreg1 + #1071, #3967
  static carreg1 + #1072, #3967
  static carreg1 + #1073, #3967
  static carreg1 + #1074, #592
  static carreg1 + #1075, #3967
  static carreg1 + #1076, #3967
  static carreg1 + #1077, #3967
  static carreg1 + #1078, #1070
  static carreg1 + #1079, #3967

  ;Linha 27
  static carreg1 + #1080, #3967
  static carreg1 + #1081, #3967
  static carreg1 + #1082, #1070
  static carreg1 + #1083, #3967
  static carreg1 + #1084, #3967
  static carreg1 + #1085, #3967
  static carreg1 + #1086, #3967
  static carreg1 + #1087, #3967
  static carreg1 + #1088, #3967
  static carreg1 + #1089, #3967
  static carreg1 + #1090, #3967
  static carreg1 + #1091, #3967
  static carreg1 + #1092, #3967
  static carreg1 + #1093, #3967
  static carreg1 + #1094, #3967
  static carreg1 + #1095, #3967
  static carreg1 + #1096, #3967
  static carreg1 + #1097, #3967
  static carreg1 + #1098, #3967
  static carreg1 + #1099, #3967
  static carreg1 + #1100, #3967
  static carreg1 + #1101, #3967
  static carreg1 + #1102, #3967
  static carreg1 + #1103, #3967
  static carreg1 + #1104, #3967
  static carreg1 + #1105, #3967
  static carreg1 + #1106, #3967
  static carreg1 + #1107, #3967
  static carreg1 + #1108, #1070
  static carreg1 + #1109, #3967
  static carreg1 + #1110, #3967
  static carreg1 + #1111, #3967
  static carreg1 + #1112, #3967
  static carreg1 + #1113, #3967
  static carreg1 + #1114, #3967
  static carreg1 + #1115, #3967
  static carreg1 + #1116, #3967
  static carreg1 + #1117, #3967
  static carreg1 + #1118, #3967
  static carreg1 + #1119, #3967

  ;Linha 28
  static carreg1 + #1120, #3967
  static carreg1 + #1121, #3967
  static carreg1 + #1122, #3967
  static carreg1 + #1123, #3967
  static carreg1 + #1124, #3967
  static carreg1 + #1125, #3967
  static carreg1 + #1126, #3967
  static carreg1 + #1127, #3967
  static carreg1 + #1128, #3967
  static carreg1 + #1129, #3967
  static carreg1 + #1130, #3967
  static carreg1 + #1131, #1070
  static carreg1 + #1132, #3967
  static carreg1 + #1133, #3967
  static carreg1 + #1134, #3967
  static carreg1 + #1135, #3967
  static carreg1 + #1136, #3967
  static carreg1 + #1137, #3967
  static carreg1 + #1138, #3967
  static carreg1 + #1139, #3967
  static carreg1 + #1140, #3967
  static carreg1 + #1141, #3967
  static carreg1 + #1142, #1070
  static carreg1 + #1143, #3967
  static carreg1 + #1144, #3967
  static carreg1 + #1145, #3967
  static carreg1 + #1146, #3967
  static carreg1 + #1147, #3967
  static carreg1 + #1148, #3967
  static carreg1 + #1149, #3967
  static carreg1 + #1150, #3967
  static carreg1 + #1151, #3967
  static carreg1 + #1152, #3967
  static carreg1 + #1153, #3967
  static carreg1 + #1154, #3967
  static carreg1 + #1155, #3967
  static carreg1 + #1156, #3967
  static carreg1 + #1157, #3967
  static carreg1 + #1158, #3967
  static carreg1 + #1159, #3967

  ;Linha 29
  static carreg1 + #1160, #3967
  static carreg1 + #1161, #3967
  static carreg1 + #1162, #3967
  static carreg1 + #1163, #3967
  static carreg1 + #1164, #3967
  static carreg1 + #1165, #3967
  static carreg1 + #1166, #3967
  static carreg1 + #1167, #3967
  static carreg1 + #1168, #3967
  static carreg1 + #1169, #3967
  static carreg1 + #1170, #3967
  static carreg1 + #1171, #3967
  static carreg1 + #1172, #3967
  static carreg1 + #1173, #3967
  static carreg1 + #1174, #3967
  static carreg1 + #1175, #3967
  static carreg1 + #1176, #3967
  static carreg1 + #1177, #3967
  static carreg1 + #1178, #3967
  static carreg1 + #1179, #3967
  static carreg1 + #1180, #3967
  static carreg1 + #1181, #3967
  static carreg1 + #1182, #3967
  static carreg1 + #1183, #3967
  static carreg1 + #1184, #3967
  static carreg1 + #1185, #3967
  static carreg1 + #1186, #3967
  static carreg1 + #1187, #3967
  static carreg1 + #1188, #3967
  static carreg1 + #1189, #3967
  static carreg1 + #1190, #3967
  static carreg1 + #1191, #3967
  static carreg1 + #1192, #3967
  static carreg1 + #1193, #3967
  static carreg1 + #1194, #3967
  static carreg1 + #1195, #3967
  static carreg1 + #1196, #1070
  static carreg1 + #1197, #3967
  static carreg1 + #1198, #3967
  static carreg1 + #1199, #3967
carreg2 : var #1200
  ;Linha 0
  static carreg2 + #0, #3967
  static carreg2 + #1, #3967
  static carreg2 + #2, #3967
  static carreg2 + #3, #3967
  static carreg2 + #4, #3967
  static carreg2 + #5, #3967
  static carreg2 + #6, #3967
  static carreg2 + #7, #3967
  static carreg2 + #8, #3967
  static carreg2 + #9, #3967
  static carreg2 + #10, #3967
  static carreg2 + #11, #3967
  static carreg2 + #12, #3967
  static carreg2 + #13, #3967
  static carreg2 + #14, #3967
  static carreg2 + #15, #3967
  static carreg2 + #16, #3967
  static carreg2 + #17, #3967
  static carreg2 + #18, #3967
  static carreg2 + #19, #3967
  static carreg2 + #20, #3967
  static carreg2 + #21, #3967
  static carreg2 + #22, #3967
  static carreg2 + #23, #1070
  static carreg2 + #24, #3967
  static carreg2 + #25, #3967
  static carreg2 + #26, #3967
  static carreg2 + #27, #3967
  static carreg2 + #28, #3967
  static carreg2 + #29, #3967
  static carreg2 + #30, #3967
  static carreg2 + #31, #3967
  static carreg2 + #32, #3967
  static carreg2 + #33, #3967
  static carreg2 + #34, #3967
  static carreg2 + #35, #3967
  static carreg2 + #36, #3967
  static carreg2 + #37, #3967
  static carreg2 + #38, #3967
  static carreg2 + #39, #3967

  ;Linha 1
  static carreg2 + #40, #3967
  static carreg2 + #41, #3967
  static carreg2 + #42, #3967
  static carreg2 + #43, #1070
  static carreg2 + #44, #3967
  static carreg2 + #45, #2128
  static carreg2 + #46, #2097
  static carreg2 + #47, #3967
  static carreg2 + #48, #3967
  static carreg2 + #49, #3967
  static carreg2 + #50, #3967
  static carreg2 + #51, #3967
  static carreg2 + #52, #3967
  static carreg2 + #53, #3967
  static carreg2 + #54, #3967
  static carreg2 + #55, #1070
  static carreg2 + #56, #3967
  static carreg2 + #57, #3967
  static carreg2 + #58, #3967
  static carreg2 + #59, #3967
  static carreg2 + #60, #3967
  static carreg2 + #61, #3967
  static carreg2 + #62, #3967
  static carreg2 + #63, #3967
  static carreg2 + #64, #3967
  static carreg2 + #65, #3967
  static carreg2 + #66, #3967
  static carreg2 + #67, #3967
  static carreg2 + #68, #1070
  static carreg2 + #69, #3967
  static carreg2 + #70, #3967
  static carreg2 + #71, #3967
  static carreg2 + #72, #3967
  static carreg2 + #73, #592
  static carreg2 + #74, #562
  static carreg2 + #75, #3967
  static carreg2 + #76, #3967
  static carreg2 + #77, #1070
  static carreg2 + #78, #3967
  static carreg2 + #79, #3967

  ;Linha 2
  static carreg2 + #80, #3967
  static carreg2 + #81, #1070
  static carreg2 + #82, #3967
  static carreg2 + #83, #3967
  static carreg2 + #84, #3967
  static carreg2 + #85, #3967
  static carreg2 + #86, #3967
  static carreg2 + #87, #3967
  static carreg2 + #88, #3967
  static carreg2 + #89, #3967
  static carreg2 + #90, #3967
  static carreg2 + #91, #1070
  static carreg2 + #92, #3967
  static carreg2 + #93, #3967
  static carreg2 + #94, #3967
  static carreg2 + #95, #3967
  static carreg2 + #96, #3967
  static carreg2 + #97, #3967
  static carreg2 + #98, #3967
  static carreg2 + #99, #3967
  static carreg2 + #100, #3967
  static carreg2 + #101, #3967
  static carreg2 + #102, #3967
  static carreg2 + #103, #3967
  static carreg2 + #104, #3967
  static carreg2 + #105, #3967
  static carreg2 + #106, #3967
  static carreg2 + #107, #3967
  static carreg2 + #108, #3967
  static carreg2 + #109, #3967
  static carreg2 + #110, #3967
  static carreg2 + #111, #3967
  static carreg2 + #112, #3967
  static carreg2 + #113, #3967
  static carreg2 + #114, #3967
  static carreg2 + #115, #3967
  static carreg2 + #116, #3967
  static carreg2 + #117, #3967
  static carreg2 + #118, #3967
  static carreg2 + #119, #3967

  ;Linha 3
  static carreg2 + #120, #3967
  static carreg2 + #121, #3967
  static carreg2 + #122, #3967
  static carreg2 + #123, #3967
  static carreg2 + #124, #3967
  static carreg2 + #125, #2048
  static carreg2 + #126, #2048
  static carreg2 + #127, #3967
  static carreg2 + #128, #1070
  static carreg2 + #129, #3967
  static carreg2 + #130, #3967
  static carreg2 + #131, #3967
  static carreg2 + #132, #3967
  static carreg2 + #133, #3967
  static carreg2 + #134, #3967
  static carreg2 + #135, #3967
  static carreg2 + #136, #3967
  static carreg2 + #137, #3967
  static carreg2 + #138, #3967
  static carreg2 + #139, #3967
  static carreg2 + #140, #3967
  static carreg2 + #141, #3967
  static carreg2 + #142, #3967
  static carreg2 + #143, #3967
  static carreg2 + #144, #3967
  static carreg2 + #145, #3967
  static carreg2 + #146, #1070
  static carreg2 + #147, #3967
  static carreg2 + #148, #3967
  static carreg2 + #149, #3967
  static carreg2 + #150, #512
  static carreg2 + #151, #512
  static carreg2 + #152, #3967
  static carreg2 + #153, #3967
  static carreg2 + #154, #3967
  static carreg2 + #155, #3967
  static carreg2 + #156, #512
  static carreg2 + #157, #512
  static carreg2 + #158, #3967
  static carreg2 + #159, #3967

  ;Linha 4
  static carreg2 + #160, #3967
  static carreg2 + #161, #3967
  static carreg2 + #162, #3967
  static carreg2 + #163, #3967
  static carreg2 + #164, #3967
  static carreg2 + #165, #2048
  static carreg2 + #166, #2048
  static carreg2 + #167, #3967
  static carreg2 + #168, #3967
  static carreg2 + #169, #3967
  static carreg2 + #170, #3967
  static carreg2 + #171, #3967
  static carreg2 + #172, #3967
  static carreg2 + #173, #3967
  static carreg2 + #174, #3967
  static carreg2 + #175, #3967
  static carreg2 + #176, #3967
  static carreg2 + #177, #1070
  static carreg2 + #178, #3967
  static carreg2 + #179, #3967
  static carreg2 + #180, #3967
  static carreg2 + #181, #3967
  static carreg2 + #182, #3967
  static carreg2 + #183, #3967
  static carreg2 + #184, #3967
  static carreg2 + #185, #3967
  static carreg2 + #186, #3967
  static carreg2 + #187, #3967
  static carreg2 + #188, #3967
  static carreg2 + #189, #3967
  static carreg2 + #190, #3967
  static carreg2 + #191, #3967
  static carreg2 + #192, #512
  static carreg2 + #193, #3967
  static carreg2 + #194, #3967
  static carreg2 + #195, #512
  static carreg2 + #196, #3967
  static carreg2 + #197, #3967
  static carreg2 + #198, #1070
  static carreg2 + #199, #3967

  ;Linha 5
  static carreg2 + #200, #3967
  static carreg2 + #201, #3967
  static carreg2 + #202, #3967
  static carreg2 + #203, #3967
  static carreg2 + #204, #3967
  static carreg2 + #205, #2048
  static carreg2 + #206, #2048
  static carreg2 + #207, #3967
  static carreg2 + #208, #3967
  static carreg2 + #209, #3967
  static carreg2 + #210, #3967
  static carreg2 + #211, #3967
  static carreg2 + #212, #3967
  static carreg2 + #213, #3967
  static carreg2 + #214, #3967
  static carreg2 + #215, #3967
  static carreg2 + #216, #3967
  static carreg2 + #217, #3967
  static carreg2 + #218, #3967
  static carreg2 + #219, #3967
  static carreg2 + #220, #3967
  static carreg2 + #221, #3967
  static carreg2 + #222, #3967
  static carreg2 + #223, #1070
  static carreg2 + #224, #3967
  static carreg2 + #225, #3967
  static carreg2 + #226, #3967
  static carreg2 + #227, #3967
  static carreg2 + #228, #3967
  static carreg2 + #229, #3967
  static carreg2 + #230, #3967
  static carreg2 + #231, #3967
  static carreg2 + #232, #512
  static carreg2 + #233, #512
  static carreg2 + #234, #512
  static carreg2 + #235, #512
  static carreg2 + #236, #3967
  static carreg2 + #237, #3967
  static carreg2 + #238, #3967
  static carreg2 + #239, #3967

  ;Linha 6
  static carreg2 + #240, #3967
  static carreg2 + #241, #3967
  static carreg2 + #242, #2048
  static carreg2 + #243, #3967
  static carreg2 + #244, #3967
  static carreg2 + #245, #2048
  static carreg2 + #246, #2048
  static carreg2 + #247, #3967
  static carreg2 + #248, #3967
  static carreg2 + #249, #2048
  static carreg2 + #250, #3967
  static carreg2 + #251, #3967
  static carreg2 + #252, #3967
  static carreg2 + #253, #3967
  static carreg2 + #254, #3967
  static carreg2 + #255, #3967
  static carreg2 + #256, #3967
  static carreg2 + #257, #3967
  static carreg2 + #258, #3967
  static carreg2 + #259, #3967
  static carreg2 + #260, #3967
  static carreg2 + #261, #3967
  static carreg2 + #262, #3967
  static carreg2 + #263, #3967
  static carreg2 + #264, #3967
  static carreg2 + #265, #3967
  static carreg2 + #266, #3967
  static carreg2 + #267, #3967
  static carreg2 + #268, #3967
  static carreg2 + #269, #3967
  static carreg2 + #270, #3967
  static carreg2 + #271, #512
  static carreg2 + #272, #3967
  static carreg2 + #273, #512
  static carreg2 + #274, #512
  static carreg2 + #275, #3967
  static carreg2 + #276, #512
  static carreg2 + #277, #3967
  static carreg2 + #278, #3967
  static carreg2 + #279, #3967

  ;Linha 7
  static carreg2 + #280, #3967
  static carreg2 + #281, #3967
  static carreg2 + #282, #2048
  static carreg2 + #283, #3967
  static carreg2 + #284, #2048
  static carreg2 + #285, #2048
  static carreg2 + #286, #2048
  static carreg2 + #287, #2048
  static carreg2 + #288, #3967
  static carreg2 + #289, #2048
  static carreg2 + #290, #3967
  static carreg2 + #291, #3967
  static carreg2 + #292, #3967
  static carreg2 + #293, #3967
  static carreg2 + #294, #3967
  static carreg2 + #295, #3967
  static carreg2 + #296, #3967
  static carreg2 + #297, #3967
  static carreg2 + #298, #3967
  static carreg2 + #299, #3967
  static carreg2 + #300, #3967
  static carreg2 + #301, #3967
  static carreg2 + #302, #3967
  static carreg2 + #303, #3967
  static carreg2 + #304, #3967
  static carreg2 + #305, #3967
  static carreg2 + #306, #3967
  static carreg2 + #307, #3967
  static carreg2 + #308, #3967
  static carreg2 + #309, #3967
  static carreg2 + #310, #512
  static carreg2 + #311, #512
  static carreg2 + #312, #512
  static carreg2 + #313, #512
  static carreg2 + #314, #512
  static carreg2 + #315, #512
  static carreg2 + #316, #512
  static carreg2 + #317, #512
  static carreg2 + #318, #3967
  static carreg2 + #319, #3967

  ;Linha 8
  static carreg2 + #320, #3967
  static carreg2 + #321, #3967
  static carreg2 + #322, #2048
  static carreg2 + #323, #2048
  static carreg2 + #324, #2048
  static carreg2 + #325, #2048
  static carreg2 + #326, #2048
  static carreg2 + #327, #2048
  static carreg2 + #328, #2048
  static carreg2 + #329, #2048
  static carreg2 + #330, #3967
  static carreg2 + #331, #3967
  static carreg2 + #332, #3967
  static carreg2 + #333, #3967
  static carreg2 + #334, #3967
  static carreg2 + #335, #3967
  static carreg2 + #336, #3967
  static carreg2 + #337, #3967
  static carreg2 + #338, #3967
  static carreg2 + #339, #3967
  static carreg2 + #340, #3967
  static carreg2 + #341, #3967
  static carreg2 + #342, #3967
  static carreg2 + #343, #3967
  static carreg2 + #344, #3967
  static carreg2 + #345, #3967
  static carreg2 + #346, #3967
  static carreg2 + #347, #3967
  static carreg2 + #348, #3967
  static carreg2 + #349, #3967
  static carreg2 + #350, #512
  static carreg2 + #351, #3967
  static carreg2 + #352, #512
  static carreg2 + #353, #512
  static carreg2 + #354, #512
  static carreg2 + #355, #512
  static carreg2 + #356, #3967
  static carreg2 + #357, #512
  static carreg2 + #358, #3967
  static carreg2 + #359, #3967

  ;Linha 9
  static carreg2 + #360, #3967
  static carreg2 + #361, #3967
  static carreg2 + #362, #2048
  static carreg2 + #363, #2048
  static carreg2 + #364, #3967
  static carreg2 + #365, #2048
  static carreg2 + #366, #2048
  static carreg2 + #367, #3967
  static carreg2 + #368, #2048
  static carreg2 + #369, #2048
  static carreg2 + #370, #3967
  static carreg2 + #371, #3967
  static carreg2 + #372, #3967
  static carreg2 + #373, #3967
  static carreg2 + #374, #3967
  static carreg2 + #375, #1024
  static carreg2 + #376, #3967
  static carreg2 + #377, #1070
  static carreg2 + #378, #3967
  static carreg2 + #379, #1024
  static carreg2 + #380, #3967
  static carreg2 + #381, #3967
  static carreg2 + #382, #1024
  static carreg2 + #383, #1024
  static carreg2 + #384, #3967
  static carreg2 + #385, #3967
  static carreg2 + #386, #1070
  static carreg2 + #387, #3967
  static carreg2 + #388, #3967
  static carreg2 + #389, #3967
  static carreg2 + #390, #512
  static carreg2 + #391, #3967
  static carreg2 + #392, #512
  static carreg2 + #393, #3967
  static carreg2 + #394, #3967
  static carreg2 + #395, #512
  static carreg2 + #396, #3967
  static carreg2 + #397, #512
  static carreg2 + #398, #3967
  static carreg2 + #399, #3967

  ;Linha 10
  static carreg2 + #400, #1070
  static carreg2 + #401, #3967
  static carreg2 + #402, #2048
  static carreg2 + #403, #3967
  static carreg2 + #404, #3967
  static carreg2 + #405, #3967
  static carreg2 + #406, #3967
  static carreg2 + #407, #3967
  static carreg2 + #408, #3967
  static carreg2 + #409, #2048
  static carreg2 + #410, #3967
  static carreg2 + #411, #3967
  static carreg2 + #412, #1070
  static carreg2 + #413, #3967
  static carreg2 + #414, #3967
  static carreg2 + #415, #1024
  static carreg2 + #416, #3967
  static carreg2 + #417, #3967
  static carreg2 + #418, #3967
  static carreg2 + #419, #1024
  static carreg2 + #420, #3967
  static carreg2 + #421, #1024
  static carreg2 + #422, #3967
  static carreg2 + #423, #3967
  static carreg2 + #424, #1024
  static carreg2 + #425, #3967
  static carreg2 + #426, #3967
  static carreg2 + #427, #3967
  static carreg2 + #428, #3967
  static carreg2 + #429, #3967
  static carreg2 + #430, #3967
  static carreg2 + #431, #3967
  static carreg2 + #432, #512
  static carreg2 + #433, #3967
  static carreg2 + #434, #3967
  static carreg2 + #435, #512
  static carreg2 + #436, #3967
  static carreg2 + #437, #3967
  static carreg2 + #438, #3967
  static carreg2 + #439, #3967

  ;Linha 11
  static carreg2 + #440, #3967
  static carreg2 + #441, #3967
  static carreg2 + #442, #3967
  static carreg2 + #443, #3967
  static carreg2 + #444, #1070
  static carreg2 + #445, #3967
  static carreg2 + #446, #3967
  static carreg2 + #447, #3967
  static carreg2 + #448, #3967
  static carreg2 + #449, #3967
  static carreg2 + #450, #3967
  static carreg2 + #451, #3967
  static carreg2 + #452, #3967
  static carreg2 + #453, #3967
  static carreg2 + #454, #3967
  static carreg2 + #455, #1024
  static carreg2 + #456, #3967
  static carreg2 + #457, #3967
  static carreg2 + #458, #3967
  static carreg2 + #459, #1024
  static carreg2 + #460, #3967
  static carreg2 + #461, #1024
  static carreg2 + #462, #3967
  static carreg2 + #463, #3967
  static carreg2 + #464, #3967
  static carreg2 + #465, #3967
  static carreg2 + #466, #3967
  static carreg2 + #467, #3967
  static carreg2 + #468, #3967
  static carreg2 + #469, #3967
  static carreg2 + #470, #3967
  static carreg2 + #471, #3967
  static carreg2 + #472, #3967
  static carreg2 + #473, #3967
  static carreg2 + #474, #3967
  static carreg2 + #475, #3967
  static carreg2 + #476, #3967
  static carreg2 + #477, #3967
  static carreg2 + #478, #3967
  static carreg2 + #479, #3967

  ;Linha 12
  static carreg2 + #480, #3967
  static carreg2 + #481, #3967
  static carreg2 + #482, #3967
  static carreg2 + #483, #3967
  static carreg2 + #484, #3967
  static carreg2 + #485, #3967
  static carreg2 + #486, #3967
  static carreg2 + #487, #3967
  static carreg2 + #488, #3967
  static carreg2 + #489, #3967
  static carreg2 + #490, #3967
  static carreg2 + #491, #3967
  static carreg2 + #492, #3967
  static carreg2 + #493, #3967
  static carreg2 + #494, #3967
  static carreg2 + #495, #1024
  static carreg2 + #496, #3967
  static carreg2 + #497, #3967
  static carreg2 + #498, #3967
  static carreg2 + #499, #1024
  static carreg2 + #500, #3967
  static carreg2 + #501, #3967
  static carreg2 + #502, #1024
  static carreg2 + #503, #1024
  static carreg2 + #504, #3967
  static carreg2 + #505, #3967
  static carreg2 + #506, #3967
  static carreg2 + #507, #3967
  static carreg2 + #508, #3967
  static carreg2 + #509, #3967
  static carreg2 + #510, #3967
  static carreg2 + #511, #3967
  static carreg2 + #512, #3967
  static carreg2 + #513, #3967
  static carreg2 + #514, #3967
  static carreg2 + #515, #3967
  static carreg2 + #516, #3967
  static carreg2 + #517, #3967
  static carreg2 + #518, #3967
  static carreg2 + #519, #3967

  ;Linha 13
  static carreg2 + #520, #3967
  static carreg2 + #521, #3967
  static carreg2 + #522, #3967
  static carreg2 + #523, #3967
  static carreg2 + #524, #3967
  static carreg2 + #525, #3967
  static carreg2 + #526, #3967
  static carreg2 + #527, #3967
  static carreg2 + #528, #3967
  static carreg2 + #529, #3967
  static carreg2 + #530, #3967
  static carreg2 + #531, #3967
  static carreg2 + #532, #3967
  static carreg2 + #533, #3967
  static carreg2 + #534, #3967
  static carreg2 + #535, #1024
  static carreg2 + #536, #3967
  static carreg2 + #537, #3967
  static carreg2 + #538, #3967
  static carreg2 + #539, #1024
  static carreg2 + #540, #3967
  static carreg2 + #541, #3967
  static carreg2 + #542, #3967
  static carreg2 + #543, #3967
  static carreg2 + #544, #1024
  static carreg2 + #545, #3967
  static carreg2 + #546, #3967
  static carreg2 + #547, #3967
  static carreg2 + #548, #3967
  static carreg2 + #549, #1070
  static carreg2 + #550, #3967
  static carreg2 + #551, #3967
  static carreg2 + #552, #3967
  static carreg2 + #553, #3967
  static carreg2 + #554, #3967
  static carreg2 + #555, #3967
  static carreg2 + #556, #3967
  static carreg2 + #557, #3967
  static carreg2 + #558, #1070
  static carreg2 + #559, #3967

  ;Linha 14
  static carreg2 + #560, #3967
  static carreg2 + #561, #1070
  static carreg2 + #562, #3967
  static carreg2 + #563, #3967
  static carreg2 + #564, #2125
  static carreg2 + #565, #2159
  static carreg2 + #566, #2166
  static carreg2 + #567, #2106
  static carreg2 + #568, #3967
  static carreg2 + #569, #1070
  static carreg2 + #570, #3967
  static carreg2 + #571, #3967
  static carreg2 + #572, #3967
  static carreg2 + #573, #3967
  static carreg2 + #574, #3967
  static carreg2 + #575, #3967
  static carreg2 + #576, #1024
  static carreg2 + #577, #3967
  static carreg2 + #578, #1024
  static carreg2 + #579, #3967
  static carreg2 + #580, #3967
  static carreg2 + #581, #1024
  static carreg2 + #582, #3967
  static carreg2 + #583, #3967
  static carreg2 + #584, #1024
  static carreg2 + #585, #3967
  static carreg2 + #586, #3967
  static carreg2 + #587, #3967
  static carreg2 + #588, #3967
  static carreg2 + #589, #3967
  static carreg2 + #590, #3967
  static carreg2 + #591, #3967
  static carreg2 + #592, #589
  static carreg2 + #593, #623
  static carreg2 + #594, #630
  static carreg2 + #595, #570
  static carreg2 + #596, #3967
  static carreg2 + #597, #3967
  static carreg2 + #598, #3967
  static carreg2 + #599, #3967

  ;Linha 15
  static carreg2 + #600, #3967
  static carreg2 + #601, #3967
  static carreg2 + #602, #3967
  static carreg2 + #603, #3967
  static carreg2 + #604, #3967
  static carreg2 + #605, #3967
  static carreg2 + #606, #3967
  static carreg2 + #607, #3967
  static carreg2 + #608, #3967
  static carreg2 + #609, #3967
  static carreg2 + #610, #3967
  static carreg2 + #611, #3967
  static carreg2 + #612, #3967
  static carreg2 + #613, #1070
  static carreg2 + #614, #3967
  static carreg2 + #615, #3967
  static carreg2 + #616, #3967
  static carreg2 + #617, #1024
  static carreg2 + #618, #3967
  static carreg2 + #619, #3967
  static carreg2 + #620, #3967
  static carreg2 + #621, #3967
  static carreg2 + #622, #1024
  static carreg2 + #623, #1024
  static carreg2 + #624, #3967
  static carreg2 + #625, #3967
  static carreg2 + #626, #3967
  static carreg2 + #627, #1070
  static carreg2 + #628, #3967
  static carreg2 + #629, #3967
  static carreg2 + #630, #3967
  static carreg2 + #631, #3967
  static carreg2 + #632, #3967
  static carreg2 + #633, #3967
  static carreg2 + #634, #3967
  static carreg2 + #635, #3967
  static carreg2 + #636, #3967
  static carreg2 + #637, #3967
  static carreg2 + #638, #3967
  static carreg2 + #639, #3967

  ;Linha 16
  static carreg2 + #640, #3967
  static carreg2 + #641, #3967
  static carreg2 + #642, #3967
  static carreg2 + #643, #3967
  static carreg2 + #644, #3967
  static carreg2 + #645, #3967
  static carreg2 + #646, #3967
  static carreg2 + #647, #3967
  static carreg2 + #648, #3967
  static carreg2 + #649, #3967
  static carreg2 + #650, #3967
  static carreg2 + #651, #3967
  static carreg2 + #652, #3967
  static carreg2 + #653, #3967
  static carreg2 + #654, #3967
  static carreg2 + #655, #3967
  static carreg2 + #656, #3967
  static carreg2 + #657, #3967
  static carreg2 + #658, #3967
  static carreg2 + #659, #3967
  static carreg2 + #660, #3967
  static carreg2 + #661, #3967
  static carreg2 + #662, #3967
  static carreg2 + #663, #3967
  static carreg2 + #664, #3967
  static carreg2 + #665, #3967
  static carreg2 + #666, #3967
  static carreg2 + #667, #3967
  static carreg2 + #668, #3967
  static carreg2 + #669, #3967
  static carreg2 + #670, #3967
  static carreg2 + #671, #3967
  static carreg2 + #672, #3967
  static carreg2 + #673, #3967
  static carreg2 + #674, #3967
  static carreg2 + #675, #3967
  static carreg2 + #676, #3967
  static carreg2 + #677, #3967
  static carreg2 + #678, #3967
  static carreg2 + #679, #3967

  ;Linha 17
  static carreg2 + #680, #3967
  static carreg2 + #681, #3967
  static carreg2 + #682, #3967
  static carreg2 + #683, #3967
  static carreg2 + #684, #3967
  static carreg2 + #685, #2135
  static carreg2 + #686, #3967
  static carreg2 + #687, #3967
  static carreg2 + #688, #3967
  static carreg2 + #689, #3967
  static carreg2 + #690, #3967
  static carreg2 + #691, #3967
  static carreg2 + #692, #3967
  static carreg2 + #693, #3967
  static carreg2 + #694, #3967
  static carreg2 + #695, #3967
  static carreg2 + #696, #3967
  static carreg2 + #697, #3967
  static carreg2 + #698, #3967
  static carreg2 + #699, #3967
  static carreg2 + #700, #3967
  static carreg2 + #701, #1070
  static carreg2 + #702, #3967
  static carreg2 + #703, #3967
  static carreg2 + #704, #1070
  static carreg2 + #705, #3967
  static carreg2 + #706, #3967
  static carreg2 + #707, #3967
  static carreg2 + #708, #3967
  static carreg2 + #709, #3967
  static carreg2 + #710, #3967
  static carreg2 + #711, #3967
  static carreg2 + #712, #3967
  static carreg2 + #713, #3967
  static carreg2 + #714, #585
  static carreg2 + #715, #3967
  static carreg2 + #716, #3967
  static carreg2 + #717, #1070
  static carreg2 + #718, #3967
  static carreg2 + #719, #3967

  ;Linha 18
  static carreg2 + #720, #3967
  static carreg2 + #721, #3967
  static carreg2 + #722, #3967
  static carreg2 + #723, #3967
  static carreg2 + #724, #3967
  static carreg2 + #725, #3967
  static carreg2 + #726, #3967
  static carreg2 + #727, #3967
  static carreg2 + #728, #3967
  static carreg2 + #729, #3967
  static carreg2 + #730, #3967
  static carreg2 + #731, #3967
  static carreg2 + #732, #3967
  static carreg2 + #733, #1070
  static carreg2 + #734, #3967
  static carreg2 + #735, #1069
  static carreg2 + #736, #1069
  static carreg2 + #737, #1069
  static carreg2 + #738, #1069
  static carreg2 + #739, #1069
  static carreg2 + #740, #1069
  static carreg2 + #741, #3117
  static carreg2 + #742, #3117
  static carreg2 + #743, #1069
  static carreg2 + #744, #1069
  static carreg2 + #745, #3967
  static carreg2 + #746, #3967
  static carreg2 + #747, #3967
  static carreg2 + #748, #3967
  static carreg2 + #749, #3967
  static carreg2 + #750, #3967
  static carreg2 + #751, #3967
  static carreg2 + #752, #3967
  static carreg2 + #753, #3967
  static carreg2 + #754, #3967
  static carreg2 + #755, #3967
  static carreg2 + #756, #3967
  static carreg2 + #757, #3967
  static carreg2 + #758, #3967
  static carreg2 + #759, #3967

  ;Linha 19
  static carreg2 + #760, #3967
  static carreg2 + #761, #3967
  static carreg2 + #762, #3967
  static carreg2 + #763, #2113
  static carreg2 + #764, #3967
  static carreg2 + #765, #2131
  static carreg2 + #766, #3967
  static carreg2 + #767, #2116
  static carreg2 + #768, #3967
  static carreg2 + #769, #3967
  static carreg2 + #770, #3967
  static carreg2 + #771, #3967
  static carreg2 + #772, #3967
  static carreg2 + #773, #3967
  static carreg2 + #774, #3967
  static carreg2 + #775, #1091
  static carreg2 + #776, #1089
  static carreg2 + #777, #1106
  static carreg2 + #778, #1106
  static carreg2 + #779, #1093
  static carreg2 + #780, #1095
  static carreg2 + #781, #3137
  static carreg2 + #782, #3150
  static carreg2 + #783, #1092
  static carreg2 + #784, #1103
  static carreg2 + #785, #3967
  static carreg2 + #786, #3967
  static carreg2 + #787, #3967
  static carreg2 + #788, #3967
  static carreg2 + #789, #3967
  static carreg2 + #790, #3967
  static carreg2 + #791, #3967
  static carreg2 + #792, #586
  static carreg2 + #793, #3967
  static carreg2 + #794, #587
  static carreg2 + #795, #3967
  static carreg2 + #796, #588
  static carreg2 + #797, #3967
  static carreg2 + #798, #3967
  static carreg2 + #799, #3967

  ;Linha 20
  static carreg2 + #800, #3967
  static carreg2 + #801, #3967
  static carreg2 + #802, #3967
  static carreg2 + #803, #3967
  static carreg2 + #804, #3967
  static carreg2 + #805, #3967
  static carreg2 + #806, #3967
  static carreg2 + #807, #3967
  static carreg2 + #808, #3967
  static carreg2 + #809, #3967
  static carreg2 + #810, #3967
  static carreg2 + #811, #3967
  static carreg2 + #812, #3967
  static carreg2 + #813, #3967
  static carreg2 + #814, #3967
  static carreg2 + #815, #1069
  static carreg2 + #816, #1069
  static carreg2 + #817, #1069
  static carreg2 + #818, #1069
  static carreg2 + #819, #1069
  static carreg2 + #820, #1069
  static carreg2 + #821, #3117
  static carreg2 + #822, #3117
  static carreg2 + #823, #1069
  static carreg2 + #824, #1069
  static carreg2 + #825, #3967
  static carreg2 + #826, #3967
  static carreg2 + #827, #3967
  static carreg2 + #828, #1070
  static carreg2 + #829, #3967
  static carreg2 + #830, #3967
  static carreg2 + #831, #3967
  static carreg2 + #832, #3967
  static carreg2 + #833, #3967
  static carreg2 + #834, #3967
  static carreg2 + #835, #3967
  static carreg2 + #836, #3967
  static carreg2 + #837, #3967
  static carreg2 + #838, #3967
  static carreg2 + #839, #3967

  ;Linha 21
  static carreg2 + #840, #3967
  static carreg2 + #841, #1070
  static carreg2 + #842, #3967
  static carreg2 + #843, #3967
  static carreg2 + #844, #1070
  static carreg2 + #845, #3967
  static carreg2 + #846, #3967
  static carreg2 + #847, #3967
  static carreg2 + #848, #3967
  static carreg2 + #849, #3967
  static carreg2 + #850, #3967
  static carreg2 + #851, #3967
  static carreg2 + #852, #3967
  static carreg2 + #853, #3967
  static carreg2 + #854, #3967
  static carreg2 + #855, #3967
  static carreg2 + #856, #3967
  static carreg2 + #857, #3967
  static carreg2 + #858, #3967
  static carreg2 + #859, #3967
  static carreg2 + #860, #3967
  static carreg2 + #861, #3967
  static carreg2 + #862, #3967
  static carreg2 + #863, #3967
  static carreg2 + #864, #3967
  static carreg2 + #865, #3967
  static carreg2 + #866, #3967
  static carreg2 + #867, #3967
  static carreg2 + #868, #3967
  static carreg2 + #869, #3967
  static carreg2 + #870, #3967
  static carreg2 + #871, #3967
  static carreg2 + #872, #3967
  static carreg2 + #873, #3967
  static carreg2 + #874, #1070
  static carreg2 + #875, #3967
  static carreg2 + #876, #3967
  static carreg2 + #877, #3967
  static carreg2 + #878, #3967
  static carreg2 + #879, #1070

  ;Linha 22
  static carreg2 + #880, #3967
  static carreg2 + #881, #3967
  static carreg2 + #882, #3967
  static carreg2 + #883, #3967
  static carreg2 + #884, #3967
  static carreg2 + #885, #3967
  static carreg2 + #886, #3967
  static carreg2 + #887, #3967
  static carreg2 + #888, #3967
  static carreg2 + #889, #3967
  static carreg2 + #890, #3967
  static carreg2 + #891, #1070
  static carreg2 + #892, #3967
  static carreg2 + #893, #3967
  static carreg2 + #894, #3967
  static carreg2 + #895, #3967
  static carreg2 + #896, #3967
  static carreg2 + #897, #3967
  static carreg2 + #898, #3967
  static carreg2 + #899, #3967
  static carreg2 + #900, #1070
  static carreg2 + #901, #3967
  static carreg2 + #902, #3967
  static carreg2 + #903, #3967
  static carreg2 + #904, #3967
  static carreg2 + #905, #3967
  static carreg2 + #906, #3967
  static carreg2 + #907, #3967
  static carreg2 + #908, #3967
  static carreg2 + #909, #3967
  static carreg2 + #910, #3967
  static carreg2 + #911, #3967
  static carreg2 + #912, #3967
  static carreg2 + #913, #3967
  static carreg2 + #914, #3967
  static carreg2 + #915, #3967
  static carreg2 + #916, #3967
  static carreg2 + #917, #3967
  static carreg2 + #918, #3967
  static carreg2 + #919, #3967

  ;Linha 23
  static carreg2 + #920, #3967
  static carreg2 + #921, #3967
  static carreg2 + #922, #3967
  static carreg2 + #923, #2131
  static carreg2 + #924, #2152
  static carreg2 + #925, #2159
  static carreg2 + #926, #2159
  static carreg2 + #927, #2164
  static carreg2 + #928, #2106
  static carreg2 + #929, #3967
  static carreg2 + #930, #3967
  static carreg2 + #931, #3967
  static carreg2 + #932, #3967
  static carreg2 + #933, #3967
  static carreg2 + #934, #3967
  static carreg2 + #935, #3967
  static carreg2 + #936, #3967
  static carreg2 + #937, #3967
  static carreg2 + #938, #3967
  static carreg2 + #939, #3967
  static carreg2 + #940, #3967
  static carreg2 + #941, #3967
  static carreg2 + #942, #3967
  static carreg2 + #943, #3967
  static carreg2 + #944, #3967
  static carreg2 + #945, #1070
  static carreg2 + #946, #3967
  static carreg2 + #947, #3967
  static carreg2 + #948, #3967
  static carreg2 + #949, #3967
  static carreg2 + #950, #3967
  static carreg2 + #951, #595
  static carreg2 + #952, #616
  static carreg2 + #953, #623
  static carreg2 + #954, #623
  static carreg2 + #955, #628
  static carreg2 + #956, #570
  static carreg2 + #957, #3967
  static carreg2 + #958, #3967
  static carreg2 + #959, #3967

  ;Linha 24
  static carreg2 + #960, #3967
  static carreg2 + #961, #3967
  static carreg2 + #962, #3967
  static carreg2 + #963, #3967
  static carreg2 + #964, #3967
  static carreg2 + #965, #3967
  static carreg2 + #966, #3967
  static carreg2 + #967, #3967
  static carreg2 + #968, #3967
  static carreg2 + #969, #3967
  static carreg2 + #970, #3967
  static carreg2 + #971, #3967
  static carreg2 + #972, #3967
  static carreg2 + #973, #3967
  static carreg2 + #974, #3967
  static carreg2 + #975, #3967
  static carreg2 + #976, #3967
  static carreg2 + #977, #3967
  static carreg2 + #978, #3967
  static carreg2 + #979, #3967
  static carreg2 + #980, #3967
  static carreg2 + #981, #3967
  static carreg2 + #982, #3967
  static carreg2 + #983, #3967
  static carreg2 + #984, #3967
  static carreg2 + #985, #3967
  static carreg2 + #986, #1070
  static carreg2 + #987, #3967
  static carreg2 + #988, #3967
  static carreg2 + #989, #3967
  static carreg2 + #990, #3967
  static carreg2 + #991, #3967
  static carreg2 + #992, #3967
  static carreg2 + #993, #3967
  static carreg2 + #994, #3967
  static carreg2 + #995, #3967
  static carreg2 + #996, #3967
  static carreg2 + #997, #3967
  static carreg2 + #998, #3967
  static carreg2 + #999, #3967

  ;Linha 25
  static carreg2 + #1000, #3967
  static carreg2 + #1001, #3967
  static carreg2 + #1002, #3967
  static carreg2 + #1003, #3967
  static carreg2 + #1004, #3967
  static carreg2 + #1005, #3967
  static carreg2 + #1006, #3967
  static carreg2 + #1007, #3967
  static carreg2 + #1008, #3967
  static carreg2 + #1009, #3967
  static carreg2 + #1010, #3967
  static carreg2 + #1011, #3967
  static carreg2 + #1012, #3967
  static carreg2 + #1013, #3967
  static carreg2 + #1014, #1070
  static carreg2 + #1015, #3967
  static carreg2 + #1016, #3967
  static carreg2 + #1017, #3967
  static carreg2 + #1018, #3967
  static carreg2 + #1019, #3967
  static carreg2 + #1020, #3967
  static carreg2 + #1021, #3967
  static carreg2 + #1022, #3967
  static carreg2 + #1023, #3967
  static carreg2 + #1024, #3967
  static carreg2 + #1025, #3967
  static carreg2 + #1026, #3967
  static carreg2 + #1027, #3967
  static carreg2 + #1028, #3967
  static carreg2 + #1029, #3967
  static carreg2 + #1030, #3967
  static carreg2 + #1031, #3967
  static carreg2 + #1032, #3967
  static carreg2 + #1033, #3967
  static carreg2 + #1034, #3967
  static carreg2 + #1035, #3967
  static carreg2 + #1036, #3967
  static carreg2 + #1037, #3967
  static carreg2 + #1038, #3967
  static carreg2 + #1039, #3967

  ;Linha 26
  static carreg2 + #1040, #3967
  static carreg2 + #1041, #3967
  static carreg2 + #1042, #3967
  static carreg2 + #1043, #3967
  static carreg2 + #1044, #3967
  static carreg2 + #1045, #2117
  static carreg2 + #1046, #3967
  static carreg2 + #1047, #3967
  static carreg2 + #1048, #3967
  static carreg2 + #1049, #3967
  static carreg2 + #1050, #3967
  static carreg2 + #1051, #3967
  static carreg2 + #1052, #3967
  static carreg2 + #1053, #3967
  static carreg2 + #1054, #3967
  static carreg2 + #1055, #3967
  static carreg2 + #1056, #3967
  static carreg2 + #1057, #3967
  static carreg2 + #1058, #1070
  static carreg2 + #1059, #3967
  static carreg2 + #1060, #3967
  static carreg2 + #1061, #3967
  static carreg2 + #1062, #3967
  static carreg2 + #1063, #3967
  static carreg2 + #1064, #3967
  static carreg2 + #1065, #3967
  static carreg2 + #1066, #3967
  static carreg2 + #1067, #3967
  static carreg2 + #1068, #3967
  static carreg2 + #1069, #3967
  static carreg2 + #1070, #3967
  static carreg2 + #1071, #3967
  static carreg2 + #1072, #3967
  static carreg2 + #1073, #3967
  static carreg2 + #1074, #592
  static carreg2 + #1075, #3967
  static carreg2 + #1076, #3967
  static carreg2 + #1077, #3967
  static carreg2 + #1078, #1070
  static carreg2 + #1079, #3967

  ;Linha 27
  static carreg2 + #1080, #3967
  static carreg2 + #1081, #3967
  static carreg2 + #1082, #1070
  static carreg2 + #1083, #3967
  static carreg2 + #1084, #3967
  static carreg2 + #1085, #3967
  static carreg2 + #1086, #3967
  static carreg2 + #1087, #3967
  static carreg2 + #1088, #3967
  static carreg2 + #1089, #3967
  static carreg2 + #1090, #3967
  static carreg2 + #1091, #3967
  static carreg2 + #1092, #3967
  static carreg2 + #1093, #3967
  static carreg2 + #1094, #3967
  static carreg2 + #1095, #3967
  static carreg2 + #1096, #3967
  static carreg2 + #1097, #3967
  static carreg2 + #1098, #3967
  static carreg2 + #1099, #3967
  static carreg2 + #1100, #3967
  static carreg2 + #1101, #3967
  static carreg2 + #1102, #3967
  static carreg2 + #1103, #3967
  static carreg2 + #1104, #3967
  static carreg2 + #1105, #3967
  static carreg2 + #1106, #3967
  static carreg2 + #1107, #3967
  static carreg2 + #1108, #1070
  static carreg2 + #1109, #3967
  static carreg2 + #1110, #3967
  static carreg2 + #1111, #3967
  static carreg2 + #1112, #3967
  static carreg2 + #1113, #3967
  static carreg2 + #1114, #3967
  static carreg2 + #1115, #3967
  static carreg2 + #1116, #3967
  static carreg2 + #1117, #3967
  static carreg2 + #1118, #3967
  static carreg2 + #1119, #3967

  ;Linha 28
  static carreg2 + #1120, #3967
  static carreg2 + #1121, #3967
  static carreg2 + #1122, #3967
  static carreg2 + #1123, #3967
  static carreg2 + #1124, #3967
  static carreg2 + #1125, #3967
  static carreg2 + #1126, #3967
  static carreg2 + #1127, #3967
  static carreg2 + #1128, #3967
  static carreg2 + #1129, #3967
  static carreg2 + #1130, #3967
  static carreg2 + #1131, #1070
  static carreg2 + #1132, #3967
  static carreg2 + #1133, #3967
  static carreg2 + #1134, #3967
  static carreg2 + #1135, #3967
  static carreg2 + #1136, #3967
  static carreg2 + #1137, #3967
  static carreg2 + #1138, #3967
  static carreg2 + #1139, #3967
  static carreg2 + #1140, #3967
  static carreg2 + #1141, #3967
  static carreg2 + #1142, #1070
  static carreg2 + #1143, #3967
  static carreg2 + #1144, #3967
  static carreg2 + #1145, #3967
  static carreg2 + #1146, #3967
  static carreg2 + #1147, #3967
  static carreg2 + #1148, #3967
  static carreg2 + #1149, #3967
  static carreg2 + #1150, #3967
  static carreg2 + #1151, #3967
  static carreg2 + #1152, #3967
  static carreg2 + #1153, #3967
  static carreg2 + #1154, #3967
  static carreg2 + #1155, #3967
  static carreg2 + #1156, #3967
  static carreg2 + #1157, #3967
  static carreg2 + #1158, #3967
  static carreg2 + #1159, #3967

  ;Linha 29
  static carreg2 + #1160, #3967
  static carreg2 + #1161, #3967
  static carreg2 + #1162, #3967
  static carreg2 + #1163, #3967
  static carreg2 + #1164, #3967
  static carreg2 + #1165, #3967
  static carreg2 + #1166, #3967
  static carreg2 + #1167, #3967
  static carreg2 + #1168, #3967
  static carreg2 + #1169, #3967
  static carreg2 + #1170, #3967
  static carreg2 + #1171, #3967
  static carreg2 + #1172, #3967
  static carreg2 + #1173, #3967
  static carreg2 + #1174, #3967
  static carreg2 + #1175, #3967
  static carreg2 + #1176, #3967
  static carreg2 + #1177, #3967
  static carreg2 + #1178, #3967
  static carreg2 + #1179, #3967
  static carreg2 + #1180, #3967
  static carreg2 + #1181, #3967
  static carreg2 + #1182, #3967
  static carreg2 + #1183, #3967
  static carreg2 + #1184, #3967
  static carreg2 + #1185, #3967
  static carreg2 + #1186, #3967
  static carreg2 + #1187, #3967
  static carreg2 + #1188, #3967
  static carreg2 + #1189, #3967
  static carreg2 + #1190, #3967
  static carreg2 + #1191, #3967
  static carreg2 + #1192, #3967
  static carreg2 + #1193, #3967
  static carreg2 + #1194, #3967
  static carreg2 + #1195, #3967
  static carreg2 + #1196, #1070
  static carreg2 + #1197, #3967
  static carreg2 + #1198, #3967
  static carreg2 + #1199, #3967
carreg3 : var #1200
  ;Linha 0
  static carreg3 + #0, #3967
  static carreg3 + #1, #3967
  static carreg3 + #2, #3967
  static carreg3 + #3, #3967
  static carreg3 + #4, #3967
  static carreg3 + #5, #3967
  static carreg3 + #6, #3967
  static carreg3 + #7, #3967
  static carreg3 + #8, #3967
  static carreg3 + #9, #3967
  static carreg3 + #10, #3967
  static carreg3 + #11, #3967
  static carreg3 + #12, #3967
  static carreg3 + #13, #3967
  static carreg3 + #14, #3967
  static carreg3 + #15, #3967
  static carreg3 + #16, #3967
  static carreg3 + #17, #3967
  static carreg3 + #18, #3967
  static carreg3 + #19, #3967
  static carreg3 + #20, #3967
  static carreg3 + #21, #3967
  static carreg3 + #22, #3967
  static carreg3 + #23, #1070
  static carreg3 + #24, #3967
  static carreg3 + #25, #3967
  static carreg3 + #26, #3967
  static carreg3 + #27, #3967
  static carreg3 + #28, #3967
  static carreg3 + #29, #3967
  static carreg3 + #30, #3967
  static carreg3 + #31, #3967
  static carreg3 + #32, #3967
  static carreg3 + #33, #3967
  static carreg3 + #34, #3967
  static carreg3 + #35, #3967
  static carreg3 + #36, #3967
  static carreg3 + #37, #3967
  static carreg3 + #38, #3967
  static carreg3 + #39, #3967

  ;Linha 1
  static carreg3 + #40, #3967
  static carreg3 + #41, #3967
  static carreg3 + #42, #3967
  static carreg3 + #43, #1070
  static carreg3 + #44, #3967
  static carreg3 + #45, #2128
  static carreg3 + #46, #2097
  static carreg3 + #47, #3967
  static carreg3 + #48, #3967
  static carreg3 + #49, #3967
  static carreg3 + #50, #3967
  static carreg3 + #51, #3967
  static carreg3 + #52, #3967
  static carreg3 + #53, #3967
  static carreg3 + #54, #3967
  static carreg3 + #55, #1070
  static carreg3 + #56, #3967
  static carreg3 + #57, #3967
  static carreg3 + #58, #3967
  static carreg3 + #59, #3967
  static carreg3 + #60, #3967
  static carreg3 + #61, #3967
  static carreg3 + #62, #3967
  static carreg3 + #63, #3967
  static carreg3 + #64, #3967
  static carreg3 + #65, #3967
  static carreg3 + #66, #3967
  static carreg3 + #67, #3967
  static carreg3 + #68, #1070
  static carreg3 + #69, #3967
  static carreg3 + #70, #3967
  static carreg3 + #71, #3967
  static carreg3 + #72, #3967
  static carreg3 + #73, #592
  static carreg3 + #74, #562
  static carreg3 + #75, #3967
  static carreg3 + #76, #3967
  static carreg3 + #77, #1070
  static carreg3 + #78, #3967
  static carreg3 + #79, #3967

  ;Linha 2
  static carreg3 + #80, #3967
  static carreg3 + #81, #1070
  static carreg3 + #82, #3967
  static carreg3 + #83, #3967
  static carreg3 + #84, #3967
  static carreg3 + #85, #3967
  static carreg3 + #86, #3967
  static carreg3 + #87, #3967
  static carreg3 + #88, #3967
  static carreg3 + #89, #3967
  static carreg3 + #90, #3967
  static carreg3 + #91, #1070
  static carreg3 + #92, #3967
  static carreg3 + #93, #3967
  static carreg3 + #94, #3967
  static carreg3 + #95, #3967
  static carreg3 + #96, #3967
  static carreg3 + #97, #3967
  static carreg3 + #98, #3967
  static carreg3 + #99, #3967
  static carreg3 + #100, #3967
  static carreg3 + #101, #3967
  static carreg3 + #102, #3967
  static carreg3 + #103, #3967
  static carreg3 + #104, #3967
  static carreg3 + #105, #3967
  static carreg3 + #106, #3967
  static carreg3 + #107, #3967
  static carreg3 + #108, #3967
  static carreg3 + #109, #3967
  static carreg3 + #110, #3967
  static carreg3 + #111, #3967
  static carreg3 + #112, #3967
  static carreg3 + #113, #3967
  static carreg3 + #114, #3967
  static carreg3 + #115, #3967
  static carreg3 + #116, #3967
  static carreg3 + #117, #3967
  static carreg3 + #118, #3967
  static carreg3 + #119, #3967

  ;Linha 3
  static carreg3 + #120, #3967
  static carreg3 + #121, #3967
  static carreg3 + #122, #3967
  static carreg3 + #123, #3967
  static carreg3 + #124, #3967
  static carreg3 + #125, #2048
  static carreg3 + #126, #2048
  static carreg3 + #127, #3967
  static carreg3 + #128, #1070
  static carreg3 + #129, #3967
  static carreg3 + #130, #3967
  static carreg3 + #131, #3967
  static carreg3 + #132, #3967
  static carreg3 + #133, #3967
  static carreg3 + #134, #3967
  static carreg3 + #135, #3967
  static carreg3 + #136, #3967
  static carreg3 + #137, #3967
  static carreg3 + #138, #3967
  static carreg3 + #139, #3967
  static carreg3 + #140, #3967
  static carreg3 + #141, #3967
  static carreg3 + #142, #3967
  static carreg3 + #143, #3967
  static carreg3 + #144, #3967
  static carreg3 + #145, #3967
  static carreg3 + #146, #1070
  static carreg3 + #147, #3967
  static carreg3 + #148, #3967
  static carreg3 + #149, #3967
  static carreg3 + #150, #512
  static carreg3 + #151, #512
  static carreg3 + #152, #3967
  static carreg3 + #153, #3967
  static carreg3 + #154, #3967
  static carreg3 + #155, #3967
  static carreg3 + #156, #512
  static carreg3 + #157, #512
  static carreg3 + #158, #3967
  static carreg3 + #159, #3967

  ;Linha 4
  static carreg3 + #160, #3967
  static carreg3 + #161, #3967
  static carreg3 + #162, #3967
  static carreg3 + #163, #3967
  static carreg3 + #164, #3967
  static carreg3 + #165, #2048
  static carreg3 + #166, #2048
  static carreg3 + #167, #3967
  static carreg3 + #168, #3967
  static carreg3 + #169, #3967
  static carreg3 + #170, #3967
  static carreg3 + #171, #3967
  static carreg3 + #172, #3967
  static carreg3 + #173, #3967
  static carreg3 + #174, #3967
  static carreg3 + #175, #3967
  static carreg3 + #176, #3967
  static carreg3 + #177, #1070
  static carreg3 + #178, #3967
  static carreg3 + #179, #3967
  static carreg3 + #180, #3967
  static carreg3 + #181, #3967
  static carreg3 + #182, #3967
  static carreg3 + #183, #3967
  static carreg3 + #184, #3967
  static carreg3 + #185, #3967
  static carreg3 + #186, #3967
  static carreg3 + #187, #3967
  static carreg3 + #188, #3967
  static carreg3 + #189, #3967
  static carreg3 + #190, #3967
  static carreg3 + #191, #3967
  static carreg3 + #192, #512
  static carreg3 + #193, #3967
  static carreg3 + #194, #3967
  static carreg3 + #195, #512
  static carreg3 + #196, #3967
  static carreg3 + #197, #3967
  static carreg3 + #198, #1070
  static carreg3 + #199, #3967

  ;Linha 5
  static carreg3 + #200, #3967
  static carreg3 + #201, #3967
  static carreg3 + #202, #3967
  static carreg3 + #203, #3967
  static carreg3 + #204, #3967
  static carreg3 + #205, #2048
  static carreg3 + #206, #2048
  static carreg3 + #207, #3967
  static carreg3 + #208, #3967
  static carreg3 + #209, #3967
  static carreg3 + #210, #3967
  static carreg3 + #211, #3967
  static carreg3 + #212, #3967
  static carreg3 + #213, #3967
  static carreg3 + #214, #3967
  static carreg3 + #215, #3967
  static carreg3 + #216, #3967
  static carreg3 + #217, #3967
  static carreg3 + #218, #3967
  static carreg3 + #219, #3967
  static carreg3 + #220, #3967
  static carreg3 + #221, #3967
  static carreg3 + #222, #3967
  static carreg3 + #223, #1070
  static carreg3 + #224, #3967
  static carreg3 + #225, #3967
  static carreg3 + #226, #3967
  static carreg3 + #227, #3967
  static carreg3 + #228, #3967
  static carreg3 + #229, #3967
  static carreg3 + #230, #3967
  static carreg3 + #231, #3967
  static carreg3 + #232, #512
  static carreg3 + #233, #512
  static carreg3 + #234, #512
  static carreg3 + #235, #512
  static carreg3 + #236, #3967
  static carreg3 + #237, #3967
  static carreg3 + #238, #3967
  static carreg3 + #239, #3967

  ;Linha 6
  static carreg3 + #240, #3967
  static carreg3 + #241, #3967
  static carreg3 + #242, #2048
  static carreg3 + #243, #3967
  static carreg3 + #244, #3967
  static carreg3 + #245, #2048
  static carreg3 + #246, #2048
  static carreg3 + #247, #3967
  static carreg3 + #248, #3967
  static carreg3 + #249, #2048
  static carreg3 + #250, #3967
  static carreg3 + #251, #3967
  static carreg3 + #252, #3967
  static carreg3 + #253, #3967
  static carreg3 + #254, #3967
  static carreg3 + #255, #3967
  static carreg3 + #256, #3967
  static carreg3 + #257, #3967
  static carreg3 + #258, #3967
  static carreg3 + #259, #3967
  static carreg3 + #260, #3967
  static carreg3 + #261, #3967
  static carreg3 + #262, #3967
  static carreg3 + #263, #3967
  static carreg3 + #264, #3967
  static carreg3 + #265, #3967
  static carreg3 + #266, #3967
  static carreg3 + #267, #3967
  static carreg3 + #268, #3967
  static carreg3 + #269, #3967
  static carreg3 + #270, #3967
  static carreg3 + #271, #512
  static carreg3 + #272, #3967
  static carreg3 + #273, #512
  static carreg3 + #274, #512
  static carreg3 + #275, #3967
  static carreg3 + #276, #512
  static carreg3 + #277, #3967
  static carreg3 + #278, #3967
  static carreg3 + #279, #3967

  ;Linha 7
  static carreg3 + #280, #3967
  static carreg3 + #281, #3967
  static carreg3 + #282, #2048
  static carreg3 + #283, #3967
  static carreg3 + #284, #2048
  static carreg3 + #285, #2048
  static carreg3 + #286, #2048
  static carreg3 + #287, #2048
  static carreg3 + #288, #3967
  static carreg3 + #289, #2048
  static carreg3 + #290, #3967
  static carreg3 + #291, #3967
  static carreg3 + #292, #3967
  static carreg3 + #293, #3967
  static carreg3 + #294, #3967
  static carreg3 + #295, #3967
  static carreg3 + #296, #3967
  static carreg3 + #297, #3967
  static carreg3 + #298, #3967
  static carreg3 + #299, #3967
  static carreg3 + #300, #3967
  static carreg3 + #301, #3967
  static carreg3 + #302, #3967
  static carreg3 + #303, #3967
  static carreg3 + #304, #3967
  static carreg3 + #305, #3967
  static carreg3 + #306, #3967
  static carreg3 + #307, #3967
  static carreg3 + #308, #3967
  static carreg3 + #309, #3967
  static carreg3 + #310, #512
  static carreg3 + #311, #512
  static carreg3 + #312, #512
  static carreg3 + #313, #512
  static carreg3 + #314, #512
  static carreg3 + #315, #512
  static carreg3 + #316, #512
  static carreg3 + #317, #512
  static carreg3 + #318, #3967
  static carreg3 + #319, #3967

  ;Linha 8
  static carreg3 + #320, #3967
  static carreg3 + #321, #3967
  static carreg3 + #322, #2048
  static carreg3 + #323, #2048
  static carreg3 + #324, #2048
  static carreg3 + #325, #2048
  static carreg3 + #326, #2048
  static carreg3 + #327, #2048
  static carreg3 + #328, #2048
  static carreg3 + #329, #2048
  static carreg3 + #330, #3967
  static carreg3 + #331, #3967
  static carreg3 + #332, #3967
  static carreg3 + #333, #3967
  static carreg3 + #334, #3967
  static carreg3 + #335, #3967
  static carreg3 + #336, #3967
  static carreg3 + #337, #3967
  static carreg3 + #338, #3967
  static carreg3 + #339, #3967
  static carreg3 + #340, #3967
  static carreg3 + #341, #3967
  static carreg3 + #342, #3967
  static carreg3 + #343, #3967
  static carreg3 + #344, #3967
  static carreg3 + #345, #3967
  static carreg3 + #346, #3967
  static carreg3 + #347, #3967
  static carreg3 + #348, #3967
  static carreg3 + #349, #3967
  static carreg3 + #350, #512
  static carreg3 + #351, #3967
  static carreg3 + #352, #512
  static carreg3 + #353, #512
  static carreg3 + #354, #512
  static carreg3 + #355, #512
  static carreg3 + #356, #3967
  static carreg3 + #357, #512
  static carreg3 + #358, #3967
  static carreg3 + #359, #3967

  ;Linha 9
  static carreg3 + #360, #3967
  static carreg3 + #361, #3967
  static carreg3 + #362, #2048
  static carreg3 + #363, #2048
  static carreg3 + #364, #3967
  static carreg3 + #365, #2048
  static carreg3 + #366, #2048
  static carreg3 + #367, #3967
  static carreg3 + #368, #2048
  static carreg3 + #369, #2048
  static carreg3 + #370, #3967
  static carreg3 + #371, #3967
  static carreg3 + #372, #3967
  static carreg3 + #373, #3967
  static carreg3 + #374, #3967
  static carreg3 + #375, #1024
  static carreg3 + #376, #3967
  static carreg3 + #377, #1070
  static carreg3 + #378, #3967
  static carreg3 + #379, #1024
  static carreg3 + #380, #3967
  static carreg3 + #381, #3967
  static carreg3 + #382, #1024
  static carreg3 + #383, #1024
  static carreg3 + #384, #3967
  static carreg3 + #385, #3967
  static carreg3 + #386, #1070
  static carreg3 + #387, #3967
  static carreg3 + #388, #3967
  static carreg3 + #389, #3967
  static carreg3 + #390, #512
  static carreg3 + #391, #3967
  static carreg3 + #392, #512
  static carreg3 + #393, #3967
  static carreg3 + #394, #3967
  static carreg3 + #395, #512
  static carreg3 + #396, #3967
  static carreg3 + #397, #512
  static carreg3 + #398, #3967
  static carreg3 + #399, #3967

  ;Linha 10
  static carreg3 + #400, #1070
  static carreg3 + #401, #3967
  static carreg3 + #402, #2048
  static carreg3 + #403, #3967
  static carreg3 + #404, #3967
  static carreg3 + #405, #3967
  static carreg3 + #406, #3967
  static carreg3 + #407, #3967
  static carreg3 + #408, #3967
  static carreg3 + #409, #2048
  static carreg3 + #410, #3967
  static carreg3 + #411, #3967
  static carreg3 + #412, #1070
  static carreg3 + #413, #3967
  static carreg3 + #414, #3967
  static carreg3 + #415, #1024
  static carreg3 + #416, #3967
  static carreg3 + #417, #3967
  static carreg3 + #418, #3967
  static carreg3 + #419, #1024
  static carreg3 + #420, #3967
  static carreg3 + #421, #1024
  static carreg3 + #422, #3967
  static carreg3 + #423, #3967
  static carreg3 + #424, #1024
  static carreg3 + #425, #3967
  static carreg3 + #426, #3967
  static carreg3 + #427, #3967
  static carreg3 + #428, #3967
  static carreg3 + #429, #3967
  static carreg3 + #430, #3967
  static carreg3 + #431, #3967
  static carreg3 + #432, #512
  static carreg3 + #433, #3967
  static carreg3 + #434, #3967
  static carreg3 + #435, #512
  static carreg3 + #436, #3967
  static carreg3 + #437, #3967
  static carreg3 + #438, #3967
  static carreg3 + #439, #3967

  ;Linha 11
  static carreg3 + #440, #3967
  static carreg3 + #441, #3967
  static carreg3 + #442, #3967
  static carreg3 + #443, #3967
  static carreg3 + #444, #1070
  static carreg3 + #445, #3967
  static carreg3 + #446, #3967
  static carreg3 + #447, #3967
  static carreg3 + #448, #3967
  static carreg3 + #449, #3967
  static carreg3 + #450, #3967
  static carreg3 + #451, #3967
  static carreg3 + #452, #3967
  static carreg3 + #453, #3967
  static carreg3 + #454, #3967
  static carreg3 + #455, #1024
  static carreg3 + #456, #3967
  static carreg3 + #457, #3967
  static carreg3 + #458, #3967
  static carreg3 + #459, #1024
  static carreg3 + #460, #3967
  static carreg3 + #461, #1024
  static carreg3 + #462, #3967
  static carreg3 + #463, #3967
  static carreg3 + #464, #3967
  static carreg3 + #465, #3967
  static carreg3 + #466, #3967
  static carreg3 + #467, #3967
  static carreg3 + #468, #3967
  static carreg3 + #469, #3967
  static carreg3 + #470, #3967
  static carreg3 + #471, #3967
  static carreg3 + #472, #3967
  static carreg3 + #473, #3967
  static carreg3 + #474, #3967
  static carreg3 + #475, #3967
  static carreg3 + #476, #3967
  static carreg3 + #477, #3967
  static carreg3 + #478, #3967
  static carreg3 + #479, #3967

  ;Linha 12
  static carreg3 + #480, #3967
  static carreg3 + #481, #3967
  static carreg3 + #482, #3967
  static carreg3 + #483, #3967
  static carreg3 + #484, #3967
  static carreg3 + #485, #3967
  static carreg3 + #486, #3967
  static carreg3 + #487, #3967
  static carreg3 + #488, #3967
  static carreg3 + #489, #3967
  static carreg3 + #490, #3967
  static carreg3 + #491, #3967
  static carreg3 + #492, #3967
  static carreg3 + #493, #3967
  static carreg3 + #494, #3967
  static carreg3 + #495, #1024
  static carreg3 + #496, #3967
  static carreg3 + #497, #3967
  static carreg3 + #498, #3967
  static carreg3 + #499, #1024
  static carreg3 + #500, #3967
  static carreg3 + #501, #3967
  static carreg3 + #502, #1024
  static carreg3 + #503, #1024
  static carreg3 + #504, #3967
  static carreg3 + #505, #3967
  static carreg3 + #506, #3967
  static carreg3 + #507, #3967
  static carreg3 + #508, #3967
  static carreg3 + #509, #3967
  static carreg3 + #510, #3967
  static carreg3 + #511, #3967
  static carreg3 + #512, #3967
  static carreg3 + #513, #3967
  static carreg3 + #514, #3967
  static carreg3 + #515, #3967
  static carreg3 + #516, #3967
  static carreg3 + #517, #3967
  static carreg3 + #518, #3967
  static carreg3 + #519, #3967

  ;Linha 13
  static carreg3 + #520, #3967
  static carreg3 + #521, #3967
  static carreg3 + #522, #3967
  static carreg3 + #523, #3967
  static carreg3 + #524, #3967
  static carreg3 + #525, #3967
  static carreg3 + #526, #3967
  static carreg3 + #527, #3967
  static carreg3 + #528, #3967
  static carreg3 + #529, #3967
  static carreg3 + #530, #3967
  static carreg3 + #531, #3967
  static carreg3 + #532, #3967
  static carreg3 + #533, #3967
  static carreg3 + #534, #3967
  static carreg3 + #535, #1024
  static carreg3 + #536, #3967
  static carreg3 + #537, #3967
  static carreg3 + #538, #3967
  static carreg3 + #539, #1024
  static carreg3 + #540, #3967
  static carreg3 + #541, #3967
  static carreg3 + #542, #3967
  static carreg3 + #543, #3967
  static carreg3 + #544, #1024
  static carreg3 + #545, #3967
  static carreg3 + #546, #3967
  static carreg3 + #547, #3967
  static carreg3 + #548, #3967
  static carreg3 + #549, #1070
  static carreg3 + #550, #3967
  static carreg3 + #551, #3967
  static carreg3 + #552, #3967
  static carreg3 + #553, #3967
  static carreg3 + #554, #3967
  static carreg3 + #555, #3967
  static carreg3 + #556, #3967
  static carreg3 + #557, #3967
  static carreg3 + #558, #1070
  static carreg3 + #559, #3967

  ;Linha 14
  static carreg3 + #560, #3967
  static carreg3 + #561, #1070
  static carreg3 + #562, #3967
  static carreg3 + #563, #3967
  static carreg3 + #564, #2125
  static carreg3 + #565, #2159
  static carreg3 + #566, #2166
  static carreg3 + #567, #2106
  static carreg3 + #568, #3967
  static carreg3 + #569, #1070
  static carreg3 + #570, #3967
  static carreg3 + #571, #3967
  static carreg3 + #572, #3967
  static carreg3 + #573, #3967
  static carreg3 + #574, #3967
  static carreg3 + #575, #3967
  static carreg3 + #576, #1024
  static carreg3 + #577, #3967
  static carreg3 + #578, #1024
  static carreg3 + #579, #3967
  static carreg3 + #580, #3967
  static carreg3 + #581, #1024
  static carreg3 + #582, #3967
  static carreg3 + #583, #3967
  static carreg3 + #584, #1024
  static carreg3 + #585, #3967
  static carreg3 + #586, #3967
  static carreg3 + #587, #3967
  static carreg3 + #588, #3967
  static carreg3 + #589, #3967
  static carreg3 + #590, #3967
  static carreg3 + #591, #3967
  static carreg3 + #592, #589
  static carreg3 + #593, #623
  static carreg3 + #594, #630
  static carreg3 + #595, #570
  static carreg3 + #596, #3967
  static carreg3 + #597, #3967
  static carreg3 + #598, #3967
  static carreg3 + #599, #3967

  ;Linha 15
  static carreg3 + #600, #3967
  static carreg3 + #601, #3967
  static carreg3 + #602, #3967
  static carreg3 + #603, #3967
  static carreg3 + #604, #3967
  static carreg3 + #605, #3967
  static carreg3 + #606, #3967
  static carreg3 + #607, #3967
  static carreg3 + #608, #3967
  static carreg3 + #609, #3967
  static carreg3 + #610, #3967
  static carreg3 + #611, #3967
  static carreg3 + #612, #3967
  static carreg3 + #613, #1070
  static carreg3 + #614, #3967
  static carreg3 + #615, #3967
  static carreg3 + #616, #3967
  static carreg3 + #617, #1024
  static carreg3 + #618, #3967
  static carreg3 + #619, #3967
  static carreg3 + #620, #3967
  static carreg3 + #621, #3967
  static carreg3 + #622, #1024
  static carreg3 + #623, #1024
  static carreg3 + #624, #3967
  static carreg3 + #625, #3967
  static carreg3 + #626, #3967
  static carreg3 + #627, #1070
  static carreg3 + #628, #3967
  static carreg3 + #629, #3967
  static carreg3 + #630, #3967
  static carreg3 + #631, #3967
  static carreg3 + #632, #3967
  static carreg3 + #633, #3967
  static carreg3 + #634, #3967
  static carreg3 + #635, #3967
  static carreg3 + #636, #3967
  static carreg3 + #637, #3967
  static carreg3 + #638, #3967
  static carreg3 + #639, #3967

  ;Linha 16
  static carreg3 + #640, #3967
  static carreg3 + #641, #3967
  static carreg3 + #642, #3967
  static carreg3 + #643, #3967
  static carreg3 + #644, #3967
  static carreg3 + #645, #3967
  static carreg3 + #646, #3967
  static carreg3 + #647, #3967
  static carreg3 + #648, #3967
  static carreg3 + #649, #3967
  static carreg3 + #650, #3967
  static carreg3 + #651, #3967
  static carreg3 + #652, #3967
  static carreg3 + #653, #3967
  static carreg3 + #654, #3967
  static carreg3 + #655, #3967
  static carreg3 + #656, #3967
  static carreg3 + #657, #3967
  static carreg3 + #658, #3967
  static carreg3 + #659, #3967
  static carreg3 + #660, #3967
  static carreg3 + #661, #3967
  static carreg3 + #662, #3967
  static carreg3 + #663, #3967
  static carreg3 + #664, #3967
  static carreg3 + #665, #3967
  static carreg3 + #666, #3967
  static carreg3 + #667, #3967
  static carreg3 + #668, #3967
  static carreg3 + #669, #3967
  static carreg3 + #670, #3967
  static carreg3 + #671, #3967
  static carreg3 + #672, #3967
  static carreg3 + #673, #3967
  static carreg3 + #674, #3967
  static carreg3 + #675, #3967
  static carreg3 + #676, #3967
  static carreg3 + #677, #3967
  static carreg3 + #678, #3967
  static carreg3 + #679, #3967

  ;Linha 17
  static carreg3 + #680, #3967
  static carreg3 + #681, #3967
  static carreg3 + #682, #3967
  static carreg3 + #683, #3967
  static carreg3 + #684, #3967
  static carreg3 + #685, #2135
  static carreg3 + #686, #3967
  static carreg3 + #687, #3967
  static carreg3 + #688, #3967
  static carreg3 + #689, #3967
  static carreg3 + #690, #3967
  static carreg3 + #691, #3967
  static carreg3 + #692, #3967
  static carreg3 + #693, #3967
  static carreg3 + #694, #3967
  static carreg3 + #695, #3967
  static carreg3 + #696, #3967
  static carreg3 + #697, #3967
  static carreg3 + #698, #3967
  static carreg3 + #699, #3967
  static carreg3 + #700, #3967
  static carreg3 + #701, #1070
  static carreg3 + #702, #3967
  static carreg3 + #703, #3967
  static carreg3 + #704, #1070
  static carreg3 + #705, #3967
  static carreg3 + #706, #3967
  static carreg3 + #707, #3967
  static carreg3 + #708, #3967
  static carreg3 + #709, #3967
  static carreg3 + #710, #3967
  static carreg3 + #711, #3967
  static carreg3 + #712, #3967
  static carreg3 + #713, #3967
  static carreg3 + #714, #585
  static carreg3 + #715, #3967
  static carreg3 + #716, #3967
  static carreg3 + #717, #1070
  static carreg3 + #718, #3967
  static carreg3 + #719, #3967

  ;Linha 18
  static carreg3 + #720, #3967
  static carreg3 + #721, #3967
  static carreg3 + #722, #3967
  static carreg3 + #723, #3967
  static carreg3 + #724, #3967
  static carreg3 + #725, #3967
  static carreg3 + #726, #3967
  static carreg3 + #727, #3967
  static carreg3 + #728, #3967
  static carreg3 + #729, #3967
  static carreg3 + #730, #3967
  static carreg3 + #731, #3967
  static carreg3 + #732, #3967
  static carreg3 + #733, #1070
  static carreg3 + #734, #3967
  static carreg3 + #735, #1069
  static carreg3 + #736, #1069
  static carreg3 + #737, #1069
  static carreg3 + #738, #1069
  static carreg3 + #739, #3117
  static carreg3 + #740, #3117
  static carreg3 + #741, #1069
  static carreg3 + #742, #1069
  static carreg3 + #743, #1069
  static carreg3 + #744, #1069
  static carreg3 + #745, #3967
  static carreg3 + #746, #3967
  static carreg3 + #747, #3967
  static carreg3 + #748, #3967
  static carreg3 + #749, #3967
  static carreg3 + #750, #3967
  static carreg3 + #751, #3967
  static carreg3 + #752, #3967
  static carreg3 + #753, #3967
  static carreg3 + #754, #3967
  static carreg3 + #755, #3967
  static carreg3 + #756, #3967
  static carreg3 + #757, #3967
  static carreg3 + #758, #3967
  static carreg3 + #759, #3967

  ;Linha 19
  static carreg3 + #760, #3967
  static carreg3 + #761, #3967
  static carreg3 + #762, #3967
  static carreg3 + #763, #2113
  static carreg3 + #764, #3967
  static carreg3 + #765, #2131
  static carreg3 + #766, #3967
  static carreg3 + #767, #2116
  static carreg3 + #768, #3967
  static carreg3 + #769, #3967
  static carreg3 + #770, #3967
  static carreg3 + #771, #3967
  static carreg3 + #772, #3967
  static carreg3 + #773, #3967
  static carreg3 + #774, #3967
  static carreg3 + #775, #1091
  static carreg3 + #776, #1089
  static carreg3 + #777, #1106
  static carreg3 + #778, #1106
  static carreg3 + #779, #3141
  static carreg3 + #780, #3143
  static carreg3 + #781, #1089
  static carreg3 + #782, #1102
  static carreg3 + #783, #1092
  static carreg3 + #784, #1103
  static carreg3 + #785, #3967
  static carreg3 + #786, #3967
  static carreg3 + #787, #3967
  static carreg3 + #788, #3967
  static carreg3 + #789, #3967
  static carreg3 + #790, #3967
  static carreg3 + #791, #3967
  static carreg3 + #792, #586
  static carreg3 + #793, #3967
  static carreg3 + #794, #587
  static carreg3 + #795, #3967
  static carreg3 + #796, #588
  static carreg3 + #797, #3967
  static carreg3 + #798, #3967
  static carreg3 + #799, #3967

  ;Linha 20
  static carreg3 + #800, #3967
  static carreg3 + #801, #3967
  static carreg3 + #802, #3967
  static carreg3 + #803, #3967
  static carreg3 + #804, #3967
  static carreg3 + #805, #3967
  static carreg3 + #806, #3967
  static carreg3 + #807, #3967
  static carreg3 + #808, #3967
  static carreg3 + #809, #3967
  static carreg3 + #810, #3967
  static carreg3 + #811, #3967
  static carreg3 + #812, #3967
  static carreg3 + #813, #3967
  static carreg3 + #814, #3967
  static carreg3 + #815, #1069
  static carreg3 + #816, #1069
  static carreg3 + #817, #1069
  static carreg3 + #818, #1069
  static carreg3 + #819, #3117
  static carreg3 + #820, #3117
  static carreg3 + #821, #1069
  static carreg3 + #822, #1069
  static carreg3 + #823, #1069
  static carreg3 + #824, #1069
  static carreg3 + #825, #3967
  static carreg3 + #826, #3967
  static carreg3 + #827, #3967
  static carreg3 + #828, #1070
  static carreg3 + #829, #3967
  static carreg3 + #830, #3967
  static carreg3 + #831, #3967
  static carreg3 + #832, #3967
  static carreg3 + #833, #3967
  static carreg3 + #834, #3967
  static carreg3 + #835, #3967
  static carreg3 + #836, #3967
  static carreg3 + #837, #3967
  static carreg3 + #838, #3967
  static carreg3 + #839, #3967

  ;Linha 21
  static carreg3 + #840, #3967
  static carreg3 + #841, #1070
  static carreg3 + #842, #3967
  static carreg3 + #843, #3967
  static carreg3 + #844, #1070
  static carreg3 + #845, #3967
  static carreg3 + #846, #3967
  static carreg3 + #847, #3967
  static carreg3 + #848, #3967
  static carreg3 + #849, #3967
  static carreg3 + #850, #3967
  static carreg3 + #851, #3967
  static carreg3 + #852, #3967
  static carreg3 + #853, #3967
  static carreg3 + #854, #3967
  static carreg3 + #855, #3967
  static carreg3 + #856, #3967
  static carreg3 + #857, #3967
  static carreg3 + #858, #3967
  static carreg3 + #859, #3967
  static carreg3 + #860, #3967
  static carreg3 + #861, #3967
  static carreg3 + #862, #3967
  static carreg3 + #863, #3967
  static carreg3 + #864, #3967
  static carreg3 + #865, #3967
  static carreg3 + #866, #3967
  static carreg3 + #867, #3967
  static carreg3 + #868, #3967
  static carreg3 + #869, #3967
  static carreg3 + #870, #3967
  static carreg3 + #871, #3967
  static carreg3 + #872, #3967
  static carreg3 + #873, #3967
  static carreg3 + #874, #1070
  static carreg3 + #875, #3967
  static carreg3 + #876, #3967
  static carreg3 + #877, #3967
  static carreg3 + #878, #3967
  static carreg3 + #879, #1070

  ;Linha 22
  static carreg3 + #880, #3967
  static carreg3 + #881, #3967
  static carreg3 + #882, #3967
  static carreg3 + #883, #3967
  static carreg3 + #884, #3967
  static carreg3 + #885, #3967
  static carreg3 + #886, #3967
  static carreg3 + #887, #3967
  static carreg3 + #888, #3967
  static carreg3 + #889, #3967
  static carreg3 + #890, #3967
  static carreg3 + #891, #1070
  static carreg3 + #892, #3967
  static carreg3 + #893, #3967
  static carreg3 + #894, #3967
  static carreg3 + #895, #3967
  static carreg3 + #896, #3967
  static carreg3 + #897, #3967
  static carreg3 + #898, #3967
  static carreg3 + #899, #3967
  static carreg3 + #900, #1070
  static carreg3 + #901, #3967
  static carreg3 + #902, #3967
  static carreg3 + #903, #3967
  static carreg3 + #904, #3967
  static carreg3 + #905, #3967
  static carreg3 + #906, #3967
  static carreg3 + #907, #3967
  static carreg3 + #908, #3967
  static carreg3 + #909, #3967
  static carreg3 + #910, #3967
  static carreg3 + #911, #3967
  static carreg3 + #912, #3967
  static carreg3 + #913, #3967
  static carreg3 + #914, #3967
  static carreg3 + #915, #3967
  static carreg3 + #916, #3967
  static carreg3 + #917, #3967
  static carreg3 + #918, #3967
  static carreg3 + #919, #3967

  ;Linha 23
  static carreg3 + #920, #3967
  static carreg3 + #921, #3967
  static carreg3 + #922, #3967
  static carreg3 + #923, #2131
  static carreg3 + #924, #2152
  static carreg3 + #925, #2159
  static carreg3 + #926, #2159
  static carreg3 + #927, #2164
  static carreg3 + #928, #2106
  static carreg3 + #929, #3967
  static carreg3 + #930, #3967
  static carreg3 + #931, #3967
  static carreg3 + #932, #3967
  static carreg3 + #933, #3967
  static carreg3 + #934, #3967
  static carreg3 + #935, #3967
  static carreg3 + #936, #3967
  static carreg3 + #937, #3967
  static carreg3 + #938, #3967
  static carreg3 + #939, #3967
  static carreg3 + #940, #3967
  static carreg3 + #941, #3967
  static carreg3 + #942, #3967
  static carreg3 + #943, #3967
  static carreg3 + #944, #3967
  static carreg3 + #945, #1070
  static carreg3 + #946, #3967
  static carreg3 + #947, #3967
  static carreg3 + #948, #3967
  static carreg3 + #949, #3967
  static carreg3 + #950, #3967
  static carreg3 + #951, #595
  static carreg3 + #952, #616
  static carreg3 + #953, #623
  static carreg3 + #954, #623
  static carreg3 + #955, #628
  static carreg3 + #956, #570
  static carreg3 + #957, #3967
  static carreg3 + #958, #3967
  static carreg3 + #959, #3967

  ;Linha 24
  static carreg3 + #960, #3967
  static carreg3 + #961, #3967
  static carreg3 + #962, #3967
  static carreg3 + #963, #3967
  static carreg3 + #964, #3967
  static carreg3 + #965, #3967
  static carreg3 + #966, #3967
  static carreg3 + #967, #3967
  static carreg3 + #968, #3967
  static carreg3 + #969, #3967
  static carreg3 + #970, #3967
  static carreg3 + #971, #3967
  static carreg3 + #972, #3967
  static carreg3 + #973, #3967
  static carreg3 + #974, #3967
  static carreg3 + #975, #3967
  static carreg3 + #976, #3967
  static carreg3 + #977, #3967
  static carreg3 + #978, #3967
  static carreg3 + #979, #3967
  static carreg3 + #980, #3967
  static carreg3 + #981, #3967
  static carreg3 + #982, #3967
  static carreg3 + #983, #3967
  static carreg3 + #984, #3967
  static carreg3 + #985, #3967
  static carreg3 + #986, #1070
  static carreg3 + #987, #3967
  static carreg3 + #988, #3967
  static carreg3 + #989, #3967
  static carreg3 + #990, #3967
  static carreg3 + #991, #3967
  static carreg3 + #992, #3967
  static carreg3 + #993, #3967
  static carreg3 + #994, #3967
  static carreg3 + #995, #3967
  static carreg3 + #996, #3967
  static carreg3 + #997, #3967
  static carreg3 + #998, #3967
  static carreg3 + #999, #3967

  ;Linha 25
  static carreg3 + #1000, #3967
  static carreg3 + #1001, #3967
  static carreg3 + #1002, #3967
  static carreg3 + #1003, #3967
  static carreg3 + #1004, #3967
  static carreg3 + #1005, #3967
  static carreg3 + #1006, #3967
  static carreg3 + #1007, #3967
  static carreg3 + #1008, #3967
  static carreg3 + #1009, #3967
  static carreg3 + #1010, #3967
  static carreg3 + #1011, #3967
  static carreg3 + #1012, #3967
  static carreg3 + #1013, #3967
  static carreg3 + #1014, #1070
  static carreg3 + #1015, #3967
  static carreg3 + #1016, #3967
  static carreg3 + #1017, #3967
  static carreg3 + #1018, #3967
  static carreg3 + #1019, #3967
  static carreg3 + #1020, #3967
  static carreg3 + #1021, #3967
  static carreg3 + #1022, #3967
  static carreg3 + #1023, #3967
  static carreg3 + #1024, #3967
  static carreg3 + #1025, #3967
  static carreg3 + #1026, #3967
  static carreg3 + #1027, #3967
  static carreg3 + #1028, #3967
  static carreg3 + #1029, #3967
  static carreg3 + #1030, #3967
  static carreg3 + #1031, #3967
  static carreg3 + #1032, #3967
  static carreg3 + #1033, #3967
  static carreg3 + #1034, #3967
  static carreg3 + #1035, #3967
  static carreg3 + #1036, #3967
  static carreg3 + #1037, #3967
  static carreg3 + #1038, #3967
  static carreg3 + #1039, #3967

  ;Linha 26
  static carreg3 + #1040, #3967
  static carreg3 + #1041, #3967
  static carreg3 + #1042, #3967
  static carreg3 + #1043, #3967
  static carreg3 + #1044, #3967
  static carreg3 + #1045, #2117
  static carreg3 + #1046, #3967
  static carreg3 + #1047, #3967
  static carreg3 + #1048, #3967
  static carreg3 + #1049, #3967
  static carreg3 + #1050, #3967
  static carreg3 + #1051, #3967
  static carreg3 + #1052, #3967
  static carreg3 + #1053, #3967
  static carreg3 + #1054, #3967
  static carreg3 + #1055, #3967
  static carreg3 + #1056, #3967
  static carreg3 + #1057, #3967
  static carreg3 + #1058, #1070
  static carreg3 + #1059, #3967
  static carreg3 + #1060, #3967
  static carreg3 + #1061, #3967
  static carreg3 + #1062, #3967
  static carreg3 + #1063, #3967
  static carreg3 + #1064, #3967
  static carreg3 + #1065, #3967
  static carreg3 + #1066, #3967
  static carreg3 + #1067, #3967
  static carreg3 + #1068, #3967
  static carreg3 + #1069, #3967
  static carreg3 + #1070, #3967
  static carreg3 + #1071, #3967
  static carreg3 + #1072, #3967
  static carreg3 + #1073, #3967
  static carreg3 + #1074, #592
  static carreg3 + #1075, #3967
  static carreg3 + #1076, #3967
  static carreg3 + #1077, #3967
  static carreg3 + #1078, #1070
  static carreg3 + #1079, #3967

  ;Linha 27
  static carreg3 + #1080, #3967
  static carreg3 + #1081, #3967
  static carreg3 + #1082, #1070
  static carreg3 + #1083, #3967
  static carreg3 + #1084, #3967
  static carreg3 + #1085, #3967
  static carreg3 + #1086, #3967
  static carreg3 + #1087, #3967
  static carreg3 + #1088, #3967
  static carreg3 + #1089, #3967
  static carreg3 + #1090, #3967
  static carreg3 + #1091, #3967
  static carreg3 + #1092, #3967
  static carreg3 + #1093, #3967
  static carreg3 + #1094, #3967
  static carreg3 + #1095, #3967
  static carreg3 + #1096, #3967
  static carreg3 + #1097, #3967
  static carreg3 + #1098, #3967
  static carreg3 + #1099, #3967
  static carreg3 + #1100, #3967
  static carreg3 + #1101, #3967
  static carreg3 + #1102, #3967
  static carreg3 + #1103, #3967
  static carreg3 + #1104, #3967
  static carreg3 + #1105, #3967
  static carreg3 + #1106, #3967
  static carreg3 + #1107, #3967
  static carreg3 + #1108, #1070
  static carreg3 + #1109, #3967
  static carreg3 + #1110, #3967
  static carreg3 + #1111, #3967
  static carreg3 + #1112, #3967
  static carreg3 + #1113, #3967
  static carreg3 + #1114, #3967
  static carreg3 + #1115, #3967
  static carreg3 + #1116, #3967
  static carreg3 + #1117, #3967
  static carreg3 + #1118, #3967
  static carreg3 + #1119, #3967

  ;Linha 28
  static carreg3 + #1120, #3967
  static carreg3 + #1121, #3967
  static carreg3 + #1122, #3967
  static carreg3 + #1123, #3967
  static carreg3 + #1124, #3967
  static carreg3 + #1125, #3967
  static carreg3 + #1126, #3967
  static carreg3 + #1127, #3967
  static carreg3 + #1128, #3967
  static carreg3 + #1129, #3967
  static carreg3 + #1130, #3967
  static carreg3 + #1131, #1070
  static carreg3 + #1132, #3967
  static carreg3 + #1133, #3967
  static carreg3 + #1134, #3967
  static carreg3 + #1135, #3967
  static carreg3 + #1136, #3967
  static carreg3 + #1137, #3967
  static carreg3 + #1138, #3967
  static carreg3 + #1139, #3967
  static carreg3 + #1140, #3967
  static carreg3 + #1141, #3967
  static carreg3 + #1142, #1070
  static carreg3 + #1143, #3967
  static carreg3 + #1144, #3967
  static carreg3 + #1145, #3967
  static carreg3 + #1146, #3967
  static carreg3 + #1147, #3967
  static carreg3 + #1148, #3967
  static carreg3 + #1149, #3967
  static carreg3 + #1150, #3967
  static carreg3 + #1151, #3967
  static carreg3 + #1152, #3967
  static carreg3 + #1153, #3967
  static carreg3 + #1154, #3967
  static carreg3 + #1155, #3967
  static carreg3 + #1156, #3967
  static carreg3 + #1157, #3967
  static carreg3 + #1158, #3967
  static carreg3 + #1159, #3967

  ;Linha 29
  static carreg3 + #1160, #3967
  static carreg3 + #1161, #3967
  static carreg3 + #1162, #3967
  static carreg3 + #1163, #3967
  static carreg3 + #1164, #3967
  static carreg3 + #1165, #3967
  static carreg3 + #1166, #3967
  static carreg3 + #1167, #3967
  static carreg3 + #1168, #3967
  static carreg3 + #1169, #3967
  static carreg3 + #1170, #3967
  static carreg3 + #1171, #3967
  static carreg3 + #1172, #3967
  static carreg3 + #1173, #3967
  static carreg3 + #1174, #3967
  static carreg3 + #1175, #3967
  static carreg3 + #1176, #3967
  static carreg3 + #1177, #3967
  static carreg3 + #1178, #3967
  static carreg3 + #1179, #3967
  static carreg3 + #1180, #3967
  static carreg3 + #1181, #3967
  static carreg3 + #1182, #3967
  static carreg3 + #1183, #3967
  static carreg3 + #1184, #3967
  static carreg3 + #1185, #3967
  static carreg3 + #1186, #3967
  static carreg3 + #1187, #3967
  static carreg3 + #1188, #3967
  static carreg3 + #1189, #3967
  static carreg3 + #1190, #3967
  static carreg3 + #1191, #3967
  static carreg3 + #1192, #3967
  static carreg3 + #1193, #3967
  static carreg3 + #1194, #3967
  static carreg3 + #1195, #3967
  static carreg3 + #1196, #1070
  static carreg3 + #1197, #3967
  static carreg3 + #1198, #3967
  static carreg3 + #1199, #3967
carreg4 : var #1200
  ;Linha 0
  static carreg4 + #0, #3967
  static carreg4 + #1, #3967
  static carreg4 + #2, #3967
  static carreg4 + #3, #3967
  static carreg4 + #4, #3967
  static carreg4 + #5, #3967
  static carreg4 + #6, #3967
  static carreg4 + #7, #3967
  static carreg4 + #8, #3967
  static carreg4 + #9, #3967
  static carreg4 + #10, #3967
  static carreg4 + #11, #3967
  static carreg4 + #12, #3967
  static carreg4 + #13, #3967
  static carreg4 + #14, #3967
  static carreg4 + #15, #3967
  static carreg4 + #16, #3967
  static carreg4 + #17, #3967
  static carreg4 + #18, #3967
  static carreg4 + #19, #3967
  static carreg4 + #20, #3967
  static carreg4 + #21, #3967
  static carreg4 + #22, #3967
  static carreg4 + #23, #1070
  static carreg4 + #24, #3967
  static carreg4 + #25, #3967
  static carreg4 + #26, #3967
  static carreg4 + #27, #3967
  static carreg4 + #28, #3967
  static carreg4 + #29, #3967
  static carreg4 + #30, #3967
  static carreg4 + #31, #3967
  static carreg4 + #32, #3967
  static carreg4 + #33, #3967
  static carreg4 + #34, #3967
  static carreg4 + #35, #3967
  static carreg4 + #36, #3967
  static carreg4 + #37, #3967
  static carreg4 + #38, #3967
  static carreg4 + #39, #3967

  ;Linha 1
  static carreg4 + #40, #3967
  static carreg4 + #41, #3967
  static carreg4 + #42, #3967
  static carreg4 + #43, #1070
  static carreg4 + #44, #3967
  static carreg4 + #45, #2128
  static carreg4 + #46, #2097
  static carreg4 + #47, #3967
  static carreg4 + #48, #3967
  static carreg4 + #49, #3967
  static carreg4 + #50, #3967
  static carreg4 + #51, #3967
  static carreg4 + #52, #3967
  static carreg4 + #53, #3967
  static carreg4 + #54, #3967
  static carreg4 + #55, #1070
  static carreg4 + #56, #3967
  static carreg4 + #57, #3967
  static carreg4 + #58, #3967
  static carreg4 + #59, #3967
  static carreg4 + #60, #3967
  static carreg4 + #61, #3967
  static carreg4 + #62, #3967
  static carreg4 + #63, #3967
  static carreg4 + #64, #3967
  static carreg4 + #65, #3967
  static carreg4 + #66, #3967
  static carreg4 + #67, #3967
  static carreg4 + #68, #1070
  static carreg4 + #69, #3967
  static carreg4 + #70, #3967
  static carreg4 + #71, #3967
  static carreg4 + #72, #3967
  static carreg4 + #73, #592
  static carreg4 + #74, #562
  static carreg4 + #75, #3967
  static carreg4 + #76, #3967
  static carreg4 + #77, #1070
  static carreg4 + #78, #3967
  static carreg4 + #79, #3967

  ;Linha 2
  static carreg4 + #80, #3967
  static carreg4 + #81, #1070
  static carreg4 + #82, #3967
  static carreg4 + #83, #3967
  static carreg4 + #84, #3967
  static carreg4 + #85, #3967
  static carreg4 + #86, #3967
  static carreg4 + #87, #3967
  static carreg4 + #88, #3967
  static carreg4 + #89, #3967
  static carreg4 + #90, #3967
  static carreg4 + #91, #1070
  static carreg4 + #92, #3967
  static carreg4 + #93, #3967
  static carreg4 + #94, #3967
  static carreg4 + #95, #3967
  static carreg4 + #96, #3967
  static carreg4 + #97, #3967
  static carreg4 + #98, #3967
  static carreg4 + #99, #3967
  static carreg4 + #100, #3967
  static carreg4 + #101, #3967
  static carreg4 + #102, #3967
  static carreg4 + #103, #3967
  static carreg4 + #104, #3967
  static carreg4 + #105, #3967
  static carreg4 + #106, #3967
  static carreg4 + #107, #3967
  static carreg4 + #108, #3967
  static carreg4 + #109, #3967
  static carreg4 + #110, #3967
  static carreg4 + #111, #3967
  static carreg4 + #112, #3967
  static carreg4 + #113, #3967
  static carreg4 + #114, #3967
  static carreg4 + #115, #3967
  static carreg4 + #116, #3967
  static carreg4 + #117, #3967
  static carreg4 + #118, #3967
  static carreg4 + #119, #3967

  ;Linha 3
  static carreg4 + #120, #3967
  static carreg4 + #121, #3967
  static carreg4 + #122, #3967
  static carreg4 + #123, #3967
  static carreg4 + #124, #3967
  static carreg4 + #125, #2048
  static carreg4 + #126, #2048
  static carreg4 + #127, #3967
  static carreg4 + #128, #1070
  static carreg4 + #129, #3967
  static carreg4 + #130, #3967
  static carreg4 + #131, #3967
  static carreg4 + #132, #3967
  static carreg4 + #133, #3967
  static carreg4 + #134, #3967
  static carreg4 + #135, #3967
  static carreg4 + #136, #3967
  static carreg4 + #137, #3967
  static carreg4 + #138, #3967
  static carreg4 + #139, #3967
  static carreg4 + #140, #3967
  static carreg4 + #141, #3967
  static carreg4 + #142, #3967
  static carreg4 + #143, #3967
  static carreg4 + #144, #3967
  static carreg4 + #145, #3967
  static carreg4 + #146, #1070
  static carreg4 + #147, #3967
  static carreg4 + #148, #3967
  static carreg4 + #149, #3967
  static carreg4 + #150, #512
  static carreg4 + #151, #512
  static carreg4 + #152, #3967
  static carreg4 + #153, #3967
  static carreg4 + #154, #3967
  static carreg4 + #155, #3967
  static carreg4 + #156, #512
  static carreg4 + #157, #512
  static carreg4 + #158, #3967
  static carreg4 + #159, #3967

  ;Linha 4
  static carreg4 + #160, #3967
  static carreg4 + #161, #3967
  static carreg4 + #162, #3967
  static carreg4 + #163, #3967
  static carreg4 + #164, #3967
  static carreg4 + #165, #2048
  static carreg4 + #166, #2048
  static carreg4 + #167, #3967
  static carreg4 + #168, #3967
  static carreg4 + #169, #3967
  static carreg4 + #170, #3967
  static carreg4 + #171, #3967
  static carreg4 + #172, #3967
  static carreg4 + #173, #3967
  static carreg4 + #174, #3967
  static carreg4 + #175, #3967
  static carreg4 + #176, #3967
  static carreg4 + #177, #1070
  static carreg4 + #178, #3967
  static carreg4 + #179, #3967
  static carreg4 + #180, #3967
  static carreg4 + #181, #3967
  static carreg4 + #182, #3967
  static carreg4 + #183, #3967
  static carreg4 + #184, #3967
  static carreg4 + #185, #3967
  static carreg4 + #186, #3967
  static carreg4 + #187, #3967
  static carreg4 + #188, #3967
  static carreg4 + #189, #3967
  static carreg4 + #190, #3967
  static carreg4 + #191, #3967
  static carreg4 + #192, #512
  static carreg4 + #193, #3967
  static carreg4 + #194, #3967
  static carreg4 + #195, #512
  static carreg4 + #196, #3967
  static carreg4 + #197, #3967
  static carreg4 + #198, #1070
  static carreg4 + #199, #3967

  ;Linha 5
  static carreg4 + #200, #3967
  static carreg4 + #201, #3967
  static carreg4 + #202, #3967
  static carreg4 + #203, #3967
  static carreg4 + #204, #3967
  static carreg4 + #205, #2048
  static carreg4 + #206, #2048
  static carreg4 + #207, #3967
  static carreg4 + #208, #3967
  static carreg4 + #209, #3967
  static carreg4 + #210, #3967
  static carreg4 + #211, #3967
  static carreg4 + #212, #3967
  static carreg4 + #213, #3967
  static carreg4 + #214, #3967
  static carreg4 + #215, #3967
  static carreg4 + #216, #3967
  static carreg4 + #217, #3967
  static carreg4 + #218, #3967
  static carreg4 + #219, #3967
  static carreg4 + #220, #3967
  static carreg4 + #221, #3967
  static carreg4 + #222, #3967
  static carreg4 + #223, #1070
  static carreg4 + #224, #3967
  static carreg4 + #225, #3967
  static carreg4 + #226, #3967
  static carreg4 + #227, #3967
  static carreg4 + #228, #3967
  static carreg4 + #229, #3967
  static carreg4 + #230, #3967
  static carreg4 + #231, #3967
  static carreg4 + #232, #512
  static carreg4 + #233, #512
  static carreg4 + #234, #512
  static carreg4 + #235, #512
  static carreg4 + #236, #3967
  static carreg4 + #237, #3967
  static carreg4 + #238, #3967
  static carreg4 + #239, #3967

  ;Linha 6
  static carreg4 + #240, #3967
  static carreg4 + #241, #3967
  static carreg4 + #242, #2048
  static carreg4 + #243, #3967
  static carreg4 + #244, #3967
  static carreg4 + #245, #2048
  static carreg4 + #246, #2048
  static carreg4 + #247, #3967
  static carreg4 + #248, #3967
  static carreg4 + #249, #2048
  static carreg4 + #250, #3967
  static carreg4 + #251, #3967
  static carreg4 + #252, #3967
  static carreg4 + #253, #3967
  static carreg4 + #254, #3967
  static carreg4 + #255, #3967
  static carreg4 + #256, #3967
  static carreg4 + #257, #3967
  static carreg4 + #258, #3967
  static carreg4 + #259, #3967
  static carreg4 + #260, #3967
  static carreg4 + #261, #3967
  static carreg4 + #262, #3967
  static carreg4 + #263, #3967
  static carreg4 + #264, #3967
  static carreg4 + #265, #3967
  static carreg4 + #266, #3967
  static carreg4 + #267, #3967
  static carreg4 + #268, #3967
  static carreg4 + #269, #3967
  static carreg4 + #270, #3967
  static carreg4 + #271, #512
  static carreg4 + #272, #3967
  static carreg4 + #273, #512
  static carreg4 + #274, #512
  static carreg4 + #275, #3967
  static carreg4 + #276, #512
  static carreg4 + #277, #3967
  static carreg4 + #278, #3967
  static carreg4 + #279, #3967

  ;Linha 7
  static carreg4 + #280, #3967
  static carreg4 + #281, #3967
  static carreg4 + #282, #2048
  static carreg4 + #283, #3967
  static carreg4 + #284, #2048
  static carreg4 + #285, #2048
  static carreg4 + #286, #2048
  static carreg4 + #287, #2048
  static carreg4 + #288, #3967
  static carreg4 + #289, #2048
  static carreg4 + #290, #3967
  static carreg4 + #291, #3967
  static carreg4 + #292, #3967
  static carreg4 + #293, #3967
  static carreg4 + #294, #3967
  static carreg4 + #295, #3967
  static carreg4 + #296, #3967
  static carreg4 + #297, #3967
  static carreg4 + #298, #3967
  static carreg4 + #299, #3967
  static carreg4 + #300, #3967
  static carreg4 + #301, #3967
  static carreg4 + #302, #3967
  static carreg4 + #303, #3967
  static carreg4 + #304, #3967
  static carreg4 + #305, #3967
  static carreg4 + #306, #3967
  static carreg4 + #307, #3967
  static carreg4 + #308, #3967
  static carreg4 + #309, #3967
  static carreg4 + #310, #512
  static carreg4 + #311, #512
  static carreg4 + #312, #512
  static carreg4 + #313, #512
  static carreg4 + #314, #512
  static carreg4 + #315, #512
  static carreg4 + #316, #512
  static carreg4 + #317, #512
  static carreg4 + #318, #3967
  static carreg4 + #319, #3967

  ;Linha 8
  static carreg4 + #320, #3967
  static carreg4 + #321, #3967
  static carreg4 + #322, #2048
  static carreg4 + #323, #2048
  static carreg4 + #324, #2048
  static carreg4 + #325, #2048
  static carreg4 + #326, #2048
  static carreg4 + #327, #2048
  static carreg4 + #328, #2048
  static carreg4 + #329, #2048
  static carreg4 + #330, #3967
  static carreg4 + #331, #3967
  static carreg4 + #332, #3967
  static carreg4 + #333, #3967
  static carreg4 + #334, #3967
  static carreg4 + #335, #3967
  static carreg4 + #336, #3967
  static carreg4 + #337, #3967
  static carreg4 + #338, #3967
  static carreg4 + #339, #3967
  static carreg4 + #340, #3967
  static carreg4 + #341, #3967
  static carreg4 + #342, #3967
  static carreg4 + #343, #3967
  static carreg4 + #344, #3967
  static carreg4 + #345, #3967
  static carreg4 + #346, #3967
  static carreg4 + #347, #3967
  static carreg4 + #348, #3967
  static carreg4 + #349, #3967
  static carreg4 + #350, #512
  static carreg4 + #351, #3967
  static carreg4 + #352, #512
  static carreg4 + #353, #512
  static carreg4 + #354, #512
  static carreg4 + #355, #512
  static carreg4 + #356, #3967
  static carreg4 + #357, #512
  static carreg4 + #358, #3967
  static carreg4 + #359, #3967

  ;Linha 9
  static carreg4 + #360, #3967
  static carreg4 + #361, #3967
  static carreg4 + #362, #2048
  static carreg4 + #363, #2048
  static carreg4 + #364, #3967
  static carreg4 + #365, #2048
  static carreg4 + #366, #2048
  static carreg4 + #367, #3967
  static carreg4 + #368, #2048
  static carreg4 + #369, #2048
  static carreg4 + #370, #3967
  static carreg4 + #371, #3967
  static carreg4 + #372, #3967
  static carreg4 + #373, #3967
  static carreg4 + #374, #3967
  static carreg4 + #375, #1024
  static carreg4 + #376, #3967
  static carreg4 + #377, #1070
  static carreg4 + #378, #3967
  static carreg4 + #379, #1024
  static carreg4 + #380, #3967
  static carreg4 + #381, #3967
  static carreg4 + #382, #1024
  static carreg4 + #383, #1024
  static carreg4 + #384, #3967
  static carreg4 + #385, #3967
  static carreg4 + #386, #1070
  static carreg4 + #387, #3967
  static carreg4 + #388, #3967
  static carreg4 + #389, #3967
  static carreg4 + #390, #512
  static carreg4 + #391, #3967
  static carreg4 + #392, #512
  static carreg4 + #393, #3967
  static carreg4 + #394, #3967
  static carreg4 + #395, #512
  static carreg4 + #396, #3967
  static carreg4 + #397, #512
  static carreg4 + #398, #3967
  static carreg4 + #399, #3967

  ;Linha 10
  static carreg4 + #400, #1070
  static carreg4 + #401, #3967
  static carreg4 + #402, #2048
  static carreg4 + #403, #3967
  static carreg4 + #404, #3967
  static carreg4 + #405, #3967
  static carreg4 + #406, #3967
  static carreg4 + #407, #3967
  static carreg4 + #408, #3967
  static carreg4 + #409, #2048
  static carreg4 + #410, #3967
  static carreg4 + #411, #3967
  static carreg4 + #412, #1070
  static carreg4 + #413, #3967
  static carreg4 + #414, #3967
  static carreg4 + #415, #1024
  static carreg4 + #416, #3967
  static carreg4 + #417, #3967
  static carreg4 + #418, #3967
  static carreg4 + #419, #1024
  static carreg4 + #420, #3967
  static carreg4 + #421, #1024
  static carreg4 + #422, #3967
  static carreg4 + #423, #3967
  static carreg4 + #424, #1024
  static carreg4 + #425, #3967
  static carreg4 + #426, #3967
  static carreg4 + #427, #3967
  static carreg4 + #428, #3967
  static carreg4 + #429, #3967
  static carreg4 + #430, #3967
  static carreg4 + #431, #3967
  static carreg4 + #432, #512
  static carreg4 + #433, #3967
  static carreg4 + #434, #3967
  static carreg4 + #435, #512
  static carreg4 + #436, #3967
  static carreg4 + #437, #3967
  static carreg4 + #438, #3967
  static carreg4 + #439, #3967

  ;Linha 11
  static carreg4 + #440, #3967
  static carreg4 + #441, #3967
  static carreg4 + #442, #3967
  static carreg4 + #443, #3967
  static carreg4 + #444, #1070
  static carreg4 + #445, #3967
  static carreg4 + #446, #3967
  static carreg4 + #447, #3967
  static carreg4 + #448, #3967
  static carreg4 + #449, #3967
  static carreg4 + #450, #3967
  static carreg4 + #451, #3967
  static carreg4 + #452, #3967
  static carreg4 + #453, #3967
  static carreg4 + #454, #3967
  static carreg4 + #455, #1024
  static carreg4 + #456, #3967
  static carreg4 + #457, #3967
  static carreg4 + #458, #3967
  static carreg4 + #459, #1024
  static carreg4 + #460, #3967
  static carreg4 + #461, #1024
  static carreg4 + #462, #3967
  static carreg4 + #463, #3967
  static carreg4 + #464, #3967
  static carreg4 + #465, #3967
  static carreg4 + #466, #3967
  static carreg4 + #467, #3967
  static carreg4 + #468, #3967
  static carreg4 + #469, #3967
  static carreg4 + #470, #3967
  static carreg4 + #471, #3967
  static carreg4 + #472, #3967
  static carreg4 + #473, #3967
  static carreg4 + #474, #3967
  static carreg4 + #475, #3967
  static carreg4 + #476, #3967
  static carreg4 + #477, #3967
  static carreg4 + #478, #3967
  static carreg4 + #479, #3967

  ;Linha 12
  static carreg4 + #480, #3967
  static carreg4 + #481, #3967
  static carreg4 + #482, #3967
  static carreg4 + #483, #3967
  static carreg4 + #484, #3967
  static carreg4 + #485, #3967
  static carreg4 + #486, #3967
  static carreg4 + #487, #3967
  static carreg4 + #488, #3967
  static carreg4 + #489, #3967
  static carreg4 + #490, #3967
  static carreg4 + #491, #3967
  static carreg4 + #492, #3967
  static carreg4 + #493, #3967
  static carreg4 + #494, #3967
  static carreg4 + #495, #1024
  static carreg4 + #496, #3967
  static carreg4 + #497, #3967
  static carreg4 + #498, #3967
  static carreg4 + #499, #1024
  static carreg4 + #500, #3967
  static carreg4 + #501, #3967
  static carreg4 + #502, #1024
  static carreg4 + #503, #1024
  static carreg4 + #504, #3967
  static carreg4 + #505, #3967
  static carreg4 + #506, #3967
  static carreg4 + #507, #3967
  static carreg4 + #508, #3967
  static carreg4 + #509, #3967
  static carreg4 + #510, #3967
  static carreg4 + #511, #3967
  static carreg4 + #512, #3967
  static carreg4 + #513, #3967
  static carreg4 + #514, #3967
  static carreg4 + #515, #3967
  static carreg4 + #516, #3967
  static carreg4 + #517, #3967
  static carreg4 + #518, #3967
  static carreg4 + #519, #3967

  ;Linha 13
  static carreg4 + #520, #3967
  static carreg4 + #521, #3967
  static carreg4 + #522, #3967
  static carreg4 + #523, #3967
  static carreg4 + #524, #3967
  static carreg4 + #525, #3967
  static carreg4 + #526, #3967
  static carreg4 + #527, #3967
  static carreg4 + #528, #3967
  static carreg4 + #529, #3967
  static carreg4 + #530, #3967
  static carreg4 + #531, #3967
  static carreg4 + #532, #3967
  static carreg4 + #533, #3967
  static carreg4 + #534, #3967
  static carreg4 + #535, #1024
  static carreg4 + #536, #3967
  static carreg4 + #537, #3967
  static carreg4 + #538, #3967
  static carreg4 + #539, #1024
  static carreg4 + #540, #3967
  static carreg4 + #541, #3967
  static carreg4 + #542, #3967
  static carreg4 + #543, #3967
  static carreg4 + #544, #1024
  static carreg4 + #545, #3967
  static carreg4 + #546, #3967
  static carreg4 + #547, #3967
  static carreg4 + #548, #3967
  static carreg4 + #549, #1070
  static carreg4 + #550, #3967
  static carreg4 + #551, #3967
  static carreg4 + #552, #3967
  static carreg4 + #553, #3967
  static carreg4 + #554, #3967
  static carreg4 + #555, #3967
  static carreg4 + #556, #3967
  static carreg4 + #557, #3967
  static carreg4 + #558, #1070
  static carreg4 + #559, #3967

  ;Linha 14
  static carreg4 + #560, #3967
  static carreg4 + #561, #1070
  static carreg4 + #562, #3967
  static carreg4 + #563, #3967
  static carreg4 + #564, #2125
  static carreg4 + #565, #2159
  static carreg4 + #566, #2166
  static carreg4 + #567, #2106
  static carreg4 + #568, #3967
  static carreg4 + #569, #1070
  static carreg4 + #570, #3967
  static carreg4 + #571, #3967
  static carreg4 + #572, #3967
  static carreg4 + #573, #3967
  static carreg4 + #574, #3967
  static carreg4 + #575, #3967
  static carreg4 + #576, #1024
  static carreg4 + #577, #3967
  static carreg4 + #578, #1024
  static carreg4 + #579, #3967
  static carreg4 + #580, #3967
  static carreg4 + #581, #1024
  static carreg4 + #582, #3967
  static carreg4 + #583, #3967
  static carreg4 + #584, #1024
  static carreg4 + #585, #3967
  static carreg4 + #586, #3967
  static carreg4 + #587, #3967
  static carreg4 + #588, #3967
  static carreg4 + #589, #3967
  static carreg4 + #590, #3967
  static carreg4 + #591, #3967
  static carreg4 + #592, #589
  static carreg4 + #593, #623
  static carreg4 + #594, #630
  static carreg4 + #595, #570
  static carreg4 + #596, #3967
  static carreg4 + #597, #3967
  static carreg4 + #598, #3967
  static carreg4 + #599, #3967

  ;Linha 15
  static carreg4 + #600, #3967
  static carreg4 + #601, #3967
  static carreg4 + #602, #3967
  static carreg4 + #603, #3967
  static carreg4 + #604, #3967
  static carreg4 + #605, #3967
  static carreg4 + #606, #3967
  static carreg4 + #607, #3967
  static carreg4 + #608, #3967
  static carreg4 + #609, #3967
  static carreg4 + #610, #3967
  static carreg4 + #611, #3967
  static carreg4 + #612, #3967
  static carreg4 + #613, #1070
  static carreg4 + #614, #3967
  static carreg4 + #615, #3967
  static carreg4 + #616, #3967
  static carreg4 + #617, #1024
  static carreg4 + #618, #3967
  static carreg4 + #619, #3967
  static carreg4 + #620, #3967
  static carreg4 + #621, #3967
  static carreg4 + #622, #1024
  static carreg4 + #623, #1024
  static carreg4 + #624, #3967
  static carreg4 + #625, #3967
  static carreg4 + #626, #3967
  static carreg4 + #627, #1070
  static carreg4 + #628, #3967
  static carreg4 + #629, #3967
  static carreg4 + #630, #3967
  static carreg4 + #631, #3967
  static carreg4 + #632, #3967
  static carreg4 + #633, #3967
  static carreg4 + #634, #3967
  static carreg4 + #635, #3967
  static carreg4 + #636, #3967
  static carreg4 + #637, #3967
  static carreg4 + #638, #3967
  static carreg4 + #639, #3967

  ;Linha 16
  static carreg4 + #640, #3967
  static carreg4 + #641, #3967
  static carreg4 + #642, #3967
  static carreg4 + #643, #3967
  static carreg4 + #644, #3967
  static carreg4 + #645, #3967
  static carreg4 + #646, #3967
  static carreg4 + #647, #3967
  static carreg4 + #648, #3967
  static carreg4 + #649, #3967
  static carreg4 + #650, #3967
  static carreg4 + #651, #3967
  static carreg4 + #652, #3967
  static carreg4 + #653, #3967
  static carreg4 + #654, #3967
  static carreg4 + #655, #3967
  static carreg4 + #656, #3967
  static carreg4 + #657, #3967
  static carreg4 + #658, #3967
  static carreg4 + #659, #3967
  static carreg4 + #660, #3967
  static carreg4 + #661, #3967
  static carreg4 + #662, #3967
  static carreg4 + #663, #3967
  static carreg4 + #664, #3967
  static carreg4 + #665, #3967
  static carreg4 + #666, #3967
  static carreg4 + #667, #3967
  static carreg4 + #668, #3967
  static carreg4 + #669, #3967
  static carreg4 + #670, #3967
  static carreg4 + #671, #3967
  static carreg4 + #672, #3967
  static carreg4 + #673, #3967
  static carreg4 + #674, #3967
  static carreg4 + #675, #3967
  static carreg4 + #676, #3967
  static carreg4 + #677, #3967
  static carreg4 + #678, #3967
  static carreg4 + #679, #3967

  ;Linha 17
  static carreg4 + #680, #3967
  static carreg4 + #681, #3967
  static carreg4 + #682, #3967
  static carreg4 + #683, #3967
  static carreg4 + #684, #3967
  static carreg4 + #685, #2135
  static carreg4 + #686, #3967
  static carreg4 + #687, #3967
  static carreg4 + #688, #3967
  static carreg4 + #689, #3967
  static carreg4 + #690, #3967
  static carreg4 + #691, #3967
  static carreg4 + #692, #3967
  static carreg4 + #693, #3967
  static carreg4 + #694, #3967
  static carreg4 + #695, #3967
  static carreg4 + #696, #3967
  static carreg4 + #697, #3967
  static carreg4 + #698, #3967
  static carreg4 + #699, #3967
  static carreg4 + #700, #3967
  static carreg4 + #701, #1070
  static carreg4 + #702, #3967
  static carreg4 + #703, #3967
  static carreg4 + #704, #1070
  static carreg4 + #705, #3967
  static carreg4 + #706, #3967
  static carreg4 + #707, #3967
  static carreg4 + #708, #3967
  static carreg4 + #709, #3967
  static carreg4 + #710, #3967
  static carreg4 + #711, #3967
  static carreg4 + #712, #3967
  static carreg4 + #713, #3967
  static carreg4 + #714, #585
  static carreg4 + #715, #3967
  static carreg4 + #716, #3967
  static carreg4 + #717, #1070
  static carreg4 + #718, #3967
  static carreg4 + #719, #3967

  ;Linha 18
  static carreg4 + #720, #3967
  static carreg4 + #721, #3967
  static carreg4 + #722, #3967
  static carreg4 + #723, #3967
  static carreg4 + #724, #3967
  static carreg4 + #725, #3967
  static carreg4 + #726, #3967
  static carreg4 + #727, #3967
  static carreg4 + #728, #3967
  static carreg4 + #729, #3967
  static carreg4 + #730, #3967
  static carreg4 + #731, #3967
  static carreg4 + #732, #3967
  static carreg4 + #733, #1070
  static carreg4 + #734, #3967
  static carreg4 + #735, #1069
  static carreg4 + #736, #1069
  static carreg4 + #737, #3117
  static carreg4 + #738, #3117
  static carreg4 + #739, #1069
  static carreg4 + #740, #1069
  static carreg4 + #741, #1069
  static carreg4 + #742, #1069
  static carreg4 + #743, #1069
  static carreg4 + #744, #1069
  static carreg4 + #745, #3967
  static carreg4 + #746, #3967
  static carreg4 + #747, #3967
  static carreg4 + #748, #3967
  static carreg4 + #749, #3967
  static carreg4 + #750, #3967
  static carreg4 + #751, #3967
  static carreg4 + #752, #3967
  static carreg4 + #753, #3967
  static carreg4 + #754, #3967
  static carreg4 + #755, #3967
  static carreg4 + #756, #3967
  static carreg4 + #757, #3967
  static carreg4 + #758, #3967
  static carreg4 + #759, #3967

  ;Linha 19
  static carreg4 + #760, #3967
  static carreg4 + #761, #3967
  static carreg4 + #762, #3967
  static carreg4 + #763, #2113
  static carreg4 + #764, #3967
  static carreg4 + #765, #2131
  static carreg4 + #766, #3967
  static carreg4 + #767, #2116
  static carreg4 + #768, #3967
  static carreg4 + #769, #3967
  static carreg4 + #770, #3967
  static carreg4 + #771, #3967
  static carreg4 + #772, #3967
  static carreg4 + #773, #3967
  static carreg4 + #774, #3967
  static carreg4 + #775, #1091
  static carreg4 + #776, #1089
  static carreg4 + #777, #3154
  static carreg4 + #778, #3154
  static carreg4 + #779, #1093
  static carreg4 + #780, #1095
  static carreg4 + #781, #1089
  static carreg4 + #782, #1102
  static carreg4 + #783, #1092
  static carreg4 + #784, #1103
  static carreg4 + #785, #3967
  static carreg4 + #786, #3967
  static carreg4 + #787, #3967
  static carreg4 + #788, #3967
  static carreg4 + #789, #3967
  static carreg4 + #790, #3967
  static carreg4 + #791, #3967
  static carreg4 + #792, #586
  static carreg4 + #793, #3967
  static carreg4 + #794, #587
  static carreg4 + #795, #3967
  static carreg4 + #796, #588
  static carreg4 + #797, #3967
  static carreg4 + #798, #3967
  static carreg4 + #799, #3967

  ;Linha 20
  static carreg4 + #800, #3967
  static carreg4 + #801, #3967
  static carreg4 + #802, #3967
  static carreg4 + #803, #3967
  static carreg4 + #804, #3967
  static carreg4 + #805, #3967
  static carreg4 + #806, #3967
  static carreg4 + #807, #3967
  static carreg4 + #808, #3967
  static carreg4 + #809, #3967
  static carreg4 + #810, #3967
  static carreg4 + #811, #3967
  static carreg4 + #812, #3967
  static carreg4 + #813, #3967
  static carreg4 + #814, #3967
  static carreg4 + #815, #1069
  static carreg4 + #816, #1069
  static carreg4 + #817, #3117
  static carreg4 + #818, #3117
  static carreg4 + #819, #1069
  static carreg4 + #820, #1069
  static carreg4 + #821, #1069
  static carreg4 + #822, #1069
  static carreg4 + #823, #1069
  static carreg4 + #824, #1069
  static carreg4 + #825, #3967
  static carreg4 + #826, #3967
  static carreg4 + #827, #3967
  static carreg4 + #828, #1070
  static carreg4 + #829, #3967
  static carreg4 + #830, #3967
  static carreg4 + #831, #3967
  static carreg4 + #832, #3967
  static carreg4 + #833, #3967
  static carreg4 + #834, #3967
  static carreg4 + #835, #3967
  static carreg4 + #836, #3967
  static carreg4 + #837, #3967
  static carreg4 + #838, #3967
  static carreg4 + #839, #3967

  ;Linha 21
  static carreg4 + #840, #3967
  static carreg4 + #841, #1070
  static carreg4 + #842, #3967
  static carreg4 + #843, #3967
  static carreg4 + #844, #1070
  static carreg4 + #845, #3967
  static carreg4 + #846, #3967
  static carreg4 + #847, #3967
  static carreg4 + #848, #3967
  static carreg4 + #849, #3967
  static carreg4 + #850, #3967
  static carreg4 + #851, #3967
  static carreg4 + #852, #3967
  static carreg4 + #853, #3967
  static carreg4 + #854, #3967
  static carreg4 + #855, #3967
  static carreg4 + #856, #3967
  static carreg4 + #857, #3967
  static carreg4 + #858, #3967
  static carreg4 + #859, #3967
  static carreg4 + #860, #3967
  static carreg4 + #861, #3967
  static carreg4 + #862, #3967
  static carreg4 + #863, #3967
  static carreg4 + #864, #3967
  static carreg4 + #865, #3967
  static carreg4 + #866, #3967
  static carreg4 + #867, #3967
  static carreg4 + #868, #3967
  static carreg4 + #869, #3967
  static carreg4 + #870, #3967
  static carreg4 + #871, #3967
  static carreg4 + #872, #3967
  static carreg4 + #873, #3967
  static carreg4 + #874, #1070
  static carreg4 + #875, #3967
  static carreg4 + #876, #3967
  static carreg4 + #877, #3967
  static carreg4 + #878, #3967
  static carreg4 + #879, #1070

  ;Linha 22
  static carreg4 + #880, #3967
  static carreg4 + #881, #3967
  static carreg4 + #882, #3967
  static carreg4 + #883, #3967
  static carreg4 + #884, #3967
  static carreg4 + #885, #3967
  static carreg4 + #886, #3967
  static carreg4 + #887, #3967
  static carreg4 + #888, #3967
  static carreg4 + #889, #3967
  static carreg4 + #890, #3967
  static carreg4 + #891, #1070
  static carreg4 + #892, #3967
  static carreg4 + #893, #3967
  static carreg4 + #894, #3967
  static carreg4 + #895, #3967
  static carreg4 + #896, #3967
  static carreg4 + #897, #3967
  static carreg4 + #898, #3967
  static carreg4 + #899, #3967
  static carreg4 + #900, #1070
  static carreg4 + #901, #3967
  static carreg4 + #902, #3967
  static carreg4 + #903, #3967
  static carreg4 + #904, #3967
  static carreg4 + #905, #3967
  static carreg4 + #906, #3967
  static carreg4 + #907, #3967
  static carreg4 + #908, #3967
  static carreg4 + #909, #3967
  static carreg4 + #910, #3967
  static carreg4 + #911, #3967
  static carreg4 + #912, #3967
  static carreg4 + #913, #3967
  static carreg4 + #914, #3967
  static carreg4 + #915, #3967
  static carreg4 + #916, #3967
  static carreg4 + #917, #3967
  static carreg4 + #918, #3967
  static carreg4 + #919, #3967

  ;Linha 23
  static carreg4 + #920, #3967
  static carreg4 + #921, #3967
  static carreg4 + #922, #3967
  static carreg4 + #923, #2131
  static carreg4 + #924, #2152
  static carreg4 + #925, #2159
  static carreg4 + #926, #2159
  static carreg4 + #927, #2164
  static carreg4 + #928, #2106
  static carreg4 + #929, #3967
  static carreg4 + #930, #3967
  static carreg4 + #931, #3967
  static carreg4 + #932, #3967
  static carreg4 + #933, #3967
  static carreg4 + #934, #3967
  static carreg4 + #935, #3967
  static carreg4 + #936, #3967
  static carreg4 + #937, #3967
  static carreg4 + #938, #3967
  static carreg4 + #939, #3967
  static carreg4 + #940, #3967
  static carreg4 + #941, #3967
  static carreg4 + #942, #3967
  static carreg4 + #943, #3967
  static carreg4 + #944, #3967
  static carreg4 + #945, #1070
  static carreg4 + #946, #3967
  static carreg4 + #947, #3967
  static carreg4 + #948, #3967
  static carreg4 + #949, #3967
  static carreg4 + #950, #3967
  static carreg4 + #951, #595
  static carreg4 + #952, #616
  static carreg4 + #953, #623
  static carreg4 + #954, #623
  static carreg4 + #955, #628
  static carreg4 + #956, #570
  static carreg4 + #957, #3967
  static carreg4 + #958, #3967
  static carreg4 + #959, #3967

  ;Linha 24
  static carreg4 + #960, #3967
  static carreg4 + #961, #3967
  static carreg4 + #962, #3967
  static carreg4 + #963, #3967
  static carreg4 + #964, #3967
  static carreg4 + #965, #3967
  static carreg4 + #966, #3967
  static carreg4 + #967, #3967
  static carreg4 + #968, #3967
  static carreg4 + #969, #3967
  static carreg4 + #970, #3967
  static carreg4 + #971, #3967
  static carreg4 + #972, #3967
  static carreg4 + #973, #3967
  static carreg4 + #974, #3967
  static carreg4 + #975, #3967
  static carreg4 + #976, #3967
  static carreg4 + #977, #3967
  static carreg4 + #978, #3967
  static carreg4 + #979, #3967
  static carreg4 + #980, #3967
  static carreg4 + #981, #3967
  static carreg4 + #982, #3967
  static carreg4 + #983, #3967
  static carreg4 + #984, #3967
  static carreg4 + #985, #3967
  static carreg4 + #986, #1070
  static carreg4 + #987, #3967
  static carreg4 + #988, #3967
  static carreg4 + #989, #3967
  static carreg4 + #990, #3967
  static carreg4 + #991, #3967
  static carreg4 + #992, #3967
  static carreg4 + #993, #3967
  static carreg4 + #994, #3967
  static carreg4 + #995, #3967
  static carreg4 + #996, #3967
  static carreg4 + #997, #3967
  static carreg4 + #998, #3967
  static carreg4 + #999, #3967

  ;Linha 25
  static carreg4 + #1000, #3967
  static carreg4 + #1001, #3967
  static carreg4 + #1002, #3967
  static carreg4 + #1003, #3967
  static carreg4 + #1004, #3967
  static carreg4 + #1005, #3967
  static carreg4 + #1006, #3967
  static carreg4 + #1007, #3967
  static carreg4 + #1008, #3967
  static carreg4 + #1009, #3967
  static carreg4 + #1010, #3967
  static carreg4 + #1011, #3967
  static carreg4 + #1012, #3967
  static carreg4 + #1013, #3967
  static carreg4 + #1014, #1070
  static carreg4 + #1015, #3967
  static carreg4 + #1016, #3967
  static carreg4 + #1017, #3967
  static carreg4 + #1018, #3967
  static carreg4 + #1019, #3967
  static carreg4 + #1020, #3967
  static carreg4 + #1021, #3967
  static carreg4 + #1022, #3967
  static carreg4 + #1023, #3967
  static carreg4 + #1024, #3967
  static carreg4 + #1025, #3967
  static carreg4 + #1026, #3967
  static carreg4 + #1027, #3967
  static carreg4 + #1028, #3967
  static carreg4 + #1029, #3967
  static carreg4 + #1030, #3967
  static carreg4 + #1031, #3967
  static carreg4 + #1032, #3967
  static carreg4 + #1033, #3967
  static carreg4 + #1034, #3967
  static carreg4 + #1035, #3967
  static carreg4 + #1036, #3967
  static carreg4 + #1037, #3967
  static carreg4 + #1038, #3967
  static carreg4 + #1039, #3967

  ;Linha 26
  static carreg4 + #1040, #3967
  static carreg4 + #1041, #3967
  static carreg4 + #1042, #3967
  static carreg4 + #1043, #3967
  static carreg4 + #1044, #3967
  static carreg4 + #1045, #2117
  static carreg4 + #1046, #3967
  static carreg4 + #1047, #3967
  static carreg4 + #1048, #3967
  static carreg4 + #1049, #3967
  static carreg4 + #1050, #3967
  static carreg4 + #1051, #3967
  static carreg4 + #1052, #3967
  static carreg4 + #1053, #3967
  static carreg4 + #1054, #3967
  static carreg4 + #1055, #3967
  static carreg4 + #1056, #3967
  static carreg4 + #1057, #3967
  static carreg4 + #1058, #1070
  static carreg4 + #1059, #3967
  static carreg4 + #1060, #3967
  static carreg4 + #1061, #3967
  static carreg4 + #1062, #3967
  static carreg4 + #1063, #3967
  static carreg4 + #1064, #3967
  static carreg4 + #1065, #3967
  static carreg4 + #1066, #3967
  static carreg4 + #1067, #3967
  static carreg4 + #1068, #3967
  static carreg4 + #1069, #3967
  static carreg4 + #1070, #3967
  static carreg4 + #1071, #3967
  static carreg4 + #1072, #3967
  static carreg4 + #1073, #3967
  static carreg4 + #1074, #592
  static carreg4 + #1075, #3967
  static carreg4 + #1076, #3967
  static carreg4 + #1077, #3967
  static carreg4 + #1078, #1070
  static carreg4 + #1079, #3967

  ;Linha 27
  static carreg4 + #1080, #3967
  static carreg4 + #1081, #3967
  static carreg4 + #1082, #1070
  static carreg4 + #1083, #3967
  static carreg4 + #1084, #3967
  static carreg4 + #1085, #3967
  static carreg4 + #1086, #3967
  static carreg4 + #1087, #3967
  static carreg4 + #1088, #3967
  static carreg4 + #1089, #3967
  static carreg4 + #1090, #3967
  static carreg4 + #1091, #3967
  static carreg4 + #1092, #3967
  static carreg4 + #1093, #3967
  static carreg4 + #1094, #3967
  static carreg4 + #1095, #3967
  static carreg4 + #1096, #3967
  static carreg4 + #1097, #3967
  static carreg4 + #1098, #3967
  static carreg4 + #1099, #3967
  static carreg4 + #1100, #3967
  static carreg4 + #1101, #3967
  static carreg4 + #1102, #3967
  static carreg4 + #1103, #3967
  static carreg4 + #1104, #3967
  static carreg4 + #1105, #3967
  static carreg4 + #1106, #3967
  static carreg4 + #1107, #3967
  static carreg4 + #1108, #1070
  static carreg4 + #1109, #3967
  static carreg4 + #1110, #3967
  static carreg4 + #1111, #3967
  static carreg4 + #1112, #3967
  static carreg4 + #1113, #3967
  static carreg4 + #1114, #3967
  static carreg4 + #1115, #3967
  static carreg4 + #1116, #3967
  static carreg4 + #1117, #3967
  static carreg4 + #1118, #3967
  static carreg4 + #1119, #3967

  ;Linha 28
  static carreg4 + #1120, #3967
  static carreg4 + #1121, #3967
  static carreg4 + #1122, #3967
  static carreg4 + #1123, #3967
  static carreg4 + #1124, #3967
  static carreg4 + #1125, #3967
  static carreg4 + #1126, #3967
  static carreg4 + #1127, #3967
  static carreg4 + #1128, #3967
  static carreg4 + #1129, #3967
  static carreg4 + #1130, #3967
  static carreg4 + #1131, #1070
  static carreg4 + #1132, #3967
  static carreg4 + #1133, #3967
  static carreg4 + #1134, #3967
  static carreg4 + #1135, #3967
  static carreg4 + #1136, #3967
  static carreg4 + #1137, #3967
  static carreg4 + #1138, #3967
  static carreg4 + #1139, #3967
  static carreg4 + #1140, #3967
  static carreg4 + #1141, #3967
  static carreg4 + #1142, #1070
  static carreg4 + #1143, #3967
  static carreg4 + #1144, #3967
  static carreg4 + #1145, #3967
  static carreg4 + #1146, #3967
  static carreg4 + #1147, #3967
  static carreg4 + #1148, #3967
  static carreg4 + #1149, #3967
  static carreg4 + #1150, #3967
  static carreg4 + #1151, #3967
  static carreg4 + #1152, #3967
  static carreg4 + #1153, #3967
  static carreg4 + #1154, #3967
  static carreg4 + #1155, #3967
  static carreg4 + #1156, #3967
  static carreg4 + #1157, #3967
  static carreg4 + #1158, #3967
  static carreg4 + #1159, #3967

  ;Linha 29
  static carreg4 + #1160, #3967
  static carreg4 + #1161, #3967
  static carreg4 + #1162, #3967
  static carreg4 + #1163, #3967
  static carreg4 + #1164, #3967
  static carreg4 + #1165, #3967
  static carreg4 + #1166, #3967
  static carreg4 + #1167, #3967
  static carreg4 + #1168, #3967
  static carreg4 + #1169, #3967
  static carreg4 + #1170, #3967
  static carreg4 + #1171, #3967
  static carreg4 + #1172, #3967
  static carreg4 + #1173, #3967
  static carreg4 + #1174, #3967
  static carreg4 + #1175, #3967
  static carreg4 + #1176, #3967
  static carreg4 + #1177, #3967
  static carreg4 + #1178, #3967
  static carreg4 + #1179, #3967
  static carreg4 + #1180, #3967
  static carreg4 + #1181, #3967
  static carreg4 + #1182, #3967
  static carreg4 + #1183, #3967
  static carreg4 + #1184, #3967
  static carreg4 + #1185, #3967
  static carreg4 + #1186, #3967
  static carreg4 + #1187, #3967
  static carreg4 + #1188, #3967
  static carreg4 + #1189, #3967
  static carreg4 + #1190, #3967
  static carreg4 + #1191, #3967
  static carreg4 + #1192, #3967
  static carreg4 + #1193, #3967
  static carreg4 + #1194, #3967
  static carreg4 + #1195, #3967
  static carreg4 + #1196, #1070
  static carreg4 + #1197, #3967
  static carreg4 + #1198, #3967
  static carreg4 + #1199, #3967
carreg5 : var #1200
  ;Linha 0
  static carreg5 + #0, #3967
  static carreg5 + #1, #3967
  static carreg5 + #2, #3967
  static carreg5 + #3, #3967
  static carreg5 + #4, #3967
  static carreg5 + #5, #3967
  static carreg5 + #6, #3967
  static carreg5 + #7, #3967
  static carreg5 + #8, #3967
  static carreg5 + #9, #3967
  static carreg5 + #10, #3967
  static carreg5 + #11, #3967
  static carreg5 + #12, #3967
  static carreg5 + #13, #3967
  static carreg5 + #14, #3967
  static carreg5 + #15, #3967
  static carreg5 + #16, #3967
  static carreg5 + #17, #3967
  static carreg5 + #18, #3967
  static carreg5 + #19, #3967
  static carreg5 + #20, #3967
  static carreg5 + #21, #3967
  static carreg5 + #22, #3967
  static carreg5 + #23, #1070
  static carreg5 + #24, #3967
  static carreg5 + #25, #3967
  static carreg5 + #26, #3967
  static carreg5 + #27, #3967
  static carreg5 + #28, #3967
  static carreg5 + #29, #3967
  static carreg5 + #30, #3967
  static carreg5 + #31, #3967
  static carreg5 + #32, #3967
  static carreg5 + #33, #3967
  static carreg5 + #34, #3967
  static carreg5 + #35, #3967
  static carreg5 + #36, #3967
  static carreg5 + #37, #3967
  static carreg5 + #38, #3967
  static carreg5 + #39, #3967

  ;Linha 1
  static carreg5 + #40, #3967
  static carreg5 + #41, #3967
  static carreg5 + #42, #3967
  static carreg5 + #43, #1070
  static carreg5 + #44, #3967
  static carreg5 + #45, #2128
  static carreg5 + #46, #2097
  static carreg5 + #47, #3967
  static carreg5 + #48, #3967
  static carreg5 + #49, #3967
  static carreg5 + #50, #3967
  static carreg5 + #51, #3967
  static carreg5 + #52, #3967
  static carreg5 + #53, #3967
  static carreg5 + #54, #3967
  static carreg5 + #55, #1070
  static carreg5 + #56, #3967
  static carreg5 + #57, #3967
  static carreg5 + #58, #3967
  static carreg5 + #59, #3967
  static carreg5 + #60, #3967
  static carreg5 + #61, #3967
  static carreg5 + #62, #3967
  static carreg5 + #63, #3967
  static carreg5 + #64, #3967
  static carreg5 + #65, #3967
  static carreg5 + #66, #3967
  static carreg5 + #67, #3967
  static carreg5 + #68, #1070
  static carreg5 + #69, #3967
  static carreg5 + #70, #3967
  static carreg5 + #71, #3967
  static carreg5 + #72, #3967
  static carreg5 + #73, #592
  static carreg5 + #74, #562
  static carreg5 + #75, #3967
  static carreg5 + #76, #3967
  static carreg5 + #77, #1070
  static carreg5 + #78, #3967
  static carreg5 + #79, #3967

  ;Linha 2
  static carreg5 + #80, #3967
  static carreg5 + #81, #1070
  static carreg5 + #82, #3967
  static carreg5 + #83, #3967
  static carreg5 + #84, #3967
  static carreg5 + #85, #3967
  static carreg5 + #86, #3967
  static carreg5 + #87, #3967
  static carreg5 + #88, #3967
  static carreg5 + #89, #3967
  static carreg5 + #90, #3967
  static carreg5 + #91, #1070
  static carreg5 + #92, #3967
  static carreg5 + #93, #3967
  static carreg5 + #94, #3967
  static carreg5 + #95, #3967
  static carreg5 + #96, #3967
  static carreg5 + #97, #3967
  static carreg5 + #98, #3967
  static carreg5 + #99, #3967
  static carreg5 + #100, #3967
  static carreg5 + #101, #3967
  static carreg5 + #102, #3967
  static carreg5 + #103, #3967
  static carreg5 + #104, #3967
  static carreg5 + #105, #3967
  static carreg5 + #106, #3967
  static carreg5 + #107, #3967
  static carreg5 + #108, #3967
  static carreg5 + #109, #3967
  static carreg5 + #110, #3967
  static carreg5 + #111, #3967
  static carreg5 + #112, #3967
  static carreg5 + #113, #3967
  static carreg5 + #114, #3967
  static carreg5 + #115, #3967
  static carreg5 + #116, #3967
  static carreg5 + #117, #3967
  static carreg5 + #118, #3967
  static carreg5 + #119, #3967

  ;Linha 3
  static carreg5 + #120, #3967
  static carreg5 + #121, #3967
  static carreg5 + #122, #3967
  static carreg5 + #123, #3967
  static carreg5 + #124, #3967
  static carreg5 + #125, #2048
  static carreg5 + #126, #2048
  static carreg5 + #127, #3967
  static carreg5 + #128, #1070
  static carreg5 + #129, #3967
  static carreg5 + #130, #3967
  static carreg5 + #131, #3967
  static carreg5 + #132, #3967
  static carreg5 + #133, #3967
  static carreg5 + #134, #3967
  static carreg5 + #135, #3967
  static carreg5 + #136, #3967
  static carreg5 + #137, #3967
  static carreg5 + #138, #3967
  static carreg5 + #139, #3967
  static carreg5 + #140, #3967
  static carreg5 + #141, #3967
  static carreg5 + #142, #3967
  static carreg5 + #143, #3967
  static carreg5 + #144, #3967
  static carreg5 + #145, #3967
  static carreg5 + #146, #1070
  static carreg5 + #147, #3967
  static carreg5 + #148, #3967
  static carreg5 + #149, #3967
  static carreg5 + #150, #512
  static carreg5 + #151, #512
  static carreg5 + #152, #3967
  static carreg5 + #153, #3967
  static carreg5 + #154, #3967
  static carreg5 + #155, #3967
  static carreg5 + #156, #512
  static carreg5 + #157, #512
  static carreg5 + #158, #3967
  static carreg5 + #159, #3967

  ;Linha 4
  static carreg5 + #160, #3967
  static carreg5 + #161, #3967
  static carreg5 + #162, #3967
  static carreg5 + #163, #3967
  static carreg5 + #164, #3967
  static carreg5 + #165, #2048
  static carreg5 + #166, #2048
  static carreg5 + #167, #3967
  static carreg5 + #168, #3967
  static carreg5 + #169, #3967
  static carreg5 + #170, #3967
  static carreg5 + #171, #3967
  static carreg5 + #172, #3967
  static carreg5 + #173, #3967
  static carreg5 + #174, #3967
  static carreg5 + #175, #3967
  static carreg5 + #176, #3967
  static carreg5 + #177, #1070
  static carreg5 + #178, #3967
  static carreg5 + #179, #3967
  static carreg5 + #180, #3967
  static carreg5 + #181, #3967
  static carreg5 + #182, #3967
  static carreg5 + #183, #3967
  static carreg5 + #184, #3967
  static carreg5 + #185, #3967
  static carreg5 + #186, #3967
  static carreg5 + #187, #3967
  static carreg5 + #188, #3967
  static carreg5 + #189, #3967
  static carreg5 + #190, #3967
  static carreg5 + #191, #3967
  static carreg5 + #192, #512
  static carreg5 + #193, #3967
  static carreg5 + #194, #3967
  static carreg5 + #195, #512
  static carreg5 + #196, #3967
  static carreg5 + #197, #3967
  static carreg5 + #198, #1070
  static carreg5 + #199, #3967

  ;Linha 5
  static carreg5 + #200, #3967
  static carreg5 + #201, #3967
  static carreg5 + #202, #3967
  static carreg5 + #203, #3967
  static carreg5 + #204, #3967
  static carreg5 + #205, #2048
  static carreg5 + #206, #2048
  static carreg5 + #207, #3967
  static carreg5 + #208, #3967
  static carreg5 + #209, #3967
  static carreg5 + #210, #3967
  static carreg5 + #211, #3967
  static carreg5 + #212, #3967
  static carreg5 + #213, #3967
  static carreg5 + #214, #3967
  static carreg5 + #215, #3967
  static carreg5 + #216, #3967
  static carreg5 + #217, #3967
  static carreg5 + #218, #3967
  static carreg5 + #219, #3967
  static carreg5 + #220, #3967
  static carreg5 + #221, #3967
  static carreg5 + #222, #3967
  static carreg5 + #223, #1070
  static carreg5 + #224, #3967
  static carreg5 + #225, #3967
  static carreg5 + #226, #3967
  static carreg5 + #227, #3967
  static carreg5 + #228, #3967
  static carreg5 + #229, #3967
  static carreg5 + #230, #3967
  static carreg5 + #231, #3967
  static carreg5 + #232, #512
  static carreg5 + #233, #512
  static carreg5 + #234, #512
  static carreg5 + #235, #512
  static carreg5 + #236, #3967
  static carreg5 + #237, #3967
  static carreg5 + #238, #3967
  static carreg5 + #239, #3967

  ;Linha 6
  static carreg5 + #240, #3967
  static carreg5 + #241, #3967
  static carreg5 + #242, #2048
  static carreg5 + #243, #3967
  static carreg5 + #244, #3967
  static carreg5 + #245, #2048
  static carreg5 + #246, #2048
  static carreg5 + #247, #3967
  static carreg5 + #248, #3967
  static carreg5 + #249, #2048
  static carreg5 + #250, #3967
  static carreg5 + #251, #3967
  static carreg5 + #252, #3967
  static carreg5 + #253, #3967
  static carreg5 + #254, #3967
  static carreg5 + #255, #3967
  static carreg5 + #256, #3967
  static carreg5 + #257, #3967
  static carreg5 + #258, #3967
  static carreg5 + #259, #3967
  static carreg5 + #260, #3967
  static carreg5 + #261, #3967
  static carreg5 + #262, #3967
  static carreg5 + #263, #3967
  static carreg5 + #264, #3967
  static carreg5 + #265, #3967
  static carreg5 + #266, #3967
  static carreg5 + #267, #3967
  static carreg5 + #268, #3967
  static carreg5 + #269, #3967
  static carreg5 + #270, #3967
  static carreg5 + #271, #512
  static carreg5 + #272, #3967
  static carreg5 + #273, #512
  static carreg5 + #274, #512
  static carreg5 + #275, #3967
  static carreg5 + #276, #512
  static carreg5 + #277, #3967
  static carreg5 + #278, #3967
  static carreg5 + #279, #3967

  ;Linha 7
  static carreg5 + #280, #3967
  static carreg5 + #281, #3967
  static carreg5 + #282, #2048
  static carreg5 + #283, #3967
  static carreg5 + #284, #2048
  static carreg5 + #285, #2048
  static carreg5 + #286, #2048
  static carreg5 + #287, #2048
  static carreg5 + #288, #3967
  static carreg5 + #289, #2048
  static carreg5 + #290, #3967
  static carreg5 + #291, #3967
  static carreg5 + #292, #3967
  static carreg5 + #293, #3967
  static carreg5 + #294, #3967
  static carreg5 + #295, #3967
  static carreg5 + #296, #3967
  static carreg5 + #297, #3967
  static carreg5 + #298, #3967
  static carreg5 + #299, #3967
  static carreg5 + #300, #3967
  static carreg5 + #301, #3967
  static carreg5 + #302, #3967
  static carreg5 + #303, #3967
  static carreg5 + #304, #3967
  static carreg5 + #305, #3967
  static carreg5 + #306, #3967
  static carreg5 + #307, #3967
  static carreg5 + #308, #3967
  static carreg5 + #309, #3967
  static carreg5 + #310, #512
  static carreg5 + #311, #512
  static carreg5 + #312, #512
  static carreg5 + #313, #512
  static carreg5 + #314, #512
  static carreg5 + #315, #512
  static carreg5 + #316, #512
  static carreg5 + #317, #512
  static carreg5 + #318, #3967
  static carreg5 + #319, #3967

  ;Linha 8
  static carreg5 + #320, #3967
  static carreg5 + #321, #3967
  static carreg5 + #322, #2048
  static carreg5 + #323, #2048
  static carreg5 + #324, #2048
  static carreg5 + #325, #2048
  static carreg5 + #326, #2048
  static carreg5 + #327, #2048
  static carreg5 + #328, #2048
  static carreg5 + #329, #2048
  static carreg5 + #330, #3967
  static carreg5 + #331, #3967
  static carreg5 + #332, #3967
  static carreg5 + #333, #3967
  static carreg5 + #334, #3967
  static carreg5 + #335, #3967
  static carreg5 + #336, #3967
  static carreg5 + #337, #3967
  static carreg5 + #338, #3967
  static carreg5 + #339, #3967
  static carreg5 + #340, #3967
  static carreg5 + #341, #3967
  static carreg5 + #342, #3967
  static carreg5 + #343, #3967
  static carreg5 + #344, #3967
  static carreg5 + #345, #3967
  static carreg5 + #346, #3967
  static carreg5 + #347, #3967
  static carreg5 + #348, #3967
  static carreg5 + #349, #3967
  static carreg5 + #350, #512
  static carreg5 + #351, #3967
  static carreg5 + #352, #512
  static carreg5 + #353, #512
  static carreg5 + #354, #512
  static carreg5 + #355, #512
  static carreg5 + #356, #3967
  static carreg5 + #357, #512
  static carreg5 + #358, #3967
  static carreg5 + #359, #3967

  ;Linha 9
  static carreg5 + #360, #3967
  static carreg5 + #361, #3967
  static carreg5 + #362, #2048
  static carreg5 + #363, #2048
  static carreg5 + #364, #3967
  static carreg5 + #365, #2048
  static carreg5 + #366, #2048
  static carreg5 + #367, #3967
  static carreg5 + #368, #2048
  static carreg5 + #369, #2048
  static carreg5 + #370, #3967
  static carreg5 + #371, #3967
  static carreg5 + #372, #3967
  static carreg5 + #373, #3967
  static carreg5 + #374, #3967
  static carreg5 + #375, #1024
  static carreg5 + #376, #3967
  static carreg5 + #377, #1070
  static carreg5 + #378, #3967
  static carreg5 + #379, #1024
  static carreg5 + #380, #3967
  static carreg5 + #381, #3967
  static carreg5 + #382, #1024
  static carreg5 + #383, #1024
  static carreg5 + #384, #3967
  static carreg5 + #385, #3967
  static carreg5 + #386, #1070
  static carreg5 + #387, #3967
  static carreg5 + #388, #3967
  static carreg5 + #389, #3967
  static carreg5 + #390, #512
  static carreg5 + #391, #3967
  static carreg5 + #392, #512
  static carreg5 + #393, #3967
  static carreg5 + #394, #3967
  static carreg5 + #395, #512
  static carreg5 + #396, #3967
  static carreg5 + #397, #512
  static carreg5 + #398, #3967
  static carreg5 + #399, #3967

  ;Linha 10
  static carreg5 + #400, #1070
  static carreg5 + #401, #3967
  static carreg5 + #402, #2048
  static carreg5 + #403, #3967
  static carreg5 + #404, #3967
  static carreg5 + #405, #3967
  static carreg5 + #406, #3967
  static carreg5 + #407, #3967
  static carreg5 + #408, #3967
  static carreg5 + #409, #2048
  static carreg5 + #410, #3967
  static carreg5 + #411, #3967
  static carreg5 + #412, #1070
  static carreg5 + #413, #3967
  static carreg5 + #414, #3967
  static carreg5 + #415, #1024
  static carreg5 + #416, #3967
  static carreg5 + #417, #3967
  static carreg5 + #418, #3967
  static carreg5 + #419, #1024
  static carreg5 + #420, #3967
  static carreg5 + #421, #1024
  static carreg5 + #422, #3967
  static carreg5 + #423, #3967
  static carreg5 + #424, #1024
  static carreg5 + #425, #3967
  static carreg5 + #426, #3967
  static carreg5 + #427, #3967
  static carreg5 + #428, #3967
  static carreg5 + #429, #3967
  static carreg5 + #430, #3967
  static carreg5 + #431, #3967
  static carreg5 + #432, #512
  static carreg5 + #433, #3967
  static carreg5 + #434, #3967
  static carreg5 + #435, #512
  static carreg5 + #436, #3967
  static carreg5 + #437, #3967
  static carreg5 + #438, #3967
  static carreg5 + #439, #3967

  ;Linha 11
  static carreg5 + #440, #3967
  static carreg5 + #441, #3967
  static carreg5 + #442, #3967
  static carreg5 + #443, #3967
  static carreg5 + #444, #1070
  static carreg5 + #445, #3967
  static carreg5 + #446, #3967
  static carreg5 + #447, #3967
  static carreg5 + #448, #3967
  static carreg5 + #449, #3967
  static carreg5 + #450, #3967
  static carreg5 + #451, #3967
  static carreg5 + #452, #3967
  static carreg5 + #453, #3967
  static carreg5 + #454, #3967
  static carreg5 + #455, #1024
  static carreg5 + #456, #3967
  static carreg5 + #457, #3967
  static carreg5 + #458, #3967
  static carreg5 + #459, #1024
  static carreg5 + #460, #3967
  static carreg5 + #461, #1024
  static carreg5 + #462, #3967
  static carreg5 + #463, #3967
  static carreg5 + #464, #3967
  static carreg5 + #465, #3967
  static carreg5 + #466, #3967
  static carreg5 + #467, #3967
  static carreg5 + #468, #3967
  static carreg5 + #469, #3967
  static carreg5 + #470, #3967
  static carreg5 + #471, #3967
  static carreg5 + #472, #3967
  static carreg5 + #473, #3967
  static carreg5 + #474, #3967
  static carreg5 + #475, #3967
  static carreg5 + #476, #3967
  static carreg5 + #477, #3967
  static carreg5 + #478, #3967
  static carreg5 + #479, #3967

  ;Linha 12
  static carreg5 + #480, #3967
  static carreg5 + #481, #3967
  static carreg5 + #482, #3967
  static carreg5 + #483, #3967
  static carreg5 + #484, #3967
  static carreg5 + #485, #3967
  static carreg5 + #486, #3967
  static carreg5 + #487, #3967
  static carreg5 + #488, #3967
  static carreg5 + #489, #3967
  static carreg5 + #490, #3967
  static carreg5 + #491, #3967
  static carreg5 + #492, #3967
  static carreg5 + #493, #3967
  static carreg5 + #494, #3967
  static carreg5 + #495, #1024
  static carreg5 + #496, #3967
  static carreg5 + #497, #3967
  static carreg5 + #498, #3967
  static carreg5 + #499, #1024
  static carreg5 + #500, #3967
  static carreg5 + #501, #3967
  static carreg5 + #502, #1024
  static carreg5 + #503, #1024
  static carreg5 + #504, #3967
  static carreg5 + #505, #3967
  static carreg5 + #506, #3967
  static carreg5 + #507, #3967
  static carreg5 + #508, #3967
  static carreg5 + #509, #3967
  static carreg5 + #510, #3967
  static carreg5 + #511, #3967
  static carreg5 + #512, #3967
  static carreg5 + #513, #3967
  static carreg5 + #514, #3967
  static carreg5 + #515, #3967
  static carreg5 + #516, #3967
  static carreg5 + #517, #3967
  static carreg5 + #518, #3967
  static carreg5 + #519, #3967

  ;Linha 13
  static carreg5 + #520, #3967
  static carreg5 + #521, #3967
  static carreg5 + #522, #3967
  static carreg5 + #523, #3967
  static carreg5 + #524, #3967
  static carreg5 + #525, #3967
  static carreg5 + #526, #3967
  static carreg5 + #527, #3967
  static carreg5 + #528, #3967
  static carreg5 + #529, #3967
  static carreg5 + #530, #3967
  static carreg5 + #531, #3967
  static carreg5 + #532, #3967
  static carreg5 + #533, #3967
  static carreg5 + #534, #3967
  static carreg5 + #535, #1024
  static carreg5 + #536, #3967
  static carreg5 + #537, #3967
  static carreg5 + #538, #3967
  static carreg5 + #539, #1024
  static carreg5 + #540, #3967
  static carreg5 + #541, #3967
  static carreg5 + #542, #3967
  static carreg5 + #543, #3967
  static carreg5 + #544, #1024
  static carreg5 + #545, #3967
  static carreg5 + #546, #3967
  static carreg5 + #547, #3967
  static carreg5 + #548, #3967
  static carreg5 + #549, #1070
  static carreg5 + #550, #3967
  static carreg5 + #551, #3967
  static carreg5 + #552, #3967
  static carreg5 + #553, #3967
  static carreg5 + #554, #3967
  static carreg5 + #555, #3967
  static carreg5 + #556, #3967
  static carreg5 + #557, #3967
  static carreg5 + #558, #1070
  static carreg5 + #559, #3967

  ;Linha 14
  static carreg5 + #560, #3967
  static carreg5 + #561, #1070
  static carreg5 + #562, #3967
  static carreg5 + #563, #3967
  static carreg5 + #564, #2125
  static carreg5 + #565, #2159
  static carreg5 + #566, #2166
  static carreg5 + #567, #2106
  static carreg5 + #568, #3967
  static carreg5 + #569, #1070
  static carreg5 + #570, #3967
  static carreg5 + #571, #3967
  static carreg5 + #572, #3967
  static carreg5 + #573, #3967
  static carreg5 + #574, #3967
  static carreg5 + #575, #3967
  static carreg5 + #576, #1024
  static carreg5 + #577, #3967
  static carreg5 + #578, #1024
  static carreg5 + #579, #3967
  static carreg5 + #580, #3967
  static carreg5 + #581, #1024
  static carreg5 + #582, #3967
  static carreg5 + #583, #3967
  static carreg5 + #584, #1024
  static carreg5 + #585, #3967
  static carreg5 + #586, #3967
  static carreg5 + #587, #3967
  static carreg5 + #588, #3967
  static carreg5 + #589, #3967
  static carreg5 + #590, #3967
  static carreg5 + #591, #3967
  static carreg5 + #592, #589
  static carreg5 + #593, #623
  static carreg5 + #594, #630
  static carreg5 + #595, #570
  static carreg5 + #596, #3967
  static carreg5 + #597, #3967
  static carreg5 + #598, #3967
  static carreg5 + #599, #3967

  ;Linha 15
  static carreg5 + #600, #3967
  static carreg5 + #601, #3967
  static carreg5 + #602, #3967
  static carreg5 + #603, #3967
  static carreg5 + #604, #3967
  static carreg5 + #605, #3967
  static carreg5 + #606, #3967
  static carreg5 + #607, #3967
  static carreg5 + #608, #3967
  static carreg5 + #609, #3967
  static carreg5 + #610, #3967
  static carreg5 + #611, #3967
  static carreg5 + #612, #3967
  static carreg5 + #613, #1070
  static carreg5 + #614, #3967
  static carreg5 + #615, #3967
  static carreg5 + #616, #3967
  static carreg5 + #617, #1024
  static carreg5 + #618, #3967
  static carreg5 + #619, #3967
  static carreg5 + #620, #3967
  static carreg5 + #621, #3967
  static carreg5 + #622, #1024
  static carreg5 + #623, #1024
  static carreg5 + #624, #3967
  static carreg5 + #625, #3967
  static carreg5 + #626, #3967
  static carreg5 + #627, #1070
  static carreg5 + #628, #3967
  static carreg5 + #629, #3967
  static carreg5 + #630, #3967
  static carreg5 + #631, #3967
  static carreg5 + #632, #3967
  static carreg5 + #633, #3967
  static carreg5 + #634, #3967
  static carreg5 + #635, #3967
  static carreg5 + #636, #3967
  static carreg5 + #637, #3967
  static carreg5 + #638, #3967
  static carreg5 + #639, #3967

  ;Linha 16
  static carreg5 + #640, #3967
  static carreg5 + #641, #3967
  static carreg5 + #642, #3967
  static carreg5 + #643, #3967
  static carreg5 + #644, #3967
  static carreg5 + #645, #3967
  static carreg5 + #646, #3967
  static carreg5 + #647, #3967
  static carreg5 + #648, #3967
  static carreg5 + #649, #3967
  static carreg5 + #650, #3967
  static carreg5 + #651, #3967
  static carreg5 + #652, #3967
  static carreg5 + #653, #3967
  static carreg5 + #654, #3967
  static carreg5 + #655, #3967
  static carreg5 + #656, #3967
  static carreg5 + #657, #3967
  static carreg5 + #658, #3967
  static carreg5 + #659, #3967
  static carreg5 + #660, #3967
  static carreg5 + #661, #3967
  static carreg5 + #662, #3967
  static carreg5 + #663, #3967
  static carreg5 + #664, #3967
  static carreg5 + #665, #3967
  static carreg5 + #666, #3967
  static carreg5 + #667, #3967
  static carreg5 + #668, #3967
  static carreg5 + #669, #3967
  static carreg5 + #670, #3967
  static carreg5 + #671, #3967
  static carreg5 + #672, #3967
  static carreg5 + #673, #3967
  static carreg5 + #674, #3967
  static carreg5 + #675, #3967
  static carreg5 + #676, #3967
  static carreg5 + #677, #3967
  static carreg5 + #678, #3967
  static carreg5 + #679, #3967

  ;Linha 17
  static carreg5 + #680, #3967
  static carreg5 + #681, #3967
  static carreg5 + #682, #3967
  static carreg5 + #683, #3967
  static carreg5 + #684, #3967
  static carreg5 + #685, #2135
  static carreg5 + #686, #3967
  static carreg5 + #687, #3967
  static carreg5 + #688, #3967
  static carreg5 + #689, #3967
  static carreg5 + #690, #3967
  static carreg5 + #691, #3967
  static carreg5 + #692, #3967
  static carreg5 + #693, #3967
  static carreg5 + #694, #3967
  static carreg5 + #695, #3967
  static carreg5 + #696, #3967
  static carreg5 + #697, #3967
  static carreg5 + #698, #3967
  static carreg5 + #699, #3967
  static carreg5 + #700, #3967
  static carreg5 + #701, #1070
  static carreg5 + #702, #3967
  static carreg5 + #703, #3967
  static carreg5 + #704, #1070
  static carreg5 + #705, #3967
  static carreg5 + #706, #3967
  static carreg5 + #707, #3967
  static carreg5 + #708, #3967
  static carreg5 + #709, #3967
  static carreg5 + #710, #3967
  static carreg5 + #711, #3967
  static carreg5 + #712, #3967
  static carreg5 + #713, #3967
  static carreg5 + #714, #585
  static carreg5 + #715, #3967
  static carreg5 + #716, #3967
  static carreg5 + #717, #1070
  static carreg5 + #718, #3967
  static carreg5 + #719, #3967

  ;Linha 18
  static carreg5 + #720, #3967
  static carreg5 + #721, #3967
  static carreg5 + #722, #3967
  static carreg5 + #723, #3967
  static carreg5 + #724, #3967
  static carreg5 + #725, #3967
  static carreg5 + #726, #3967
  static carreg5 + #727, #3967
  static carreg5 + #728, #3967
  static carreg5 + #729, #3967
  static carreg5 + #730, #3967
  static carreg5 + #731, #3967
  static carreg5 + #732, #3967
  static carreg5 + #733, #1070
  static carreg5 + #734, #3967
  static carreg5 + #735, #3117
  static carreg5 + #736, #3117
  static carreg5 + #737, #1069
  static carreg5 + #738, #1069
  static carreg5 + #739, #1069
  static carreg5 + #740, #1069
  static carreg5 + #741, #1069
  static carreg5 + #742, #1069
  static carreg5 + #743, #1069
  static carreg5 + #744, #1069
  static carreg5 + #745, #3967
  static carreg5 + #746, #3967
  static carreg5 + #747, #3967
  static carreg5 + #748, #3967
  static carreg5 + #749, #3967
  static carreg5 + #750, #3967
  static carreg5 + #751, #3967
  static carreg5 + #752, #3967
  static carreg5 + #753, #3967
  static carreg5 + #754, #3967
  static carreg5 + #755, #3967
  static carreg5 + #756, #3967
  static carreg5 + #757, #3967
  static carreg5 + #758, #3967
  static carreg5 + #759, #3967

  ;Linha 19
  static carreg5 + #760, #3967
  static carreg5 + #761, #3967
  static carreg5 + #762, #3967
  static carreg5 + #763, #2113
  static carreg5 + #764, #3967
  static carreg5 + #765, #2131
  static carreg5 + #766, #3967
  static carreg5 + #767, #2116
  static carreg5 + #768, #3967
  static carreg5 + #769, #3967
  static carreg5 + #770, #3967
  static carreg5 + #771, #3967
  static carreg5 + #772, #3967
  static carreg5 + #773, #3967
  static carreg5 + #774, #3967
  static carreg5 + #775, #3139
  static carreg5 + #776, #3137
  static carreg5 + #777, #1106
  static carreg5 + #778, #1106
  static carreg5 + #779, #1093
  static carreg5 + #780, #1095
  static carreg5 + #781, #1089
  static carreg5 + #782, #1102
  static carreg5 + #783, #1092
  static carreg5 + #784, #1103
  static carreg5 + #785, #3967
  static carreg5 + #786, #3967
  static carreg5 + #787, #3967
  static carreg5 + #788, #3967
  static carreg5 + #789, #3967
  static carreg5 + #790, #3967
  static carreg5 + #791, #3967
  static carreg5 + #792, #586
  static carreg5 + #793, #3967
  static carreg5 + #794, #587
  static carreg5 + #795, #3967
  static carreg5 + #796, #588
  static carreg5 + #797, #3967
  static carreg5 + #798, #3967
  static carreg5 + #799, #3967

  ;Linha 20
  static carreg5 + #800, #3967
  static carreg5 + #801, #3967
  static carreg5 + #802, #3967
  static carreg5 + #803, #3967
  static carreg5 + #804, #3967
  static carreg5 + #805, #3967
  static carreg5 + #806, #3967
  static carreg5 + #807, #3967
  static carreg5 + #808, #3967
  static carreg5 + #809, #3967
  static carreg5 + #810, #3967
  static carreg5 + #811, #3967
  static carreg5 + #812, #3967
  static carreg5 + #813, #3967
  static carreg5 + #814, #3967
  static carreg5 + #815, #3117
  static carreg5 + #816, #3117
  static carreg5 + #817, #1069
  static carreg5 + #818, #1069
  static carreg5 + #819, #1069
  static carreg5 + #820, #1069
  static carreg5 + #821, #1069
  static carreg5 + #822, #1069
  static carreg5 + #823, #1069
  static carreg5 + #824, #1069
  static carreg5 + #825, #3967
  static carreg5 + #826, #3967
  static carreg5 + #827, #3967
  static carreg5 + #828, #1070
  static carreg5 + #829, #3967
  static carreg5 + #830, #3967
  static carreg5 + #831, #3967
  static carreg5 + #832, #3967
  static carreg5 + #833, #3967
  static carreg5 + #834, #3967
  static carreg5 + #835, #3967
  static carreg5 + #836, #3967
  static carreg5 + #837, #3967
  static carreg5 + #838, #3967
  static carreg5 + #839, #3967

  ;Linha 21
  static carreg5 + #840, #3967
  static carreg5 + #841, #1070
  static carreg5 + #842, #3967
  static carreg5 + #843, #3967
  static carreg5 + #844, #1070
  static carreg5 + #845, #3967
  static carreg5 + #846, #3967
  static carreg5 + #847, #3967
  static carreg5 + #848, #3967
  static carreg5 + #849, #3967
  static carreg5 + #850, #3967
  static carreg5 + #851, #3967
  static carreg5 + #852, #3967
  static carreg5 + #853, #3967
  static carreg5 + #854, #3967
  static carreg5 + #855, #3967
  static carreg5 + #856, #3967
  static carreg5 + #857, #3967
  static carreg5 + #858, #3967
  static carreg5 + #859, #3967
  static carreg5 + #860, #3967
  static carreg5 + #861, #3967
  static carreg5 + #862, #3967
  static carreg5 + #863, #3967
  static carreg5 + #864, #3967
  static carreg5 + #865, #3967
  static carreg5 + #866, #3967
  static carreg5 + #867, #3967
  static carreg5 + #868, #3967
  static carreg5 + #869, #3967
  static carreg5 + #870, #3967
  static carreg5 + #871, #3967
  static carreg5 + #872, #3967
  static carreg5 + #873, #3967
  static carreg5 + #874, #1070
  static carreg5 + #875, #3967
  static carreg5 + #876, #3967
  static carreg5 + #877, #3967
  static carreg5 + #878, #3967
  static carreg5 + #879, #1070

  ;Linha 22
  static carreg5 + #880, #3967
  static carreg5 + #881, #3967
  static carreg5 + #882, #3967
  static carreg5 + #883, #3967
  static carreg5 + #884, #3967
  static carreg5 + #885, #3967
  static carreg5 + #886, #3967
  static carreg5 + #887, #3967
  static carreg5 + #888, #3967
  static carreg5 + #889, #3967
  static carreg5 + #890, #3967
  static carreg5 + #891, #1070
  static carreg5 + #892, #3967
  static carreg5 + #893, #3967
  static carreg5 + #894, #3967
  static carreg5 + #895, #3967
  static carreg5 + #896, #3967
  static carreg5 + #897, #3967
  static carreg5 + #898, #3967
  static carreg5 + #899, #3967
  static carreg5 + #900, #1070
  static carreg5 + #901, #3967
  static carreg5 + #902, #3967
  static carreg5 + #903, #3967
  static carreg5 + #904, #3967
  static carreg5 + #905, #3967
  static carreg5 + #906, #3967
  static carreg5 + #907, #3967
  static carreg5 + #908, #3967
  static carreg5 + #909, #3967
  static carreg5 + #910, #3967
  static carreg5 + #911, #3967
  static carreg5 + #912, #3967
  static carreg5 + #913, #3967
  static carreg5 + #914, #3967
  static carreg5 + #915, #3967
  static carreg5 + #916, #3967
  static carreg5 + #917, #3967
  static carreg5 + #918, #3967
  static carreg5 + #919, #3967

  ;Linha 23
  static carreg5 + #920, #3967
  static carreg5 + #921, #3967
  static carreg5 + #922, #3967
  static carreg5 + #923, #2131
  static carreg5 + #924, #2152
  static carreg5 + #925, #2159
  static carreg5 + #926, #2159
  static carreg5 + #927, #2164
  static carreg5 + #928, #2106
  static carreg5 + #929, #3967
  static carreg5 + #930, #3967
  static carreg5 + #931, #3967
  static carreg5 + #932, #3967
  static carreg5 + #933, #3967
  static carreg5 + #934, #3967
  static carreg5 + #935, #3967
  static carreg5 + #936, #3967
  static carreg5 + #937, #3967
  static carreg5 + #938, #3967
  static carreg5 + #939, #3967
  static carreg5 + #940, #3967
  static carreg5 + #941, #3967
  static carreg5 + #942, #3967
  static carreg5 + #943, #3967
  static carreg5 + #944, #3967
  static carreg5 + #945, #1070
  static carreg5 + #946, #3967
  static carreg5 + #947, #3967
  static carreg5 + #948, #3967
  static carreg5 + #949, #3967
  static carreg5 + #950, #3967
  static carreg5 + #951, #595
  static carreg5 + #952, #616
  static carreg5 + #953, #623
  static carreg5 + #954, #623
  static carreg5 + #955, #628
  static carreg5 + #956, #570
  static carreg5 + #957, #3967
  static carreg5 + #958, #3967
  static carreg5 + #959, #3967

  ;Linha 24
  static carreg5 + #960, #3967
  static carreg5 + #961, #3967
  static carreg5 + #962, #3967
  static carreg5 + #963, #3967
  static carreg5 + #964, #3967
  static carreg5 + #965, #3967
  static carreg5 + #966, #3967
  static carreg5 + #967, #3967
  static carreg5 + #968, #3967
  static carreg5 + #969, #3967
  static carreg5 + #970, #3967
  static carreg5 + #971, #3967
  static carreg5 + #972, #3967
  static carreg5 + #973, #3967
  static carreg5 + #974, #3967
  static carreg5 + #975, #3967
  static carreg5 + #976, #3967
  static carreg5 + #977, #3967
  static carreg5 + #978, #3967
  static carreg5 + #979, #3967
  static carreg5 + #980, #3967
  static carreg5 + #981, #3967
  static carreg5 + #982, #3967
  static carreg5 + #983, #3967
  static carreg5 + #984, #3967
  static carreg5 + #985, #3967
  static carreg5 + #986, #1070
  static carreg5 + #987, #3967
  static carreg5 + #988, #3967
  static carreg5 + #989, #3967
  static carreg5 + #990, #3967
  static carreg5 + #991, #3967
  static carreg5 + #992, #3967
  static carreg5 + #993, #3967
  static carreg5 + #994, #3967
  static carreg5 + #995, #3967
  static carreg5 + #996, #3967
  static carreg5 + #997, #3967
  static carreg5 + #998, #3967
  static carreg5 + #999, #3967

  ;Linha 25
  static carreg5 + #1000, #3967
  static carreg5 + #1001, #3967
  static carreg5 + #1002, #3967
  static carreg5 + #1003, #3967
  static carreg5 + #1004, #3967
  static carreg5 + #1005, #3967
  static carreg5 + #1006, #3967
  static carreg5 + #1007, #3967
  static carreg5 + #1008, #3967
  static carreg5 + #1009, #3967
  static carreg5 + #1010, #3967
  static carreg5 + #1011, #3967
  static carreg5 + #1012, #3967
  static carreg5 + #1013, #3967
  static carreg5 + #1014, #1070
  static carreg5 + #1015, #3967
  static carreg5 + #1016, #3967
  static carreg5 + #1017, #3967
  static carreg5 + #1018, #3967
  static carreg5 + #1019, #3967
  static carreg5 + #1020, #3967
  static carreg5 + #1021, #3967
  static carreg5 + #1022, #3967
  static carreg5 + #1023, #3967
  static carreg5 + #1024, #3967
  static carreg5 + #1025, #3967
  static carreg5 + #1026, #3967
  static carreg5 + #1027, #3967
  static carreg5 + #1028, #3967
  static carreg5 + #1029, #3967
  static carreg5 + #1030, #3967
  static carreg5 + #1031, #3967
  static carreg5 + #1032, #3967
  static carreg5 + #1033, #3967
  static carreg5 + #1034, #3967
  static carreg5 + #1035, #3967
  static carreg5 + #1036, #3967
  static carreg5 + #1037, #3967
  static carreg5 + #1038, #3967
  static carreg5 + #1039, #3967

  ;Linha 26
  static carreg5 + #1040, #3967
  static carreg5 + #1041, #3967
  static carreg5 + #1042, #3967
  static carreg5 + #1043, #3967
  static carreg5 + #1044, #3967
  static carreg5 + #1045, #2117
  static carreg5 + #1046, #3967
  static carreg5 + #1047, #3967
  static carreg5 + #1048, #3967
  static carreg5 + #1049, #3967
  static carreg5 + #1050, #3967
  static carreg5 + #1051, #3967
  static carreg5 + #1052, #3967
  static carreg5 + #1053, #3967
  static carreg5 + #1054, #3967
  static carreg5 + #1055, #3967
  static carreg5 + #1056, #3967
  static carreg5 + #1057, #3967
  static carreg5 + #1058, #1070
  static carreg5 + #1059, #3967
  static carreg5 + #1060, #3967
  static carreg5 + #1061, #3967
  static carreg5 + #1062, #3967
  static carreg5 + #1063, #3967
  static carreg5 + #1064, #3967
  static carreg5 + #1065, #3967
  static carreg5 + #1066, #3967
  static carreg5 + #1067, #3967
  static carreg5 + #1068, #3967
  static carreg5 + #1069, #3967
  static carreg5 + #1070, #3967
  static carreg5 + #1071, #3967
  static carreg5 + #1072, #3967
  static carreg5 + #1073, #3967
  static carreg5 + #1074, #592
  static carreg5 + #1075, #3967
  static carreg5 + #1076, #3967
  static carreg5 + #1077, #3967
  static carreg5 + #1078, #1070
  static carreg5 + #1079, #3967

  ;Linha 27
  static carreg5 + #1080, #3967
  static carreg5 + #1081, #3967
  static carreg5 + #1082, #1070
  static carreg5 + #1083, #3967
  static carreg5 + #1084, #3967
  static carreg5 + #1085, #3967
  static carreg5 + #1086, #3967
  static carreg5 + #1087, #3967
  static carreg5 + #1088, #3967
  static carreg5 + #1089, #3967
  static carreg5 + #1090, #3967
  static carreg5 + #1091, #3967
  static carreg5 + #1092, #3967
  static carreg5 + #1093, #3967
  static carreg5 + #1094, #3967
  static carreg5 + #1095, #3967
  static carreg5 + #1096, #3967
  static carreg5 + #1097, #3967
  static carreg5 + #1098, #3967
  static carreg5 + #1099, #3967
  static carreg5 + #1100, #3967
  static carreg5 + #1101, #3967
  static carreg5 + #1102, #3967
  static carreg5 + #1103, #3967
  static carreg5 + #1104, #3967
  static carreg5 + #1105, #3967
  static carreg5 + #1106, #3967
  static carreg5 + #1107, #3967
  static carreg5 + #1108, #1070
  static carreg5 + #1109, #3967
  static carreg5 + #1110, #3967
  static carreg5 + #1111, #3967
  static carreg5 + #1112, #3967
  static carreg5 + #1113, #3967
  static carreg5 + #1114, #3967
  static carreg5 + #1115, #3967
  static carreg5 + #1116, #3967
  static carreg5 + #1117, #3967
  static carreg5 + #1118, #3967
  static carreg5 + #1119, #3967

  ;Linha 28
  static carreg5 + #1120, #3967
  static carreg5 + #1121, #3967
  static carreg5 + #1122, #3967
  static carreg5 + #1123, #3967
  static carreg5 + #1124, #3967
  static carreg5 + #1125, #3967
  static carreg5 + #1126, #3967
  static carreg5 + #1127, #3967
  static carreg5 + #1128, #3967
  static carreg5 + #1129, #3967
  static carreg5 + #1130, #3967
  static carreg5 + #1131, #1070
  static carreg5 + #1132, #3967
  static carreg5 + #1133, #3967
  static carreg5 + #1134, #3967
  static carreg5 + #1135, #3967
  static carreg5 + #1136, #3967
  static carreg5 + #1137, #3967
  static carreg5 + #1138, #3967
  static carreg5 + #1139, #3967
  static carreg5 + #1140, #3967
  static carreg5 + #1141, #3967
  static carreg5 + #1142, #1070
  static carreg5 + #1143, #3967
  static carreg5 + #1144, #3967
  static carreg5 + #1145, #3967
  static carreg5 + #1146, #3967
  static carreg5 + #1147, #3967
  static carreg5 + #1148, #3967
  static carreg5 + #1149, #3967
  static carreg5 + #1150, #3967
  static carreg5 + #1151, #3967
  static carreg5 + #1152, #3967
  static carreg5 + #1153, #3967
  static carreg5 + #1154, #3967
  static carreg5 + #1155, #3967
  static carreg5 + #1156, #3967
  static carreg5 + #1157, #3967
  static carreg5 + #1158, #3967
  static carreg5 + #1159, #3967

  ;Linha 29
  static carreg5 + #1160, #3967
  static carreg5 + #1161, #3967
  static carreg5 + #1162, #3967
  static carreg5 + #1163, #3967
  static carreg5 + #1164, #3967
  static carreg5 + #1165, #3967
  static carreg5 + #1166, #3967
  static carreg5 + #1167, #3967
  static carreg5 + #1168, #3967
  static carreg5 + #1169, #3967
  static carreg5 + #1170, #3967
  static carreg5 + #1171, #3967
  static carreg5 + #1172, #3967
  static carreg5 + #1173, #3967
  static carreg5 + #1174, #3967
  static carreg5 + #1175, #3967
  static carreg5 + #1176, #3967
  static carreg5 + #1177, #3967
  static carreg5 + #1178, #3967
  static carreg5 + #1179, #3967
  static carreg5 + #1180, #3967
  static carreg5 + #1181, #3967
  static carreg5 + #1182, #3967
  static carreg5 + #1183, #3967
  static carreg5 + #1184, #3967
  static carreg5 + #1185, #3967
  static carreg5 + #1186, #3967
  static carreg5 + #1187, #3967
  static carreg5 + #1188, #3967
  static carreg5 + #1189, #3967
  static carreg5 + #1190, #3967
  static carreg5 + #1191, #3967
  static carreg5 + #1192, #3967
  static carreg5 + #1193, #3967
  static carreg5 + #1194, #3967
  static carreg5 + #1195, #3967
  static carreg5 + #1196, #1070
  static carreg5 + #1197, #3967
  static carreg5 + #1198, #3967
  static carreg5 + #1199, #3967
