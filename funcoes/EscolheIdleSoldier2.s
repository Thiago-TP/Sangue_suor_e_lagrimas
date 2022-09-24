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

EscolheIdleSoldier2:
	la	t0, Soldier2			# carrega a posicao do personagem 1 em t0
	lw	t1, 16(t0)			# carrega o conteudo do endereco em t0+8 (indicador de moveset) em t1
	beqz	t1, StandByLanca2		# se t1 for igual a zero pula para StandByLanca2 
	li	t2, 1				# carrega 1 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaLanca2S	# se t1 for igual a t2 pula para MovimentaLanca2S
	li	t2, 2				# carrega 2 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaLanca2E	# se t1 for igual a t2 pula para MovimentaLanca2E
	li	t2, 3				# carrega 3 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaLanca2E	# se t1 for igual a t2 pula para MovimentaLanca2E
	li	t2, 4				# carrega 4 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaLanca2N	# se t1 for igual a t2 pula para MovimentaLanca2N
	#j	StandByLanca2Gray		# pula para a StandByLanca2Gray
	# Se formos colocar morte teriamos que mudar duas linhas de codigo a de cima e acrescentar mais uma
	# possibilidade
StandByLanca2:
	li	t0, 3 				# carrego 3 em t0 para fazer o resto de s0 / 3
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleLanca21		# se t1 nao for igual a zero pula para PulaIdleLanca21
	la	t1, Lanca1StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 0(sp)			# salva o conteudo do registrador t1 na pilha (0+sp)	
	j	FimEscolheIdleLanca2		# pula pra FimEscolheIdleLanca2
PulaIdleLanca21:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLanca22	# se t1 for nao igual a t0 pula para PulaIdleLanca22
	la	t1, Lanca2StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 0(sp)			# salva o conteudo do registrador t1 na pilha (0+sp)
	j	FimEscolheIdleLanca2		# pula pra FimEscolheIdleLanca2
PulaIdleLanca22:
	la	t1, Lanca3StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 0(sp)			# salva o conteudo do registrador t1 na pilha (0+sp)
	j	FimEscolheIdleLanca2		# pula pra FimEscolheIdleLanca2
StandByLanca2Gray:

	# implementar depois que eu fizer a movimentacao #
	li	a7,  10
	ecall
	##################################################
	
MovimentaLanca2S:
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleLanca24		# Se t1 nao for igual a zero pula para PulaIdleLanca24
	la	t1, Lanca1MovimentaS		# Carrega o endereco da imagem para salvar na pilha
	sw	t1, 0(sp)			# Salva o conteudo do registrador t1 na pilha (0+sp)
	j	FimEscolheIdleLanca2		# Pula pra FimEscolheIdleLanca2
PulaIdleLanca24:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLanca25	# se t1 for nao igual a t0 pula para PulaIdleLanca25
	la	t1, Lanca2MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 0(sp)			# salva o conteudo do registrador t1 na pilha (0+sp)
	j	FimEscolheIdleLanca2		# pula pra FimEscolheIdleLanca2
PulaIdleLanca25:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLanca26		# se t1 for nao igual a t0 pula para PulaIdleLanca26
	la	t1, Lanca3MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 0(sp)			# salva o conteudo do registrador t1 na pilha (0+sp)
	j	FimEscolheIdleLanca2		# pula pra FimEscolheIdleLanca2
PulaIdleLanca26:
	la	t1, Lanca2MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 0(sp)			# salva o conteudo do registrador t1 na pilha (0+sp)
	j	FimEscolheIdleLanca2		# pula pra FimEscolheIdleLanca2
MovimentaLanca2E:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleLanca27		# se t1 nao for igual a zero pula para PulaIdleLanca27
	la	t1, Lanca1MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 0(sp)			# salva o conteudo do registrador t1 na pilha (0+sp)
	j	FimEscolheIdleLanca2		# pula pra FimEscolheIdleLanca2
PulaIdleLanca27:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLanca28	# se t1 for nao igual a t0 pula para PulaIdleLanca28
	la	t1, Lanca2MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 0(sp)			# salva o conteudo do registrador t1 na pilha (0+sp)
	j	FimEscolheIdleLanca2		# pula pra FimEscolheIdleLanca2
PulaIdleLanca28:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLanca29		# se t1 for nao igual a t0 pula para PulaIdleLanca29
	la	t1, Lanca3MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 0(sp)			# salva o conteudo do registrador t1 na pilha (0+sp)
	j	FimEscolheIdleLanca2		# pula pra FimEscolheIdleLanca2
PulaIdleLanca29:
	la	a0, Lanca2MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 0(sp)			# salva o conteudo do registrador t1 na pilha (0+sp)
	j 	FimEscolheIdleLanca2		# pula pra FimEscolheIdleLanca2
MovimentaLanca2N:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleLanca210		# se t1 nao for igual a zero pula para PulaIdleLanca210
	la	a0, Lanca1MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 0(sp)			# salva o conteudo do registrador t1 na pilha (0+sp)
	j	FimEscolheIdleLanca2		# pula pra FimEscolheIdleLanca2
PulaIdleLanca210:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLanca211	# se t1 for nao igual a t0 pula para PulaIdleLanca211
	la	t1, Lanca2MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 0(sp)			# salva o conteudo do registrador t1 na pilha (0+sp)
	j	FimEscolheIdleLanca2		# pula pra FimEscolheIdleLanca2
PulaIdleLanca211:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLanca212	# se t1 for nao igual a t0 pula para PulaIdleLanca212
	la	t1, Lanca3MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 0(sp)			# salva o conteudo do registrador t1 na pilha (0+sp)
	j	FimEscolheIdleLanca2		# pula pra FimEscolheIdleLanca2
PulaIdleLanca212:
	la	t1, Lanca2MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 0(sp)			# salva o conteudo do registrador t1 na pilha (0+sp)
FimEscolheIdleLanca2:
	ret					# Retorna para a funcao chamadora
