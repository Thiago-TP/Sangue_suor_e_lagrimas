#################################################################
#	esta funcao verifica se o jogador ganhou a fase,	#
#	i. e., todos os personagens inimigos morreram		#
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
#################################################################
#	esta funcao verifica se o jogador ganhou a fase,	#
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
VerificaWin:
	la	t2, Fase
	lb	t2, 0(t2)
	# verifica estado e HP de cada personagem dos personagens jogaveis
	# Brigand
	la	t0, Brigand
	lb	t1, 20(t0)		
	bnez	t1, fimVerificaWin	# hp =/= 0 ? fim : continua check
	li	t0, 1
	beq	t0, t2, Ganhou		# Fase = 1 ? fim : continua check
	
	# Soldier
	la	t0, Soldier
	lb	t1, 20(t0)		
	bnez	t1, fimVerificaWin	# hp =/= 0 ? fim : continua check
	li	t0, 2
	beq	t0, t2, Ganhou		# Fase = 2 ? fim : continua check
	
	# Assassin
	la	t0, Assassin
	lb	t1, 20(t0)		
	bnez	t1, fimVerificaWin	# hp =/= 0 ? fim : continua check
	li	t0, 3
	beq	t0, t2, Ganhou		# Fase = 3 ? fim : continua check
	
	# Brigand2
	la	t0, Brigand2
	lb	t1, 20(t0)		
	bnez	t1, fimVerificaWin	# hp =/= 0 ? fim : continua check
	li	t0, 4
	beq	t0, t2, Ganhou		# Fase = 4 ? fim : continua check
	
	# Soldier2
	la	t0, Soldier2
	lb	t1, 20(t0)		
	bnez	t1, fimVerificaWin	# hp =/= 0 ? fim : continua check
Ganhou:	
	la	t0, Win
	li	t1, 1
	sb	t1, 0(t0)		# Win = 1 => ganhou a fase
fimVerificaWin:
	ret			# volta para quem chamou a funcao
