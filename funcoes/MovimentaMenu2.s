MovimentaMenu2:
	addi	sp, sp, -4			# aloco espaco de memoria
	sw	ra, 0(sp)			# salvo o ponteiro de retorno
	li 	t1, 0xFF200000			# carrega o endereco de controle do KDMMIO
	lw 	t0, 0(t1)			# le bit de Controle Teclado
	andi 	t0, t0, 0x0001			# mascara o bit menos significativo
   	beq 	t0, zero, FimMovimentaMenu2   	# se nao ha tecla pressionada entao vai para FIM
  	lw 	t2, 4(t1)			# carrego o valor da tecla em t2 (o valor da tecla fica guardado no endereco do teclado+4)
  	li	t0, '\n'			# carrego o valor do caracter '\n' para fazer a comparacao abaixo
  	beq 	t2, t0, CHAR_ENTER2		# se t2 for igual a t0 pula para Char_Enter
	li	t0, 'p'				# carrego o valor do caracter '\n' para fazer a comparacao abaixo
  	beq 	t2, t0, FECHA_MENU		# se t2 for igual a t0 pula para Char_Enter
	li	t0, 'w'				# carrego o valor do caracter '\n' para fazer a comparacao abaixo
  	beq 	t2, t0, MovimentaPraCima	# se t2 for igual a t0 pula para Char_Enter
	li 	t0, 's'				# carrego o valor do caracter 'd' para fazer a comparacao abaixo
	beq 	t2, t0, MovimentaPraBaixo	# se tecla pressionada for '1',  inicia a fase 1 
FimMovimentaMenu2:	
	lw	ra, 0(sp)			# recupero o ponteiro de retorno da pilha
	addi	sp, sp, 4			# desaloca a memoria da pilha
	ret					# retorno para a funcao chamadora
CHAR_ENTER2:
	la	t0, MenuPause
	li 	t2, 255	
	lbu	t1, 1(t0)
	beq 	t2, t1, PulaParaFase1			# se tecla pressionada for '2',  inicia a fase 2 
	lbu	t1, 2(t0)
	beq 	t2, t1, PulaParaFase2			# se tecla pressionada for '2',  inicia a fase 2 
	lbu	t1, 3(t0)
	beq 	t2, t1, PulaParaFase3			# se tecla pressionada for '3',  inicia a fase 3 
	lbu	t1, 4(t0)
	beq 	t2, t1, PulaParaFase4			# se tecla pressionada for '4',  inicia a fase 4 
	lbu	t1, 5(t0)
	beq 	t2, t1, PulaParaFase5			# se tecla pressionada for '5',  inicia a fase 5
	la	t0,GameOver
	li	t2, 1
	sb	t2, 0(t0)
	j	FimMovimentaMenu2
FECHA_MENU:
	li	a1, 7
	li	a2, 5
	li	a4, 13
	li	a5, 12
	call	ClearScreen
	la	t1, MenuAtivado2
	li	t0, 0
	sb	t0, 0(t1)
	j	FimMovimentaMenu2
	
MovimentaPraCima:
	la	t0, MenuPause
	lb	t1, 6(t0)
	beqz	t1, PulaMovimentoMenu1
	li	t2,255
	li	t3,1
	bne	t1,t3,PulaOpcaoMenu1
	sb	t2, 0(t0)
	sb	zero, 1(t0)
PulaOpcaoMenu1:
	li	t3,2
	bne	t1,t3,PulaOpcaoMenu2
	sb	t2, 1(t0)
	sb	zero, 2(t0)
PulaOpcaoMenu2:
	li	t3,3
	bne	t1,t3,PulaOpcaoMenu3
	sb	t2, 2(t0)
	sb	zero, 3(t0)
PulaOpcaoMenu3:
	li	t3,4
	bne	t1,t3,PulaOpcaoMenu4
	sb	t2, 3(t0)
	sb	zero, 4(t0)
PulaOpcaoMenu4:
	li	t3,5
	bne	t1,t3,PulaOpcaoMenu5
	sb	t2, 4(t0)
	sb	zero, 5(t0)
PulaOpcaoMenu5:
	addi	t1,t1,-1
	sb	t1, 6(t0)
PulaMovimentoMenu1:
	j	FimMovimentaMenu2
	
MovimentaPraBaixo:
	la	t0, MenuPause
	lb	t1, 6(t0)
	li	t2,5
	beq	t1,t2, PulaMovimentoMenu2
	li	t2,255
	bnez	t1,PulaOpcaoMenu6
	sb	zero, 0(t0)
	sb	t2, 1(t0)
PulaOpcaoMenu6:
	li	t3,1
	bne	t1,t3,PulaOpcaoMenu7
	sb	zero, 1(t0)
	sb	t2, 2(t0)
PulaOpcaoMenu7:
	li	t3,2
	bne	t1,t3,PulaOpcaoMenu8
	sb	zero, 2(t0)
	sb	t2, 3(t0)
PulaOpcaoMenu8:
	li	t3,3
	bne	t1,t3,PulaOpcaoMenu9
	sb	zero, 3(t0)
	sb	t2, 4(t0)
PulaOpcaoMenu9:
	li	t3,4
	bne	t1,t3,PulaOpcaoMenu10
	sb	zero, 4(t0)
	sb	t2, 5(t0)
PulaOpcaoMenu10:
	addi	t1,t1,1
	sb	t1, 6(t0)
PulaMovimentoMenu2:
	j	FimMovimentaMenu2				

PulaParaFase1:	
	li	t0,1
	la	t1,GuardaHack
	sb	t0,0(t1)
	j	FECHA_MENU
PulaParaFase2:	
	li	t0,2
	la	t1,GuardaHack
	sb	t0,0(t1)
	j	FECHA_MENU
PulaParaFase3:	
	li 	t0,3
	la	t1,GuardaHack
	sb	t0,0(t1)
	j	FECHA_MENU
PulaParaFase4:	
	li	t0,4
	la	t1,GuardaHack
	sb	t0,0(t1)
	j	FECHA_MENU
PulaParaFase5:	
	li	t0,5
	la	t1,GuardaHack
	sb	t0,0(t1)
	j	FECHA_MENU
