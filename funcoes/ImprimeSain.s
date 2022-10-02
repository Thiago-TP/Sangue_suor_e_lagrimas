#################################################
#	muda a sprite do Sain nas telas	#
#	de vitoria e de derrota 		#
#########################################################
#	- Inputs -					#
#	s1 = estado do personagem que deve ser impresso	#
#	s2 = frame onde a impressao deve ocorrer	#
#########################################################
ImprimeSain:
	addi	sp, sp, -4
	sw	ra, 0(sp)

	beqz	s1, sprite1Sain
	li	t0, 1
	beq	s1, t0,	sprite2Sain
	la	a0, Sain2W
fimImprimeSain:
	mv	t6, a0
	mv	a0, s2
	li	a1, 144
	li	a2, 104
	li	a3, 24
	li	a4, 24
	call	CobreTela		# call limpa a sprite no proximo frame
	
	mv	a0, t6
	li	a1, 144
	li	a2, 104
	mv	a3, s2
	li	a4, 0
	call	PrintByte
	
	lw	ra, 0(sp)
	addi	sp, sp, 4
	ret
sprite1Sain:
	la	a0, Sain1W
	j	fimImprimeSain
sprite2Sain:
	la	a0, Sain3W
	j	fimImprimeSain