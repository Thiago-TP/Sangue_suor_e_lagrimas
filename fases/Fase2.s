Fase2:	
	addi	sp, sp, -4
	sw	ra, 0(sp)
	
	la	t0, musicTime	
	la	t1, noteCounter
	la	t2, Vez
	la	t3, GameOver
	la	t4, Win
	la	t5, MenuPause
	li	t6,255
	sw	zero, 0(t0)
	sw	zero, 0(t1)
	sb	zero, 0(t2)
	sb	zero, 0(t3)
	sb	zero, 0(t4)
	sb	t6, 0(t5)
	sb	zero, 1(t5)
	sb	zero, 2(t5)
	sb	zero, 3(t5)
	sb	zero, 4(t5)
	sb	zero, 5(t5)
	sb	zero, 6(t5)
	
	call	InicializaPersonagens
	
	la	t0, Fase
	li	t1, 2
	sb	t1, 0(t0)		# num fase = 2

	call	Dialogo2		# nao existe no momento	
			
	li	a5, 4			# a5 <- quantidade de personagens (aliados + inimigos)
	la	a0, tilemap_floresta
	call 	SetupMapa		# funcao no MapaMain	
	
	lw	ra, 0(sp)
	addi	sp, sp, 4
	ret																

#.include "Dialogo2.s"
