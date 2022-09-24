DecideMapa:
	la	t2, Fase		# t2 <- endereco do numero da fase
	lb	t2, 0(t2)		# t2 <- numero da fase
	# escolha de mapa de acordo com a fase
	li	t1, 1
	beq	t2, t1, mapa1	
	li	t1, 2
	beq	t2, t1, mapa2
	li	t1, 3
	beq	t2, t1, mapa3
	li	t1, 4
	beq	t2, t1, mapa4
	li	t1, 5
	beq	t2, t1, mapa5
	
mapa1:	
	la 	a0, tilemap_praia		
	j	fimEscolheMapa
mapa2:	
	la 	a0, tilemap_floresta		
	j	fimEscolheMapa
mapa3:	
	la 	a0, tilemap_estrada		
	j	fimEscolheMapa
mapa4:	
	la 	a0, tilemap_estrada
	j	fimEscolheMapa
mapa5:	
	la 	a0, tilemap_praia
	j	fimEscolheMapa		
fimEscolheMapa:
	ret
