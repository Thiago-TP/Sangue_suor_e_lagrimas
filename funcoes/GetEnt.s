#################################################################################
# Polling do teclado: congela o jogo ate que o usuario aperte enter no KDMMIO 	#
#################################################################################
#	não recebe registradores ax e nao retorna nada			      	#
#################################################################################
GetEnt:
	addi 	sp, sp, -4
	sw	ra, 0(sp)
LOOP_POLL1:  
	jal 	GET_KEY       		# le o teclado 	non-blocking
	li	t0, '\n'		# carrega o enter no t0
  	beq	t2, t0, END_GET_ENT	# tecla = enter ? mais um loop : fim do poll
	j 	LOOP_POLL1		# volta ao loop
END_GET_ENT:
	lw 	ra, 0(sp)
	addi 	sp, sp, 4
	ret				# retorna
# Apenas verifica se há tecla pressionada
GET_KEY: 
	li 	t1, 0xFF200000		# carrega o endereço de controle do KDMMIO
LOOP_POLL2: 
	lw 	t0, 0(t1)		# Le bit de Controle Teclado
   	andi 	t0, t0, 0x0001		# mascara o bit menos significativo
   	beq 	t0, zero, LOOP_POLL2	# não tem tecla pressionada então volta ao loop
   	lw 	t2, 4(t1)		# le o valor da tecla
   	ret				# retorna
#################################################################################
