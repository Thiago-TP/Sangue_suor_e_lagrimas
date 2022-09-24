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

EscolheIdleYogi:
	la	t0, Yogi			# carrega a posicao do personagem 1 em t0
	lw	t1, 16(t0)			# carrega o conteudo do endereco em t0+8 (indicador de moveset) em t1
	beqz	t1, StandByKnight		# se t1 for igual a zero pula para StandByKnight 
	li	t2, 1				# carrega 1 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaKnightS	# se t1 for igual a t2 pula para MovimentaKnightS
	li	t2, 2				# carrega 2 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaKnightE	# se t1 for igual a t2 pula para MovimentaKnightE
	li	t2, 3				# carrega 3 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaKnightE	# se t1 for igual a t2 pula para MovimentaKnightE
	li	t2, 4				# carrega 4 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaKnightN	# se t1 for igual a t2 pula para MovimentaKnightN
	j	StandByKnightGray		# pula para a StandByKnightGray
	# Se formos colocar morte teriamos que mudar duas linhas de codigo a de cima e acrescentar mais uma
	# possibilidade
StandByKnight:
	li	t0, 3 				# carrego 3 em t0 para fazer o resto de s0 / 3
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleKnight1		# se t1 nao for igual a zero pula para PulaIdleKnight1
	la	t1, Knight1StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 28(sp)			# salva o conteudo do registrador t1 na pilha (28+sp)
	j	FimEscolheIdleKnight		# pula pra FimEscolheIdleKnight
PulaIdleKnight1:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleKnight2	# se t1 for nao igual a t0 pula para PulaIdleKnight2
	la	t1, Knight2StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 28(sp)			# salva o conteudo do registrador t1 na pilha (28+sp)
	j	FimEscolheIdleKnight		# pula pra FimEscolheIdleKnight
PulaIdleKnight2:
	la	t1, Knight3StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 28(sp)			# salva o conteudo do registrador t1 na pilha (28+sp)
	j	FimEscolheIdleKnight		# pula pra FimEscolheIdleKnight
StandByKnightGray:

	# implementar depois que eu fizer a movimentacao #
	li	a7,  10
	ecall
	##################################################
	
MovimentaKnightS:
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleKnight4		# Se t1 nao for igual a zero pula para PulaIdleKnight4
	la	t1, Knight1MovimentaS		# Carrega o endereco da imagem para salvar na pilha
	sw	t1, 28(sp)			# Salva o conteudo do registrador t1 na pilha (28+sp)
	j	FimEscolheIdleKnight		# Pula pra FimEscolheIdleKnight
PulaIdleKnight4:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleKnight5		# se t1 for nao igual a t0 pula para PulaIdleKnight5
	la	t1, Knight2MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 28(sp)			# salva o conteudo do registrador t1 na pilha (28+sp)
	j	FimEscolheIdleKnight		# pula pra FimEscolheIdleKnight
PulaIdleKnight5:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleKnight6		# se t1 for nao igual a t0 pula para PulaIdleKnight6
	la	t1, Knight3MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 28(sp)			# salva o conteudo do registrador t1 na pilha (28+sp)
	j	FimEscolheIdleKnight		# pula pra FimEscolheIdleKnight
PulaIdleKnight6:
	la	t1, Knight1MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 28(sp)			# salva o conteudo do registrador t1 na pilha (28+sp)
	j	FimEscolheIdleKnight		# pula pra FimEscolheIdleKnight
MovimentaKnightE:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleKnight7		# se t1 nao for igual a zero pula para PulaIdleKnight7
	la	t1, Knight1MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 28(sp)			# salva o conteudo do registrador t1 na pilha (28+sp)
	j	FimEscolheIdleKnight		# pula pra FimEscolheIdleKnight
PulaIdleKnight7:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleKnight8		# se t1 for nao igual a t0 pula para PulaIdleKnight8
	la	t1, Knight2MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 28(sp)			# salva o conteudo do registrador t1 na pilha (28+sp)
	j	FimEscolheIdleKnight		# pula pra FimEscolheIdleKnight
PulaIdleKnight8:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleKnight9		# se t1 for nao igual a t0 pula para PulaIdleKnight9
	la	t1, Knight3MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 28(sp)			# salva o conteudo do registrador t1 na pilha (28+sp)
	j	FimEscolheIdleKnight		# pula pra FimEscolheIdleKnight
PulaIdleKnight9:
	la	a0, Knight1MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 28(sp)			# salva o conteudo do registrador t1 na pilha (28+sp)
	j 	FimEscolheIdleKnight		# pula pra FimEscolheIdleKnight
MovimentaKnightN:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleKnight10		# se t1 nao for igual a zero pula para PulaIdleKnight10
	la	a0, Knight1MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 28(sp)			# salva o conteudo do registrador t1 na pilha (28+sp)
	j	FimEscolheIdleKnight		# pula pra FimEscolheIdleKnight
PulaIdleKnight10:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleKnight11	# se t1 for nao igual a t0 pula para PulaIdleKnight11
	la	t1, Knight2MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 28(sp)			# salva o conteudo do registrador t1 na pilha (28+sp)
	j	FimEscolheIdleKnight		# pula pra FimEscolheIdleKnight
PulaIdleKnight11:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleKnight12	# se t1 for nao igual a t0 pula para PulaIdleKnight12
	la	t1, Knight3MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 28(sp)			# salva o conteudo do registrador t1 na pilha (28+sp)
	j	FimEscolheIdleKnight		# pula pra FimEscolheIdleKnight
PulaIdleKnight12:
	la	t1, Knight1MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 28(sp)			# salva o conteudo do registrador t1 na pilha (28+sp)
FimEscolheIdleKnight:
	ret					# retorna para a funcao chamadora
