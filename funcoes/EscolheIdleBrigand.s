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

EscolheIdleBrigand:
	la	t0, Brigand			# carrega a posicao do personagem 1 em t0
	lw	t1, 16(t0)			# carrega o conteudo do endereco em t0+8 (indicador de moveset) em t1
	beqz	t1, StandByBrigand		# se t1 for igual a zero pula para StandByBrigand 
	li	t2, 1				# carrega 1 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaBrigandS	# se t1 for igual a t2 pula para MovimentaBrigandS
	li	t2, 2				# carrega 2 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaBrigandE	# se t1 for igual a t2 pula para MovimentaBrigandE
	li	t2, 3				# carrega 3 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaBrigandE	# se t1 for igual a t2 pula para MovimentaBrigandE
	li	t2, 4				# carrega 4 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaBrigandN	# se t1 for igual a t2 pula para MovimentaBrigandN
	#j	StandByBrigandGray		# pula para a StandByBrigandGray
	# Se formos colocar morte teriamos que mudar duas linhas de codigo a de cima e acrescentar mais uma
	# possibilidade
StandByBrigand:
	li	t0, 3 				# carrego 3 em t0 para fazer o resto de s0 / 3
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleBrigand1		# se t1 nao for igual a zero pula para PulaIdleBrigand1
	la	t1, Brigand1StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 32(sp)			# salva o conteudo do registrador t1 na pilha (32+sp)	
	j	FimEscolheIdleBrigand		# pula pra FimEscolheIdleBrigand
PulaIdleBrigand1:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleBrigand2	# se t1 for nao igual a t0 pula para PulaIdleBrigand2
	la	t1, Brigand2StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 32(sp)			# salva o conteudo do registrador t1 na pilha (32+sp)
	j	FimEscolheIdleBrigand		# pula pra FimEscolheIdleBrigand
PulaIdleBrigand2:
	la	t1, Brigand3StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 32(sp)			# salva o conteudo do registrador t1 na pilha (32+sp)
	j	FimEscolheIdleBrigand		# pula pra FimEscolheIdleBrigand
StandByBrigandGray:

	# implementar depois que eu fizer a movimentacao #
	li	a7,  10
	ecall
	##################################################
	
MovimentaBrigandS:
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleBrigand4		# Se t1 nao for igual a zero pula para PulaIdleBrigand4
	la	t1, Brigand1MovimentaS		# Carrega o endereco da imagem para salvar na pilha
	sw	t1, 32(sp)			# Salva o conteudo do registrador t1 na pilha (32+sp)
	j	FimEscolheIdleBrigand		# Pula pra FimEscolheIdleBrigand
PulaIdleBrigand4:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleBrigand5	# se t1 for nao igual a t0 pula para PulaIdleBrigand5
	la	t1, Brigand2MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 32(sp)			# salva o conteudo do registrador t1 na pilha (32+sp)
	j	FimEscolheIdleBrigand		# pula pra FimEscolheIdleBrigand
PulaIdleBrigand5:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleBrigand6		# se t1 for nao igual a t0 pula para PulaIdleBrigand6
	la	t1, Brigand3MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 32(sp)			# salva o conteudo do registrador t1 na pilha (32+sp)
	j	FimEscolheIdleBrigand		# pula pra FimEscolheIdleBrigand
PulaIdleBrigand6:
	la	t1, Brigand2MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 32(sp)			# salva o conteudo do registrador t1 na pilha (32+sp)
	j	FimEscolheIdleBrigand		# pula pra FimEscolheIdleBrigand
MovimentaBrigandE:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleBrigand7		# se t1 nao for igual a zero pula para PulaIdleBrigand7
	la	t1, Brigand1MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 32(sp)			# salva o conteudo do registrador t1 na pilha (32+sp)
	j	FimEscolheIdleBrigand		# pula pra FimEscolheIdleBrigand
PulaIdleBrigand7:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleBrigand8	# se t1 for nao igual a t0 pula para PulaIdleBrigand8
	la	t1, Brigand2MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 32(sp)			# salva o conteudo do registrador t1 na pilha (32+sp)
	j	FimEscolheIdleBrigand		# pula pra FimEscolheIdleBrigand
PulaIdleBrigand8:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleBrigand9		# se t1 for nao igual a t0 pula para PulaIdleBrigand9
	la	t1, Brigand3MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 32(sp)			# salva o conteudo do registrador t1 na pilha (32+sp)
	j	FimEscolheIdleBrigand		# pula pra FimEscolheIdleBrigand
PulaIdleBrigand9:
	la	a0, Brigand2MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 32(sp)			# salva o conteudo do registrador t1 na pilha (32+sp)
	j 	FimEscolheIdleBrigand		# pula pra FimEscolheIdleBrigand
MovimentaBrigandN:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleBrigand10		# se t1 nao for igual a zero pula para PulaIdleBrigand10
	la	a0, Brigand1MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 32(sp)			# salva o conteudo do registrador t1 na pilha (32+sp)
	j	FimEscolheIdleBrigand		# pula pra FimEscolheIdleBrigand
PulaIdleBrigand10:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleBrigand11	# se t1 for nao igual a t0 pula para PulaIdleBrigand11
	la	t1, Brigand2MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 32(sp)			# salva o conteudo do registrador t1 na pilha (32+sp)
	j	FimEscolheIdleBrigand		# pula pra FimEscolheIdleBrigand
PulaIdleBrigand11:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleBrigand12	# se t1 for nao igual a t0 pula para PulaIdleBrigand12
	la	t1, Brigand3MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 32(sp)			# salva o conteudo do registrador t1 na pilha (32+sp)
	j	FimEscolheIdleBrigand		# pula pra FimEscolheIdleBrigand
PulaIdleBrigand12:
	la	t1, Brigand2MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 32(sp)			# salva o conteudo do registrador t1 na pilha (32+sp)
FimEscolheIdleBrigand:
	ret					# Retorna para a funcao chamadora
