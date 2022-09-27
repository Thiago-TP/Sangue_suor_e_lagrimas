#################################################################
#	esta funcao verifica se o jogador perdeu o jogo,	#
#	i. e., todos os personagens morreram			#
#################################################################
#	- Inputs -	#
#	nenhum		#
#################################
#	- Outputs -		#
#	0 ou 1 em GameOver	#
#########################################
#	- Internas -			#
#	t0 = label do personagem	#
#	t1 - hp do personagem		#
#	t2 = Fase			#
#########################################
VerificaGameOver:
	la	t2, Fase
	lb	t2, 0(t2)
	# verifica estado e HP de cada personagem dos personagens jogaveis
	# Lyn
	la	t0, Lyn
	lb	t1, 20(t0)		
	bnez	t1, fimVerificaGame	# hp =/= 0 ? fim : continua check
	li	t0, 1
	beq	t0, t2, Perdeu		# Fase = 1 ? fim : continua check
	
	# Yogi
	la	t0, Yogi
	lb	t1, 20(t0)		
	bnez	t1, fimVerificaGame	# hp =/= 0 ? fim : continua check
	li	t0, 2
	beq	t0, t2, Perdeu		# Fase = 2 ? fim : continua check
	
	# Dorcas
	la	t0, Dorcas
	lb	t1, 20(t0)		
	bnez	t1, fimVerificaGame	# hp =/= 0 ? fim : continua check
	li	t0, 3
	beq	t0, t2, Perdeu		# Fase = 3 ? fim : continua check
	
	# Dart
	la	t0, Dart
	lb	t1, 20(t0)		
	bnez	t1, fimVerificaGame	# hp =/= 0 ? fim : continua check
	li	t0, 4
	beq	t0, t2, Perdeu		# Fase = 4 ? fim : continua check
	
	# Sain
	la	t0, Sain
	lb	t1, 20(t0)		
	bnez	t1, fimVerificaGame	# hp =/= 0 ? fim : continua check
Perdeu:	
	la	t0, GameOver
	li	t1, 1
	sb	t1, 0(t0)		# Vez = 1 => vez do PC
fimVerificaGame:
	ret