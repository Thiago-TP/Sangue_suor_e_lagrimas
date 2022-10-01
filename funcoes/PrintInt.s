#########################################################
#	imprime numero de dois digitos decimais em a0	#
#########################################################
#	- Inputs -			#
#	a0 = d1d0 (entre 0 e 25)	#
#	a1 = x				#
#	a2 = y				#
#	a3 = frame			#
#	a4 = 0 (flag de cinza)		#
#########################################
PrintInt:
	addi	sp, sp, -8
	sw	ra, 0(sp)
	sw	a0, 4(sp)
	
	li	t0, 10
	divu	a0, a0, t0	# t0 <- d1
	jal	switchInt	# sprite de d1
	call	PrintByte
	
	lw	a0, 4(sp)
	li	t0, 10
	rem	a0, a0, t0	# a0 <- d0
	jal	switchInt	# a0 <- sprite de d0
	addi	a1, a1, 8	# x += 8
	call	PrintByte
		
fimPrintInt:
	addi	a1, a1, -8
	lw	ra, 0(sp)
	lw	a0, 4(sp)
	addi	sp, sp, 8
	ret

switchInt:
	beqz	a0, Zero
	li	t0, 1
	beq	t0, a0, Um
	li	t0, 2
	beq	t0, a0, Dois
	li	t0, 3
	beq	t0, a0, Tres
	li	t0, 4
	beq	t0, a0, Quatro
	li	t0, 5
	beq	t0, a0, Cinco
	li	t0, 6
	beq	t0, a0, Seis
	li	t0, 7
	beq	t0, a0, Sete
	li	t0, 8
	beq	t0, a0, Oito
	
	la	a0, nove
switchEnd:
	ret

Zero:	la	a0, numzero
	j	switchEnd
Um:	la	a0, um
	j	switchEnd
Dois:	la	a0, dois
	j	switchEnd
Tres:	la	a0, tres
	j	switchEnd
Quatro:	la	a0, quatro
	j	switchEnd
Cinco:	la	a0, cinco
	j	switchEnd
Seis:	la	a0, seis
	j	switchEnd
Sete:	la	a0, sete
	j	switchEnd
Oito:	la	a0, oito
	j	switchEnd
