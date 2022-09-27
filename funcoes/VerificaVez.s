#################################################################
#	esta funcao verifica se a vez do jogador acabou		#
#################################################################
#	- Inputs -	#
#	nenhum		#
#########################
#	- Outputs -	#
#	0 ou 1 em Vez	#
#########################################
#	- Internas -			#
#	t0 = label do personagem	#
#	t1 - 5 (estado cinza)		#
#	t2 = estado do personagem	#
#	t3 = Fase			#
#########################################

VerificaVez:
	li	t1, 5
	la	t4, Fase
	lb	t4, 0(t4)
	# verifica estado e HP de cada personagem dos personagens jogaveis
	# Lyn
	la	t0, Lyn
	lw	t2, 16(t0)		
	bne	t2, t1, fimVerificaVez	# estado = cinza ? fim : continua check
	li	t0, 1
	beq	t0, t4, VezMuda		# Fase = 1 ? fim : continua check
	
	# Yogi
	la	t0, Yogi
	lw	t2, 16(t0)		
	bne	t2, t1, fimVerificaVez	# estado = cinza ? fim : continua check
	li	t0, 2
	beq	t0, t4, VezMuda		# Fase = 2 ? fim : continua check
	
	# Dorcas
	la	t0, Dorcas
	lw	t2, 16(t0)		
	bne	t2, t1, fimVerificaVez	# estado = cinza ? fim : continua check
	li	t0, 3
	beq	t0, t4, VezMuda		# Fase = 3 ? fim : continua check
	
	# Dart
	la	t0, Dart
	lw	t2, 16(t0)		
	bne	t2, t1, fimVerificaVez	# estado = cinza ? fim : continua check
	li	t0, 4
	beq	t0, t4, VezMuda		# Fase = 4 ? fim : continua check
	
	# Sain
	la	t0, Sain
	lw	t2, 16(t0)		
	bne	t2, t1, fimVerificaVez	# estado = cinza ? fim : continua check
VezMuda:	
	la	t0, Vez
	li	t1, 1
	sb	t1, 0(t0)		# Vez = 1 => vez do PC
fimVerificaVez:
	ret	