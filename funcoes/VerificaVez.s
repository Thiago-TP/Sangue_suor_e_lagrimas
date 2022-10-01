#################################################################
#	esta funcao verifica se a vez do jogador e da maquina	#
#	acabaram						#
#################################################################
#	- Inputs -	#
#	nenhum		#
#########################
#	- Outputs -	#
#	0 ou 1 em Vez	#
#########################

# >:) você que lute com as mudanças >:D #

VerificaVez:
	addi	sp, sp, -4 	# aloca espaco na pilha
	sw	ra, 0(sp) 	# salva o ponteiro de retorno
	li	t5, 5
	mv	t6, zero
LoopVerificaCinzaAliado:
	mv	a7, t6
	call	EscolhePersonagem # retorna em a1
	lb	t4, 16(a1)
	bne	t4, t5, fimVerificaAliado
	addi	t6, t6, 2
	blt	t6, s4, LoopVerificaCinzaAliado
	li	t1,1
	j	VezMuda
fimVerificaAliado:
	li	t6, 1
LoopVerificaCinzaInimigo:
	mv	a7,t6
	call	EscolhePersonagem # retorna em a1
	lb	t4, 16(a1)
	bne	t4,t5,fimVerificaVez
	addi	t6, t6, 2
	blt	t6,s4,LoopVerificaCinzaInimigo
	li	t1,0
VezMuda:
	bnez	t1,PulaResetaAliado
	mv	t6, zero
LoopResetaCinzaAliado:
	mv	a7, t6
	call	EscolhePersonagem # retorna em a1
	li	t4, 0
	sb	t4, 16(a1)
	addi	t6, t6, 2
	blt	t6, s4, LoopResetaCinzaAliado
	j	FimResetaCinza
PulaResetaAliado:
	li	t6, 1
LoopResetaCinzaInimigo:
	mv	a7, t6
	call	EscolhePersonagem # retorna em a1
	li	t4, 0
	sb	t4, 16(a1)
	addi	t6, t6, 2
	blt	t6, s4, LoopResetaCinzaInimigo
FimResetaCinza:	
	la	t0, Vez
	sb	t1, 0(t0)		# Vez = 1 => vez do PC
fimVerificaVez:
	lw	ra, 0(sp) 		# carrega o valor de ra de sp
	addi	sp, sp, 4 		# desaloca a memoria da pilha
	ret 				# volta para quem chamou a funcao
