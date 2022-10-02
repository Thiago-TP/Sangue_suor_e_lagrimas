#################################################
#	muda a sprite do Lyn nas telas		#
#	de vitoria e de derrota 		#
#########################################################
#	- Inputs -					#
#	s1 = estado do personagem que deve ser impresso	#
#	s2 = frame onde a impressao deve ocorrer	#
#########################################################
ImprimeLyn:
	addi	sp, sp, -4
	sw	ra, 0(sp)

	beqz	s1, sprite1Lyn
	li	t0, 1
	beq	s1, t0,	sprite2Lyn
	la	a0, Lyn3Win
fimImprimeLyn:
	mv	t6, a0
	mv	a0, s2
	li	a1, 112
	li	a2, 100
	li	a3, 32
	li	a4, 32
	call	CobreTela		# call limpa a sprite no proximo frame
	
	mv	a0, t6
	li	a1, 112
	li	a2, 100
	mv	a3, s2
	li	a4, 0
	call	PrintByte
	
	lw	ra, 0(sp)
	addi	sp, sp, 4
	ret
sprite1Lyn:
	la	a0, Lyn1Win
	j	fimImprimeLyn
sprite2Lyn:
	la	a0, Lyn2Win
	j	fimImprimeLyn