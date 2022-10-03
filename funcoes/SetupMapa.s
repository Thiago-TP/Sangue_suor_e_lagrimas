#################################################
#	a5 = 	qntd aliados e inimigos		#
#################################################
SetupMapa:
	addi	sp, sp, -4 	# aloca espaco na pilha
	la	t0, guardaSP		# guardando o sp expandido
	sw	sp, 0(t0)
	sw	ra, 0(sp) 	# salva o ponteiro de retorno
	mv	s4, a5 		# move o argumento recebido em a5 para s4 para termos o limite de personagens
	li 	a1, 0
	li	a2, 0
	li	a4, 20
	li	a5, 15
	call	ClearScreen
	mv	s0, zero 	# iniciliaza s0 como zero
	mv	s1, zero 	# inicializa s1 como zero
	mv	s6, sp 		# salvo o endereco inicial de tudo para voltar toda vez depois do loop
	mv	s7, zero	# s7  = struct de posicao do personagem sendo movimentado
	mv	s8, zero	# s8  = struct da posicao atual do cursor
	mv	s9, zero	# s9  = ...
	mv	s10,zero
	mv	s11,zero
LoopGame: 
		
	################ testes de funcoes de controle ####################
	#call	VerificaWin	# Win <- 1 se for PC morreu
	#la	t0, Win
	#lb	t0, 0(t0)
	#bnez	t0, ProximaFase	# Win ? fim da fase
	# Perdeu ainda n foi implementada
	#call	VerificaGameOver	# GameOver <- 1 se jogador morreu
	#la	t0, GameOver
	#lb	t0, 0(t0)
	#bnez	t0, Perdeu	# GameOver ? tela de derrota
	####################################################################
	
	call	VerificaVez	# Vez <- 1 se for a vez do PC
	la	t0, Vez
	lb	t0, 0(t0)
	beqz	t0, PulaVezPC	# Vez = 1 ? PC joga (vez do PC ainda nao foi implementada)
	bnez	s9, PulaVezPC
	mv	a7,s11
	call	EscolhePersonagem # retorna em a1
	li	t1,6
	lw	t0, 16(a1)
	beq	t0,t1,PulaEscolheAtacado
	la	a0,PosicaoInimigo
	lw	t2,0(a1)
	lw	t3,4(a1)
	sw	t2,0(a0)
	sw	t3,4(a0)
	mv	s8,a0
	li	t6, 1
	li	s10, 500
LoopEscolhePersonagemAtacante:
	mv	a7, t6
	call	EscolhePersonagem # retorna em a1
	lw	t0, 16(a1)
	li	t1, 5
	bge	t0, t1, PulaTrocaMinimo
	lw	t0, 0(a1)
	lw	t1, 4(a1)
	sub	t4, t2, t0
	bgez	t4,PulaModuloX
	sub	t4, zero, t4
PulaModuloX:
	sub	t5, t3, t1
	bgez	t5,PulaModuloY
	sub	t5, zero, t5
PulaModuloY:
	mul	t4, t4, t4
	mul	t5, t5, t5
	add	t0, t4, t5
	fcvt.s.w	ft0, t0
	fsqrt.s	ft0, ft0
	fcvt.w.s	t0, ft0
	bge	t0, s10,PulaTrocaMinimo
	mv	s10, t0
	mv	a5, a1
PulaTrocaMinimo:
	addi	t6, t6, 2
	blt	t6, s4, LoopEscolhePersonagemAtacante
	li	t0,500
	beq	s10,t0,PulaVezPC
PulaTratamentoMorteTotal:
	mv	s7, a5
	lw	t0, 0(s7)
	lw	t1, 0(s8)
	sub	t2, t1, t0
	bgez	t2,PulaModuloDistX
	sub	t2, zero, t2
PulaModuloDistX:
	li	t3, 64
	blt	t2, t3, PulaLimiteX
	sub	t2, t2, t3
	blt	t1, t0, AdicionaX
	sub	t1, t1, t2
	j	FimDecideLimiteX
AdicionaX:
	add	t1, t1, t2
FimDecideLimiteX:
	sw	t1, 0(s8)
PulaLimiteX:
	lw	t0, 4(s7)
	lw	t1, 4(s8)
	sub	t2, t1, t0
	bgez	t2,PulaModuloDistY
	sub	t2, zero, t2
PulaModuloDistY:
	li	t3, 64
	blt	t2, t3, PulaLimiteY
	sub	t2, t2, t3
	blt	t1, t0, AdicionaY
	sub	t1, t1, t2
	j	FimDecideLimiteY
AdicionaY:
	add	t1, t1, t2
FimDecideLimiteY:
	sw	t1, 4(s8)
PulaLimiteY:	
	li	s9, 1
	mv	s10, zero
PulaEscolheAtacado:
	addi	s11, s11, 2
	blt	s11,s4,PulaVezPC
	mv	s11,zero
PulaVezPC:
	beqz	s9, PulaMovimento
	call 	MovimentaPersonagem
	la	t0, Vez
	lb	t0, 0(t0)
	bnez	t0,PulaMovimentaMenu
	mv	s11,zero
PulaMovimento:
	bnez	s9, PulaMovimentaMenu	# enquanto o personagem se move, o cursor permanece congelado
	la	t0, MenuAtivado
	lb	t1, 0(t0)	
	bnez	t1, PulaMovimentaCursor
	call	MovimentaCursor
	j	PulaMovimentaMenu
PulaMovimentaCursor:
	call 	MovimentaMenu
PulaMovimentaMenu:
	mv	sp, s6 			# reinicio o ponteiro da pilha
	addi	sp, sp, -40 		# aloco espaco de memoria na pilha (40 = 4*(10 personagens))
	addi	s2, sp, 40 		# salvo o endereco antigo da pilha
	call	EscolheIdleLyn 		# funcao que decide qual sprite imprimir da Lyn
	call	EscolheIdleBrigand 	# funcao que decide qual sprite imprimir do Brigand
	call	EscolheIdleYogi		# funcao que decide qual sprite imprimir do Yogi
	call	EscolheIdleSoldier 	# funcao que decide qual sprite imprimir do Soldier
	call	EscolheIdleDorcas	# funcao que decide qual sprite imprimir do Dorcas
	call	EscolheIdleAssassin	# funcao que decide qual sprite imprimir do Assassin
	call	EscolheIdleDart		# funcao que decide qual sprite imprimir do Dart
	call	EscolheIdleBrigand2	# funcao que decide qual sprite imprimir do Brigand2
	call	EscolheIdleSain		# funcao que decide qual sprite imprimir do Sain
	call	EscolheIdleSoldier2	# funcao que decide qual sprite imprimir do Soldier2
	xori	s1, s1, 1 		# inverte o valor em s1
	mv	a3, s1 			# coloca em a3 para indicar o frame
	la	a2, PosicaoAnteriorCursor 	# carrego o endereco da posicao atual do cursor em a2
	lw	a1, 0(a2)		# carrego o valor x da posicao atual do cursor
	lw	a2, 4(a2)		# carrego o valor y da posicao atual do cursor
	li	a4, 20
	li	a5, 20
	mv	s5, sp
	call	SalvaSprite
	mv	s3, sp 			# final do espaco reservado para os argumentos das Idles
	mv	t6, zero 		# inicializa o contador como t6
LoopSalvaSprites:
	mv	a7, t6
	call 	EscolhePersonagem 	# carrega em a1 a posicao que queremos receber em t6 :)
	li	t1, 6
	lw	t0, 16(a1)
	bge	t0,t1,PulaSalvamentoPersonagem
	li	t1,7
	lb	t0,22(a1)
	bne	t0,t1,PulaArrumaBrigand2.Salva
	j	PulaBrigand2.Salva
PulaArrumaBrigand2.Salva:
	li	t1,1
	bne	t0,t1,PulaArrumaBrigand.Salva
PulaBrigand2.Salva:
	lw	t0,16(a1)
	li	t1,5
	bne	t0,t1,PulaConcertoBrigandCinza.Salva
	li	t0,10
	j	FimEscolheAlturaBrigand.Salva
PulaConcertoBrigandCinza.Salva:
	bnez	t0,PulaConcertoBrigandStandBy.Salva
	li	t0,10
	j	FimEscolheAlturaBrigand.Salva
PulaConcertoBrigandStandBy.Salva:
	li	t0,10
FimEscolheAlturaBrigand.Salva:
	lw	a2, 12(a1) 		# carrega y
	lw	a1, 8(a1) 		# carrega x
	sub	a2,a2,t0
	j	FimConcerto.Salva
PulaArrumaBrigand.Salva:
	li	t1,6
	bne	t0,t1,PulaArrumaDart.Salva
	lw	t0,16(a1)
	li	t1,5
	bne	t0,t1,PulaConcertoDartCinza.Salva
	li	t0,10
	j	FimEscolheAlturaDart.Salva
PulaConcertoDartCinza.Salva:
	bnez	t0,PulaConcertoDartStandBy.Salva
	li	t0,10
	j	FimEscolheAlturaDart.Salva
PulaConcertoDartStandBy.Salva:
	li	t0,10
FimEscolheAlturaDart.Salva:
	lw	a2, 12(a1) 		# carrega y
	lw	a1, 8(a1) 		# carrega x
	sub	a2,a2,t0
	j	FimConcerto.Salva
PulaArrumaDart.Salva:
	li	t1,4
	bne	t0,t1,PulaArrumaDorcas.Salva
	lw	t0,16(a1)
	li	t1,5
	bne	t0,t1,PulaConcertoDorcasCinza.Salva
	li	t0,10
	j	FimEscolheAlturaDorcas.Salva
PulaConcertoDorcasCinza.Salva:
	bnez	t0,PulaConcertoDorcasStandBy.Salva
	li	t0,10
	j	FimEscolheAlturaDorcas.Salva
PulaConcertoDorcasStandBy.Salva:
	li	t0,10
FimEscolheAlturaDorcas.Salva:
	lw	a2, 12(a1) 		# carrega y
	lw	a1, 8(a1) 		# carrega x
	sub	a2,a2,t0
	j	FimConcerto.Salva
PulaArrumaDorcas.Salva:
	li	t1,8
	bne	t0,t1,PulaArrumaSain.Salva
	lw	t0,16(a1)
	li	t1,5
	bne	t0,t1,PulaConcertoSainCinza.Salva
	li	t0,10
	j	FimEscolheAlturaSain.Salva
PulaConcertoSainCinza.Salva:
	bnez	t0,PulaConcertoSainStandBy.Salva
	li	t0,10
	j	FimEscolheAlturaSain.Salva
PulaConcertoSainStandBy.Salva:
	li	t0,10
FimEscolheAlturaSain.Salva:
	lw	a2, 12(a1) 		# carrega y
	lw	a1, 8(a1) 		# carrega x
	sub	a2,a2,t0
	j	FimConcerto.Salva
PulaArrumaSain.Salva:
	lw	a2, 12(a1) 		# carrega y
	lw	a1, 8(a1) 		# carrega x
FimConcerto.Salva:
	li	a4, 28
	li	a5, 28
	call	SalvaSprite
PulaSalvamentoPersonagem:
	addi	t6, t6, 1
	blt	t6, s4, LoopSalvaSprites # se a quantidade maxima for atingida sai da funcao
	mv	t6, zero
	call	Musica			
LoopRecuperaArgumentos:
	addi	s2, s2, -4 		# incrementa o registrador que esta guardando o endereco da pilha
	lw	a0, 0(s2) 		# a0 <- label da sprite a ser impressa
	mv	a7, t6
	call 	EscolhePersonagem 	# retorna em a1 o personagem da vez :)
	lw	t0, 16(a1)
	mv	a7, t0
	li	t1,6
	bge	t0,t1,FinalEscolhaPrint
	li	t1,7
	lb	t0,22(a1)
	bne	t0,t1,PulaArrumaBrigand2
	j	PulaBrigand2
PulaArrumaBrigand2:
	li	t1,1
	bne	t0,t1,PulaArrumaBrigand
PulaBrigand2:
	lw	t0,16(a1)
	li	t1,5
	bne	t0,t1,PulaConcertoBrigandCinza
	li	t0,3
	j	FimEscolheAlturaBrigand
PulaConcertoBrigandCinza:
	bnez	t0,PulaConcertoBrigandStandBy
	li	t0,3
	j	FimEscolheAlturaBrigand
PulaConcertoBrigandStandBy:
	li	t0,10
FimEscolheAlturaBrigand:
	lw	a2, 4(a1) 		# carrega y
	lw	a1, 0(a1) 		# carrega x
	sub	a2,a2,t0
	j	FimConcerto
PulaArrumaBrigand:
	li	t1,6
	bne	t0,t1,PulaArrumaDart
	lw	t0,16(a1)
	li	t1,5
	bne	t0,t1,PulaConcertoDartCinza
	li	t0,7
	j	FimEscolheAlturaDart
PulaConcertoDartCinza:
	bnez	t0,PulaConcertoDartStandBy
	li	t0,7
	j	FimEscolheAlturaDart
PulaConcertoDartStandBy:
	li	t0,10
FimEscolheAlturaDart:
	lw	a2, 4(a1) 		# carrega y
	lw	a1, 0(a1) 		# carrega x
	sub	a2,a2,t0
	j	FimConcerto
PulaArrumaDart:
	li	t1,4
	bne	t0,t1,PulaArrumaDorcas
	lw	t0,16(a1)
	li	t1,5
	bne	t0,t1,PulaConcertoDorcasCinza
	li	t0,7
	j	FimEscolheAlturaDorcas
PulaConcertoDorcasCinza:
	bnez	t0,PulaConcertoDorcasStandBy
	li	t0,7
	j	FimEscolheAlturaDorcas
PulaConcertoDorcasStandBy:
	li	t0,10
FimEscolheAlturaDorcas:
	lw	a2, 4(a1) 		# carrega y
	lw	a1, 0(a1) 		# carrega x
	sub	a2,a2,t0
	j	FimConcerto
PulaArrumaDorcas:
	li	t1,8
	bne	t0,t1,PulaArrumaSain
	lw	t0,16(a1)
	li	t1,5
	bne	t0,t1,PulaConcertoSainCinza
	li	t0,5
	j	FimEscolheAlturaSain
PulaConcertoSainCinza:
	bnez	t0,PulaConcertoSainStandBy
	li	t0,5
	j	FimEscolheAlturaSain
PulaConcertoSainStandBy:
	li	t0,10
FimEscolheAlturaSain:
	lw	a2, 4(a1) 		# carrega y
	lw	a1, 0(a1) 		# carrega x
	sub	a2,a2,t0
	j	FimConcerto
PulaArrumaSain:
	lw	a2, 4(a1) 		# carrega y
	lw	a1, 0(a1) 		# carrega x
FimConcerto:
	mv	t0,a7
	li	t1, 5
	bltu	t0, t1, colorido
	li	a4, 1
colorido:	
	li	t1, 2
	bne	t0, t1, PulaEscolhaPrint	# imprime a sprite espelhada se a movimentacao eh para a direita
	call	PrintByteInverso
	j	FinalEscolhaPrint
PulaEscolhaPrint:
	call 	PrintByte 		# chama a funcao PrintByte
	mv	a4, zero
FinalEscolhaPrint:
	addi	t6, t6, 1 		# incrementa o contador
	blt	t6, s4, LoopRecuperaArgumentos # se a quantidade maxima for atingida sai da funcao
	la	t0, Vez
	lb	t1, 0(t0)
	bnez	t1,PulaImprimeMenu
	la	t0, MenuAtivado
	lb	t1, 0(t0)
	bnez	t1, PulaImprimeCursor
	li	t0, 2			# carrego 2 em t0 para fazer o resto de a0 / 2
	rem	t0, s0, t0		# uso resto 2 para escolher entre as duas sprites (generalizavel para todas)
	bnez	t0, PulaCursor1		# se t0 for igual a zero pula para PulaCursor1
	la	a0, Cursor1		# carrega o endereco da imagem Cursor1 em a0
	j	FimEscolheCursor	# pula para FimEscolheCursor
PulaCursor1:
	la	a0, Cursor2		# carrega o endereco da imagem Cursor2 em a0
FimEscolheCursor:
	la	a2, PosicaoAtualCursor 	# carrego o endereco da posicao atual do cursor em a2
	lw	a1, 0(a2)		# carrego o valor x da posicao atual do cursor
	lw	a2, 4(a2)		# carrego o valor y da posicao atual do cursor
	call	PrintByte 		# chama a funcao para imprimir o cursor em a0 Byte a Byte
	j	PulaImprimeMenu 
PulaImprimeCursor:
	call 	MontaMenu
PulaImprimeMenu:	
	li 	t0, 0xFF200604 		# carrega em t0 o endereco de troca de frame
	sw 	s1, 0(t0) 		# troca de frame
	mv	a3, s1 			# move o valor de s1 para a3
	xori	a3, a3, 1 		# inverte o valor de a3
	li	a4, 20			# carrega xmax = 20 para a funcao RecuperaSprite
	li	a5, 20			# carrega ymax = 20 para a funcao RecuperaSprite
	la	t0, PosicaoAnteriorCursor 	# carrega a label da posicao atual do cursor
	lw	a1, 0(t0) 		# carrega x
	lw	a2, 4(t0) 		# carrega y
	mv	a6, s5 			# move o valor de s5 (comeco do sprite salvo na pilha) para a6
	call	RecuperaSprite 		# Chama a funcao RecuperaSprite
	mv	t6, zero 		# inicializa o contador t6
	mv	a6, s3
LoopLimpaPersonagens:
	mv	a7, t6
	call 	EscolhePersonagem 	# carrega em a1 a posicao que queremos 
	lw	t0,16(a1)
	li	t1,6
	bge	t0,t1,PulaRecuperaPersonagem
	mv	t2, a1
	li	t1,7
	lb	t0,22(a1)
	bne	t0,t1,PulaArrumaBrigand2.Recupera
	j	PulaBrigand2.Recupera
PulaArrumaBrigand2.Recupera:
	li	t1,1
	bne	t0,t1,PulaArrumaBrigand.Recupera
PulaBrigand2.Recupera:
	lw	t0,16(a1)
	li	t1,5
	bne	t0,t1,PulaConcertoBrigandCinza.Recupera
	li	t0,10
	j	FimEscolheAlturaBrigand.Recupera
PulaConcertoBrigandCinza.Recupera:
	bnez	t0,PulaConcertoBrigandStandBy.Recupera
	li	t0,10
	j	FimEscolheAlturaBrigand.Recupera
PulaConcertoBrigandStandBy.Recupera:
	li	t0,10
FimEscolheAlturaBrigand.Recupera:
	lw	a2, 12(a1) 		# carrega y
	lw	a1, 8(a1) 		# carrega x
	sub	a2,a2,t0
	j	FimConcerto.Recupera
PulaArrumaBrigand.Recupera:
	li	t1,6
	bne	t0,t1,PulaArrumaDart.Recupera
	lw	t0,16(a1)
	li	t1,5
	bne	t0,t1,PulaConcertoDartCinza.Recupera
	li	t0,10
	j	FimEscolheAlturaDart.Recupera
PulaConcertoDartCinza.Recupera:
	bnez	t0,PulaConcertoDartStandBy.Recupera
	li	t0,10
	j	FimEscolheAlturaDart.Recupera
PulaConcertoDartStandBy.Recupera:
	li	t0,10
FimEscolheAlturaDart.Recupera:
	lw	a2, 12(a1) 		# carrega y
	lw	a1, 8(a1) 		# carrega x
	sub	a2,a2,t0
	j	FimConcerto.Recupera
PulaArrumaDart.Recupera:
	li	t1,4
	bne	t0,t1,PulaArrumaDorcas.Recupera
	lw	t0,16(a1)
	li	t1,5
	bne	t0,t1,PulaConcertoDorcasCinza.Recupera
	li	t0,10
	j	FimEscolheAlturaDorcas.Recupera
PulaConcertoDorcasCinza.Recupera:
	bnez	t0,PulaConcertoDorcasStandBy.Recupera
	li	t0,10
	j	FimEscolheAlturaDorcas.Recupera
PulaConcertoDorcasStandBy.Recupera:
	li	t0,10
FimEscolheAlturaDorcas.Recupera:
	lw	a2, 12(a1) 		# carrega y
	lw	a1, 8(a1) 		# carrega x
	sub	a2,a2,t0
	j	FimConcerto.Recupera
PulaArrumaDorcas.Recupera:
	li	t1,8
	bne	t0,t1,PulaArrumaSain.Recupera
	lw	t0,16(a1)
	li	t1,5
	bne	t0,t1,PulaConcertoSainCinza.Recupera
	li	t0,10
	j	FimEscolheAlturaSain.Recupera
PulaConcertoSainCinza.Recupera:
	bnez	t0,PulaConcertoSainStandBy.Recupera
	li	t0,10
	j	FimEscolheAlturaSain.Recupera
PulaConcertoSainStandBy.Recupera:
	li	t0,10
FimEscolheAlturaSain.Recupera:
	lw	a2, 12(a1) 		# carrega y
	lw	a1, 8(a1) 		# carrega x
	sub	a2,a2,t0
	j	FimConcerto.Recupera
PulaArrumaSain.Recupera:
	lw	a2, 12(a1) 		# carrega y
	lw	a1, 8(a1) 		# carrega x
FimConcerto.Recupera:
	lw	t0, 0(t2)
	lw	t1, 4(t2)
	sw	t0, 8(t2)
	sw	t1, 12(t2)
	li	a4, 28
	li	a5, 28
	call	RecuperaSprite
PulaRecuperaPersonagem:
	addi	t6, t6, 1 		# incrementa contador
	blt	t6, s4, LoopLimpaPersonagens # se a quantidade maxima for atingida sai da funcao	
	li	a0, 140 
	la	t0, Fase
	lb	t0, 0(t0)
	li	t1, 5
	bne	t0, t1, sleepNormal
	li	a0, 160			# sleep da fase 5
sleepNormal:
	call 	Sleep			# este sleep so nao funciona no RARS
	la	t0, PosicaoAnteriorCursor
	la 	t1, PosicaoAtualCursor
	lw 	t2, 0(t1)
	sw 	t2, 0(t0)
	lw 	t2, 4(t1)
	sw 	t2, 4(t0)
	addi	s0, s0, 1		# incremento s0 (lembrar que ele controla qual a idle que eu quero printar)
	j	LoopGame		# volta para LoopStandby
ProximaFase:	
	la	t0, guardaSP		# recuperando o sp expandido
	lw	sp, 0(t0)
	lw	ra, 0(sp) 		# carrega o valor de ra de sp
	addi	sp, sp, 4 		# desaloca a memoria da pilha
	ret 				# volta para quem chamou a funcao

MovimentaPersonagem:
	addi	sp, sp, -4 	# aloca espaco na pilha
	sw	ra, 0(sp) 	# salva o ponteiro de retorno
	la	t2, Vez
	lb	t3, 0(t2)
	beqz	t3,PulaAcaoOportunoInimigo1	
	lw	t2, 0(s7)
	lw	t3, 4(s7)
	mv	t6, zero
LoopAtaqueOportunoInimigo1:
	mv	a7,t6
	call 	EscolhePersonagem
	li	t0,6
	lw	t1,16(a1)
	bge	t1,t0,PulaVerificaBaixo1
	lw	t0, 0(a1)
	lw	t1, 4(a1)
	addi	t4,t2,-16
	bne	t4,t0,PulaVerificaEsquerda1
	bne	t3,t1,PulaVerificaEsquerda1
	j	FinalizaAtaqueOportunoInimigo1
PulaVerificaEsquerda1:
	addi	t4,t2,16
	bne	t4,t0,PulaVerificaDireita1
	bne	t3,t1,PulaVerificaDireita1
	j	FinalizaAtaqueOportunoInimigo1
PulaVerificaDireita1:
	addi	t5,t3,-16
	bne	t2,t0,PulaVerificaCima1
	bne	t5,t1,PulaVerificaCima1
	j	FinalizaAtaqueOportunoInimigo1
PulaVerificaCima1:
	addi	t5,t3,16
	bne	t2,t0,PulaVerificaBaixo1
	bne	t5,t1,PulaVerificaBaixo1
	j	FinalizaAtaqueOportunoInimigo1
PulaVerificaBaixo1:
	addi	t6,t6,2
	blt	t6,s4,LoopAtaqueOportunoInimigo1
	j	PulaAcaoOportunoInimigo1
FinalizaAtaqueOportunoInimigo1:
	li	t0, 5
	sw	t0, 16(s7)
	mv	a0,a1
	mv	a1,s7
	call	Luta
	mv	s9, zero		# fim do movimento => s9 = 0
	j	PulaEscolhaEixo
PulaAcaoOportunoInimigo1:
	lw 	t5, 0(s7)
	lw 	t6, 4(s7)
	lw	t0, 0(s8)
	bne	t5,t0,PulaVerificaIgualdade
	lw	t0, 4(s8)
	bne	t6,t0,PulaVerificaIgualdade
	j	PulaEscolhaEixo
PulaVerificaIgualdade:
	bnez	s10,PulaEixoX
	lw	t0, 0(s8)		# t0 <- x do cursor
	bne	t5,t0,PulaTrocaMovimento1
	xori	s10,s10,1
	j	PulaEixoX
PulaTrocaMovimento1:
	sub	t0, t0, t5 		# se for negativo a1 eh maior que t0 entao preciso decrementar a1
	bltz	t0, PulaEixoXPositivo	# x personagem > x cursor ? pula : move para a direita
	#	aqui so entra se t0 for positivo quer dizer que o idle eh para a direita e preciso incrementar
	addi	t5, t5, 4		# personagem move 4 pixeis para a direita
	sw	t5, 0(s7)		# atualiza struct de posicao do personagem
	li	t0, 2			# moveset eh para direita
	sw	t0, 16(s7)		# atualiza o estado do personagem	
	j	PulaEscolhaEixo
PulaEixoXPositivo:
	addi	t5, t5, -4		# personagem move 4 pixeis para a esquerda ("-4 para a direita")
	sw	t5, 0(s7)		
	li	t0, 3			# moveset eh para esquerda
	sw	t0, 16(s7)	
	j	PulaEscolhaEixo
PulaEixoX:	# Repete-se aqui, no eixo Y, o que foi feito no X
	beqz	s10,PulaEscolhaEixo
	lw	t0, 4(s8)
	bne	t6,t0,PulaTrocaMovimento2
	xori	s10,s10,1
	j	LoopGame
PulaTrocaMovimento2:
	sub	t0, t0, t6 		# se for negativo a1 eh maior que t0 entao preciso decrementar a1
	bltz	t0, PulaEixoYPositivo	
	addi	t6, t6, 4		# personagem move 4 pixeis para baixo
	sw	t6, 4(s7)
	li	t0, 1			# moveset eh para baixo
	sw	t0, 16(s7)	
	j	PulaEscolhaEixo
PulaEixoYPositivo:
	addi	t6, t6, -4		# personagem move 4 pixeis para a cima ("-4 pixeis para baixo")
	sw	t6, 4(s7)
	li	t0, 4			# moveset eh para cima
	sw	t0, 16(s7)		
PulaEscolhaEixo:
	lw	t0, 0(s7)
	lw	t1, 0(s8)
	bne	t0, t1, FimMovimento	# x personagem =/= x cursor ? mais movimento : verifica x 
	lw	t0, 4(s7)
	lw	t1, 4(s8)
	bne	t0, t1, FimMovimento	# y personagem =/= y cursor ? mais movimento : chegamos ao destino
	mv	s10,zero
	mv	s9, zero		# fim do movimento => s9 = 0
	sw	zero, 16(s7)		# atualiza o estado do personagem para StandBy
	la	t0, Vez
	lb	t1, 0(t0)
	beqz	t1,PulaTransformaInimigoCinza
	lw	t2, 0(s7)
	lw	t3, 4(s7)
	mv	t6, zero
LoopAtaqueOportunoInimigo2:
	mv	a7,t6
	call 	EscolhePersonagem
	li	t0,6
	lw	t1,16(a1)
	bge	t1,t0,PulaVerificaBaixo2
	lw	t0, 0(a1)
	lw	t1, 4(a1)
	addi	t4,t2,-16
	bne	t4,t0,PulaVerificaEsquerda2
	bne	t3,t1,PulaVerificaEsquerda2
	j	FinalizaAtaqueOportunoInimigo2
PulaVerificaEsquerda2:
	addi	t4,t2,16
	bne	t4,t0,PulaVerificaDireita2
	bne	t3,t1,PulaVerificaDireita2
	j	FinalizaAtaqueOportunoInimigo2
PulaVerificaDireita2:
	addi	t5,t3,-16
	bne	t2,t0,PulaVerificaCima2
	bne	t5,t1,PulaVerificaCima2
	j	FinalizaAtaqueOportunoInimigo2
PulaVerificaCima2:
	addi	t5,t3,16
	bne	t2,t0,PulaVerificaBaixo2
	bne	t5,t1,PulaVerificaBaixo2
	j	FinalizaAtaqueOportunoInimigo2
PulaVerificaBaixo2:
	addi	t6,t6,2
	blt	t6,s4,LoopAtaqueOportunoInimigo2
	j	PulaAcaoOportunoInimigo2
FinalizaAtaqueOportunoInimigo2:
	li	t0, 5
	sw	t0, 16(s7)
	mv	a0,a1
	mv	a1,s7
	call	Luta
	j	FimMovimento
PulaAcaoOportunoInimigo2:
	li	t0, 5
	sw	t0, 16(s7)
	j	FimMovimento
PulaTransformaInimigoCinza:
	li	t0, 1
	la	t1, MenuAtivado
	sb	t0, 0(t1)
FimMovimento:	
	lw	ra, 0(sp) 		# carrega o valor de ra de sp
	addi	sp, sp, 4 		# desaloca a memoria da pilha
	ret 				# volta para quem chamou a funcao
