MontaMenu:
	addi	sp, sp, -4 			# aloco espaco na pilha
	sw	ra, 0(sp)
	li	a5, 2
	la	a0, BordaMenuC
	li	a4, 2
	li	a1, 5
	li	a2, 5
	call 	PrintByteInverso
	la	a0, LadoMenuC
LoopMenu1:
	addi	a1 ,a1, 20
	addi	a4, a4, -1
	call 	PrintByteInverso
	bnez	a4, LoopMenu1	
	addi	a1, a1, 20
	la	a0, BordaMenuC
	call 	PrintByte	
LoopMenu2:
	addi	a2, a2, 20
	li	a1, 5
	li	a4, 2
	la	a0,LadoMenu
	call 	PrintByteInverso
	la	a0, MioloMenu
LoopMenu3:
	addi	a1 ,a1, 20
	addi	a4, a4, -1
	call 	PrintByteInverso#PRINT
	bnez	a4, LoopMenu3
	addi	a1, a1, 20
	addi	a5, a5, -1
	la	a0, LadoMenu
	call 	PrintByte
	bnez	a5, LoopMenu2
	addi	a2, a2, 20			
	li	a1, 5
	la	a0, BordaMenuB
	li	a4, 2
	call 	PrintByteInverso
	la	a0, LadoMenuB
LoopMenu4:
	addi	a1, a1, 20
	addi	a4, a4, -1
	call 	PrintByteInverso
	bnez	a4, LoopMenu4
	addi	a1, a1, 20	
	la	a0, BordaMenuB
	call 	PrintByte
	li	a6, 11
	li	s10,1
	li	t6,1
LoopVerificaPersonagemAtaque:
	mv	a7,t6
	call 	EscolhePersonagem 	# carrega em a1 a posicao que queremos receber em t6 :)
	li	t0,6
	lw	t1,16(a1)
	bge	t1,t0,FimVerificaAtaque
	lw	t0,0(s8)
	lw	t1,4(s8)
	addi	t2,t0,16
	lw	a2, 4(a1) 	# carrega y
	lw	a1, 0(a1)	# carrega x
	bne	t2,a1,Pula1Condicao
	bne	t1,a2,Pula1Condicao
	li	s10,2
	j	 FimVerificaAtaque
Pula1Condicao:
	addi	t3,t0,-16
	bne	t3,a1,Pula2Condicao
	bne	t1,a2,Pula2Condicao
	li	s10,2
	j	FimVerificaAtaque 
Pula2Condicao:
	addi	t4,t1,16
	bne	t0,a1,Pula3Condicao
	bne	t4,a2,Pula3Condicao
	li	s10,2
	j	FimVerificaAtaque
Pula3Condicao:
	addi	t5,t1,-16
	bne	t0,a1,Pula4Condicao
	bne	t4,a2,Pula4Condicao
	li	s10,2
	j	FimVerificaAtaque
Pula4Condicao:
	addi	t6,t6,2
	blt	t6,s4,LoopVerificaPersonagemAtaque
FimVerificaAtaque:
	mv	a5,a3
	li	t0,1
	la	t6, MenuBatalha
	beq	s10,t0,PulaAtaque
	la	a0, menu1opcao1
	li 	a1, 10		# posicao x da impressao (coluna)
	mv	a2, a6		# posicao y da impressao (linha)
	mv	a4, a5
	lbu 	a3, 0(t6)	# cor da string => 0 = preto
	li	t0, 0x0000c700
	add	a3, a3, t0
	call 	printString
	addi	a6,a6,10
PulaAtaque:
	la	t6, MenuBatalha	
	la	a0,menu1opcao2
	li 	a1, 10		# posicao x da impressao (coluna)
	mv	a2, a6		# posicao y da impressao (linha)
	mv	a4, a5
	lbu 	a3, 1(t6)	# cor da string => 0 = preto
	li	t0, 0x0000c700
	add	a3, a3, t0
	call	printString
	lw	ra, 0(sp)	# recupero o ponteiro de retorno da pilha
	addi	sp, sp, 4 	# desaloco a memoria da pilha
	ret			# retorno para a funcao chamadora
