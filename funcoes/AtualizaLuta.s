AtualizaLuta:
	addi	sp, sp, -8
	sw	ra, 0(sp)
	sw	a0, 4(sp)
	
	bnez	a0, Hit	
	la	a0, miss	# a0 
	li	a1, 136		# x
	li	a2, 152		# y
	li	a3, 0		# frame
	li	a4, 0		# colorido
	call	PrintByte	# impressao da mensagem
	lw	a0, 4(sp)
	j	SFXatk
Hit:
	li	t1, 8
	beq	a0, t1, Crit
	li	t1, 11
	beq	a0, t1, Crit
	li	t1, 15
	beq	a0, t1, Crit
	j	SFXatk
Crit:
	la	a0, Critou	
	li	a1, 128		# x
	li	a2, 152		# y
	li	a3, 0x0000ff00	# cor
	li	a4, 0		# frame
	call	printString	# impressao da mensagem
	lw	a0, 4(sp)
SFXatk:
	call	midiAtaque	# somzinho de ataque + sleep
	li	a1, 128		# pos em x
	li	a2, 152		# pos em y
	li	a3, 64		# largura
	li	a4, 16		# altura
	call	CobreMensagem	# cobre a mensagem de critico/erro

	lw	ra, 0(sp)
	lw	a0, 4(sp)
	addi	sp, sp, 8
	ret
