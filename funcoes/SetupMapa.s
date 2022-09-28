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
	# inicializacao dos registradores salvos
	mv	s0, zero 	# iniciliaza s0 como zero
	mv	s1, zero 	# inicializa s1 como zero
	mv	s6, sp 		# salvo o endereco inicial de tudo para voltar toda vez depois do loop
	mv	s7, zero	# s7  = struct de posicao do personagem sendo movimentado
	mv	s8, zero	# s8  = struct da posicao atual do cursor
	mv	s9, zero	# s9  = ...
	mv	s10,zero
LoopGame: 
	################ testes de funcoes de controle ####################
	call	VerificaVez	# Vez <- 1 se for a vez do PC
	la	t0, Vez
	lb	t0, 0(t0)
	bnez	t0, VezDoPC	# Vez = 1 ? PC joga (vez do PC ainda nao foi implementada)
	
	call	VerificaWin	# Win <- 1 se for PC morreu
	la	t0, Win
	lb	t0, 0(t0)
	bnez	t0, ProximaFase	# Win ? fim da fase
	
	# Perdeu ainda n foi implementada
	#call	VerificaGameOver	# GameOver <- 1 se jogador morreu
	#la	t0, GameOver
	#lb	t0, 0(t0)
	#bnez	t0, Perdeu	# GameOver ? tela de derrota
	####################################################################
	
	beqz	s9, PulaMovimento
	########################## Trecho que permite movimentacao dinamica ##############################
	# Esse trecho vai roubar o controle total do Movimenta Cursor, logo ele que vai decidir as Idles do personagem em
	# movimento ja que so ele estaria possivelmente trocando para atingir o objetivo
	# Uma consequencia disso eh que so vai sair do movimento quando atingir o objetivo (pode quebrar o jogo se o mapa for dificil)
	# guarda/recupera a sprites do mapa em s7 = posicao do personagem
	lw 	a1, 0(s7)
	lw 	a2, 4(s7)
	# Trecho de codigo responsavel por mover o personagem ao cursor de destino,
	# atualizando a sprite ao longo do caminho (animacao)
	lw	t0, 0(s8)		# t0 <- x do cursor
	beq	t0, a1, PulaEixoX	# x do cursor = x do personagem ? pula : verifica diferenca
	sub	t0, t0, a1 		# se for negativo a1 eh maior que t0 entao preciso decrementar a1
	bltz	t0, PulaEixoXPositivo	# x personagem > x cursor ? pula : move para a direita
	#	aqui so entra se t0 for positivo quer dizer que o idle eh para a direita e preciso incrementar
	addi	a1, a1, 4		# personagem move 4 pixeis para a direita
	sw	a1, 0(s7)		# atualiza struct de posicao do personagem
	li	t0, 2			# moveset eh para direita
	sw	t0, 16(s7)		# atualiza o estado do personagem	
	j	PulaEscolhaEixo
PulaEixoXPositivo:
	addi	a1, a1, -4		# personagem move 4 pixeis para a esquerda ("-4 para a direita")
	sw	a1, 0(s7)		
	li	t0, 3			# moveset eh para esquerda
	sw	t0, 16(s7)	
	j	PulaEscolhaEixo
PulaEixoX:	# Repete-se aqui, no eixo Y, o que foi feito no X
	lw	t0, 4(s8)
	sub	t0, t0, a2 		# se for negativo a1 eh maior que t0 entao preciso decrementar a1
	bltz	t0, PulaEixoYPositivo	
	addi	a2, a2, 4		# personagem move 4 pixeis para baixo
	sw	a2, 4(s7)
	li	t0, 1			# moveset eh para baixo
	sw	t0, 16(s7)	
	j	PulaEscolhaEixo
PulaEixoYPositivo:
	addi	a2, a2, -4		# personagem move 4 pixeis para a cima ("-4 pixeis para baixo")
	sw	a2, 4(s7)
	li	t0, 4			# moveset eh para cima
	sw	t0, 16(s7)		
PulaEscolhaEixo:
	lw	t0, 0(s7)
	lw	t1, 0(s8)
	bne	t0, t1, PulaMovimento	# x personagem =/= x cursor ? mais movimento : verifica x 
	lw	t0, 4(s7)
	lw	t1, 4(s8)
	bne	t0, t1, PulaMovimento	# y personagem =/= y cursor ? mais movimento : chegamos ao destino
	mv	s9, zero		# fim do movimento => s9 = 0
	sw	zero, 16(s7)		# atualiza o estado do personagem para StandBy
	li	t0, 1
	la	t1, MenuAtivado
	sb	t0, 0(t1)
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
	lw	a2, 12(a1) 		# carrega y
	lw	a1, 8(a1) 		# carrega x
	li	a4, 28
	li	a5, 28
	call	SalvaSprite
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
	lw	a2, 4(a1) 		# carrega y
	lw	a1, 0(a1) 		# carrega x
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
	mv	t2, a1
	lw	a2, 12(a1) 		# carrega y
	lw	a1, 8(a1) 		# carrega x
	lw	t0, 0(t2)
	lw	t1, 4(t2)
	sw	t0, 8(t2)
	sw	t1, 12(t2)
	li	a4, 28
	li	a5, 28
	call	RecuperaSprite
	addi	t6, t6, 1 		# incrementa contador
	blt	t6, s4, LoopLimpaPersonagens # se a quantidade maxima for atingida sai da funcao	
	
	li	a0, 140 
	la	t0, Fase
	lb	t0, 0(t0)
	li	t1, 5
	bne	t0, t1, sleepNormal
	li	a0, 170			# sleep da fase 5
sleepNormal:
	
	call 	Sleep			# este sleep so nao funciona no RARS
	la	t0, PosicaoAnteriorCursor
	la 	t1, PosicaoAtualCursor
	lw 	t2, 0(t1)
	sw 	t2, 0(t0)
	lw 	t2, 4(t1)
	sw 	t2, 4(t0)
	addi	s0, s0, 1		# incremento s0 (lembrar que ele controla qual a idle que eu quero printar)
	
	
	############### teste da luta #############
	la	a0, Lyn
	la	a1, Assassin
	lb	t0, 20(a0)
	beqz	t0, pula
	lb	t0, 20(a1)
	beqz	t0, pula
	#call	Luta
pula:	
	###########################################
	j	LoopGame		# volta para LoopStandby
	mv	sp, s2 			# retorna o valor de sp para s2
ProximaFase:	
	la	t0, guardaSP		# recuperando o sp expandido
	lw	sp, 0(t0)
	lw	ra, 0(sp) 		# carrega o valor de ra de sp
	addi	sp, sp, 4 		# desaloca a memoria da pilha
	ret 				# volta para quem chamou a funcao
####################################










VezDoPC:	# vez do pc ainda n foi implementada. No momento, apenas pula de fase
	la	t0, Fase
	lb	t0, 0(t0)
	addi	t0, t0, 1
	li	t1, 5
	bgt	t0, t1, Fase1
	li	t1, 2
	beq	t0, t1, Fase2
	li	t1, 3
	beq	t0, t1, Fase3
	li	t1, 4
	beq	t0, t1, Fase4
	j	Fase5
