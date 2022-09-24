PrintBalao:
	addi	sp, sp, -4 			# aloco espaco na pilha
	sw	ra, 0(sp)
	li	a5, 4
	la	a0, cantoSD
	li	a4, 18
	li	a1, 0
	li	a2, 0
	call 	PrintByteInverso
	la	a0, arestaS
LoopBalao1:
	addi	a1 ,a1, 16
	addi	a4, a4, -1
	call 	PrintByteInverso
	bnez	a4, LoopBalao1	
	addi	a1,a1,16
	la	a0, cantoSD
	call 	PrintByte	
LoopBalao2:
	addi	a2,a2,16
	li	a1,0
	li	a4,18
	la	a0,arestaD
	call 	PrintByteInverso
	la	a0,miolo
LoopBalao3:
	addi	a1 ,a1, 16
	addi	a4, a4, -1
	call 	PRINT
	bnez	a4, LoopBalao3
	addi	a1 ,a1, 16
	addi	a5,a5,-1
	la	a0, arestaD
	call 	PrintByte
	bnez	a5,LoopBalao2
	addi	a2,a2,16			
	li	a1,0
	la	a0, cantoID
	li	a4, 18
	call 	PrintByteInverso
LoopBalao4:
	la	a0, arestaI
	addi	a1 ,a1, 16
	addi	a4, a4, -1
	li	t0,9
	bne	a4,t0,PulaArestaR
	la	a0, arestaR
PulaArestaR:
	call 	PrintByteInverso
	bnez	a4, LoopBalao4
	addi	a1 ,a1, 16	
	la	a0, cantoID
	call 	PrintByte
	lw	ra, 0(sp)			# recupero o ponteiro de retorno da pilha
	addi	sp, sp, 4 			# desaloco a memoria da pilha
	ret					# retorno para a funcao chamadora