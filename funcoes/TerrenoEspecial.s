#########################################################
#	esta funcao modifica os valores de critico e 	#
#	e miss se o personagem estiver no lugar certo	#
#########################################################
#	- Inputs -					#
#	t0 = flag do atacanate (0 - jogador, 1 - pc)	#
#	s0 = label do personagem do jogador		#
#	s1 = label do personagem do pc			#
#	a0 = dano atual					#
#########################################################
TerrenoEspecial:
	addi	sp, sp, -8
	sw	ra, 0(sp)
	sw	a0, 4(sp)
	
	beqz	a0, fimTerreno		# dano nulo => errou => terreno n tem efeito
	
	mv	t1, s0			# t1 <- label do jogador
	beqz	t0, jogadorAtacando
	mv	t1, s1			# t1 <- label do pc
	#ebreak
jogadorAtacando:
	lw	t2, 0(t1)		# t2 <- x (sempre multiplo de 16)
	lw	t3, 4(t1)		# t3 <- y (sempre multiplo de 16)
	# x e y serao convertidos para um indice de tilemap
	srli	t2, t2, 4		# t2 <- x // 16
	srli	t3, t3, 4		# t3 <- y // 16
	# ind = (x // 16) + (y // 16)*20
	li	t1, 20
	mul	t3, t3, t1		# t3 <- (y // 16)*20
	add	t0, t2, t3		# t0 <- ind incremental
	
	call	DecideMapa		# a0 <- endereco do mapa atual
	add	t0, t0, a0		# ind real do atacante
	lbu	t0, 0(t0)		# t0 <- valor da tile do atacante
	
	lw	a0, 4(sp)		# a0 <- dano
	
	li	t1, 6
	beq	t1, t0, highGround
	li	t1, 23
	beq	t1, t0, highGround
	
	li	t1, 8
	beq	t1, t0, floresta
	li	t1, 9
	beq	t1, t0, floresta
	li	t1, 15
	beq	t1, t0, floresta
	li	t1, 24
	beq	t1, t0, floresta
	
	j	fimTerreno
floresta:
	addi	a0, a0, -1		# dano -= 1
	j	fimTerreno
highGround:
	addi	a0, a0, 2		# dano += 2
fimTerreno:
	lw	ra, 0(sp)
	addi	sp, sp, 8
	ret		
	