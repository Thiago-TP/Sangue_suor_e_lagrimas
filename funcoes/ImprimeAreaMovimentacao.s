#################################################
#	Argumentos:				#
#	a0 = PosicaoAtualCursor			#
#################################################
#################################################
#	Retorna:				#
#	Nada					#
#################################################

ImprimeAreaMovimentacao:
	addi	sp, sp, -4 			# aloco espaco na pilha
	sw	ra, 0(sp) 			# guardo o ponteiro de retorno na pilha
	lw	a6, 0(a0) 			# carrego o valor de x em a6
	lw	a7, 4(a0) 			# carrego o valor de y em a7
	addi	a1, a6, -64 			# adiciono -64 para voltar 4 casas no mapa na posicao x
	addi	a2, a7, -64 			# adiciono -64 para voltar 4 casas no mapa na posicao y
	mv	a5, zero			# inicializa um contador em a5 
LoopImprimeArea:
	li	t0, 9				# limite superior da condicao abaixo 
	beq	a5, t0, SaiLoopImprimeArea 	# condicao para sair do loop se ja printamos toda a area
	li	t0, 240 			# limite superior da condicao abaixo
	bgeu	a2, t0, PulaEssaInteracaoY 	# condicao para saber se teve transbordo na area do bitmap display
	li	t0, 320				# limite superior da condicao abaixo
	bgeu	a1, t0, PulaEssaInteracaoX	# condicao para saber se teve transbordo na area do bitmap display
	call 	DecideMapa
	mv	t0, zero
	beqz	a2, PulaCalculoTileMap1
	li	t1, 16
	div	t2, a2, t1
	li	t1, 20
	mul	t0, t1, t2
PulaCalculoTileMap1:
	beqz	a1, PulaCalculoTileMap2
	li	t1, 16
	div	t2, a1, t1
	add	t0, t0, t2
	addi	t0, t0, -1
PulaCalculoTileMap2:
	add	a0, a0, t0
	lb	a0, 0(a0)
	li	t3, 3
	bne	t3, a0, PulaTileMapVermelho1
	la	a0, seletor_verm
	j	ImprimeTile
PulaTileMapVermelho1:
	li	t3, 4
	bne	t3, a0,PulaTileMapVermelho2
	la	a0, seletor_verm
	j	ImprimeTile
PulaTileMapVermelho2:	
	la	a0, seletor_azul
	li	t6, 1				
LoopVerificaInimigo.AreaMov:
	mv	a7, t6
	mv	s5, a1	
	call EscolhePersonagem # retorna em a1
	li	t1, 6
	lw	t0, 16(a1)
	addi	t6, t6, 2
	bge	t0, t1, PulaTileVermelho
	lw	t0, 0(a1)
	lw	t1, 4(a1)
	mv	a1, s5
	bne	t0, a1, PulaTileVermelho
	bne	t1, a2, PulaTileVermelho
	la	a0, seletor_verm
	j	ImprimeTile
PulaTileVermelho:
	mv	a1, s5
	ble	t6, s4, LoopVerificaInimigo.AreaMov	# verifico se o contador eh diferente de s4 e se for volto pro Loop	
ImprimeTile:
	li	a3, 1 						
	call 	PRINT					
	li	a3, 0						
	call 	PRINT				
PulaEssaInteracaoX:
	addi	a1, a1, 16 			# adiciono 16 em a1 para ir para o proximo quadrado em x
	addi	t0, a6, 80 			# limite superior da condicao abaixo  
	blt	a1, t0, LoopImprimeArea 	# condicao para voltar para o loop enquanto nao tiver printado todos os quadrados em x
PulaEssaInteracaoY:
	addi	a1, a6, -64			# reseta o valor de x para printar a nova linha
	addi	a5, a5, 1 			# adiciono em 1 o contador
	addi	a2, a2, 16			# adiciono 16 em a1 para ir para o proximo quadrado em y
	addi	t0, a7, 80			# limite superior da condicao abaixo  
	blt	a2, t0, LoopImprimeArea		# condicao para voltar para o loop enquanto nao tiver printado todos os quadrados em y
SaiLoopImprimeArea:
	lw	ra, 0(sp) 			# carrego o ponteiro de retorno de volta da pilha
	addi	sp, sp, 4 			# desaloco espaco da memoria da pilha
	ret					# volto para a funcao chamadora 
