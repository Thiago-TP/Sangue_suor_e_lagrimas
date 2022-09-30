Dialogo1:
	addi	sp, sp, -4
	sw	ra, 0(sp)
	li 	a1, 0	
	li	a2, 0	
	li	a4, 20
	li	a5, 15
	call	ClearScreen		# imprime a tela jogavel em ambas as frames

	la	a0, fala1	# fala do personagem da esquerda
	la	a1, fala2	# fala do personagem da direita
	call	Dialogo		# imprime o dialogo de forma interativa

	# segundo par de falas (ainda com mesmos mugshots, e, a principio, fundo)
	la	a0, fala3	# fala do personagem da esquerda
	la	a1, fala4	# fala do personagem da direita
	call	Dialogo		# imprime o dialogo de forma interativa
	
	lw	ra, 0(sp)
	addi	sp, sp, 4
	ret
