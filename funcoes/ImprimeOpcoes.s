ImprimeOpcoes:	
	addi	sp, sp, -8
	sw	ra, 0(sp)
	sw	s1, 4(sp)
	
	la	t1, MenuFinais
	lw	a3, 0(t1)	# a3 <- cor branca
	lw	s1, 4(t1)	# t2 <- outra cor
	beqz	s0, pulaDireita	# nao foi para a direita ?
	lw	a3, 4(t1)	# a3 <- outra cor
	lw	s1, 0(t1)	# t2 <- cor branca
pulaDireita:
	la	a0, sim
	li	a1, 116
	li	a2, 190
	li	a4, 0
	call	printString	# imprime sim numa cor
	la	a0, sim
	li	a1, 116
	li	a2, 190
	li	a4, 1
	call	printString	# imprime sim numa cor	
	
	la	a0, nao
	mv	a3, s1
	li	a1, 180
	li	a2, 190
	li	a4, 0
	call	printString	# imprime sim numa cor
	la	a0, nao
	li	a1, 180
	li	a2, 190
	li	a4, 1
	call	printString	# imprime sim numa cor
	
	lw	ra, 0(sp)
	lw	s1, 4(sp)
	addi	sp, sp, 8
	ret