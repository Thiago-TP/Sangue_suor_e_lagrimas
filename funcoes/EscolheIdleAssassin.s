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

EscolheIdleAssassin:
	la	t0, Assassin			# carrega a posicao do personagem 1 em t0
	lw	t1, 16(t0)			# carrega o conteudo do endereco em t0+8 (indicador de moveset) em t1
	beqz	t1, StandByAssassin			# se t1 for igual a zero pula para StandByAssassin 
	li	t2, 1				# carrega 1 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaAssassinS		# se t1 for igual a t2 pula para MovimentaAssassinS
	li	t2, 2				# carrega 2 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaAssassinE		# se t1 for igual a t2 pula para MovimentaAssassinE
	li	t2, 3				# carrega 3 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaAssassinE		# se t1 for igual a t2 pula para MovimentaAssassinE
	li	t2, 4				# carrega 4 em t2 para verificar o proximo moveset
	beq	t1, t2, MovimentaAssassinN		# se t1 for igual a t2 pula para MovimentaAssassinN
	j	StandByAssassinGray			# pula para a StandByAssassinGray
	# Se formos colocar morte teriamos que mudar duas linhas de codigo a de cima e acrescentar mais uma
	# possibilidade
StandByAssassin:
	li	t0, 3 				# carrego 3 em t0 para fazer o resto de s0 / 3
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleAssassin1		# se t1 nao for igual a zero pula para PulaIdleAssassin1
	la	t1, Assassin1StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 16(sp)			# salva o conteudo do registrador t1 na pilha (16+sp)	
	j	FimEscolheIdleAssassin		# pula pra FimEscolheIdleAssassin
PulaIdleAssassin1:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleAssassin2		# se t1 for nao igual a t0 pula para PulaIdleAssassin2
	la	t1, Assassin2StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 16(sp)			# salva o conteudo do registrador t1 na pilha (16+sp)
	j	FimEscolheIdleAssassin		# pula pra FimEscolheIdleAssassin
PulaIdleAssassin2:
	la	t1, Assassin3StandBy		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 16(sp)			# salva o conteudo do registrador t1 na pilha (16+sp)
	j	FimEscolheIdleAssassin		# pula pra FimEscolheIdleAssassin
StandByAssassinGray:

	# implementar depois que eu fizer a movimentacao #
	li	a7,  10
	ecall
	##################################################
	
MovimentaAssassinS:
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleAssassin4		# Se t1 nao for igual a zero pula para PulaIdleAssassin4
	la	t1, Assassin1MovimentaS		# Carrega o endereco da imagem para salvar na pilha
	sw	t1, 16(sp)			# Salva o conteudo do registrador t1 na pilha (16+sp)
	j	FimEscolheIdleAssassin		# Pula pra FimEscolheIdleAssassin
PulaIdleAssassin4:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleAssassin5		# se t1 for nao igual a t0 pula para PulaIdleAssassin5
	la	t1, Assassin2MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 16(sp)			# salva o conteudo do registrador t1 na pilha (16+sp)
	j	FimEscolheIdleAssassin		# pula pra FimEscolheIdleAssassin
PulaIdleAssassin5:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleAssassin6		# se t1 for nao igual a t0 pula para PulaIdleAssassin6
	la	t1, Assassin3MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 16(sp)			# salva o conteudo do registrador t1 na pilha (16+sp)
	j	FimEscolheIdleAssassin		# pula pra FimEscolheIdleAssassin
PulaIdleAssassin6:
	la	t1, Assassin4MovimentaS		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 16(sp)			# salva o conteudo do registrador t1 na pilha (16+sp)
	j	FimEscolheIdleAssassin		# pula pra FimEscolheIdleAssassin
MovimentaAssassinE:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleAssassin7		# se t1 nao for igual a zero pula para PulaIdleAssassin7
	la	t1, Assassin1MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 16(sp)			# salva o conteudo do registrador t1 na pilha (16+sp)
	j	FimEscolheIdleAssassin		# pula pra FimEscolheIdleAssassin
PulaIdleAssassin7:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleAssassin8		# se t1 for nao igual a t0 pula para PulaIdleAssassin8
	la	t1, Assassin2MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 16(sp)			# salva o conteudo do registrador t1 na pilha (16+sp)
	j	FimEscolheIdleAssassin		# pula pra FimEscolheIdleAssassin
PulaIdleAssassin8:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleAssassin9		# se t1 for nao igual a t0 pula para PulaIdleAssassin9
	la	t1, Assassin3MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 16(sp)			# salva o conteudo do registrador t1 na pilha (16+sp)
	j	FimEscolheIdleAssassin		# pula pra FimEscolheIdleAssassin
PulaIdleAssassin9:
	la	a0, Assassin2MovimentaE		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 16(sp)			# salva o conteudo do registrador t1 na pilha (16+sp)
	j 	FimEscolheIdleAssassin		# pula pra FimEscolheIdleAssassin
MovimentaAssassinN:	
	li	t0, 4 				# carrego 3 em t0 para fazer o resto de s0 / 4
	rem	t1, s0, t0 			# uso resto 3 para escolher entre as tres sprites (generalizavel para todas)
	bnez	t1, PulaIdleAssassin10		# se t1 nao for igual a zero pula para PulaIdleAssassin10
	la	a0, Assassin1MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	a0, 16(sp)			# salva o conteudo do registrador t1 na pilha (16+sp)
	j	FimEscolheIdleAssassin		# pula pra FimEscolheIdleAssassin
PulaIdleAssassin10:
	li	t0, 1				# carrega 1 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleAssassin11		# se t1 for nao igual a t0 pula para PulaIdleAssassin11
	la	t1, Assassin2MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 16(sp)			# salva o conteudo do registrador t1 na pilha (16+sp)
	j	FimEscolheIdleAssassin		# pula pra FimEscolheIdleAssassin
PulaIdleAssassin11:
	li	t0, 2				# carrega 2 em t0 para verificar a proxima sprite do moveset
	bne	t1, t0, PulaIdleAssassin12		# se t1 for nao igual a t0 pula para PulaIdleAssassin16
	la	t1, Assassin3MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 16(sp)			# salva o conteudo do registrador t1 na pilha (16+sp)
	j	FimEscolheIdleAssassin		# pula pra FimEscolheIdleAssassin
PulaIdleAssassin12:
	la	t1, Assassin4MovimentaN		# carrega o endereco da imagem para salvar na pilha
	sw	t1, 16(sp)			# salva o conteudo do registrador t1 na pilha (16+sp)
FimEscolheIdleAssassin:
	ret					# Retorna para a funcao chamadora
