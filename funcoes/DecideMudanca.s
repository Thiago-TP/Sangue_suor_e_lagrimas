#################################################
#	Argumentos:				#
#	a0 = PosicaoAtualCursor			#
#################################################
#	Retorna:				#
#	Nada,  mas e aqui que mudamos os regis-	#
#	tradores s7, s8, s9. Esses regis-	#
#	tradores sao utilizados na movimentacao	#
#	do personagem do mapa seja ele qual	#
#	for. Tambem preparamos a Movimentacao	#
#	de um personagem generico na primeira	#
#	vez que se aperta o enter nele		#
#################################################

DecideMudanca:
	mv	t6, zero			# inicializo um contador como zero em t6
	addi	sp, sp, -4 			# aloco espaco na pilha
	sw	ra, 0(sp)			# guardo o ponteiro de retorno na pilha
LoopVerificaCliquePersonagem:
	mv	a7, t6				# move o contador para a7 para passar como argumento para a funcao abaixo
	call	EscolhePersonagem 		# chama a funcao escolhePersonagem que retorna em a1 a label do personagem escolhido
	lw	t2, 0(a0)			# carrega em t2 o valor x da posicao atual do cursor
	lw	t3, 0(a1)			# carrega em t3 o valor x da posicao do personagem
	lw	t4, 4(a0)			# carrega em t2 o valor y da posicao atual do cursor
	lw	t5, 4(a1)			# carrega em t3 o valor y da posicao do personagem
	lw	t1, 16(a1)			# carrego o valor do indicador de moveset do personagem em t1
	bne	t2, t3, PulaCliquePersonagem 	# Pula para PulaCliquePersonagem se o x do cursor for diferente do x do personagem
	bne	t4, t5, PulaCliquePersonagem	# pula para PulaCliquePersonagem se o y do cursor for diferente do y do personagem
	bnez	t1, PulaCliquePersonagem		# se o valor for diferente de zero eu pulo para PulaCliqueStandBy
	mv	s5, a1				# guardo o valor de a1 em s5 por enquanto (nao precisamos desse valor em todo o programa)	
	mv	t6, zero			# inicializo um contador como zero em t6
LoopRetornaStandBy:
	li	t2, 5				# limite Superior dos Movesets que podem ser limpos (talvez nao precise de tudo)
	mv	a7, t6				# move o contador para a7 para passar como argumento para a funcao abaixo
	call	EscolhePersonagem 		# chama a funcao escolhePersonagem que retorna em a1 a label do personagem escolhido
	lw	t1, 16(a1)			# carrego o valor do indicador do MoveSet do personagem
	bge	t1, t2, PulaReiniciaMoveSet	# se o Moveset for maior ou igual a 5 nao reinicio ele	
	beqz 	t1,PulaReiniciaMoveSet
	sh	zero, 16(a1)			# reinicio o moveset de todos os personagens que nao estamos mortos ou nao estao cinzas
	lw	t0, 0(a1)
	lw	t1, 4(a1)
	li	t2,16
	mv	a1,t0
	mv	a2,t1
	mv	a4,a1
	mv	a5,a2
	div	a1,a1,t2
	div	a2,a2,t2
	div	a4,a4,t2
	div	a5,a5,t2
	addi	a1,a1,-4
	bgtz	a1,PulaMinimoX1
	mv	a1,zero
PulaMinimoX1:
	addi	a2,a2,-4
	bgtz	a2,PulaMinimoY1
	mv	a2,zero
PulaMinimoY1:
	addi	a4,a4,5
	li	t0,20
	blt	a4,t5,PulaMaximoX1
	li	a4,20
PulaMaximoX1:
	addi	a5,a5,5
	li	t5,15
	blt	a5,t5,PulaMaximoY1
	li	a5,15
PulaMaximoY1:	
	call	ClearScreen
	j	SaiReiniciaMoveSet
PulaReiniciaMoveSet:
	addi	t6, t6, 2			# incremento em 2 o contador
	bne	t6, s4, LoopRetornaStandBy	# verifico se o contador eh diferente de s4 e se for volto pro Loop		
SaiReiniciaMoveSet:
	li	t1, 1				# carrego 1 em t1 para preparar a movimentacao do personagem
	la	a0, PosicaoAtualCursor		# carrego a Posicao atual do cursor em a0 para passar como argumento
	sw	t1, 16(s5)			# salvo o valor em t1 no indicador de move set do personagem
	call	ImprimeAreaMovimentacao		# chamo a funcao ImprimeAreaMovimentacao
	j	FimDecide
PulaCliquePersonagem:
	addi	t6, t6, 2			# incrementa o contador em 2
	bne	t6, s4, LoopVerificaCliquePersonagem	# verifico se o contador eh diferente de s4 e se for volto pro Loop
	mv	t6,zero
LoopVerificaAliadoCursor:
	mv	a7, t6				# move o contador para a7 para passar como argumento para a funcao abaixo
	call	EscolhePersonagem 
	li	t0,1
	lw	t1, 16(a1)
	lw	t2, 0(a0)
	lw 	t3, 4(a0)
	lw 	t4, 0(a1)
	lw	t5, 4(a1)
	beq	t1,t0,PulaPersonagemCursor
	bne	t2,t4,PulaPersonagemCursor
	bne	t3,t5,PulaPersonagemCursor
	j	FimDecide
PulaPersonagemCursor:
	addi	t6,t6,2
	blt	t6,s4,LoopVerificaAliadoCursor
	mv	t6, zero			# reinicio o contador em t6
	li	t2, 1				# carrego 1 em t2 para verificar se aquele personagem ja estava preparado para andar
LoopVerificaMovimento:
	mv	a7, t6				# move o contador para a7 para passar como argumento para a funcao abaixo
	call	EscolhePersonagem 		# chama a funcao escolhePersonagem que retorna em a1 a label do personagem escolhido
	lw	t1, 16(a1)			# carrego o valor do indicador de moveset do personagem em t1
	lw 	t3, 0(a0)
	lw 	t4, 0(a1)
	lw	t5, 4(a0)
	bne	t2, t1, PulaSetaMovimentacao 	# verifico se o personagem pode se mover e se nao pulo para PulaSetaMovimentacao
	lw	t0, 4(a1)
	sub	t3, t3,t4
	bgtz	t3, PulaInversao1
	addi	t3, t3,1
	not	t3, t3
PulaInversao1:
	li	t4, 64
	bgt	t3, t4,FimDecide
	sub	t5, t5,t0
	bgtz	t5, PulaInversao2
	addi	t5, t5,1
	not	t5, t5
PulaInversao2:
	li	t0, 64
	bgt	t5, t0,FimDecide
	lw	t1, 0(a0)
	lw	t2, 4(a0)
	addi	t1, t1,2
	addi	t2, t2,2
	li 	t0, 0xFF200604 		# carrega em t0 o endereco de troca de frame
	lw 	a3, 0(t0) 		# troca de frame
	xori	a3, a3,1
	li 	t0, 0xFF0 # carrega 0xFF0 em t0
	add 	t0, t0,a3 # adiciona o frame ao FF0 (se o frame for 1 vira FF1, se for 0 fica FF0)
	slli 	t0, t0,20 # shift de 20 bits pra esquerda (0xFF0 vira 0xFF000000, 0xFF1 vira 0xFF100000)
	add 	t0, t0,t1 # adiciona x ao t0
	li 	t1, 320 # t1 = 320
	mul 	t1, t1,t2 # multiplica y por t1
	add 	t0, t0,t1 # coloca o valor final do calculo do endereço em t0
	lb	t1, 0(t0)
	li	t3, 20
	beq	t1, t3, FimDecide
	mv	s7, a1 				# guardo a posicao do personagem em s7 (posicao inicial do movimento)
	mv	s8, a0 				# guardo a posicao atual do cursor em s8 (posicao final do movimento) 
	li	s9, 1				# carrego 1 em s9 indicando que agora existe um personagem em movimentacao 	
	lw	t0, 0(a1)
	lw	t1, 4(a1)
	li	t2,16
	mv	a1,t0
	mv	a2,t1
	mv	a4,a1
	mv	a5,a2
	div	a1,a1,t2
	div	a2,a2,t2
	div	a4,a4,t2
	div	a5,a5,t2
	addi	a1,a1,-4
	bgtz	a1,PulaMinimoX2
	mv	a1,zero
PulaMinimoX2:
	addi	a2,a2,-4
	bgtz	a2,PulaMinimoY2
	mv	a2,zero
PulaMinimoY2:
	addi	a4,a4,5
	li	t0,20
	blt	a4,t5,PulaMaximoX2
	li	a4,20
PulaMaximoX2:
	addi	a5,a5,5
	li	t5,15
	blt	a5,t5,PulaMaximoY2
	li	a5,15
PulaMaximoY2:	
	call	ClearScreen
	j	FimDecide			# pula para a FimDecide
PulaSetaMovimentacao:
	addi	t6, t6, 2			# incrementa o contador em 1
	bne	t6, s4, LoopVerificaMovimento	# verifico se o contador eh diferente de s4 e se for volto pro Loop
FimDecide:
	lw	ra, 0(sp)			# recupero o ponteiro de retorno da pilha
	addi	sp, sp, 4 			# desaloco a memoria da pilha
	ret					# retorno para a funcao chamadora
