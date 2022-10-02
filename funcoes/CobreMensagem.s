#########################################################
#	esta cria um retangulo no frame 0 com os	#
#	pixeis do frame 1, cobrindo a area		#
#########################################################
#	- Inputs -	#
#	a1 = pos em x	#
#	a2 - pos em y	#
#	a3 = largura	#
#	a4 = altura	#
#########################
CobreMensagem:		
	add 	t0, x0, a1 	# adiciona x ao t0
	li 	t1, 320 	# t1 = 320
	mul 	t1, t1, a2 	# multiplica y por t1
	add 	t0, t0, t1 	# coloca o valor final do calculo do endereço em t0
	li	t1, 0xFF100000
	add 	t6, t1, t0 	# salvo o endereco da imagem passada para a funcao em a0
	li	t1, 0xFF000000
	add 	t0, t1, t0
	mv 	t1, zero 	# zera t2
	mv 	t2, zero 	# zera t3
	mv 	t3, a3 		# carrega a largura em t3
	mv 	t4, a4 		# carrega a altura em t4
	# ate aqui estamos no primeiro endereco da imagem e no endereço que escolhemos no bitmap
CobreLinha:	
	lbu 	t5, 0(t6) 		# carrega em t6 um byte (1 pixel) da imagem	
	sb 	t5, 0(t0) 		# imprime no bitmap a word (4 pixeis) da imagem
	addi 	t0, t0, 1 		# incrementa endereco do bitmap
	addi 	t6, t6, 1 		# incrementa endereco da imagem
	addi 	t2, t2, 1 		# incrementa contador de coluna
	blt 	t2, t3, CobreLinha	# se contador da coluna < largura,  continue imprimindo
	addi	t0, t0, 320 		# t0 += 320
	sub 	t0, t0, t3 		# t0 -= largura da imagem
	addi	t6, t6, 320 		# t6 += 320
	sub 	t6, t6, t3 		# t6 -= largura da imagem
	# ^ isso serve pra "pular" de linha no bitmap display
	mv 	t2, zero 		# zera t2 (contador de coluna)
	addi 	t1, t1, 1 		# incrementa contador de linha
	bgt 	t4, t1, CobreLinha # se altura > contador de linha, continue imprimindo
	ret
