#########################################################################
#	Imprime o balao de fala e a fala correspondente no frame	#
#	dad o,ao final aguardando aval do usuario para retornar		#
#########################################################################
#	a1 <- fala a ser impressa					#
#	a2 <- frame da impressao					#
#########################################################################
.text
PrintFala:
	addi 	sp, sp, -8	# armazenamento de seguranca dos regs
	sw	ra, 0(sp)
	sw	a1, 4(sp)	# endereco da linha de texto
	
	mv	a3, a2		# a3 <- frame 
	call 	PrintBalao	# impressao do balao 
	
	lw	a0, 4(sp)	# endereco da fala 
	mv 	a4, a3		# frame 
	li 	a1, 10		# posicao x da impressao (coluna)
	li	a2, 10		# posicao y da impressao (linha)
	li 	a3, 0x0000c700	# cor da string => 0 = preto
	call 	printString	# impressao dastring na tela 
	
	# pausa	
	li 	a0, 750		# a0 = 750 ms
	call 	Sleep 		# executa o sleep
	# seta
	li 	a0, '>'		# caracter de proxima fala
	li 	a1, 307		# pos. em x
	li 	a2, 82		# pos. em y
	li 	a3, 0x0000c7a0	# cor 
	call 	printChar	# impressao na tela	
	# pausa	
	li 	a0, 1000	# a0 = 1000 ms
	call 	Sleep 		# executa o sleep
	# recuperacao dos registradores
	lw	ra, 0(sp)
	lw	a1, 4(sp)	
	addi 	sp, sp, 8
	ret			# retorno a chamada por pseudoinstrucao
