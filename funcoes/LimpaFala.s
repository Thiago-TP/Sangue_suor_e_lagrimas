LimpaFala:
	li 	t0, 0xFF000000 		# carrega 0xFF0 em t0
	add 	t0, t0, a1 		# adiciona x ao t0
	li 	t1, 320 		# t1 = 320
	mul 	t1, t1, a2 		# multiplica y por t1
	add 	t0, t0, t1 		# coloca o valor final do calculo do endereco em t0
	mv 	t1, zero 		# zera t2
	mv 	t2, zero 		# zera t3
	li	t3, 300			# carrega a largura em t3
	li	t4, 80 			# carrega a altura em t4	
	li	t5, 0x000000b7		# 0xb7 = 183 = bege
	# ate aqui estamos no primeiro endereco da imagem e no endereco que escolhemos no bitmap
LimpaLinha:	
	sb 	t5, 0(t0) 		# imprime no bitmap a word (4 pixeis) da imagem
	
	addi 	t0, t0, 1	 	# incrementa endereco do bitmap
	addi 	t2, t2, 1	 	# incrementa contador de coluna
	blt 	t2, t3, LimpaLinha 	# se contador da coluna < largura, continue imprimindo
	addi 	t0, t0, 320 		# t0 += 320
	sub 	t0, t0, t3 		# t0 -= largura da imagem
	# ^ isso serve pra "pular" de linha no bitmap display
	mv 	t2, zero 		# zera t3 (contador de coluna)
	addi 	t1, t1, 1 		# incrementa contador de linha
	bgt 	t4, t1, LimpaLinha 	# se altura > contador de linha, continue imprimindo	
	
	ret 				# retorna