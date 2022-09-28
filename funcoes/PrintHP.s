#########################################################
#	esta funcao imprime na frame 0 a barra de  	#
#	vida de acordo com a posicao e HP fornecidos	#
#########################################################
#	- Inputs -					#	
#	a0 = quantidade de vida (pauzinhos)		#
#	a1 = barra esquerda ou direita (0 ou 1)		#
#	a2 = se a vida deve ser retirada (0 ou 1)	#
#########################################################
#	- Variaveis internas - 				#
#	a1 = posicao em x				#
#	a2 = posicao em y				#
#	a3 = 0 (frame)	 				#
#########################################################
PrintHP:
	addi	sp, sp, -32
	sw	ra, 0(sp)
	sw	a0, 4(sp)
	sw	a1, 8(sp)
	sw	a2, 12(sp)
	sw	a3, 16(sp)
	sw	s0, 20(sp)
	sw	s1, 24(sp)
	sw	s2, 28(sp)
		
	mv	s0, x0	# s0 <- contador de barrinhas de HPs
	mv	s1, a0	# s1 <- quantidade a ser impressa
	
	la	a0, umHP
	beqz	a2, DecideBarra
	la	a0, umHPinvisivel
DecideBarra:
	li	a2, 200			# y
	mv	a3, x0			# frame 0
	mv	s2, a1
	beqz	s2, BarraEsquerda
	li	a1, 304			# x0 da barra direita
	j	LoopPrintHP
	
BarraEsquerda:
	li	a1, 16			# x0 da barra esquerda
LoopPrintHP:
	beq	s1, s0, FimPrintHP	# quantidade de impressos = desejada ? imprime mais um : termina
	call	PrintByte		# impressao de um HP na tela
	addi	s0, s0, 1		# cont++
	bnez	s2, deslocaDireita 
	addi	a1, a1, 4		# x += 4 (4 eh a largura do traco de um HP)
	j	midi
deslocaDireita:
	addi	a1, a1, -4		# x -= 4 (4 eh a largura do traco de um HP)
midi:
	lw	t0, 12(sp)		# t0 <- flag de dano
	beqz	t0, GanhaVida
	call 	midiDano		# a implementar
	j	pulamidiHP	
GanhaVida:
	call 	midiHP
pulamidiHP:
	mv	t3, a0
	li	a0, 50
	call	Sleep			# sleep de 50 ms (nao funfa no RARS)
	mv	a0, t3			
	j	LoopPrintHP
	
FimPrintHP:				
	lw	ra, 0(sp)
	lw	a0, 4(sp)
	lw	a1, 8(sp)
	lw	a2, 12(sp)
	lw	a3, 16(sp)
	lw	s0, 20(sp)
	lw	s1, 24(sp)
	lw	s2, 28(sp)
	addi	sp, sp, 32
	ret
