# Verifica se oponentes estao adjacentes e inicia a luta, se possivel
VerificaLuta:
	addi	sp, sp, -36
	sw	ra, 0(sp)
	sw	a0, 4(sp)
	sw	a1, 8(sp)
	sw	a2, 12(sp)
	sw	a3, 16(sp)
	sw	a4, 20(sp)
	sw	s0, 24(sp)
	sw	s1, 28(sp)
	sw	s2, 32(sp)
	
	# Lyn vs all
	la	a0, Lyn
	la	a1, Brigand
	call	VerificaAdjacencia
	bnez	t0, xisUm

	# Yogi vs all
	# Dorcas vs all
	# Dart vs all
	# Sain vs all
	j	pulaLuta
xisUm:
	lw	t0, 12(a0)
	beqz	t0, pulaLuta
	lw	t0, 12(a1)
	beqz	t0, pulaLuta
	mv	t0, a0
	li	a0, 500 
	call 	Sleep
	mv	a0, t0
	call	Luta
pulaLuta:
	lw	ra, 0(sp)
	lw	a0, 4(sp)
	lw	a1, 8(sp)
	lw	a2, 12(sp)
	lw	a3, 16(sp)
	lw	a4, 20(sp)
	lw	s0, 24(sp)
	lw	s1, 28(sp)
	lw	s2, 32(sp)
	addi	sp, sp, 36
	ret

#################################################
#	Verifica se duas labels sao adjacentes	#
#################################################
#	- Inputs - 				#
#	a0 = label 1				#
#	a1 = label 2				#
#################################################
#	- Outputs -				#
#	a2 = 1 ou 0				#
#################################################
VerificaAdjacencia:
	lw	t0, 0(a0)		# t0 <- x1
	lw	t1, 0(a1)		# t0 <- x2
	addi	t1, t1, 16		# t1 += 16
	beq	t0, t1, verificaY	# t0 = t1 ? continua check em y : continua check em x
	addi	t1, t1, -32		# t1 -= 32
	beq	t0, t1, verificaY	# t0 = t1 ? continua check em y : sem adj
	j	semAdj
verificaY:
	lw	t0, 4(a0)		# t0 <- y1
	lw	t1, 4(a1)		# t1 <- y2
	#addi	t1, t1, 320		# t1 += 320
	beq	t0, t1, comAdj		# t0 = t1 ? ta embaixo : continua check
	#addi	t1, t1, -640		# t1 -= 32
	#beq	t0, t1, comAdj		# t0 = t1 ? ta em cima : continua check em y
semAdj:
	li	t0, 0
	ret
comAdj:
	li	t0, 1
	ret
	

