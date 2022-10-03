.text
#################################################
#	a0 = endereco da imagem			#
#	a1 = posicao x incial do bitmap		#
#	a2 = posicao y inicial do bitmap	#
#	a3 = frame utilizado na função	#
#	t0 = Endereco do bitmap			#
#################################################
#	a4 = flag de cinza (0 ou 1)		#
#################################################
	
PrintByte:
	addi	sp, sp, -4
	sw	ra, 0(sp)
	
	li 	t0, 0xFF0 	# carrega 0xFF0 em t0
	add 	t0, t0, a3 	# adiciona o frame ao FF0 (se o frame for 1 vira FF1, se for 0 fica FF0)
	slli 	t0, t0, 20 	# shift de 20 bits pra esquerda (0xFF0 vira 0xFF000000, 0xFF1 vira 0xFF100000)	
	add 	t0, t0, a1 	# adiciona x ao t0
	li 	t1, 320 	# t1 = 320
	mul 	t1, t1, a2 	# multiplica y por t1
	add 	t0, t0, t1 	# coloca o valor final do calculo do endereço em t0
	mv 	t1, zero 	# zera t2
	mv 	t2, zero 	# zera t3
	lw 	t3, 0(a0) 	# carrega a largura em t3
	lw 	t4, 4(a0) 	# carrega a altura em t4
	addi 	a7, a0, 8 	# salvo o endereco da imagem passada para a funcao em a0
	# ate aqui estamos no primeiro endereco da imagem e no endereço que escolhemos no bitmap
PRINT_LINHAByte:
	add	t5,a2,t1
	sltiu	t5,t5,240
	beqz	t5,PulaInteracaoByte
	add	t5,a1,t2
	sltiu	t5,t5,320
	beqz	t5,PulaInteracaoByte	
	lbu 	t5, 0(a7) 	# carrega em t6 um byte (1 pixel) da imagem	
	addi	sp, sp, -16
	sw	t0, 0(sp)
	sw	t1, 4(sp)
	sw	t2, 8(sp)
	sw	t3, 12(sp)
	li	t0, 1
	bne	a4, t0, pulaByteCinza	
	# se o pixel eh invisivel pula
	li	t0, 0x000000c7
	beq	t5, t0, pulaByteCinza
	# novo byte de cor tem R=G=B
	call	ByteCinza	
pulaByteCinza:
	lw	t0, 0(sp)
	lw	t1, 4(sp)
	lw	t2, 8(sp)
	lw	t3, 12(sp)
	addi	sp, sp, 16
	sb 	t5, 0(t0) 		# imprime no bitmap a word (4 pixeis) da imagem
PulaInteracaoByte:
	addi 	t0, t0, 1 		# incrementa endereco do bitmap
	addi 	a7, a7, 1 		# incrementa endereco da imagem
	addi 	t2, t2, 1 		# incrementa contador de coluna
	blt 	t2, t3, PRINT_LINHAByte # se contador da coluna < largura,  continue imprimindo
	addi	t0, t0, 320 		# t0 += 320
	sub 	t0, t0, t3		# t0 -= largura da imagem
	# ^ isso serve pra "pular" de linha no bitmap display
	mv 	t2, zero 		# zera t3 (contador de coluna)
	addi 	t1, t1, 1 		# incrementa contador de linha
	bgt 	t4, t1, PRINT_LINHAByte # se altura > contador de linha, continue imprimindo	
	
	lw	ra, 0(sp)
	addi	sp, sp, 4
	ret 				# retorna
	
#################################################################



#################################################
#	Esta funcao recebe um byte de cor e 	#
#	retorna a versao cinza desse byte	#
#################################################
#	- Inputs -				#
#	t5 = bbgggrrr				#
#################################################
#	- Outputs -				#
#	t5 = byte cinza (R=G=B=media[R,G,B])	#
#################################################
#	- Variaveis internas			#
#################################################
ByteCinza:	
	addi 	sp, sp, -4
	sw	ra, 0(sp)
	
	jal	byte2RGB	# t0 <- R, t1 <- G, t2 <- B
	
	add	t0, t0, t1	# t0 <- R + G
	add	t0, t0, t2	# t0 <- R + G + B
	li	t1, 3		# t1 = 3
	divu	t0, t0, t1	# t0 <- media[R,G,B]
	mv	t1, t0		# t1 <- G=R=media
	mv	t2, t0		# t2 <- B=R=media
	
	jal	RGB2byte	# t5 <- versao cinza do byte original
	
	lw	ra, 0(sp)
	addi	sp, sp, 4
	ret			# retorno por pseudo

#################################################
#	Esta funcao cria o byte de cor a	#
#	partir do valor RGB correspondente	#
#################################################
#	- Inputs -		#
#	RGB = (R, G, B)		#
#	t0 = R			#
#	t1 = G			#
#	t2 = B			#
#################################
#	- Outputs -		#
#	t5 = bbgggrrr		#
#################################
#	- Variaveis internas	#
#	t3 = divisor		#
#################################
RGB2byte:
	# bits de vermelho
	li	t3, 32		# t3 <- 32
	divu	t0, t0, t3	# t0 <- R/32 = 0...000 rrr
	# bits de verde
	divu	t1, t1, t3	# t1 <- G/32 = 0...000 ggg
	slli	t1, t1, 3	# t1 <- 0...00 ggg000
	# bits de azul
	li	t3, 64		# t3 <- 64
	divu	t2, t2, t3	# t2 <- B/64 = 0...000 0bb
	slli	t2, t2, 6	# t2 <- 0...0 bb000000
	# montagem de t5
	add	t5, x0, t0	# t5 <- 0...0 00000rrr
	add	t5, t5, t1	# t5 <- 0...0 00gggrrr
	add	t5, t5, t2	# t5 <- 0...0 bbgggrrr
	
	ret			# retorno por pseudo

#################################################
#	Esta funcao cria o valor RGB a 		#
#	partir do byte de cor correspondente	#
#################################################
#	- Inputs -				#
#	t5 = bbgggrrr				#
#################################################
#	- Outputs -				#
#	t0 = R					#
#	t1 = G					#
#	t2 = B					#
#################################################
#	- Variaveis internas -			#
#	t3 = multiplicador			#
#################################################
byte2RGB:
	# bits de vermelho	# t5 =  bbgggrrr
	andi 	t0, t5, 0x07	# t0 <- 0000 0rrr 
	li	t3, 32		# t3 <- 32
	mul	t0, t0, t3	# t0 <- rrr*32 = R
	# bits de verde
	andi	t1, t5, 0x38	# t1 <- 00GG G000
	srli	t1, t1, 3	# t1 <- 00000ggg
	#li	t3, 32		# t0 <- 32
	mul	t1, t1, t3	# t1 <- ggg*32 = G
	# bits de azul
	srli	t2, t5, 6	# t0 <- 000000bb
	li	t3, 64		# t3 <- 64 
	mul	t2, t2, t3	# t2 <- bb*64 = B
	
	ret			# retorno por pseudo
