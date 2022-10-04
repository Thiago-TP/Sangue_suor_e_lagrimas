MontaMenu3:
	addi	sp, sp, -4 			# aloco espaco na pilha
	sw	ra, 0(sp)
	li	a5, 2
	la	a0, BordaMenuC
	li	a4, 2
	li	a1, 120
	li	a2, 80
	call 	PrintByteInverso
	la	a0, LadoMenuC
LoopMenu1.3:
	addi	a1 ,a1, 20
	addi	a4, a4, -1
	call 	PrintByteInverso
	bnez	a4, LoopMenu1.3	
	addi	a1, a1, 20
	la	a0, BordaMenuC
	call 	PrintByte	
LoopMenu2.3:
	addi	a2, a2, 20
	li	a1, 120
	li	a4, 2
	la	a0,LadoMenu
	call 	PrintByteInverso
	la	a0, MioloMenu
LoopMenu3.3:
	addi	a1 ,a1, 20
	addi	a4, a4, -1
	call 	PrintByteInverso#PRINT
	bnez	a4, LoopMenu3.3
	addi	a1, a1, 20
	addi	a5, a5, -1
	la	a0, LadoMenu
	call 	PrintByte
	bnez	a5, LoopMenu2.3
	addi	a2, a2, 20			
	li	a1, 120
	la	a0, BordaMenuB
	li	a4, 2
	call 	PrintByteInverso
	la	a0, LadoMenuB
LoopMenu4.3:
	addi	a1, a1, 20
	addi	a4, a4, -1
	call 	PrintByteInverso
	bnez	a4, LoopMenu4.3
	addi	a1, a1, 20	
	la	a0, BordaMenuB
	call 	PrintByte
	li	a6,85
	mv	a5,a3
	la	t6, MenuPause
	la	a0, menu2opcao1
	li 	a1, 125		# posicao x da impressao (coluna)
	mv	a2, a6		# posicao y da impressao (linha)
	mv	a4, a5
	lbu 	a3, 0(t6)	# cor da string => 0 = preto
	li	t0, 0x0000c700
	add	a3, a3, t0
	call 	printString
	addi	a6,a6,10
	la	t6, MenuPause	
	la	a0,menu2opcao2
	li 	a1, 125		# posicao x da impressao (coluna)
	mv	a2, a6		# posicao y da impressao (linha)
	mv	a4, a5
	lbu 	a3, 1(t6)	# cor da string => 0 = preto
	li	t0, 0x0000c700
	add	a3, a3, t0
	call	printString
	addi	a6,a6,10
	la	t6, MenuPause	
	la	a0,menu2opcao3
	li 	a1, 125		# posicao x da impressao (coluna)
	mv	a2, a6		# posicao y da impressao (linha)
	mv	a4, a5
	lbu 	a3, 2(t6)	# cor da string => 0 = preto
	li	t0, 0x0000c700
	add	a3, a3, t0
	call	printString
	addi	a6,a6,10
	la	t6, MenuPause	
	la	a0,menu2opcao4
	li 	a1, 125		# posicao x da impressao (coluna)
	mv	a2, a6		# posicao y da impressao (linha)
	mv	a4, a5
	lbu 	a3, 3(t6)	# cor da string => 0 = preto
	li	t0, 0x0000c700
	add	a3, a3, t0
	call	printString
	addi	a6,a6,10
	la	t6, MenuPause	
	la	a0,menu2opcao5
	li 	a1, 125		# posicao x da impressao (coluna)
	mv	a2, a6		# posicao y da impressao (linha)
	mv	a4, a5
	lbu 	a3, 4(t6)	# cor da string => 0 = preto
	li	t0, 0x0000c700
	add	a3, a3, t0
	call	printString
	addi	a6,a6,10
	la	t6, MenuPause	
	la	a0,menu2opcao6
	li 	a1, 125		# posicao x da impressao (coluna)
	mv	a2, a6		# posicao y da impressao (linha)
	mv	a4, a5
	lbu 	a3, 5(t6)	# cor da string => 0 = preto
	li	t0, 0x0000c700
	add	a3, a3, t0
	call	printString
	lw	ra, 0(sp)	# recupero o ponteiro de retorno da pilha
	addi	sp, sp, 4 	# desaloco a memoria da pilha
	ret			# retorno para a funcao chamadora