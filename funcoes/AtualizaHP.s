#########################################################
#	esta funcao imprime a sprite da barra		#
#	de vida de acordo com o HP do personagem	#
#########################################################
#	- Inputs - 					#
#	a0 = dano					#
#	a1 = qual barra deve ser atualizada (0 ou 1)	#
#	s2 = HP atual					#
######################################################### 
#	- Variavel interna -				#
#	a2 = 1 => barra sera diminuida			#
#########################################################

AtualizaHP:
	addi	sp, sp, -4
	sw	ra, 0(sp)
	
	bgeu	a0, s2, Morreu	# dano > vida restante => morreu
	j	FimAtualizaHP
Morreu: mv	a0, s2		# dano = HP restante
FimAtualizaHP:
	li	a2, 1
	call 	PrintHP
	
	li	t1, 10
	slt	t1, s2, t1	# vida anterior < 10 ? t1=1 : t1=0
	
	sub	a0, s2, a0	# a0 = vida anterior - dano
	li	t0, 10
	slt	t0, a0, t0	# a0 < 10 ? t0=1 : t0=0

	li	a2, 184		# y
	beqz	a1, HPesquerdo
	li	a1, 284		# x direito
	j	pulaHPesquerdo
HPesquerdo:
	li	a1, 24		# x esquerdo
pulaHPesquerdo:
	li	a3, 16		# largura
	li	a4, 8		# altura
	call	CobreMensagem	# cobre o valor antigo

	li	a3, 0x0000ff00	# cor
	li	a4, 0		# frame
	call	printInt	# imprime a quantidade de HP
	
	lw	ra, 0(sp)
	addi 	sp, sp, 4
	ret
