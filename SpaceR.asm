jmp Menu


;********************************************************
;               DECLARAÇÃO DAS VARIAVEIS
;********************************************************



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

Letra: var #1			; Contem a letra que foi digitada

Kills: var #1			; Contador de kills
Cont_Deaths: var #1		; Contador de aliens mortos em uma horda
auxKills: var #1
auxDigito: var #1

Bullets: var #1			; Munições
addBullets: var #1
auxBullets: var #1
auxDigitoBullets: var #1


; velocidade dos Aliens
velAlien1: var #1		
velAlien2: var #1
velAlien3: var #1
velAlien4: var #1

Horda: var #1			; contador de hordas
auxHorda: var #1
auxDigitoHorda: var #1


dirNave: var #1			; 0 = cima | 1 = direita | 2 = baixo | 3 = esquerda
dirTiro1: var #1     	; 0 = vertical   |  1 = horizontal
dirTiro2: var #1
dirTiro3: var #1
dirTiro_Recalculapos: var #1
dirTiro2_Recalculapos: var #1
dirTiro3_Recalculapos: var #1

posNave: var #1			
posAntNave: var #1		
posNave2: var #1
posAntNave2: var #1

Alien1Dead: var #1			; Flag pra saber se o Alien está morto
desAlien1: var #1			; Flag pra saber se o Alien desviou do tiro (Se desviou, então ele precisa voltar)
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



posTiro: var #1			
posAntTiro: var #1		
posTiro2: var #1			
posAntTiro2: var #1		
posTiro3: var #1      
posAntTiro3: var #1   

; Flags dos tiros para saber se atirou
FlagTiro: var #1		
FlagTiro2: var #1
FlagTiro3: var #1

;--------------------------------------------------------------------------


;********************************************************
;                   MENU PRINCIPAL
;********************************************************

Menu:
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
	
	Menu_Loop:	
		call DigLetra
		loadn r0, #'1'
		load r1, Letra
		cmp r0, r1			
		jeq SinglePlayer	
		
		loadn r0, #'2'
		cmp r0, r1				
		jeq MultiPlayer	
		
		loadn r0, #'0'
		cmp r0, r1
		jne Menu_Loop
	
	call ApagaTela
	halt
	