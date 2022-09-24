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

EscolheIdleDorcas:
	la	t0, Dorcas				# carrega a posicao do personagem 1 em t0
	lw	t1, 16(t0)			# carrega o conteudo do endereco em t0+8 (indicador de moveset) em t1
	beqz	t1, StandByDorcas			# se t1 for igual a zero pula para StandByDorcas 
	li	t2, 1				# carrega 1 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaDorcasS		# se t1 for igual a t2 pula para MovimentaDorcasS
	li	t2, 2				# carrega 2 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaDorcasE		# se t1 for igual a t2 pula para MovimentaDorcasE
	li	t2, 3				# carrega 3 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaDorcasE		# se t1 for igual a t2 pula para MovimentaDorcasE
	li	t2, 4				# carrega 4 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaDorcasN		# se t1 for igual a t2 pula para MovimentaDorcasN
	j	StandByDorcasGray			# pula para a StandByDorcasGray
	# Se formos colocar morte teriamos que mudar duas linhas de codigo a de cima e acrescentar mais uma
	# possibilidade
StandByDorcas:
	li	t0, 3 				# carrego 3 em t0 para fazer o resto de s0 / 3
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleDorcas1		# se t1 nao for igual a zero pula para PulaIdleDorcas1
	la	t1, Dorcas1StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 20(sp)			# salva o conteudo do registrador t1 na pilha (20+sp)	
	j	FimEscolheIdleDorcas		# pula pra FimEscolheIdleDorcas
PulaIdleDorcas1:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleDorcas2		# se t1 for nao igual a t0 pula para PulaIdleDorcas2
	la	t1, Dorcas2StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 20(sp)			# salva o conteudo do registrador t1 na pilha (20+sp)
	j	FimEscolheIdleDorcas		# pula pra FimEscolheIdleDorcas
PulaIdleDorcas2:
	la	t1, Dorcas3StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 20(sp)			# salva o conteudo do registrador t1 na pilha (20+sp)
	j	FimEscolheIdleDorcas		# pula pra FimEscolheIdleDorcas
StandByDorcasGray:

	# implementar depois que eu fizer a movimentacao #
	li	a7,  10
	ecall
	##################################################
	
MovimentaDorcasS:
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleDorcas4		# Se t1 nao for igual a zero pula para PulaIdleDorcas4
	la	t1, Dorcas1MovimentaS		# Carrega o endereco da imagem para salvar na pilha
	sw	t1, 20(sp)			# Salva o conteudo do registrador t1 na pilha (20+sp)
	j	FimEscolheIdleDorcas		# Pula pra FimEscolheIdleDorcas
PulaIdleDorcas4:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleDorcas5		# se t1 for nao igual a t0 pula para PulaIdleDorcas5
	la	t1, Dorcas2MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 20(sp)			# salva o conteudo do registrador t1 na pilha (20+sp)
	j	FimEscolheIdleDorcas		# pula pra FimEscolheIdleDorcas
PulaIdleDorcas5:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleDorcas6		# se t1 for nao igual a t0 pula para PulaIdleDorcas6
	la	t1, Dorcas3MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 20(sp)			# salva o conteudo do registrador t1 na pilha (20+sp)
	j	FimEscolheIdleDorcas		# pula pra FimEscolheIdleDorcas
PulaIdleDorcas6:
	la	t1, Dorcas4MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 20(sp)			# salva o conteudo do registrador t1 na pilha (20+sp)
	j	FimEscolheIdleDorcas		# pula pra FimEscolheIdleDorcas
MovimentaDorcasE:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleDorcas7		# se t1 nao for igual a zero pula para PulaIdleDorcas7
	la	t1, Dorcas1MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 20(sp)			# salva o conteudo do registrador t1 na pilha (20+sp)
	j	FimEscolheIdleDorcas		# pula pra FimEscolheIdleDorcas
PulaIdleDorcas7:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleDorcas8		# se t1 for nao igual a t0 pula para PulaIdleDorcas8
	la	t1, Dorcas2MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 20(sp)			# salva o conteudo do registrador t1 na pilha (20+sp)
	j	FimEscolheIdleDorcas		# pula pra FimEscolheIdleDorcas
PulaIdleDorcas8:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleDorcas9		# se t1 for nao igual a t0 pula para PulaIdleDorcas9
	la	t1, Dorcas3MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 20(sp)			# salva o conteudo do registrador t1 na pilha (20+sp)
	j	FimEscolheIdleDorcas		# pula pra FimEscolheIdleDorcas
PulaIdleDorcas9:
	la	a0, Dorcas2MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 20(sp)			# salva o conteudo do registrador t1 na pilha (20+sp)
	j 	FimEscolheIdleDorcas		# pula pra FimEscolheIdleDorcas
MovimentaDorcasN:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleDorcas10		# se t1 nao for igual a zero pula para PulaIdleDorcas10
	la	a0, Dorcas1MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 20(sp)			# salva o conteudo do registrador t1 na pilha (20+sp)
	j	FimEscolheIdleDorcas		# pula pra FimEscolheIdleDorcas
PulaIdleDorcas10:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleDorcas11		# se t1 for nao igual a t0 pula para PulaIdleDorcas11
	la	t1, Dorcas2MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 20(sp)			# salva o conteudo do registrador t1 na pilha (20+sp)
	j	FimEscolheIdleDorcas		# pula pra FimEscolheIdleDorcas
PulaIdleDorcas11:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleDorcas12		# se t1 for nao igual a t0 pula para PulaIdleDorcas12
	la	t1, Dorcas3MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 20(sp)			# salva o conteudo do registrador t1 na pilha (20+sp)
	j	FimEscolheIdleDorcas		# pula pra FimEscolheIdleDorcas
PulaIdleDorcas12:
	la	t1, Dorcas4MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 20(sp)			# salva o conteudo do registrador t1 na pilha (20+sp)
FimEscolheIdleDorcas:
	ret					# Retorna para a funcao chamadora
