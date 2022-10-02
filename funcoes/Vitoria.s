#	s0 = 0 se sim esta selecionado
#	s1 = 0, 1 ou 2 eh o estado da animacao
#	s2 = frame
Vitoria:
	addi	sp, sp, -4
	sw	ra, 0(sp)
	
	li	t0, 0xFF200604
	sw	zero, 0(t0)		# fixa o frame em 0
	
	la	t0, MenuAtivado
	li	t1, 1
	sb	t1, 0(t0)		# para evitar o barulho da impressao
	
	li	a0, 0
	li	a1, 0
	li	a2, 0
	li	a3, 320
	li	a4, 240
	call	CobreTela
	li	a0, 1
	call	CobreTela		# fundo  preto em ambos os frames
	
	la	a0, ganhou
	li	a1, 96
	li	a2, 40
	li	a3, 0x0000c7ff
	li	a4, 0
	call	printString		# imprime "Voce ganhou" (frame 0)
	la	a0, ganhou
	li	a1, 96
	li	a2, 40
	li	a3, 0x0000c7ff
	li	a4, 1
	call	printString		# imprime "Voce ganhou" (frame 1)
	la	a0, denovo
	li	a1, 100
	li	a2, 60
	li	a3, 0x0000c7ff
	li	a4, 0
	call	printString		# imprime "Jogar de novo?"
	la	a0, denovo
	li	a1, 100
	li	a2, 60
	li	a3, 0x0000c7ff
	li	a4, 1
	call	printString		# imprime "Jogar de novo?"
	mv	s0, zero		# "sim" selecionado
	mv	s1, zero		# estado 0 da animacao
	mv	s2, zero		# frame
SetupVitoria:	
   	call	MovimentaCursor2	# decide se quer jogar de novo ou nao
   	call	ImprimeOpcoes
   	call	AtualizaEstados		# estado e frame mudam		
   	call	ImprimeLyn		# sprites sao impressas no novo frame
   	call	ImprimeYogi
   	call	ImprimeDorcas
   	call	ImprimeDart
   	call	ImprimeSain
   	
   	li	t0, 0xFF200604
	sw	s2, 0(t0)		# muda o frame exibido
	
	j	SetupVitoria	
	
	lw	ra, 0(sp)
	addi	sp, sp, 4
	ret
#################################																		
												