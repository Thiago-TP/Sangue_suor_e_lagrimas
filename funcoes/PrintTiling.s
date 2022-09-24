#################################################################################
#	Esta funcao imprime pela tecnica tiling uma sprite no bitmap		#
#	na posicao inicial e no frame dado. Para o tiling, eh necessario o	#
#	endereco do mapa/matriz indice <-> conteudo, chamado aqui de tile_map	# 
#################################################################################
#	a0 <- endereco do tile_map a ser impresso				#
#	a1 -> pos. em x da impressao no bitmap					#
#	a2 -> pos. em y da impressao no bitmap					#
#	a3 -> frame da impressao no bitmap					#
#	a4 -> contador de tiles impressas					#
#################################################################################
#	s0 -> endereco do mapa							#
#	s1 -> quantidade total de tiles						#
#	t0 -> comparador							#	
#	t1 -> valor do tile no indice						#
#################################################################################

# Deixei aqui somente para tile de mapa, o dialogo não era necessario de fato um tile, era bem comportado.
# o menu também não precisava fiz uma função pra cada estão bem parecidas mas acho melhor não tentar generalizar.

PrintTiling:
	addi 	sp, sp, -28	# expansao da pilha
	sw	ra, 0(sp)	# armazenamento de seguranca dos registradores
	sw	a1, 8(sp)
	sw	a2, 12(sp)
	sw	a4, 16(sp)
	sw	a5, 20(sp)
	sw	a0, 24(sp)
	# fazer um calculo simples para saber quantos a gente quer >:)
	sub	t0,a4,a1
	sub	t1,a5,a2
	mul	t0,t0,t1
	mv	a6,t0
	
	mv 	a4, a1
	mv	a5, a2
	li	t0, 20
	mul	t0, t0, a2
	add	t0, t0 ,a1
	add	a0, a0, t0
tilingLoop:
	beqz 	a6, tilingLoopEnd	# contador = num_tiles ? mais um loop : fim
	lb	t1, 0(a0)	# t1 recebe o mapeamento do tiling
	addi	a0, a0, 1
	sw	a0, 4(sp)


# tiles da fase 1 #
tile1:	li	t0, 1
	bne	t1, t0, tile2
	la	a0, TileAreia
	j	endPrintTile
tile2:	li	t0, 2
	bne	t1, t0, tile3
	la	a0, TileBeiraMar
	j	endPrintTile
tile3:	li	t0, 3
	bne	t1, t0, tile4
	la	a0, TileMar
	j	endPrintTile
tile4:	li	t0, 4
	bne	t1, t0, tile5
	la	a0, TileTubarao
	j	endPrintTile
tile5:	li	t0, 5
	bne	t1, t0, tile6
	la	a0, TileCasa
	j	endPrintTile
tile6:	li	t0, 6
	bne	t1, t0, tile7
	la	a0, TilePedra
	j	endPrintTile
#-----------------------------------#


# tiles da fase 2 #
tile7:	li	t0, 7
	bne	t1, t0, tile8
	la	a0, TileGrama
	j	endPrintTile
tile8:	li	t0, 8
	bne	t1, t0, tile9
	la	a0, TileFloresta
	j	endPrintTile	
#-----------------------------------#


# tiles da fase 3 #
tile9:	li	t0, 9
	bne	t1, t0, tile10
	la	a0, TileFlorestaTarde
	j	endPrintTile
tile10:	li	t0, 10
	bne	t1, t0, tile11
	la	a0, TileGramaTarde
	j	endPrintTile
tile11:	li	t0, 11
	bne	t1, t0, tile12
	la	a0, TileGramaChaoD
	j	endPrintTile
tile12:	li	t0, 12
	bne	t1, t0, tile13
	la	a0, TileGramaChaoE
	j	endPrintTile
tile13:	li	t0, 13
	bne	t1, t0, tile14
	la	a0, TileChao
	j	endPrintTile
#-----------------------------------#


# tiles da fase 4 #
tile14:	li	t0, 14
	bne	t1, t0, tile15
	la	a0, TileGramaNoite
	j	endPrintTile
tile15:	li	t0, 15
	bne	t1, t0, tile16
	la	a0, TileFlorestaNoite
	j	endPrintTile
tile16:	li	t0, 16
	bne	t1, t0, tile17
	la	a0, TileGramaChaoNoite
	j	endPrintTile
tile17:	li	t0, 17
	bne	t1, t0, tile18
	la	a0, TileChaoNoite
	j	endPrintTile
tile18:	li	t0, 18
	bne	t1, t0, tile19
	la	a0, TileGramaChaoNoiteD
	j	endPrintTile
tile19:	li	t0, 19
	bne	t1, t0, tile20
	la	a0, TileCD
	j	endPrintTile
tile20:	li	t0, 20
	bne	t1, t0, tile21
	la	a0, TileCE
	j	endPrintTile
tile21:	li	t0, 21
	bne	t1, t0, tile22
	la	a0, TileFim
	j	endPrintTile
#-----------------------------------#


# tiles da fase 5 #
tile22:	li	t0, 22
	bne	t1, t0, tile23
	la	a0, TileNeve
	j	endPrintTile
tile23:	li	t0, 23
	bne	t1, t0, tile24
	la	a0, TilePedraFria
	j	endPrintTile
tile24:	li	t0, 24
	bne	t1, t0, endPrintTile
	la	a0, TileArvoreNeve
	j	endPrintTile
#-----------------------------------#	
	
	
endPrintTile:
	# aqui eu preciso converter para bits
	li	t0, 16
	mul	a1, a1, t0
	mul	a2, a2, t0
	call 	PRINT		# imprime a tile
	lw	a0, 4(sp)	# a0 <- endereco do tilemap, para a funcao calculaPos
	mv	a1, a4
	mv	a2, a5
	addi	a1, a1, 1
	lw	t0, 16(sp)
	rem	a1, a1, t0
	bnez	a1, PulaIncrementaY
	addi	a2, a2, 1
	lw	a1, 8(sp)
	lw	t0, 16(sp)
	li	t1, 20
	sub	t1, t1, t0
	add	a0, a0, a1
	add	a0, a0, t1
	mv	a5, a2
PulaIncrementaY:
	mv	a4, a1
	addi	a6, a6, -1
	j	tilingLoop	# retorno ao loop

tilingLoopEnd:
	lw	ra, 0(sp)	# recuperacao dos registradores nao-temporarios modificados
	lw	a1, 8(sp)
	lw	a2, 12(sp)
	lw	a4, 16(sp)
	lw	a5, 20(sp)
	lw	a0, 24(sp)
	addi 	sp, sp, 28	# contracao da pilha
	ret			# retorno por pseudoinstrucao
#################################################################################
