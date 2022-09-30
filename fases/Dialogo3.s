Dialogo3:
	addi	sp, sp, -4
	sw	ra, 0(sp)
	li 	a1, 0	
	li	a2, 0	
	li	a4, 20
	li	a5, 15
	call	ClearScreen		# imprime a tela jogavel em ambas as frames

	la	a0, fala9		# fala do personagem da esquerda
	la	a1, fala10		# fala do personagem da direita
	la	a2, mugshot_Carol
	la	a3, mugshot_Lyn
	call	Dialogo			# imprime o dialogo de forma interativa

	# segundo par de falas (ainda com mesmos mugshots, e, a principio, fundo)
	la	a3, mugshot_JuLynete	# mugshot do personagem da direita
	la	a0, fala11		# fala do personagem da esquerda
	la	a1, fala12		# fala do personagem da direita
	call	Dialogo			# imprime o dialogo de forma interativa
	
	lw	ra, 0(sp)
	addi	sp, sp, 4
	ret
