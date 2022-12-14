#################################################
#	a0 = endereco imagem			#
#	a1 = posicao x incial do bitmap		#
#	a2 = posicao y inicial do bitmap	#
#	a3 = frame utilizado na funcao		#
#	t0 = Endereco do bitmap			#
#################################################
	
PRINT:
	li 	t0, 0xFF0 		# carrega 0xFF0 em t0
	add 	t0, t0, a3 		# adiciona o frame ao FF0 (se o frame for 1 vira FF1, se for 0 fica FF0)
	slli 	t0, t0, 20 		# shift de 20 bits pra esquerda (0xFF0 vira 0xFF000000, 0xFF1 vira 0xFF100000)
	add 	t0, t0, a1 		# adiciona x ao t0
	li 	t1, 320 		# t1 = 320
	mul 	t1, t1, a2 		# multiplica y por t1
	add 	t0, t0, t1 		# coloca o valor final do calculo do endereco em t0
	mv 	t1, zero 		# zera t2
	mv 	t2, zero 		# zera t3
	lw 	t3, 0(a0) 		# carrega a largura em t3
	lw 	t4, 4(a0) 		# carrega a altura em t4
	addi 	a7, a0, 8 		# salvo o endereco da imagem passada para a funcao em a0
	# ate aqui estamos no primeiro endereco da imagem e no endereco que escolhemos no bitmap
PRINT_LINHA:	
	lw 	t5, 0(a7)	 	# carrega em t5 uma word (4 pixeis) da imagem
	sw 	t5, 0(t0) 		# imprime no bitmap a word (4 pixeis) da imagem
	addi 	t0, t0, 4	 	# incrementa endereco do bitmap
	addi 	a7, a7, 4	 	# incrementa endereco da imagem
	addi 	t2, t2, 4	 	# incrementa contador de coluna
	blt 	t2, t3, PRINT_LINHA 	# se contador da coluna < largura, continue imprimindo
	addi 	t0, t0, 320 		# t0 += 320
	sub 	t0, t0, t3 		# t0 -= largura da imagem
	# ^ isso serve pra "pular" de linha no bitmap display
	mv 	t2, zero 		# zera t3 (contador de coluna)
	addi 	t1, t1, 1 		# incrementa contador de linha
	bgt 	t4, t1, PRINT_LINHA 	# se altura > contador de linha, continue imprimindo	
	ret 				# retorna	
#################################################################
