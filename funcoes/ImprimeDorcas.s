#################################################
#	muda a sprite do Dorcas nas telas	#
#	de vitoria e de derrota 		#
#########################################################
#	- Inputs -					#
#	s1 = estado do personagem que deve ser impresso	#
#	s2 = frame onde a impressao deve ocorrer	#
#########################################################
ImprimeDorcas:
	addi	sp, sp, -4
	sw	ra, 0(sp)

	beqz	s1, sprite1Dorcas
	li	t0, 1
	beq	s1, t0,	sprite2Dorcas
	la	a0, Dorcas3
fimImprimeDorcas:
	mv	t6, a0
	mv	a0, s2
	li	a1, 128
	li	a2, 140
	li	a3, 32
	li	a4, 32
	call	CobreTela		# call limpa a sprite no proximo frame
	
	mv	a0, t6
	li	a1, 128
	li	a2, 140
	mv	a3, s2
	li	a4, 0
	call	PrintByte
	
	lw	ra, 0(sp)
	addi	sp, sp, 4
	ret
sprite1Dorcas:
	la	a0, Dorcas1
	j	fimImprimeDorcas
sprite2Dorcas:
	la	a0, Dorcas2
	j	fimImprimeDorcas