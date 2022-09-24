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

EscolheIdleSoldier:
	la	t0, Soldier			# carrega a posicao do personagem 1 em t0
	lw	t1, 16(t0)			# carrega o conteudo do endereco em t0+8 (indicador de moveset) em t1
	beqz	t1, StandByLanca		# se t1 for igual a zero pula para StandByLanca 
	li	t2, 1				# carrega 1 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaLancaS		# se t1 for igual a t2 pula para MovimentaLancaS
	li	t2, 2				# carrega 2 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaLancaE		# se t1 for igual a t2 pula para MovimentaLancaE
	li	t2, 3				# carrega 3 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaLancaE		# se t1 for igual a t2 pula para MovimentaLancaE
	li	t2, 4				# carrega 4 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaLancaN		# se t1 for igual a t2 pula para MovimentaLancaN
	j	StandByLancaGray		# pula para a StandByLancaGray
	# Se formos colocar morte teriamos que mudar duas linhas de codigo a de cima e acrescentar mais uma
	# possibilidade
StandByLanca:
	li	t0, 3 				# carrego 3 em t0 para fazer o resto de s0 / 3
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleLanca1		# se t1 nao for igual a zero pula para PulaIdleLanca1
	la	t1, Lanca1StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 24(sp)			# salva o conteudo do registrador t1 na pilha (24+sp)
	j	FimEscolheIdleLanca		# pula pra FimEscolheIdleLanca
PulaIdleLanca1:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLanca2		# se t1 for nao igual a t0 pula para PulaIdleLanca2
	la	t1, Lanca2StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 24(sp)			# salva o conteudo do registrador t1 na pilha (24+sp)
	j	FimEscolheIdleLanca		# pula pra FimEscolheIdleLanca
PulaIdleLanca2:
	la	t1, Lanca3StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 24(sp)			# salva o conteudo do registrador t1 na pilha (24+sp)
	j	FimEscolheIdleLanca		# pula pra FimEscolheIdleLanca
StandByLancaGray:

	# implementar depois que eu fizer a movimentacao #
	li	a7,  10
	ecall
	##################################################
	
MovimentaLancaS:
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleLanca4		# Se t1 nao for igual a zero pula para PulaIdleLanca4
	la	t1, Lanca1MovimentaS		# Carrega o endereco da imagem para salvar na pilha
	sw	t1, 24(sp)			# Salva o conteudo do registrador t1 na pilha (24+sp)
	j	FimEscolheIdleLanca		# Pula pra FimEscolheIdleLanca
PulaIdleLanca4:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLanca5		# se t1 for nao igual a t0 pula para PulaIdleLanca5
	la	t1, Lanca2MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 24(sp)			# salva o conteudo do registrador t1 na pilha (24+sp)
	j	FimEscolheIdleLanca		# pula pra FimEscolheIdleLanca
PulaIdleLanca5:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLanca6		# se t1 for nao igual a t0 pula para PulaIdleLanca6
	la	t1, Lanca3MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 24(sp)			# salva o conteudo do registrador t1 na pilha (24+sp)
	j	FimEscolheIdleLanca		# pula pra FimEscolheIdleLanca
PulaIdleLanca6:
	la	t1, Lanca4MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 24(sp)			# salva o conteudo do registrador t1 na pilha (24+sp)
	j	FimEscolheIdleLanca		# pula pra FimEscolheIdleLanca
MovimentaLancaE:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleLanca7		# se t1 nao for igual a zero pula para PulaIdleLanca7
	la	t1, Lanca1MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 24(sp)			# salva o conteudo do registrador t1 na pilha (24+sp)
	j	FimEscolheIdleLanca		# pula pra FimEscolheIdleLanca
PulaIdleLanca7:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLanca8		# se t1 for nao igual a t0 pula para PulaIdleLanca8
	la	t1, Lanca2MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 24(sp)			# salva o conteudo do registrador t1 na pilha (24+sp)
	j	FimEscolheIdleLanca		# pula pra FimEscolheIdleLanca
PulaIdleLanca8:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLanca9		# se t1 for nao igual a t0 pula para PulaIdleLanca9
	la	t1, Lanca3MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 24(sp)			# salva o conteudo do registrador t1 na pilha (24+sp)
	j	FimEscolheIdleLanca		# pula pra FimEscolheIdleLanca
PulaIdleLanca9:
	la	a0, Lanca1MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 24(sp)			# salva o conteudo do registrador t1 na pilha (24+sp)
	j 	FimEscolheIdleLanca		# pula pra FimEscolheIdleLanca
MovimentaLancaN:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleLanca10		# se t1 nao for igual a zero pula para PulaIdleLanca10
	la	a0, Lanca1MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 24(sp)			# salva o conteudo do registrador t1 na pilha (24+sp)
	j	FimEscolheIdleLanca		# pula pra FimEscolheIdleLanca
PulaIdleLanca10:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLanca11		# se t1 for nao igual a t0 pula para PulaIdleLanca11
	la	t1, Lanca2MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 24(sp)			# salva o conteudo do registrador t1 na pilha (24+sp)
	j	FimEscolheIdleLanca		# pula pra FimEscolheIdleLanca
PulaIdleLanca11:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLanca12		# se t1 for nao igual a t0 pula para PulaIdleLanca12
	la	t1, Lanca3MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 24(sp)			# salva o conteudo do registrador t1 na pilha (24+sp)
	j	FimEscolheIdleLanca		# pula pra FimEscolheIdleLanca
PulaIdleLanca12:
	la	t1, Lanca4MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 24(sp)			# salva o conteudo do registrador t1 na pilha (24+sp)
FimEscolheIdleLanca:
	ret					# Retorna para a funcao chamadora
