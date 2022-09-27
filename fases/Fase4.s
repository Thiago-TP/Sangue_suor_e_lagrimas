Fase4:	
	addi	sp, sp, -4
	sw	ra, 0(sp)
	
	la	t0, musicTime	
	la	t1, noteCounter
	la	t2, Vez
	la	t3, GameOver
	la	t4, Win
	sw	zero, 0(t0)
	sw	zero, 0(t1)
	sb	zero, 0(t2)
	sb	zero, 0(t3)
	sb	zero, 0(t4)
	
	call	InicializaPersonagens
	
	la	t0, Fase
	li	t1, 4
	sb	t1, 0(t0)		# num fase = 4 
	
	call	Dialogo4		# nao existe no momento	
			
	li	a5, 8			# a5 <- quantidade de personagens (aliados + inimigos)
	la	a0, tilemap_FimDaEstrada
	call 	SetupMapa		# funcao no MapaMain	
	
	lw	ra, 0(sp)
	addi	sp, sp, 4
	ret																
