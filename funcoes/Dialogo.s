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
#	a2 -> mugshot do personagem na esquerda						#
#	a3 -> mugshot do personagem na direita						#
#########################################################################################
Dialogo:	
	# armazenamento de seguranca dos registradores (os de cima mais ra)
	addi 	sp, sp, -24
	sw	ra, 0(sp)
	sw	a0, 4(sp)
	sw	a1, 8(sp)
	sw	a2, 12(sp)
	sw	a3, 16(sp)
	sw	a4, 20(sp)
	
	
	# fixa no frame 0
	li	t0, 0xFF200604
	sw	zero, 0(t0)
	
	# balao esquerdo
	mv	a3, zero		# frame
	call	PrintBalao
	la 	a0, rabo_esquerdo		
	li	a1, 144			# x = 144
	li	a2, 94			# y = 94 
	li	a4, 0
	call 	PrintByte		# impressao do rabinho esquerdo	
	# balao direito
	li	a3, 1			# frame
	call	PrintBalao
	la 	a0, rabo_direito		
	li	a1, 152			# x = 152
	li	a2, 94			# y = 94
	li	a4, 0
	call 	PrintByte		# impressao do rabinho direito
	
	# mugshots da garota
	lw	a0, 12(sp)		# a0 <- personagem na esquerda
	li	a1, 0
	li	a2, 164
	li	a3, 0
	li	a4, 0
	call	PrintByte		# colorido no frame 0
	li	a3, 1
	li	a4, 1
	call	PrintByte		# cinza no frame 1
	# mugshots da Lyn
	lw	a0, 16(sp)		# a0 <- personagem na esquerda
	li	a1, 240
	li	a2, 164
	li	a3, 0
	li	a4, 1
	call	PrintByte		# cinza no frame 0
	li	a3, 1
	li	a4, 0
	call	PrintByte		# colorido no frame 1
	
	# fala esquerda
	lw	a0, 4(sp)		# a0 <- string 1
	li	a1, 10
	li	a2, 10
	li	a3, 0x0000c700		# fundo invisivel com letra preta
	li	a4, 0			# frame
	call	printString
	li 	a0, 750		
	call 	Sleep 			# pausa			
	li 	a0, '>'			# caracter de proxima fala
	li 	a1, 304		
	li 	a2, 80		
	li 	a3, 0x0000c7a0		# fundo invisivel com letra marinho 
	call 	printChar		# seta		
	li 	a0, 750			
	call 	Sleep 			# pausa				
	
	call	GetEnt			# keypoll para o enter do usuario
	li	t0, 0xFF200604
	li	t1, 1
	sw	t1, 0(t0)		# vai ao frame 1
	
	li	a1, 10
	li	a2, 10
	call	LimpaFala		# limpa a fala da esq.
	
	# fala direita
	lw	a0, 8(sp)		# a0 <- string 2
	li	a1, 10
	li	a2, 10
	li	a3, 0x0000c700		# fundo invisivel com letra preta
	li	a4, 1			# frame
	call	printString
	li 	a0, 750		
	call 	Sleep 			# pausa			
	li 	a0, '>'			# caracter de proxima fala
	li 	a1, 304		
	li 	a2, 80		
	li 	a3, 0x0000c7a0		# fundo invisivel com letra marinho 
	call 	printChar		# seta			
	li 	a0, 750			
	call 	Sleep			# pausa
	
	call	GetEnt			# keypoll para o enter do usuario
	
	# fim da funcao
	lw	ra, 0(sp)
	lw	a0, 4(sp)
	lw	a1, 8(sp)
	lw	a2, 12(sp)
	lw	a3, 16(sp)
	lw	a4, 20(sp)
	addi 	sp, sp, 24
	ret
#################################################	
