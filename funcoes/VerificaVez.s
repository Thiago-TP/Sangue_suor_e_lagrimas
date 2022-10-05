VerificaVez:
	addi	sp, sp, -4 	# aloca espaco na pilha
	sw	ra, 0(sp) 	# salva o ponteiro de retorno
	la	t0, Vez
	lb	t0, 0(t0)
	bnez	t0, VerificaVezInimigo
	li	t1, 5
	la	t4, Fase
	lb	t4, 0(t4)
	# verifica estado e HP de cada personagem dos personagens jogaveis
	# Lyn
	la	t0, Lyn
	lw	t2, 16(t0)		
	blt	t2, t1, fimVerificaVez	# estado = cinza ? fim : continua check
	li	t0, 1
	beq	t0, t4, VezMuda		# Fase = 1 ? fim : continua check
	
	# Yogi
	la	t0, Yogi
	lw	t2, 16(t0)		
	blt	t2, t1, fimVerificaVez	# estado = cinza ? fim : continua check
	li	t0, 2
	beq	t0, t4, VezMuda		# Fase = 2 ? fim : continua check
	
	# Dorcas
	la	t0, Dorcas
	lw	t2, 16(t0)		
	blt	t2, t1, fimVerificaVez	# estado = cinza ? fim : continua check
	li	t0, 3
	beq	t0, t4, VezMuda		# Fase = 3 ? fim : continua check
	
	# Dart
	la	t0, Dart
	lw	t2, 16(t0)		
	blt	t2, t1, fimVerificaVez	# estado = cinza ? fim : continua check
	li	t0, 4
	beq	t0, t4, VezMuda		# Fase = 4 ? fim : continua check
	
	# Sain
	la	t0, Sain
	lw	t2, 16(t0)		
	blt	t2, t1, fimVerificaVez	# estado = cinza ? fim : continua check
VezMuda:

	li	t3,6
	la	t0, Lyn
	lw	t2, 16(t0)		
	beq	t2,t3,PulaResetaLyn
	sw	zero,16(t0)
PulaResetaLyn:
	la	t0, Yogi
	lw	t2, 16(t0)		
	beq	t2,t3,PulaResetaYogi
	sw	zero,16(t0)
PulaResetaYogi:
	la	t0, Dorcas
	lw	t2, 16(t0)		
	beq	t2,t3,PulaResetaDorcas
	sw	zero,16(t0)
PulaResetaDorcas:
	la	t0, Dart
	lw	t2, 16(t0)		
	beq	t2,t3,PulaResetaDart
	sw	zero,16(t0)
PulaResetaDart:
	la	t0, Sain
	lw	t2, 16(t0)		
	beq	t2,t3,PulaResetaSain
	sw	zero,16(t0)
PulaResetaSain:
	la	t0, Vez
	li	t1, 1
	sb	t1, 0(t0)
fimVerificaVez:
	lw	ra, 0(sp) 		# carrega o valor de ra de sp
	addi	sp, sp, 4 		# desaloca a memoria da pilha
	ret 				# volta para quem chamou a funcao
	
VerificaVezInimigo:
	li	t1, 5
	la	t4, Fase
	lb	t4, 0(t4)

	la	t0, Brigand
	lw	t2, 16(t0)		
	blt	t2, t1, fimVerificaVezInimigo	# estado = cinza ? fim : continua check
	li	t0, 1
	beq	t0, t4, VezMudaInimigo		# Fase = 1 ? fim : continua check
	
	la	t0, Soldier
	lw	t2, 16(t0)		
	blt	t2, t1, fimVerificaVezInimigo	# estado = cinza ? fim : continua check
	li	t0, 2
	beq	t0, t4, VezMudaInimigo		# Fase = 2 ? fim : continua check
	
	la	t0, Assassin
	lw	t2, 16(t0)		
	blt	t2, t1, fimVerificaVezInimigo	# estado = cinza ? fim : continua check
	li	t0, 3
	beq	t0, t4, VezMudaInimigo		# Fase = 3 ? fim : continua check
	
	la	t0, Brigand2
	lw	t2, 16(t0)		
	blt	t2, t1, fimVerificaVezInimigo	# estado = cinza ? fim : continua check
	li	t0, 4
	beq	t0, t4, VezMudaInimigo		# Fase = 4 ? fim : continua check
	
	la	t0, Soldier2
	lw	t2, 16(t0)		
	blt	t2, t1, fimVerificaVezInimigo	# estado = cinza ? fim : continua check
VezMudaInimigo:	

	li	t3,6
	la	t0, Brigand
	lw	t2, 16(t0)		
	beq	t2,t3,PulaResetaBrigand
	sw	zero,16(t0)
PulaResetaBrigand:
	la	t0, Soldier
	lw	t2, 16(t0)		
	beq	t2,t3,PulaResetaSoldier
	sw	zero,16(t0)
PulaResetaSoldier:
	la	t0, Assassin
	lw	t2, 16(t0)		
	beq	t2,t3,PulaResetaAssassin
	sw	zero,16(t0)
PulaResetaAssassin:
	la	t0, Brigand2
	lw	t2, 16(t0)		
	beq	t2,t3,PulaResetaBrigand2
	sw	zero,16(t0)
PulaResetaBrigand2:
	la	t0, Soldier2
	lw	t2, 16(t0)		
	beq	t2,t3,PulaResetaSoldier2
	sw	zero,16(t0)
PulaResetaSoldier2:
	la	t0, Vez
	li	t1, 0
	sb	t1, 0(t0)
fimVerificaVezInimigo:
	lw	ra, 0(sp) 		# carrega o valor de ra de sp
	addi	sp, sp, 4 		# desaloca a memoria da pilha
	ret 				# volta para quem chamou a funcao
