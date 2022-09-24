#########################################################################
# 	Imprime o fundo em ambas as frames, limpando a tela		#
#########################################################################
#	a0 -> endereco do tilemap da tela de fundo			#
#	a1 -> pos. em x	(sempre 0)					#
#	a2 -> pos. em y	(sempre 0)					#
#	a3 = frame							#
#########################################################################
#	s0 -> endereco da tilemap da tela de fundo			#
#########################################################################
ClearScreen:
	addi 	sp, sp, -4	# expansao da pilha		
	sw 	ra, 0(sp)	# armazenamento de ra	
	call	DecideMapa	#retorna em a0
	mv 	a3, zero	# a3 <- frame 0  
	call 	PrintTiling	# impressao do fundo na tela
	li 	a3, 1		# a3 <- frame 1 
	call 	PrintTiling	# impressao do fundo na tela
	lw 	ra, 0(sp)	# recuperacao de ra	
	addi 	sp, sp, 4	# contracao da pilha	
	ret			# retorno a chamada
#########################################################################
