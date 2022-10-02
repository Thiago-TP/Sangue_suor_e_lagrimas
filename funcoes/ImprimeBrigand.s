#################################################
#	muda a sprite do Brigand nas telas	#
#	de vitoria e de derrota 		#
#########################################################
#	- Inputs -					#
#	s1 = estado do personagem que deve ser impresso	#
#	s2 = frame onde a impressao deve ocorrer	#
#########################################################
ImprimeBrigand:
	addi	sp, sp, -4
	sw	ra, 0(sp)

	beqz	s1, sprite1Brigand
	li	t0, 1
	beq	s1, t0,	sprite2Brigand
	la	a0, Brigand1Win
fimImprimeBrigand:
	mv	t6, a0
	mv	a0, s2
	li	a1, 128
	li	a2, 100
	li	a3, 20
	li	a4, 28
	call	CobreTela		# call limpa a sprite no proximo frame
	
	mv	a0, t6
	li	a1, 128
	li	a2, 100
	mv	a3, s2
	li	a4, 0
	call	PrintByte
	
	lw	ra, 0(sp)
	addi	sp, sp, 4
	ret
sprite1Brigand:
	la	a0, Brigand3Win
	j	fimImprimeBrigand
sprite2Brigand:
	la	a0, Brigand2Win
	j	fimImprimeBrigand