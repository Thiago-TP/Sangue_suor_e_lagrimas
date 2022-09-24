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

EscolheIdleDart:
	la	t0, Dart			# carrega a posicao do personagem 1 em t0
	lw	t1, 16(t0)			# carrega o conteudo do endereco em t0+8 (indicador de moveset) em t1
	beqz	t1, StandByDart			# se t1 for igual a zero pula para StandByDart 
	li	t2, 1				# carrega 1 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaDartS		# se t1 for igual a t2 pula para MovimentaDartS
	li	t2, 2				# carrega 2 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaDartE		# se t1 for igual a t2 pula para MovimentaDartE
	li	t2, 3				# carrega 3 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaDartE		# se t1 for igual a t2 pula para MovimentaDartE
	li	t2, 4				# carrega 4 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaDartN		# se t1 for igual a t2 pula para MovimentaDartN
	#j	StandByDartGray			# pula para a StandByDartGray
	# Se formos colocar morte teriamos que mudar duas linhas de codigo a de cima e acrescentar mais uma
	# possibilidade
StandByDart:
	li	t0, 3 				# carrego 3 em t0 para fazer o resto de s0 / 3
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleDart1		# se t1 nao for igual a zero pula para PulaIdleDart1
	la	t1, Dart1StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 12(sp)			# salva o conteudo do registrador t1 na pilha (12+sp)	
	j	FimEscolheIdleDart		# pula pra FimEscolheIdleDart
PulaIdleDart1:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleDart2		# se t1 for nao igual a t0 pula para PulaIdleDart2
	la	t1, Dart2StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 12(sp)			# salva o conteudo do registrador t1 na pilha (12+sp)
	j	FimEscolheIdleDart		# pula pra FimEscolheIdleDart
PulaIdleDart2:
	la	t1, Dart3StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 12(sp)			# salva o conteudo do registrador t1 na pilha (12+sp)
	j	FimEscolheIdleDart		# pula pra FimEscolheIdleDart
StandByDartGray:

	# implementar depois que eu fizer a movimentacao #
	li	a7,  10
	ecall
	##################################################
	
MovimentaDartS:
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleDart4		# Se t1 nao for igual a zero pula para PulaIdleDart4
	la	t1, Dart1MovimentaS		# Carrega o endereco da imagem para salvar na pilha
	sw	t1, 12(sp)			# Salva o conteudo do registrador t1 na pilha (12+sp)
	j	FimEscolheIdleDart		# Pula pra FimEscolheIdleDart
PulaIdleDart4:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleDart5		# se t1 for nao igual a t0 pula para PulaIdleDart5
	la	t1, Dart2MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 12(sp)			# salva o conteudo do registrador t1 na pilha (12+sp)
	j	FimEscolheIdleDart		# pula pra FimEscolheIdleDart
PulaIdleDart5:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleDart6		# se t1 for nao igual a t0 pula para PulaIdleDart6
	la	t1, Dart3MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 12(sp)			# salva o conteudo do registrador t1 na pilha (12+sp)
	j	FimEscolheIdleDart		# pula pra FimEscolheIdleDart
PulaIdleDart6:
	la	t1, Dart4MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 12(sp)			# salva o conteudo do registrador t1 na pilha (12+sp)
	j	FimEscolheIdleDart		# pula pra FimEscolheIdleDart
MovimentaDartE:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleDart7		# se t1 nao for igual a zero pula para PulaIdleDart7
	la	t1, Dart1MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 12(sp)			# salva o conteudo do registrador t1 na pilha (12+sp)
	j	FimEscolheIdleDart		# pula pra FimEscolheIdleDart
PulaIdleDart7:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleDart8		# se t1 for nao igual a t0 pula para PulaIdleDart8
	la	t1, Dart2MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 12(sp)			# salva o conteudo do registrador t1 na pilha (12+sp)
	j	FimEscolheIdleDart		# pula pra FimEscolheIdleDart
PulaIdleDart8:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleDart9		# se t1 for nao igual a t0 pula para PulaIdleDart9
	la	t1, Dart3MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 12(sp)			# salva o conteudo do registrador t1 na pilha (12+sp)
	j	FimEscolheIdleDart		# pula pra FimEscolheIdleDart
PulaIdleDart9:
	la	a0, Dart2MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 12(sp)			# salva o conteudo do registrador t1 na pilha (12+sp)
	j 	FimEscolheIdleDart		# pula pra FimEscolheIdleDart
MovimentaDartN:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleDart10		# se t1 nao for igual a zero pula para PulaIdleDart10
	la	a0, Dart1MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 12(sp)			# salva o conteudo do registrador t1 na pilha (12+sp)
	j	FimEscolheIdleDart		# pula pra FimEscolheIdleDart
PulaIdleDart10:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleDart11		# se t1 for nao igual a t0 pula para PulaIdleDart11
	la	t1, Dart2MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 12(sp)			# salva o conteudo do registrador t1 na pilha (12+sp)
	j	FimEscolheIdleDart		# pula pra FimEscolheIdleDart
PulaIdleDart11:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleDart12		# se t1 for nao igual a t0 pula para PulaIdleDart20
	la	t1, Dart3MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 12(sp)			# salva o conteudo do registrador t1 na pilha (12+sp)
	j	FimEscolheIdleDart		# pula pra FimEscolheIdleDart
PulaIdleDart12:
	la	t1, Dart4MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 12(sp)			# salva o conteudo do registrador t1 na pilha (12+sp)
FimEscolheIdleDart:
	ret					# Retorna para a funcao chamadora
