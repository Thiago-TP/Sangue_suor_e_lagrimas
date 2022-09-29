MovimentaMenu:
	addi	sp, sp, -4			# aloco espaco de memoria
	sw	ra, 0(sp)			# salvo o ponteiro de retorno
	li 	t1, 0xFF200000			# carrega o endereco de controle do KDMMIO
	lw 	t0, 0(t1)			# le bit de Controle Teclado
	andi 	t0, t0, 0x0001			# mascara o bit menos significativo
   	beq 	t0, zero, FimMovimentaMenu   	# se nao ha tecla pressionada entao vai para FIM
  	lw 	t2, 4(t1)			# carrego o valor da tecla em t2 (o valor da tecla fica guardado no endereco do teclado+4)
  	li	t0, '\n'			# carrego o valor do caracter '\n' para fazer a comparacao abaixo
  	beq 	t2, t0, CHAR_ENTER.Menu		# se t2 for igual a t0 pula para Char_Enter
 	li 	t0, 'w'				# carrego o valor do caracter 'w' para fazer a comparacao abaixo
	beq 	t2, t0, CHAR_CIMA.Menu		# se tecla pressionada for 'w',  chama CHAR_CIMA
	li 	t0, 's'				# carrego o valor do caracter 's' para fazer a comparacao abaixo
	beq 	t2, t0, CHAR_BAIXO.Menu		# se tecla pressionada for 's',  chama CHAR_CIMA
FimMovimentaMenu:	
	lw	ra, 0(sp)			# recupero o ponteiro de retorno da pilha
	addi	sp, sp, 4			# desaloca a memoria da pilha
	ret					# retorno para a funcao chamadora
CHAR_ENTER.Menu:
		la	t0, MenuBatalha
	lb	t1, 0(t0)
	beqz	t1, PulaDecideAcao
	la	t0, MenuBatalha
	sb	zero, 0(t0)
	li	t1, 255
	sb	t1, 1(t0)
	li	a1, 0
	li	a2, 0
	li	a4, 6
	li	a5, 6
	call	ClearScreen
	la	t0, MenuAtivado
	sb	zero, 0(t0)
	la	a0, seletor_verm
	lw	a1,0(s7)
	lw	a2,4(s7)
	addi	a1,a1,16
	li	t0,320
	bgeu	a1,t0,PulaPrintAreaAtk1
	li	a3, 1 						
	call 	PrintByte					
	li	a3, 0						
	call 	PrintByte
PulaPrintAreaAtk1:
	addi	a1,a1,-32
	li	t0,320
	bgeu	a1,t0,PulaPrintAreaAtk2
	li	a3, 1 						
	call 	PrintByte					
	li	a3, 0						
	call 	PrintByte
PulaPrintAreaAtk2:
	addi	a1,a1,16
	addi	a2,a2,16
	li	t0,240
	bgeu	a2,t0,PulaPrintAreaAtk3
	li	a3, 1 						
	call 	PrintByte					
	li	a3, 0						
	call 	PrintByte
PulaPrintAreaAtk3:
	addi	a2,a2,-32
	li	t0,240
	bgeu	a2,t0,PulaPrintAreaAtk4
	li	a3, 1 						
	call 	PrintByte					
	li	a3, 0						
	call 	PrintByte
PulaPrintAreaAtk4:
	la	t0, AtaqueAtivado
	li	t1, 1
	sb	t1, 0(t0)
	j	FimMovimentaMenu
PulaDecideAcao:
	li	t0, 5
	sw	t0, 16(s7)
	li	a1, 0
	li	a2, 0
	li	a4, 6
	li	a5, 6
	call	ClearScreen
	la	t0, MenuAtivado
	sb	zero, 0(t0)
	j	FimMovimentaMenu
CHAR_CIMA.Menu:
	li	t0,2
	bne	s10,t0,FimMovimentaMenu
	la 	t0, MenuBatalha
	li	t1,255
	sb	t1,0(t0)
	sb	zero,1(t0)		
	j	FimMovimentaMenu
CHAR_BAIXO.Menu:
	li	t0,2
	bne	s10,t0,FimMovimentaMenu	
	la	t0, MenuBatalha
	li	t1,255
	sb	zero,0(t0)
	sb	t1,1(t0)
	j	FimMovimentaMenu
