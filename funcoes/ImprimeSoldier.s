#################################################
#	muda a sprite do Lanca nas telas	#
#	de vitoria e de derrota 		#
#########################################################
#	- Inputs -					#
#	s1 = estado do personagem que deve ser impresso	#
#	s2 = frame onde a impressao deve ocorrer	#
#########################################################
ImprimeSoldier:
	addi	sp, sp, -4
	sw	ra, 0(sp)

	beqz	s1, sprite1Lanca
	li	t0, 1
	beq	s1, t0,	sprite2Lanca
	la	a0, Lanca1StandBy
fimImprimeLanca:
	mv	t6, a0
	mv	a0, s2
	li	a1, 152
	li	a2, 152
	li	a3, 20
	li	a4, 20
	call	CobreTela		# call limpa a sprite no proximo frame
	
	mv	a0, t6
	li	a1, 152
	li	a2, 152
	mv	a3, s2
	li	a4, 0
	call	PrintByte
	
	lw	ra, 0(sp)
	addi	sp, sp, 4
	ret
sprite1Lanca:
	la	a0, Lanca2StandBy
	j	fimImprimeLanca
sprite2Lanca:
	la	a0, Lanca3StandBy
	j	fimImprimeLanca