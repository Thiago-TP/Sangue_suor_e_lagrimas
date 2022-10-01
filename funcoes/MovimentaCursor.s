#################################################
#	nao recebe nada como argumento	 	#
#################################################
MovimentaCursor:
	addi	sp, sp, -4			# aloco espaco de memoria
	sw	ra, 0(sp)			# salvo o ponteiro de retorno
	li 	t1, 0xFF200000			# carrega o endereco de controle do KDMMIO
	lw 	t0, 0(t1)			# le bit de Controle Teclado
	andi 	t0, t0, 0x0001			# mascara o bit menos significativo
   	beq 	t0, zero, FimMovimentaCursor   	# se nao ha tecla pressionada entao vai para FIM
  	lw 	t2, 4(t1)			# carrego o valor da tecla em t2 (o valor da tecla fica guardado no endereco do teclado+4)
  	li	t0, '\n'			# carrego o valor do caracter '\n' para fazer a comparacao abaixo
  	beq 	t2, t0, CHAR_ENTER		# se t2 for igual a t0 pula para Char_Enter
 	li 	t0, 'w'				# carrego o valor do caracter 'w' para fazer a comparacao abaixo
	beq 	t2, t0, CHAR_CIMA		# se tecla pressionada for 'w',  chama CHAR_CIMA
	li 	t0, 'a'				# carrego o valor do caracter 'a' para fazer a comparacao abaixo
	beq 	t2, t0, CHAR_ESQ		# se tecla pressionada for 'a',  chama CHAR_CIMA
	li 	t0, 's'				# carrego o valor do caracter 's' para fazer a comparacao abaixo
	beq 	t2, t0, CHAR_BAIXO		# se tecla pressionada for 's',  chama CHAR_CIMA
	li 	t0, 'd'				# carrego o valor do caracter 'd' para fazer a comparacao abaixo
	beq 	t2, t0, CHAR_DIR		# se tecla pressionada for 'd',  chama CHAR_CIMA 
	li 	t0, '1'				# carrego o valor do caracter 'd' para fazer a comparacao abaixo
	beq 	t2, t0, FASE1			# se tecla pressionada for '1',  inicia a fase 1 
	li 	t0, '2'				# carrego o valor do caracter 'd' para fazer a comparacao abaixo
	beq 	t2, t0, FASE2			# se tecla pressionada for '2',  inicia a fase 2 
	li 	t0, '3'				# carrego o valor do caracter 'd' para fazer a comparacao abaixo
	beq 	t2, t0, FASE3			# se tecla pressionada for '3',  inicia a fase 3 
	li 	t0, '4'				# carrego o valor do caracter 'd' para fazer a comparacao abaixo
	beq 	t2, t0, FASE4			# se tecla pressionada for '4',  inicia a fase 4 
	li 	t0, '5'				# carrego o valor do caracter 'd' para fazer a comparacao abaixo
	beq 	t2, t0, FASE5			# se tecla pressionada for '5',  inicia a fase 5 
FimMovimentaCursor:	
	lw	ra, 0(sp)			# recupero o ponteiro de retorno da pilha
	addi	sp, sp, 4			# desaloca a memoria da pilha
	ret					# retorno para a funcao chamadora
CHAR_ENTER:
	la	a0, PosicaoAtualCursor
	la	t0, AtaqueAtivado
	lb	t1, 0(t0)
	beqz	t1, PulaDecideAtaque
	lw	t4, 0(a0)
	lw	t5, 4(a0)
	li	t6, 1					
LoopVerificaInimigo.MoviCursor:
	mv	a7, t6
	call 	EscolhePersonagem # retorna em a1
	li	t1, 6
	lw	t0, 16(a1)
	bge	t0, t1, PulaVerificaInimigo.MoviCursor
	lw	t0, 0(a1)
	lw	t1, 4(a1)
	bne	t0, t4, PulaVerificaInimigo.MoviCursor
	bne	t1, t5, PulaVerificaInimigo.MoviCursor
	addi	t4, t4, 2
	addi	t5, t5, 2
	li 	t0, 0xFF200604 		# carrega em t0 o endereco de troca de frame
	lw 	t1, 0(t0) 		# troca de frame
	xori	t1, t1, 1
	li 	t0, 0xFF0 # carrega 0xFF0 em t0
	add 	t0, t0, t1 # adiciona o frame ao FF0 (se o frame for 1 vira FF1, se for 0 fica FF0)
	slli 	t0, t0, 20 # shift de 20 bits pra esquerda (0xFF0 vira 0xFF000000, 0xFF1 vira 0xFF100000)
	add 	t0, t0, t4 # adiciona x ao t0
	li 	t1, 320 # t1 = 320
	mul 	t1, t1, t5 # multiplica y por t1
	add 	t0, t0, t1 # coloca o valor final do calculo do endereço em t0
	lb	t1, 0(t0)
	li	t3, 20
	bne	t1, t3,FimMovimentaCursor
	la	t0, AtaqueAtivado
	sb	zero, 0(t0)
	li	t0, 5
	sb	t0, 16(s7)
	mv	a0, s7
	call	Luta
	j	FimMovimentaCursor
PulaVerificaInimigo.MoviCursor:
	addi	t6, t6, 2
	ble	t6, s4, LoopVerificaInimigo.MoviCursor
	j	FimMovimentaCursor
PulaDecideAtaque:
	call	DecideMudanca
	j	FimMovimentaCursor
CHAR_ESQ:
	la 	t0, PosicaoAtualCursor
	lw 	t1, 0(t0) 			# carrega o x atual do personagem
	addi 	t1, t1, -16 			# move 16 pixeis para a esquerda
	li	t4, 320
	bgeu 	t1, t4, FimMovimentaCursor
	sw 	t1, 0(t0)			# atualiza posicao x do cursor	
	j	FimMovimentaCursor
CHAR_DIR:
	la 	t0, PosicaoAtualCursor
	lw 	t1, 0(t0) 			# carrega o x atual do personagem
	addi 	t1, t1, 16 			# move 16 pixeis para a direita
	li	t4, 320
	bgeu 	t1, t4, FimMovimentaCursor
	sw 	t1, 0(t0)		
	j	FimMovimentaCursor
CHAR_CIMA:
	la 	t0, PosicaoAtualCursor
	lw 	t1, 4(t0) 			# carrega o y atual do personagem
	addi 	t1, t1, -16 			# move 16 pixeis para a cima
	li	t4, 240
	bgeu 	t1, t4, FimMovimentaCursor
	sw 	t1, 4(t0)			# atualiza posicao y do cursor
	j	FimMovimentaCursor
CHAR_BAIXO:	
	la 	t0, PosicaoAtualCursor
	lw 	t1, 4(t0) 			# carrega o y atual do personagem
	addi	t1, t1, 16 			# move 16 pixeis para a baixo
	li	t4, 240
	bgeu 	t1, t4, FimMovimentaCursor
	sw 	t1, 4(t0)			# atualiza posicao x do cursor	
	j	FimMovimentaCursor

FASE1:	j	Fase1
FASE2:	j	Fase2
FASE3:	j	Fase3
FASE4:	j	Fase4
FASE5:	j	Fase5
