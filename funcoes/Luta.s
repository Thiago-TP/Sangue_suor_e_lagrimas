#########################################################
#	criacao e teste de um ambiente de luta		#
#	automatico estilo Fire Emblem para o jogo	#
#########################################################
#	- Inputs -					#
#	a0 = .data (struct) do personagem 1		#
#	a1 = .data (struct) do personagem 2		#
#########################################################
Luta:
	addi	sp, sp, -36
	sw	ra, 0(sp)
	sw	a0, 4(sp)
	sw	a1, 8(sp)
	sw	a2, 12(sp)
	sw	a3, 16(sp)
	sw	a4, 20(sp)
	sw	s0, 24(sp)
	sw	s1, 28(sp)
	sw	s2, 32(sp)
	mv 	s0, a0		# labels em registradores salvos para facilitar manipulacao
	mv	s1, a1
	# imprime fundo
	call	DecideMapa
	li 	a1, 0
	li	a2, 0
	li	a4, 20
	li	a5, 15
	call	ClearScreen
	li	t0, 0xFF200604
	sw	x0, 0(t0)	# mostra o frame 0	
	# imprime personagens
	li	a1, 40		# x do lutador na esquerda
	lb	a0, 22(s0)	# a0 <- codigo do personagem do time do jogador
	call	DecideLutador	# a0 <- sprite de luta do personagem do jogador
	li	a3, 0		# frame
	call	PrintByte	# impressao no bitmap
	lb	a0, 22(s1)	# a0 <- codigo do personagem do time do pc
	li	a1, 240		# x do lutador na direita
	call	DecideLutador	# a0 <- sprite de luta do personagem do pc
	call	PrintByte	# impressao no bitmap
	# imprime barras de vida
	lb	s2, 20(s0)	# s2 <- HP do jogador
	mv	a0, s2		# a0 <- HP do jogador
	li 	a1, 0		# a1=0 => barra esquerda (jogador)
	li 	a2, 0		# a2=0 => aumenta a barra de vida
	call 	PrintHP		# imprime a barra em si		
	li	a1, 24		# x
	li	a2, 184		# y
	li	a3, 0x0000ff00	# cor
	li	a4, 0		# frame
	call	printInt	# imprime a quantidade de HP
	la	a0, square
	li	a1, 42		# x
	li	a2, 178		# y
	li	a3, 0		# cor
	li	a4, 0		# frame
	call	PrintByte
	mv	a0, s0
	call	SimboloArma	# a0 <- simbolo da arma
	li	a1, 44
	li	a2, 180
	li	a3, 0
	li	a4, 0
	call	PrintByte
	lb	s2, 20(s1)	# s2 <- HP do pc
	mv	a0, s2		# a0 <- HP do pc
	li 	a1, 1		# a1=1 => barra direita (PC)
	li 	a2, 0		# a2=0 => aumenta a barra de vida
	call 	PrintHP		# imprime a barra em si
	li	a1, 284		# x
	li	a2, 184		# y
	li	a3, 0x0000ff00	# cor
	li	a4, 0		# frame
	call	printInt	# imprime a quantidade de HP
	la	a0, square
	li	a1, 262		# x
	li	a2, 178		# y
	li	a3, 0		# cor
	li	a4, 0		# frame
	call	PrintByte
	mv	a0, s1
	call	SimboloArma	# a0 <- simbolo da arma
	li	a1, 264
	li	a2, 180
	li	a3, 0
	li	a4, 0
	call	PrintByte	
	call	SimboloSetas		
	# 1 ataque do jogador
	# mensagem
	la	a0, VoceAtacou	# a0 <- "Voce atacou!"
	li	a1, 112		# x
	li	a2, 116		# y
	li	a3, 0x0000ff00	# cor
	li	a4, 0		# frame
	call	printString	# impressao da mensagem
	# ataque em si
	lb	a0, 21(s0)	# a0 <- tipo de arma do jogador
	lb	a1, 21(s1)	# a1 <- tipo de arma do pc
	call	Ataque		# a0 <- dano
	li	t0, 0
	call	TerrenoEspecial	# modifica o dano de acordo com a posicao do atacante no mapa
	call	AtualizaLuta
	# atualizacao da barra de vida do PC
	lb	s2, 20(s1)	# s2 <- vida atual do pc
	li	a1, 1		# a1 = 1 => barra direita
	call	AtualizaHP	# imprime barra e numero de HP pos ataque
				# a0 <- vida anterior - dano ou 0
	sb	a0, 20(s1)	# HP do struct do pc atualizado 
	beqz	a0, fimLuta
	# 1 ataque do pc
	li	a1, 112		# pos em x
	li	a2, 116		# pos em y
	li	a3, 96		# largura
	li	a4, 8		# altura
	call	CobreMensagem	# cobre a mensagem anterior
	la	a0, PcAtacou	# a0 <- "O inimigo atacou!"
	li	a1, 92		# x
	li	a2, 116		# y
	li	a3, 0x0000ff00	# cor
	li	a4, 0		# frame
	call	printString	# impressao da mensagem
	# ataque em si
	lb	a0, 21(s1)	# a0 <- tipo de arma do pc
	lb	a1, 21(s0)	# a1 <- tipo de arma do jogador
	call	Ataque		# a0 <- dano
	li	t0, 1
	call	TerrenoEspecial	# modifica o dano de acordo com a posicao do atacante no mapa
	call	AtualizaLuta
	# atualizacao da barra de vida do jogador
	lb	s2, 20(s0)	# s2 <- vida atual do jogador
	li	a1, 0		# a1 = 0 => barra esquerda
	call	AtualizaHP	# imprime barra e numero de HP pos ataque
				# a0 <- vida anterior - dano
	sb	a0, 20(s0)	# HP do struct do jogador atualizado 
fimLuta:
	lb	t0, 20(s0)
	bnez	t0, PulaMorte1
	li	t0, 6
	sb	t0, 16(s0)
PulaMorte1:
	lb	t0, 20(s1)
	bnez	t0, PulaMorte2
	li	t0, 6
	sb	t0, 16(s1)
PulaMorte2:
	li	a0, 800
	call	Sleep		# sleep 
	# imprime fundo
	call	DecideMapa
	li 	a1, 0
	li	a2, 0
	li	a4, 20
	li	a5, 15
	call	ClearScreen
	lw	ra, 0(sp)
	lw	a0, 4(sp)
	lw	a1, 8(sp)
	lw	a2, 12(sp)
	lw	a3, 16(sp)
	lw	a4, 20(sp)
	lw	s0, 24(sp)
	lw	s1, 28(sp)
	lw	s2, 32(sp)
	addi	sp, sp, 36
	ret	