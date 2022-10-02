#########################################################
#	muda o estado dos personagens na tela 		#
#	de vitoria e de derrota, quando for a hora	#
#########################################################
#	- Inputs -		#
#	s1 = estado atual	#
#	s2 = frame		#
#################################
AtualizaEstados:
	li	t0, 3
	rem	s1, s1, t0	# s1 <- estado das sprites
	li	t0, 1
	beq	s1, t0, estado2

	la	t0, animTime12
	lw	t1, 0(t0)
	csrr	t2, time
	sub	t3, t2, t1
	li	t1, 350
	bgeu	t3, t1, mudaEstado
fimAnimaInimigos:
	xori	s2, s2, 1	# troca o frame
	ret
	
mudaEstado:
	la	t0, animTime12
	sw	t2, 0(t0)
	la	t0, animTime23
	sw	t2, 0(t0)

	addi	s1, s1, 1
	
	j	fimAnimaInimigos
estado2:
	la	t0, animTime23
	lw	t1, 0(t0)
	csrr	t2, time
	sub	t3, t2, t1
	li	t1, 50
	bgeu	t3, t1, mudaEstado
	j	fimAnimaInimigos
