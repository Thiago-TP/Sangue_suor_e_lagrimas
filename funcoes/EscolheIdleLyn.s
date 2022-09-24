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

EscolheIdleLyn:
	la	t0, Lyn				# carrega a posicao do personagem 1 em t0
	lw	t1, 16(t0)			# carrega o conteudo do endereco em t0+8 (indicador de moveset) em t1
	beqz	t1, StandByLyn			# se t1 for igual a zero pula para StandByLyn 
	li	t2, 1				# carrega 1 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaLynS		# se t1 for igual a t2 pula para MovimentaLynS
	li	t2, 2				# carrega 2 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaLynE		# se t1 for igual a t2 pula para MovimentaLynE
	li	t2, 3				# carrega 3 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaLynE		# se t1 for igual a t2 pula para MovimentaLynE
	li	t2, 4				# carrega 4 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaLynN		# se t1 for igual a t2 pula para MovimentaLynN
	j	StandByLynGray			# pula para a StandByLynGray
	# Se formos colocar morte teriamos que mudar duas linhas de codigo a de cima e acrescentar mais uma
	# possibilidade
StandByLyn:
	li	t0, 3 				# carrego 3 em t0 para fazer o resto de s0 / 3
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleLyn1		# se t1 nao for igual a zero pula para PulaIdleLyn1
	la	t1, Lyn1StandBy			# carrega o endereco da imagem para salvar na pilha
	sw	t1, 36(sp)			# salva o conteudo do registrador t1 na pilha (36+sp)	
	j	FimEscolheIdleLyn		# pula pra FimEscolheIdleLyn
PulaIdleLyn1:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLyn2		# se t1 for nao igual a t0 pula para PulaIdleLyn2
	la	t1, Lyn2StandBy			# carrega o endereco da imagem para salvar na pilha
	sw	t1, 36(sp)			# salva o conteudo do registrador t1 na pilha (36+sp)
	j	FimEscolheIdleLyn		# pula pra FimEscolheIdleLyn
PulaIdleLyn2:
	la	t1, Lyn3StandBy			# carrega o endereco da imagem para salvar na pilha
	sw	t1, 36(sp)			# salva o conteudo do registrador t1 na pilha (36+sp)
	j	FimEscolheIdleLyn		# pula pra FimEscolheIdleLyn
StandByLynGray:
	# implementar depois que eu fizer a movimentacao #
	li	a7,  10
	ecall
	##################################################
	
MovimentaLynS:
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleLyn4		# Se t1 nao for igual a zero pula para PulaIdleLyn4
	la	t1, Lyn1MovimentaS		# Carrega o endereco da imagem para salvar na pilha
	sw	t1, 36(sp)			# Salva o conteudo do registrador t1 na pilha (36+sp)
	j	FimEscolheIdleLyn		# Pula pra FimEscolheIdleLyn
PulaIdleLyn4:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLyn5		# se t1 for nao igual a t0 pula para PulaIdleLyn5
	la	t1, Lyn2MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 36(sp)			# salva o conteudo do registrador t1 na pilha (36+sp)
	j	FimEscolheIdleLyn		# pula pra FimEscolheIdleLyn
PulaIdleLyn5:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLyn6		# se t1 for nao igual a t0 pula para PulaIdleLyn6
	la	t1, Lyn3MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 36(sp)			# salva o conteudo do registrador t1 na pilha (36+sp)
	j	FimEscolheIdleLyn		# pula pra FimEscolheIdleLyn
PulaIdleLyn6:
	la	t1, Lyn4MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 36(sp)			# salva o conteudo do registrador t1 na pilha (36+sp)
	j	FimEscolheIdleLyn		# pula pra FimEscolheIdleLyn
MovimentaLynE:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleLyn7		# se t1 nao for igual a zero pula para PulaIdleLyn7
	la	t1, Lyn1MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 36(sp)			# salva o conteudo do registrador t1 na pilha (36+sp)
	j	FimEscolheIdleLyn		# pula pra FimEscolheIdleLyn
PulaIdleLyn7:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLyn8		# se t1 for nao igual a t0 pula para PulaIdleLyn8
	la	t1, Lyn2MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 36(sp)			# salva o conteudo do registrador t1 na pilha (36+sp)
	j	FimEscolheIdleLyn		# pula pra FimEscolheIdleLyn
PulaIdleLyn8:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLyn9		# se t1 for nao igual a t0 pula para PulaIdleLyn9
	la	t1, Lyn3MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 36(sp)			# salva o conteudo do registrador t1 na pilha (36+sp)
	j	FimEscolheIdleLyn		# pula pra FimEscolheIdleLyn
PulaIdleLyn9:
	la	a0, Lyn4MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 36(sp)			# salva o conteudo do registrador t1 na pilha (36+sp)
	j 	FimEscolheIdleLyn		# pula pra FimEscolheIdleLyn
MovimentaLynN:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleLyn10		# se t1 nao for igual a zero pula para PulaIdleLyn10
	la	a0, Lyn1MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 36(sp)			# salva o conteudo do registrador t1 na pilha (36+sp)
	j	FimEscolheIdleLyn		# pula pra FimEscolheIdleLyn
PulaIdleLyn10:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLyn11		# se t1 for nao igual a t0 pula para PulaIdleLyn11
	la	t1, Lyn2MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 36(sp)			# salva o conteudo do registrador t1 na pilha (36+sp)
	j	FimEscolheIdleLyn		# pula pra FimEscolheIdleLyn
PulaIdleLyn11:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleLyn12		# se t1 for nao igual a t0 pula para PulaIdleLyn12
	la	t1, Lyn3MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 36(sp)			# salva o conteudo do registrador t1 na pilha (36+sp)
	j	FimEscolheIdleLyn		# pula pra FimEscolheIdleLyn
PulaIdleLyn12:
	la	t1, Lyn4MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 36(sp)			# salva o conteudo do registrador t1 na pilha (36+sp)
FimEscolheIdleLyn:
	ret					# Retorna para a funcao chamadora
