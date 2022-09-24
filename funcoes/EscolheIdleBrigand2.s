#################################################
#	Escolhe moveset a partir 		#
#     de informacoes guardadas na label		#
#    associada a esse determinado personagem	#
#    e depois guarda na pilha para recuperar 	#
#################################################
#	Argumentos:				#	
#	Nada					#
#################################################
#	Retorno:				#
#	Nada					#
#################################################

EscolheIdleBrigand2:
	la	t0, Brigand2			# carrega a posicao do personagem 1 em t0
	lw	t1, 16(t0)			# carrega o conteudo do endereco em t0+8 (indicador de moveset) em t1
	beqz	t1, StandByBrigand2		# se t1 for igual a zero pula para StandByBrigand2 
	li	t2, 1				# carrega 1 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaBrigand2S	# se t1 for igual a t2 pula para MovimentaBrigand2S
	li	t2, 2				# carrega 2 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaBrigand2E	# se t1 for igual a t2 pula para MovimentaBrigand2E
	li	t2, 3				# carrega 3 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaBrigand2E	# se t1 for igual a t2 pula para MovimentaBrigand2E
	li	t2, 4				# carrega 4 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaBrigand2N	# se t1 for igual a t2 pula para MovimentaBrigand2N
	#j	StandByBrigand2Gray		# pula para a StandByBrigand2Gray
	# Se formos colocar morte teriamos que mudar duas linhas de codigo a de cima e acrescentar mais uma
	# possibilidade
StandByBrigand2:
	li	t0, 3 				# carrego 3 em t0 para fazer o resto de s0 / 3
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleBrigand21		# se t1 nao for igual a zero pula para PulaIdleBrigand21
	la	t1, Brigand1StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 8(sp)			# salva o conteudo do registrador t1 na pilha (8+sp)	
	j	FimEscolheIdleBrigand2		# pula pra FimEscolheIdleBrigand2
PulaIdleBrigand21:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleBrigand22	# se t1 for nao igual a t0 pula para PulaIdleBrigand22
	la	t1, Brigand2StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 8(sp)			# salva o conteudo do registrador t1 na pilha (8+sp)
	j	FimEscolheIdleBrigand2		# pula pra FimEscolheIdleBrigand2
PulaIdleBrigand22:
	la	t1, Brigand3StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 8(sp)			# salva o conteudo do registrador t1 na pilha (8+sp)
	j	FimEscolheIdleBrigand2		# pula pra FimEscolheIdleBrigand2
StandByBrigand2Gray:

	# implementar depois que eu fizer a movimentacao #
	li	a7,  10
	ecall
	##################################################
	
MovimentaBrigand2S:
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleBrigand24		# Se t1 nao for igual a zero pula para PulaIdleBrigand24
	la	t1, Brigand1MovimentaS		# Carrega o endereco da imagem para salvar na pilha
	sw	t1, 8(sp)			# Salva o conteudo do registrador t1 na pilha (8+sp)
	j	FimEscolheIdleBrigand2		# Pula pra FimEscolheIdleBrigand2
PulaIdleBrigand24:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleBrigand25	# se t1 for nao igual a t0 pula para PulaIdleBrigand25
	la	t1, Brigand2MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 8(sp)			# salva o conteudo do registrador t1 na pilha (8+sp)
	j	FimEscolheIdleBrigand2		# pula pra FimEscolheIdleBrigand2
PulaIdleBrigand25:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleBrigand26		# se t1 for nao igual a t0 pula para PulaIdleBrigand26
	la	t1, Brigand3MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 8(sp)			# salva o conteudo do registrador t1 na pilha (8+sp)
	j	FimEscolheIdleBrigand2		# pula pra FimEscolheIdleBrigand2
PulaIdleBrigand26:
	la	t1, Brigand2MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 8(sp)			# salva o conteudo do registrador t1 na pilha (8+sp)
	j	FimEscolheIdleBrigand2		# pula pra FimEscolheIdleBrigand2
MovimentaBrigand2E:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleBrigand27		# se t1 nao for igual a zero pula para PulaIdleBrigand27
	la	t1, Brigand1MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 8(sp)			# salva o conteudo do registrador t1 na pilha (8+sp)
	j	FimEscolheIdleBrigand2		# pula pra FimEscolheIdleBrigand2
PulaIdleBrigand27:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleBrigand28	# se t1 for nao igual a t0 pula para PulaIdleBrigand28
	la	t1, Brigand2MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 8(sp)			# salva o conteudo do registrador t1 na pilha (8+sp)
	j	FimEscolheIdleBrigand2		# pula pra FimEscolheIdleBrigand2
PulaIdleBrigand28:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleBrigand29		# se t1 for nao igual a t0 pula para PulaIdleBrigand29
	la	t1, Brigand3MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 8(sp)			# salva o conteudo do registrador t1 na pilha (8+sp)
	j	FimEscolheIdleBrigand2		# pula pra FimEscolheIdleBrigand2
PulaIdleBrigand29:
	la	a0, Brigand2MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 8(sp)			# salva o conteudo do registrador t1 na pilha (8+sp)
	j 	FimEscolheIdleBrigand2		# pula pra FimEscolheIdleBrigand2
MovimentaBrigand2N:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleBrigand210		# se t1 nao for igual a zero pula para PulaIdleBrigand210
	la	a0, Brigand1MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 8(sp)			# salva o conteudo do registrador t1 na pilha (8+sp)
	j	FimEscolheIdleBrigand2		# pula pra FimEscolheIdleBrigand2
PulaIdleBrigand210:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleBrigand211	# se t1 for nao igual a t0 pula para PulaIdleBrigand211
	la	t1, Brigand2MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 8(sp)			# salva o conteudo do registrador t1 na pilha (8+sp)
	j	FimEscolheIdleBrigand2		# pula pra FimEscolheIdleBrigand2
PulaIdleBrigand211:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleBrigand212	# se t1 for nao igual a t0 pula para PulaIdleBrigand212
	la	t1, Brigand3MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 8(sp)			# salva o conteudo do registrador t1 na pilha (8+sp)
	j	FimEscolheIdleBrigand2		# pula pra FimEscolheIdleBrigand2
PulaIdleBrigand212:
	la	t1, Brigand2MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 8(sp)			# salva o conteudo do registrador t1 na pilha (8+sp)
FimEscolheIdleBrigand2:
	ret					# Retorna para a funcao chamadora
