#################################################
#	muda a sprite do Assassin nas telas	#
#	de vitoria e de derrota 		#
#########################################################
#	- Inputs -					#
#	s1 = estado do personagem que deve ser impresso	#
#	s2 = frame onde a impressao deve ocorrer	#
#########################################################
ImprimeAssassin:
	addi	sp, sp, -4
	sw	ra, 0(sp)

	beqz	s1, sprite1Assassin
	li	t0, 1
	beq	s1, t0,	sprite2Assassin
	la	a0, Assassin3Win
fimImprimeAssassin:
	mv	t6, a0
	mv	a0, s2
	li	a1, 180
	li	a2, 112
	li	a3, 20
	li	a4, 20
	call	CobreTela		# call limpa a sprite no proximo frame
	
	mv	a0, t6
	li	a1, 180
	li	a2, 112
	mv	a3, s2
	li	a4, 0
	call	PrintByte
	
	lw	ra, 0(sp)
	addi	sp, sp, 4
	ret
sprite1Assassin:
	la	a0, Assassin1Win
	j	fimImprimeAssassin
sprite2Assassin:
	la	a0, Assassin2Win
	j	fimImprimeAssassin