#################################################
#	Argumentos:				#
#	a7 = o valor do contador para escolher	#
#	todos os personagens			#
#################################################
#	Retorna:				#
#	a1 = o endereco da posicao daquele	#
#	personagem, lembrar que a posicao	#
#	tambem tem informacao de qual moveset	#
#	eh para aquele personagem performar	#
#################################################

EscolhePersonagem:
	# a7 = X => Personagem[X+1]
	beqz	a7, Personagem1		# Lyn	
	li	t0, 1
	beq	a7, t0, Personagem2	# Brigand
	li	t0, 2
	beq	a7, t0, Personagem3	# Yogi
	li	t0, 3
	beq	a7, t0, Personagem4	# Soldier
	li	t0, 4
	beq	a7, t0, Personagem5	# Dorcas
	li	t0, 5
	beq	a7, t0, Personagem6	# Assassin
	li	t0, 6
	beq	a7, t0, Personagem7	# Dart
	li	t0, 7
	beq	a7, t0, Personagem8	# Brigand2
	li	t0, 8
	beq	a7, t0, Personagem9	# Sain	
	j	Personagem10		# Soldier2
Personagem1:
	la	a1, Lyn
	j 	fimTeste
Personagem2:
	la	a1, Brigand
	j 	fimTeste
Personagem3:
	la	a1, Yogi
	j 	fimTeste
Personagem4:
	la	a1, Soldier
	j 	fimTeste
Personagem5:
	la	a1, Dorcas
	j 	fimTeste
Personagem6:
	la	a1, Assassin
	j 	fimTeste
Personagem7:
	la	a1, Dart
	j 	fimTeste
Personagem8:
	la	a1, Brigand2
	j 	fimTeste
Personagem9:
	la	a1, Sain
	j 	fimTeste
Personagem10:
	la	a1, Soldier2
fimTeste:
	ret
