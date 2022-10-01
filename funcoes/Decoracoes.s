Decoracoes:	
	addi	sp, sp, -4
	sw	ra, 0(sp)
	
	la	a0, quadroAzulE		# quadro azul
	li 	a1, 0
	li	a2, 194
	li	a3, 0
	call	PrintByte		# metade esquerda
	li 	a1, 80
	call	PrintByteInverso	# metade direita
	li 	a3, 1
	call	PrintByteInverso	
	
	la	a0, quadroVermE		# quadro vermelho
	li 	a1, 160
	li	a3, 0
	call	PrintByte		# metade esquerda
	li 	a3, 1
	call	PrintByte		# metade esquerda
	li	a3, 0
	li 	a1, 240
	call	PrintByteInverso	# metade direita
		
	
	la	a0, quadroMarromE	# quadro marrom do jogador
	li 	a1, 24
	li	a2, 172
	call	PrintByte		# metade esquerda
	li 	a1, 92
	call	PrintByteInverso	# metade direita
	li 	a1, 160
	call	PrintByte		# quadro marrom do pc (metade esquerda)
	li 	a1, 228
	call	PrintByteInverso	# metade direita
	
	
	lbu	a0, 22(s0)		# a0 <- n° do personagem jogavel
	call	EscolheNome
	li	a1, 32
	li	a2, 180
	li	a3, 0x0000c700		# cor
	li	a4, 0			# frame
	call	printString
	
	
	lbu	a0, 22(s1)		# a0 <- n° do personagem inimigo
	call	EscolheNome
	li	a1, 168
	call	printString
	
	lw	ra, 0(sp)
	addi	sp, sp, 4
	ret
###########################################################

EscolheNome:
	beqz	a0, stringLyn	
	li	t1, 1
	beq	a0, t1, stringBrigand	
	li	t1, 2
	beq	a0, t1, stringYogi
	li	t1, 3
	beq	a0, t1, stringSoldier
	li	t1, 4
	beq	a0, t1, stringDorcas
	li	t1, 5
	beq	a0, t1, stringAssassin
	li	t1, 6
	beq	a0, t1, stringDart
	li	t1, 7
	beq	a0, t1, stringBrigand
	li	t1, 8
	beq	a0, t1, stringSain
	
	la	a0, strSoldier
fimEscolhe:
	ret
	
stringLyn:	la	a0 strLyn
		j 	fimEscolhe	
stringBrigand:	la	a0 strBrigand
		j 	fimEscolhe		
stringYogi:	la 	a0 strYogi
		j 	fimEscolhe	
stringSoldier:	la 	a0 strSoldier
		j 	fimEscolhe	
stringDorcas:	la 	a0 strDorcas
		j 	fimEscolhe	
stringAssassin:	la 	a0 strAssassin
		j 	fimEscolhe
stringDart:	la 	a0 strDart
		j 	fimEscolhe	
stringSain:	la 	a0 strSain
		j 	fimEscolhe
	
	
	
	
	
	
	
	
	
	
	
	
	
