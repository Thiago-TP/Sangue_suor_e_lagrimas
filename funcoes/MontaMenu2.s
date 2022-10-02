MontaMenu2:
	addi	sp, sp, -8			# aloco espaco na pilha
	sw	ra, 0(sp)
	sw	s0, 4(sp)
	
	la	a0, BordaMenuC
	li	a1, 90
	li	a2, 30
	call 	PrintByteInverso
	li	a1, 210
	call 	PrintByte
	

	la	a0, LadoMenuC
	li	a1, 110
	call 	PrintByte
	li	s0, 4
	la	a0, LadoMenuC
loopLadoC:
	addi	a1, a1, 20
	call 	PrintByte
	addi	s0, s0, -1
	bgtz	s0, loopLadoC
	
	la	a0, BordaMenuB
	li	a1, 90
	li	a2, 50
	call 	PrintByteInverso
	li	a1, 210
	call 	PrintByte
	

	la	a0, LadoMenuB
	li	a1, 110
	call 	PrintByte
	li	s0, 4
	la	a0, LadoMenuB
loopLadoB:
	addi	a1, a1, 20
	call 	PrintByte
	addi	s0, s0, -1
	bgtz	s0, loopLadoB
	
	
	lw	ra, 0(sp)
	lw	s0, 4(sp)
	addi	sp, sp, 8
	ret