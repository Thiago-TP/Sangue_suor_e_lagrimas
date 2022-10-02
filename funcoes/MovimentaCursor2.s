MovimentaCursor2:	
	li 	t0, 0xFF200000		# carrega o endereço de controle do KDMMIO
   	lw 	t1, 4(t0)		# le o valor da tecla
   	
   	li	t0, 'd'
   	beq	t1, t0, opcaoDireita						
	li	t0, 'a'
   	beq	t1, t0, opcaoEsquerda
   	li	t0, '\n'
   	beq	t1, t0, DecideMudanca2
fimMovimenta2:
	ret
	
opcaoDireita:							
	li	s0, 1
	j	fimMovimenta2	
opcaoEsquerda:							
	li	s0, 0
	j	fimMovimenta2
		
DecideMudanca2:
	beqz	s0, jogaDenovo
	li	a7, 10
	ecall
jogaDenovo:
	la	t0, MenuAtivado
	sb	x0, 0(t0)	
	j	Fase1