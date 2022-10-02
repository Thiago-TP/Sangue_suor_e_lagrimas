.data
perdeu:		.string "Voce perdeu ! :("
denovo:		.string "Tentar de novo?"
sim:		.string "sim"
nao:		.string "nao"
cores:		.word	0x0000c7ff, 0x0000c7cc
animTime12:	.word	0x00000000
animTime23:	.word	0x00000000
animTime31:	.word	0x00000000

.text
#	s0 = 0 se sim esta selecionado
#	s1 = 0, 1 ou 2 eh o estado da animacao
#	s2 = frame
Derrota:
	addi	sp, sp, -4
	sw	ra, 0(sp)
	
	li	t0, 0xFF200604
	sw	zero, 0(t0)	# fixa o frame em 0
	
	#call	TelaPreta	# fundo preto
	li	a0, 0
	li	a1, 0
	li	a2, 0
	li	a3, 320
	li	a4, 240
	call	CobreTela
	li	a0, 1
	call	CobreTela
	
	la	a0, perdeu
	li	a1, 120
	li	a2, 80
	li	a3, 0x0000c7ff
	li	a4, 0
	call	printString	# imprime "Voce perdeu" (frame 0)
	la	a0, perdeu
	li	a1, 120
	li	a2, 80
	li	a3, 0x0000c7ff
	li	a4, 1
	call	printString	# imprime "Voce perdeu" (frame 1)
	la	a0, denovo
	li	a1, 130
	li	a2, 100
	li	a3, 0x0000c7ff
	li	a4, 0
	call	printString	# imprime "Jogar de novo?"
	la	a0, denovo
	li	a1, 130
	li	a2, 100
	li	a3, 0x0000c7ff
	li	a4, 1
	call	printString	# imprime "Jogar de novo?"
	mv	s0, zero	# "sim" selecionado
	mv	s1, zero	# estado 0 da animacao
	mv	s2, zero	# frame
SetupDerrota:	
   	call	MovimentaCursorDerrota
   	call	ImprimeOpcoes
   	call	AnimaInimigos
   	call	ImprimeBrigand
	
	j	SetupDerrota	
	
	lw	ra, 0(sp)
	addi	sp, sp, 4
	ret
#################################

ImprimeBrigand:
	addi	sp, sp, -4
	sw	ra, 0(sp)

	beqz	s1, sprite1Brigand
	li	t0, 1
	beq	s1, t0,	sprite2Brigand
	la	a0, Brigand1StandBy
fimImprimeBrigand:
	mv	t6, a0
	mv	a0, s2
	li	a1, 10
	li	a2, 200
	li	a3, 20
	li	a4, 20
	call	CobreTela		# call limpa a sprite no proximo frame
	
	mv	a0, t6
	li	a1, 10
	li	a2, 200
	mv	a3, s2
	li	a4, 0
	call	PrintByte
	li	t0, 0xFF200604
	sw	s2, 0(t0)		# muda o frame exibido
	
	xori	a0, s2, 1
	li	a1, 10
	li	a2, 200
	li	a3, 20
	li	a4, 20
	call	CobreTela		# call limpa a sprite no frame anterior
	
	lw	ra, 0(sp)
	addi	sp, sp, 4
	ret
sprite1Brigand:
	la	a0, Brigand2StandBy
	j	fimImprimeBrigand
sprite2Brigand:
	la	a0, Brigand3StandBy
	j	fimImprimeBrigand
##################################

AnimaInimigos:
	li	t0, 3
	rem	s1, s1, t0	# s1 <- estado das sprites
	li	t0, 1
	beq	s1, t0, estado2

	la	t0, animTime12
	lw	t1, 0(t0)
	csrr	t2, time
	sub	t3, t2, t1
	li	t1, 350
	bgeu	t3, t1, mudaEstado
fimAnimaInimigos:
	xori	s2, s2, 1	# troca o frame
	ret
	
mudaEstado:
	la	t0, animTime12
	sw	t2, 0(t0)
	la	t0, animTime23
	sw	t2, 0(t0)
	addi	s1, s1, 1
	j	fimAnimaInimigos
estado2:
	la	t0, animTime23
	lw	t1, 0(t0)
	csrr	t2, time
	sub	t3, t2, t1
	li	t1, 50
	bgeu	t3, t1, mudaEstado
	j	fimAnimaInimigos
	
#################################



#################################################
#	esta cria um retangulo no frame 0 com	#
#	os pixeis pretos, cobrindo a area	#
#################################################
#	- Inputs -	#
#	a0 = frame	#
#	a1 = pos em x	#
#	a2 - pos em y	#
#	a3 = largura	#
#	a4 = altura	#
#########################
CobreTela:		
	add 	t0, x0, a1 	# adiciona x ao t0
	li 	t1, 320 	# t1 = 320
	mul 	t1, t1, a2 	# multiplica y por t1
	add 	t0, t0, t1 	# coloca o valor final do calculo do endereço em t0
	li	t1, 0xFF000000
	beqz	a0, frame0
	li	t1, 0xFF100000
frame0:
	add 	t0, t1, t0
	mv 	t1, zero 	# zera t2
	mv 	t2, zero 	# zera t3
	mv 	t3, a3 		# carrega a largura em t3
	mv 	t4, a4 		# carrega a altura em t4
	# ate aqui estamos no primeiro endereco da imagem e no endereço que escolhemos no bitmap
CobreLinhaDerrota:		
	sb 	x0, 0(t0) 		# imprime no bitmap a word (4 pixeis) da imagem
	addi 	t0, t0, 1 		# incrementa endereco do bitmap
	addi 	t2, t2, 1 		# incrementa contador de coluna
	blt 	t2, t3, CobreLinhaDerrota	# se contador da coluna < largura,  continue imprimindo
	addi	t0, t0, 320 		# t0 += 320
	sub 	t0, t0, t3 		# t0 -= largura da imagem
	# ^ isso serve pra "pular" de linha no bitmap display
	mv 	t2, zero 		# zera t2 (contador de coluna)
	addi 	t1, t1, 1 		# incrementa contador de linha
	bgt 	t4, t1, CobreLinhaDerrota # se altura > contador de linha, continue imprimindo
	ret
#################################



ImprimeOpcoes:	
	addi	sp, sp, -8
	sw	ra, 0(sp)
	sw	s1, 4(sp)
	
	la	t1, cores
	lw	a3, 0(t1)	# a3 <- cor branca
	lw	s1, 4(t1)	# t2 <- outra cor
	beqz	s0, pulaDireita	# nao foi para a direita ?
	lw	a3, 4(t1)	# a3 <- outra cor
	lw	s1, 0(t1)	# t2 <- cor branca
pulaDireita:
	la	a0, sim
	li	a1, 130
	li	a2, 190
	li	a4, 0
	call	printString	# imprime sim numa cor
	la	a0, sim
	li	a1, 130
	li	a2, 190
	li	a4, 1
	call	printString	# imprime sim numa cor
	
	
	la	a0, nao
	mv	a3, s1
	li	a1, 190
	li	a2, 190
	li	a4, 0
	call	printString	# imprime sim numa cor
	la	a0, nao
	li	a1, 190
	li	a2, 190
	li	a4, 1
	call	printString	# imprime sim numa cor
	
	lw	ra, 0(sp)
	lw	s1, 4(sp)
	addi	sp, sp, 8
	ret	
			
				
					
#################################
MovimentaCursorDerrota:	
	li 	t0, 0xFF200000		# carrega o endere�o de controle do KDMMIO
   	lw 	t1, 4(t0)		# le o valor da tecla
   	
   	li	t0, 'd'
   	beq	t1, t0, opcaoDireitaDerrota						
	li	t0, 'a'
   	beq	t1, t0, opcaoEsquerdaDerrota
   	li	t0, '\n'
   	beq	t1, t0, DecideMudancaDerrota
fimMovimentaDerrota:
	ret
	
opcaoDireitaDerrota:							
	li	s0, 1
	j	fimMovimentaDerrota	
opcaoEsquerdaDerrota:							
	li	s0, 0
	j	fimMovimentaDerrota
		
DecideMudancaDerrota:
	beqz	s0, jogaDenovo
	li	a7, 10
	ecall
jogaDenovo:
	j	Fase1				
									
										
											
													