#################################################
#	muda a sprite do Yogi nas telas		#
#	de vitoria e de derrota 		#
#########################################################
#	- Inputs -					#
#	s1 = estado do personagem que deve ser impresso	#
#	s2 = frame onde a impressao deve ocorrer	#
#########################################################
ImprimeYogi:
	addi	sp, sp, -4
	sw	ra, 0(sp)

	beqz	s1, sprite1Yogi
	li	t0, 1
	beq	s1, t0,	sprite2Yogi
	la	a0, Yogi3W
fimImprimeYogi:
	mv	t6, a0
	mv	a0, s2
	li	a1, 176
	li	a2, 100
	li	a3, 32
	li	a4, 32
	call	CobreTela		# call limpa a sprite no proximo frame
	
	mv	a0, t6
	li	a1, 176
	li	a2, 100
	mv	a3, s2
	li	a4, 0
	call	PrintByte
	
	lw	ra, 0(sp)
	addi	sp, sp, 4
	ret
sprite1Yogi:
	la	a0, Yogi1W
	j	fimImprimeYogi
sprite2Yogi:
	la	a0, Yogi2W
	j	fimImprimeYogi