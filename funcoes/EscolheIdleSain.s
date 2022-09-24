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

EscolheIdleSain:
	la	t0, Sain				# carrega a posicao do personagem 1 em t0
	lw	t1, 16(t0)			# carrega o conteudo do endereco em t0+8 (indicador de moveset) em t1
	beqz	t1, StandBySain			# se t1 for igual a zero pula para StandBySain 
	li	t2, 1				# carrega 1 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaSainS		# se t1 for igual a t2 pula para MovimentaSainS
	li	t2, 2				# carrega 2 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaSainE		# se t1 for igual a t2 pula para MovimentaSainE
	li	t2, 3				# carrega 3 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaSainE		# se t1 for igual a t2 pula para MovimentaSainE
	li	t2, 4				# carrega 4 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaSainN		# se t1 for igual a t2 pula para MovimentaSainN
	#j	StandBySainGray			# pula para a StandBySainGray
	# Se formos colocar morte teriamos que mudar duas linhas de codigo a de cima e acrescentar mais uma
	# possibilidade
StandBySain:
	li	t0, 3 				# carrego 3 em t0 para fazer o resto de s0 / 3
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleSain1		# se t1 nao for igual a zero pula para PulaIdleSain1
	la	t1, Sain1StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 4(sp)			# salva o conteudo do registrador t1 na pilha (4+sp)	
	j	FimEscolheIdleSain		# pula pra FimEscolheIdleSain
PulaIdleSain1:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleSain2		# se t1 for nao igual a t0 pula para PulaIdleSain2
	la	t1, Sain2StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 4(sp)			# salva o conteudo do registrador t1 na pilha (4+sp)
	j	FimEscolheIdleSain		# pula pra FimEscolheIdleSain
PulaIdleSain2:
	la	t1, Sain3StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 4(sp)			# salva o conteudo do registrador t1 na pilha (4+sp)
	j	FimEscolheIdleSain		# pula pra FimEscolheIdleSain
StandBySainGray:

	# implementar depois que eu fizer a movimentacao #
	li	a7,  10
	ecall
	##################################################
	
MovimentaSainS:
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleSain4		# Se t1 nao for igual a zero pula para PulaIdleSain4
	la	t1, Sain1MovimentaS		# Carrega o endereco da imagem para salvar na pilha
	sw	t1, 4(sp)			# Salva o conteudo do registrador t1 na pilha (4+sp)
	j	FimEscolheIdleSain		# Pula pra FimEscolheIdleSain
PulaIdleSain4:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleSain5		# se t1 for nao igual a t0 pula para PulaIdleSain5
	la	t1, Sain2MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 4(sp)			# salva o conteudo do registrador t1 na pilha (4+sp)
	j	FimEscolheIdleSain		# pula pra FimEscolheIdleSain
PulaIdleSain5:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleSain6		# se t1 for nao igual a t0 pula para PulaIdleSain6
	la	t1, Sain3MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 4(sp)			# salva o conteudo do registrador t1 na pilha (4+sp)
	j	FimEscolheIdleSain		# pula pra FimEscolheIdleSain
PulaIdleSain6:
	la	t1, Sain2MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 4(sp)			# salva o conteudo do registrador t1 na pilha (4+sp)
	j	FimEscolheIdleSain		# pula pra FimEscolheIdleSain
MovimentaSainE:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleSain7		# se t1 nao for igual a zero pula para PulaIdleSain7
	la	t1, Sain1MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 4(sp)			# salva o conteudo do registrador t1 na pilha (4+sp)
	j	FimEscolheIdleSain		# pula pra FimEscolheIdleSain
PulaIdleSain7:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleSain8		# se t1 for nao igual a t0 pula para PulaIdleSain8
	la	t1, Sain2MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 4(sp)			# salva o conteudo do registrador t1 na pilha (4+sp)
	j	FimEscolheIdleSain		# pula pra FimEscolheIdleSain
PulaIdleSain8:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleSain9		# se t1 for nao igual a t0 pula para PulaIdleSain9
	la	t1, Sain3MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 4(sp)			# salva o conteudo do registrador t1 na pilha (4+sp)
	j	FimEscolheIdleSain		# pula pra FimEscolheIdleSain
PulaIdleSain9:
	la	a0, Sain2MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 4(sp)			# salva o conteudo do registrador t1 na pilha (4+sp)
	j 	FimEscolheIdleSain		# pula pra FimEscolheIdleSain
MovimentaSainN:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleSain10		# se t1 nao for igual a zero pula para PulaIdleSain10
	la	a0, Sain1MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 4(sp)			# salva o conteudo do registrador t1 na pilha (4+sp)
	j	FimEscolheIdleSain		# pula pra FimEscolheIdleSain
PulaIdleSain10:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleSain11		# se t1 for nao igual a t0 pula para PulaIdleSain11
	la	t1, Sain2MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 4(sp)			# salva o conteudo do registrador t1 na pilha (4+sp)
	j	FimEscolheIdleSain		# pula pra FimEscolheIdleSain
PulaIdleSain11:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleSain12		# se t1 for nao igual a t0 pula para PulaIdleSain12
	la	t1, Sain3MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 4(sp)			# salva o conteudo do registrador t1 na pilha (4+sp)
	j	FimEscolheIdleSain		# pula pra FimEscolheIdleSain
PulaIdleSain12:
	la	t1, Sain2MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 4(sp)			# salva o conteudo do registrador t1 na pilha (4+sp)
FimEscolheIdleSain:
	ret					# Retorna para a funcao chamadora
