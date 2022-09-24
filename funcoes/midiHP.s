#################################################################
#	esta funcao gera um barulhinho, e deve ser 		#
#	chamada toda vez que uma barrinha de HP eh impressa	#
#################################################################
midiHP:
	addi	sp, sp, -24	# armazenamento dos regs usados (necessario)
	sw	a0, 0(sp)
	sw	a1, 4(sp)
	sw	a2, 8(sp)
	sw	a3, 12(sp)
	sw	a7, 16(sp)
	sw	ra, 20(sp)	
	
	li	a7, 31		# preparo para gerar midi assincrono
	li	a0, 65		# pitch 
	li	a1, 20		# duracao em ms
	li	a2, 2		# instrumento
	li 	a3, 80		# volume/127
	#call	midiOut		# midiOut so funciona na FPGA
	ecall			# ecall so nao funciona na FPGA
	
	lw	a0, 0(sp)	# recuperacao dos regs usados
	lw	a1, 4(sp)
	lw	a2, 8(sp)
	lw	a3, 12(sp)
	lw	a7, 16(sp)
	lw	ra, 20(sp)
	addi	sp, sp, 24
	ret			# retorno da funcao
