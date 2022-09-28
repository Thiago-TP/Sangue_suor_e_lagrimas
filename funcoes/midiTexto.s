#################################################################
#	esta funcao faz o barulhinho + sleep de cada char no	#
#	texto de dialogo, e so deve ser chamada nesse caso	#
#################################################################
midiTexto:
	addi	sp, sp, -4
	sw	ra, 0(sp)
	
	mv	t0, a0
	li 	a7, 31		# prepara para tocar uma nota (rars/fpga)	
	li	a0, 69		# pitch 
	li	a1, 10		# duracao em ms
	li	a2, 121		# instrumento padrao 
	li 	a3, 127		# volume/127
	li	t1, '>'
	beq	t0, t1, midiSeta	# char = > ? muda o instrumento : segue
	j	fimMidi
midiSeta:
	li	a0, 69		# pitch 
	li	a1, 20		# duracao em ms
	li	a2, 40		# instrumento da seta 
	li 	a3, 70		# volume/127
fimMidi:		
	ecall			# toca a nota
	#call 	midiOut		# toca a nota (funciona apenas na fpga)
	# sleep para cada char
	li	a0, 30
	call	Sleep		# sleep versao FPGA/fpgrars
	
	lw	ra, 0(sp)
	addi	sp, sp, 4
	ret
