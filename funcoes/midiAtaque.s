#########################################################
#	esta funcao gera um barulhinho, e deve ser 	#
#	chamada toda vez que o cursor eh movimentado	#
#########################################################
midiAtaque:
	addi	sp, sp, -24	# armazenamento dos regs usados (necessario)
	sw	a0, 0(sp)
	sw	a1, 4(sp)
	sw	a2, 8(sp)
	sw	a3, 12(sp)
	sw	a7, 16(sp)
	sw	ra, 20(sp)	
	
	li	a0, 801
	call	Sleep
	
	li	a7, 31		# preparo para gerar midi assincrono
	li	a0, 59		# pitch 
	li	a1, 100		# duracao em ms
	li	a2, 127		# instrumento padrao
	li 	a3, 127		# volume/127
	
	lw	t0, 0(sp)	# t0 <- dano
	beqz	t0, SFXerro
	li	t1, 8
	beq	t0, t1, SFXcrit
	li	t1, 11
	beq	t0, t1, SFXcrit
	li	t1, 15
	beq	t0, t1, SFXcrit
	j	SFX
SFXcrit:
	li	a2, 99		# instrumento do crit
	j	SFX
SFXerro:
	li	a2, 126		# instrumento do erro
SFX:
	call	midiOut		# midiOut so funciona na FPGA
	#ecall			# ecall so nao funciona na FPGA
	li	a0, 296
	call	Sleep
	
	lw	a0, 0(sp)	# recuperacao dos regs usados
	lw	a1, 4(sp)
	lw	a2, 8(sp)
	lw	a3, 12(sp)
	lw	a7, 16(sp)
	lw	ra, 20(sp)
	addi	sp, sp, 24
	ret			# retorno da funcao
