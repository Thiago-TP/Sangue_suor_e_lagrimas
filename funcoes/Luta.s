#########################################################
#	criacao e teste de um ambiente de luta		#
#	automatico estilo Fire Emblem para o jogo	#
#########################################################
#	- Inputs -					#
#	a0 = .data (struct) do personagem 1		#
#	a1 = .data (struct) do personagem 2		#
#########################################################
Luta:
.data	
	VoceAtacou:	.string	"Voce atacou!"
	PcAtacou:	.string "O inimigo atacou!"
	Critou:		.string "Critico!"
	Errou:		.string "Errou!"

.text
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
	#la	a0, tilemap_estrada	# trocar esse tilemap pelo fundo de verdade
	call	ClearScreen
	li	t0, 0xFF200604
	sw	x0, 0(t0)	
	
	# imprime personagens
	li	a1, 40		# x do lutador na esquerda
	#li	a2, 100		# y
	lb	a0, 14(s0)	# a0 <- codigo do personagem do time do jogador
	call	DecideLutador	# a0 <- sprite de luta do personagem do jogador
	li	a3, 0		# frame
	call	PrintByte		# impressao no bitmap
	
	lb	a0, 14(s1)	# a0 <- codigo do personagem do time do pc
	li	a1, 240		# x do lutador na direita
	call	DecideLutador	# a0 <- sprite de luta do personagem do pc
	call	PrintByte		# impressao no bitmap
	
	# imprime barras de vida
	lb	s2, 12(s0)	# s2 <- HP do jogador
	mv	a0, s2		# a0 <- HP do jogador
	li 	a1, 0		# a1=0 => barra esquerda (jogador)
	li 	a2, 0		# a2=0 => aumenta a barra de vida
	call 	PrintHP		# imprime a barra em si
	li	a1, 24		# x
	li	a2, 184		# y
	li	a3, 0		# cor
	li	a4, 0		# frame
	call	printInt	# imprime a quantidade de HP
	
	
	lb	s2, 12(s1)	# s2 <- HP do pc
	mv	a0, s2		# a0 <- HP do pc
	li 	a1, 1		# a1=1 => barra direita (PC)
	li 	a2, 0		# a2=0 => aumenta a barra de vida
	call 	PrintHP		# imprime a barra em si
	li	a1, 284		# x
	li	a2, 184		# y
	li	a3, 0		# cor
	li	a4, 0		# frame
	call	printInt	# imprime a quantidade de HP			
	
	# 1 ataque do jogador
	# mensagem
	la	a0, VoceAtacou	# a0 <- "Voce atacou!"
	li	a1, 112		# x
	li	a2, 116		# y
	li	a3, 0		# cor
	li	a4, 0		# frame
	call	printString	# impressao da mensagem
	# ataque em si
	lb	a0, 13(s0)	# a0 <- tipo de arma do jogador
	lb	a1, 13(s1)	# a1 <- tipo de arma do pc
	call	Ataque		# a0 <- dano

	call	AtualizaJogo
	# atualizacao da barra de vida do PC
	lb	s2, 12(s1)	# s2 <- vida atual do pc
	li	a1, 1		# a1 = 1 => barra direita
	call	AtualizaHP	# imprime barra e numero de HP pos ataque
				# a0 <- vida anterior - dano ou 0
	
	sb	a0, 12(s1)	# HP do struct do pc atualizado 
	beqz	a0, fimLuta
	
	# 1 ataque do pc
	la	a0, PcAtacou	# a0 <- "O inimigo atacou!"
	li	a1, 92		# x
	li	a2, 116		# y
	li	a3, 0		# cor
	li	a4, 0		# frame
	call	printString	# impressao da mensagem
	# ataque em si
	lb	a0, 13(s1)	# a0 <- tipo de arma do pc
	lb	a1, 13(s0)	# a1 <- tipo de arma do jogador
	call	Ataque		# a0 <- dano

	call	AtualizaJogo
	# atualizacao da barra de vida do jogador
	lb	s2, 12(s0)	# s2 <- vida atual do jogador
	li	a1, 0		# a1 = 0 => barra esquerda
	call	AtualizaHP	# imprime barra e numero de HP pos ataque
				# a0 <- vida anterior - dano

	sb	a0, 12(s0)	# HP do struct do jogador atualizado 
	
	# fim da luta
fimLuta:
	li	a0, 800
	call	Sleep		# sleep de 1s
	# imprime fundo
	call	DecideMapa
	#la	a0, tilemap_estrada	# trocar esse tilemap pelo fundo de verdade
	call	ClearScreen
	#la	a0, tilemap_estrada	
	#call	ClearScreen		# fim da luta => imprime o tilemap nas duas frames
	
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

CobreMensagem:	
	li	a1, 128
	li	a2, 210
	
	add 	t0, x0, a1 	# adiciona x ao t0
	li 	t1, 320 	# t1 = 320
	mul 	t1, t1, a2 	# multiplica y por t1
	add 	t0, t0, t1 	# coloca o valor final do calculo do endereço em t0
	li	t1, 0xFF100000
	add 	t6, t1, t0 	# salvo o endereco da imagem passada para a funcao em a0
	li	t1, 0xFF000000
	add 	t0, t1, t0
	mv 	t1, zero 	# zera t2
	mv 	t2, zero 	# zera t3
	li 	t3, 64 		# carrega a largura em t3
	li 	t4, 8 		# carrega a altura em t4
	# ate aqui estamos no primeiro endereco da imagem e no endereço que escolhemos no bitmap
CobreLinha:	
	lbu 	t5, 0(t6) 	# carrega em t6 um byte (1 pixel) da imagem	
	#li	t5, 200	
	sb 	t5, 0(t0) 		# imprime no bitmap a word (4 pixeis) da imagem
	addi 	t0, t0, 1 		# incrementa endereco do bitmap
	addi 	t6, t6, 1 		# incrementa endereco da imagem
	addi 	t2, t2, 1 		# incrementa contador de coluna
	blt 	t2, t3, CobreLinha	# se contador da coluna < largura,  continue imprimindo
	addi	t0, t0, 320 		# t0 += 320
	sub 	t0, t0, t3 		# t0 -= largura da imagem
	addi	t6, t6, 320 		# t0 += 320
	sub 	t6, t6, t3 		# t0 -= largura da imagem
	# ^ isso serve pra "pular" de linha no bitmap display
	mv 	t2, zero 		# zera t3 (contador de coluna)
	addi 	t1, t1, 1 		# incrementa contador de linha
	bgt 	t4, t1, CobreLinha # se altura > contador de linha, continue imprimindo
	ret
	
AtualizaJogo:
	addi	sp, sp, -8
	sw	ra, 0(sp)
	sw	a0, 4(sp)
	
	bnez	a0, Hit	
	la	a0, Errou	# a0 
	li	a1, 136		# x
	li	a2, 210		# y
	li	a3, 0		# cor
	li	a4, 0		# frame
	call	printString	# impressao da mensagem
	lw	a0, 4(sp)
	j	SFXatk
Hit:
	li	t1, 8
	beq	a0, t1, Crit
	li	t1, 11
	beq	a0, t1, Crit
	li	t1, 15
	beq	a0, t1, Crit
	j	SFXatk
Crit:
	la	a0, Critou	
	li	a1, 128		# x
	li	a2, 210		# y
	li	a3, 0		# cor
	li	a4, 0		# frame
	call	printString	# impressao da mensagem
	lw	a0, 4(sp)
SFXatk:
	call	midiAtaque	# somzinho de ataque + sleep
	call	CobreMensagem	# cobre a mensagem de critico/erro

	lw	ra, 0(sp)
	lw	a0, 4(sp)
	addi	sp, sp, 8
	ret	
