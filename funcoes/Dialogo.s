#########################################################################################
#	Objetivo: funcao que recebe duas sprites de personagens e 			#
#	uma linha de fala de cada e mostra o di�logo entre elas no bitmap		#
#	Na linha final de cada fala, espera-se o usu�rio apertar enter (\n),		#
#	passando para a proxima fala ou fim da funcao, se for a segunda fala.		#
#	Para dialogo com mais de duas linhas, chame esta funcao novamente :/		#
#	A caixa de texto comporta string de ate ~120 caracteres, e os caracteres	#
#	imprimiveis vao do ASCII 32 (space) ao 126(~)					#
#########################################################################################
#	a0 -> endereco da fala (string) da personagem 1/esquerda			#
#	a1 -> endereco da fala (string) da personagem 2/direita				#
#	a2 -> endereco da sprite do personagem 1 - fica na esquerda			#
#	a3 -> endereco da sprite do personagem 2 - fica na direita			#
#	a4 -> flag de cinza (0 ou 1)							#
#########################################################################################
#	s0 -> tela original em tilemap (atual tela jog�vel)				#
#	s1 -> frame original								#
#	s2 -> frame oposto ao original							#
#########################################################################################
Dialogo:	
	# armazenamento de seguranca dos registradores (os de cima mais ra)
	addi 	sp, sp, -32
	sw	ra, 0(sp)
	sw	a0, 4(sp)
	sw	a1, 8(sp)
	sw	a2, 12(sp)
	sw	a3, 16(sp)
	sw	s1, 20(sp)
	sw	s2, 24(sp)
	sw	a4, 28(sp)
	# determinacao do frame inicial (s1) e o outro frame (s2)
	li 	t0, 0xFF200604  # carrega o endereco de escolha da frame
	lw 	s1, 0(t0) 	# s1 <- frame da tela original 
	xori	s2, s1, 1	# s2 <- frame inverso
	# impressoes de sprites
	# imprime os mugshots em ambos os frames	
	lw	a0, 12(sp)	# a0 <- mugshot1
	mv	a1, zero	# x = 0
	li	a2, 164		# y = 164
	mv	a3, s1		# frame = inicial
	li	a4, 0
	call	PrintByte	# impressao do mugshot1 no frame inicial
	mv	a3, s2		# frame = outro
	li	a4, 1
	call	PrintByte	# impressao do mugshot1 no outro frame
	
	lw	a0, 16(sp)	# a0 <- mugshot2
	li	a1, 240		# x = 240, y = 164
	li	a4, 0
	call	PrintByte	# impressao do mugshot2 no outro frame
	mv	a3, s1		# frame = inicial
	li	a4, 1
	call	PrintByte	# impressao do mugshot2 no frame inicial
	# imprime o rabinho esquerdo
	la 	a0, rabo_esquerdo	# tilemap do balao	
	li	a1, 144		# x = 154
	li	a2, 94		# y = 95 
	call 	PRINT		# impressao do rabinho esquerdo	
	# imprime o balao esq e a fala esq
	lw	a1, 4(sp)	# a1 = fala esq
	mv	a2, s1		# impressao na frame inicial
	call 	PrintFala	# imprime o balao e depois a fala
	# espera enter
	call	GetEnt		# keypoll para o enter
	# muda a frame apos keypoll
	li 	t0, 0xFF200604  # carrega o endereco de escolha da frame	
	sw	s2, 0(t0)	# muda o frame 
	# imprime o rabinho direito
	la 	a0, rabo_direito	# tilemap do balao	
	li	a1, 152		# x = 160
	li	a2, 94		# y = 95
	mv 	a3, s2		# a3 <- outra frame 
	call 	PRINT		# impressao do rabinho direito
	# imprime o balao dir e a fala dir
	lw	a1, 8(sp)	# a1 = fala dir
	mv	a2, s2		# impressao na outra frame
	call 	PrintFala	# imprime o balao e depois a fala
	# espera enter
	call	GetEnt		# keypoll para o enter

	# retorno ao frame original	
	li 	t0, 0xFF200604  # carrega o endereco de escolha da frame	
	sw	s1, 0(t0)	# volta ao frame inicial
	
	lw	ra, 0(sp)	# recuperacao dos registradores
	lw	a0, 4(sp)	
	lw	a1, 8(sp)
	lw	a2, 12(sp)
	lw	a3, 16(sp)
	lw	s1, 20(sp)
	lw	s2, 24(sp)
	lw	a4, 28(sp)	
	addi 	sp, sp, 32	# fechamento da pilha
	ret			# retorno da funcao
#########################################################################################
