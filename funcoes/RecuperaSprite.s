#################################################
#	Esta funcao guarda na pilha uma sprite	#
#	de dimensoes dadas			#
#################################################
#	Argumentos:				#
#	a4 = x maximo da recuperacao		#
#	a5 = y maximo da recuperacao		#
#	a6 = estado da pilha que queremos	#
#################################################
#	Retorno:				#
#	Nada					#
#################################################

RecuperaSprite:
	li 	t0, 0xFF0 			# carrega 0xFF0 em t0
	add 	t0, t0, a3 			# adiciona o frame ao FF0 (se o frame for 1 vira FF1,  se for 0 fica FF0)
	slli 	t0, t0, 20 			# shift de 20 bits pra esquerda (0xFF0 vira 0xFF000000,  0xFF1 vira 0xFF100000)
	add 	t0, t0, a1 			# adiciona x ao t0
	li 	t1, 320 			# t1 = 320
	mul 	t1, t1, a2 			# multiplica y por t1
	add 	t0, t0, t1 			# coloca o valor final do calculo do endereco em t0
	mv	t5, a5				# move o valor de y maximo para t5
	mv	t4, a4				# move o valor de x maximo para t4 
	mv	t2, zero			# inicializa o contador de linhas em t2
	mv	t3, zero			# inicializa o contador de colunas em t3
LoopRecuperaSprite:
	addi	a6, a6, -4			# decrementa o valor do endereco da pilha ja
	lw	t1, 0(a6) 			# carrega a word que foi salva na pilha
	sw 	t1, 0(t0) 			# imprime no bitmap a word (4 pixeis) que foi salva na pilha
	addi 	t0, t0, 4			# incrementa endereco do bitmap
	addi	t3, t3, 4			# incrementa o contador de colunas em 4
	blt 	t3, t4, LoopRecuperaSprite	# se contador da coluna < largura, continue imprimindo
	addi 	t0, t0, 320 			# t0 += 320
	sub 	t0, t0, t4 			# t0 -= largura da imagem
	mv 	t3, zero			# zera t3 (contador de coluna)
	addi 	t2, t2, 1			# incrementa o contador de linhas em 1
	bgt 	t5, t2, LoopRecuperaSprite 	# se altura > contador de linha, continue imprimindo
FimRecupera:
	ret					# retorna para a funcao chamadora
