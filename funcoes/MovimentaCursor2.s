MovimentaCursor2:	
	li 	t1, 0xFF200000		# carrega o endereço de controle do KDMMIO
   	lw 	t0, 0(t1)			# le bit de Controle Teclado
	andi 	t0, t0, 0x0001			# mascara o bit menos significativo
   	lw 	t1, 4(t1)
   	beq 	t0, zero, FimMovimentaCursor2   	# se nao ha tecla pressionada entao vai para FIM
   	li	t0, 'd'
   	beq	t1, t0, opcaoDireita						
	li	t0, 'a'
   	beq	t1, t0, opcaoEsquerda
   	li	t0, '\n'
   	beq	t1, t0, DecideMudanca2
FimMovimentaCursor2:
	ret
	
opcaoDireita:							
	li	s0, 1
	j	FimMovimentaCursor2 	
opcaoEsquerda:							
	li	s0, 0
	j	FimMovimentaCursor2 
		
DecideMudanca2:
	beqz	s0, jogaDenovo
	j	FimSetupVitoria
jogaDenovo:
	li	t0,1
	la	t1,GuardaHack
	sb	t0,0(t1)
	la	t0, MenuAtivado
	sb	x0, 0(t0)	
	j	FimSetupVitoria

MovimentaCursor3:	
	li 	t1, 0xFF200000		# carrega o endereço de controle do KDMMIO
   	lw 	t0, 0(t1)			# le bit de Controle Teclado
	andi 	t0, t0, 0x0001			# mascara o bit menos significativo
   	lw 	t1, 4(t1)
   	beq 	t0, zero, FimMovimentaCursor3  	# se nao ha tecla pressionada entao vai para FIM
   	li	t0, 'd'
   	beq	t1, t0, opcaoDireita2						
	li	t0, 'a'
   	beq	t1, t0, opcaoEsquerda2
   	li	t0, '\n'
   	beq	t1, t0, DecideMudanca3
FimMovimentaCursor3:
	ret
	
opcaoDireita2:							
	li	s0, 1
	j	FimMovimentaCursor3 	
opcaoEsquerda2:							
	li	s0, 0
	j	FimMovimentaCursor3 
		
DecideMudanca3:
	beqz	s0, jogaDenovo2
	j	FimSetupDerrota
jogaDenovo2:
	li	t0,1
	la	t1,GuardaHack
	sb	t0,0(t1)
	la	t0, MenuAtivado
	sb	x0, 0(t0)	
	j	FimSetupDerrota
