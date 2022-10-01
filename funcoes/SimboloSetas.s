#	espada (0) > machado (1) > lanca (2) > espada (0) ...	
SimboloSetas:
	addi	sp, sp, -4
	sw	ra, 0(sp)
	
	lb	t0, 21(s0)	# t0 <- arma do jogador
	lb	t1, 21(s1)	# t1 <- arma do pc
	li	t2, 1
	li	t3, 2
	
	beqz	t0, espada	# jogador tem espada?
	beq	t0, t2, machado	# jogador tem machado?	
				# jogador tem lanca
	beqz	t1, forte	# contra espada
	beq	t1, t2, fraco	# contra machado
	j	fimSetas
espada:
	beq	t1, t2, forte	# contra machado
	beq	t1, t3, fraco	# contra lanca
	j	fimSetas
machado:
	beq	t1, t3, forte	# contra lanca
	beqz	t1, fraco	# contra espada
	j	fimSetas
fimSetas:
	lw	ra, 0(sp)
	addi	sp, sp, 4
	ret
	
# impressao das setas
forte:
	la	a0, arrowUP
	li	a1, 128
	li	a2, 198
	call	PrintByte
	la	a0, arrowDOWN
	li	a1, 168
	call	PrintByte
	j	fimSetas
fraco:
	la	a0, arrowDOWN
	li	a1, 128
	li	a2, 198
	call	PrintByte
	la	a0, arrowUP
	li	a1, 168
	call	PrintByte
	j	fimSetas
