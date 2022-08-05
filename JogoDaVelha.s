.data	
	BOARD: 				.word 0,0,0,0,0,0,0,0,0
	posicao_seletor: 		.half 60,24 
	posicao_seletor_velha: 		.half 60,24
.text

####################################### MACROS ##########################################

.macro CarregaSprite(%sprite,%posicao)
	mv 	a0, %sprite # carrega o sprite especicado no endereço da label
	la 	a4, %posicao # carrega o endereço da label posição personagem
	lh 	a1, 0(a4) # atribui o primeiro valor da posição em a1
	lh 	a2, 2(a4) # atribui o primeiro valor da posição em a2
.end_macro

################################# Programa Principal ####################################

Setup:	
	la	a0, Image11 # carrega o endereço da tela de escolha de dificuldade
	li 	a1, 0 # x = 0
	li 	a2, 0 # y = 0
	li 	a3, 1 # frame=1
	call 	PRINT # Chama a função print para printar a segunda tela
	li	s7, 0 # inicia com o valor do simbolo escolhido pelo jogador como zero
	la	a0, Image6 # carrega o endereço da tela de escolha de simbolo
	li 	a1, 0 # x = 0
	li 	a2, 0 # y = 0
	li	a3, 0 # troca o frame ques estava
	call 	PRINT # chama a função print para printar a tela de escolha de simbolo
	li	a0, 0
LOOP1:
	la	a1, Image10 # O selecionado
	la	a2, Image7 # X nao selecionado
	la	a4, Image8 # X selecionado
	la	a5, Image9 # O nao selecionado
	li 	t1, 0xFF200000 # carrega o endereco de controle do KDMMIO
	lw 	t0, 0(t1) # Le bit de Controle Teclado
	andi 	t0, t0,0x0001 # mascara o bit menos significativo
   	beq 	t0, zero,FIM_Setup1 # Se nao ha tecla pressionada entao vai para FIM
  	lw 	t2, 4(t1) # le o valor da tecla teclada
	li 	t0, '\n' # carrega o valor da tecla enter em t0
	bne 	t0, t2,Char_Esquerda_Setup1 # se t2 não foi igual a t0 pula para a label
	add 	s7, s7, a0 # até aqui a0 ainda é o resultado de Movimenta_Setup
	j	Exit_Setup1 # pula para a label Exit_Setup
Char_Esquerda_Setup1:
   	li 	t0, 'a' # carrega o codigo ascii de a no registrador t0
  	bne 	t0, t2,Char_Direita_Setup1 # verifica se o valor de t0 não é igual ao valor em t2 e se não for pula pra label
  	li 	a0, -1 # carrega em a0 -1 para indicar que está indo para esquerda
  	call	Movimenta_Setup1 # chama a função movimenta para movimentar o navegador
Char_Direita_Setup1:  	
	li 	t0, 'd' # carrega o codigo ascii de d no registrador t0
  	bne 	t0, t2,FIM_Setup1 # verifica se o valor de t0 não é igual ao valor em t2 e se não for pula pra label
  	li 	a0, 1 # carrega em a0 1 para indicar que está indo para direita
  	call	Movimenta_Setup1 # chama a função movimenta para movimentar o navegador
FIM_Setup1:	
	j 	LOOP1 # pula para a label LOOP1
Exit_Setup1:
	li	a3, 1 # troca o frame que estava
	li 	t0, 0xFF200604 # endereço usado para informar para o bit display que trocamos de frame
	li	s1, 0 # inicializa a onde o navegador está
	sw 	a3, 0(t0) # salva no endereço que informa que trocamos de frame o conteudo de a3
	la 	a0, Image1 # carrega o endereco do sprite do tabuleiro em a0
	li 	a1, 0 # x = 0
	li 	a2, 0 # y = 0
	li	a3, 0 # frame = 0
	call 	PRINT #chama a função print
	li 	a3, 1 #estabelece o frame em que o loop2 vai atuar
	li	a6, 0 #carrega em a6 o argumento da função Movimenta_Setup2
	li	a0, 0
LOOP2:
	li 	t1, 0xFF200000 # carrega o endereco de controle do KDMMIO
	lw 	t0, 0(t1) # Le bit de Controle Teclado
	andi 	t0, t0,0x0001 # mascara o bit menos significativo
   	beq 	t0, zero,FIM_Setup2 # Se nao ha tecla pressionada entao vai para FIM
  	lw 	t2, 4(t1) # le o valor da tecla teclada
	li 	t0, '\n' # carrega o valor da tecla enter em t0
	bne 	t0, t2,Char_Esquerda_Setup2 # se t2 não foi igual a t0 pula para a label
	add 	s1, s1, a0 # até aqui a0 ainda é o resultado de Movimenta_Setup
	j	Exit_Setup2 # pula para a label Exit_Setup
Char_Esquerda_Setup2:
   	li 	t0, 'a' # carrega o codigo ascii de a no registrador t0
  	bne 	t0, t2,Char_Direita_Setup2 # verifica se o valor de t0 não é igual ao valor em t2 e se não for pula pra label
  	li 	a0, -1 # carrega em a0 -1 para indicar que está indo para esquerda
  	call	Movimenta_Setup2 # chama a função movimenta para movimentar o navegador
Char_Direita_Setup2:  	
	li 	t0, 'd' # carrega o codigo ascii de d no registrador t0
  	bne 	t0, t2,FIM_Setup2 # verifica se o valor de t0 não é igual ao valor em t2 e se não for pula pra label
  	li 	a0, 1 # carrega em a0 1 para indicar que está indo para direita
  	call	Movimenta_Setup2 # chama a função movimenta para movimentar o navegador
FIM_Setup2:	
	j 	LOOP2 # pula para a label LOOP
Exit_Setup2:
	li	a3, 0 # troca o frame ques estava
	li 	t0, 0xFF200604 # endereço usado para informar para o bit display que trocamos de frame
	sw 	a3, 0(t0) # salva no endereço que informa que trocamos de frame o conteudo de a3
	
	la 	a0, Image1
	li 	a1, 0 # x = 0
	li 	a2, 0 # y = 0
	li	a3, 1 # frame = 0
	call 	PRINT #chama a função print
	
	li	s10,0
	li	s4,0
	li	s3,0
	li 	s11,9
	li	s8,0
	la 	a0, Image5 # carrega o endereco do seletor
	li 	a1, 60 # x = 0
	li 	a2, 24 # y = 0
	li	a3,0
	call 	PRINTSeletor #chama a função print
	
Game_Loop:	
	call	Controle # chama a função controle que controla os movimentos do jogador
	add	t0,s3,s4
	add	t0,t0,s10
	slti	t1,t0,20
	bnez	t1,PulaExit
	j	Exit
PulaExit:
	beqz	s11,Empate
Voltaempate:
	beqz	s8, Fim   # turn = 0 => vez é do usuário
	call 	jogada_pc # chama a função jogada pc que controla os movimentos da maquina
Fim:	
	j 	Game_Loop # faz um loop infinito

Empate:
	addi	s3,s3,1
	j	Reinicia_Board
volta:
	li	s11,9
	slti	t0,s3,20
	bnez	t0,condicao_3
	j	Exit
condicao_3:
	j	Voltaempate
Aumenta_Score:
	slti	t0,a7,2
	li	a1,100
	li	a2,8
	beqz 	t0,DecideQuemAumenta1	
	li 	a1,296
	addi	s4,s4,1
	mv 	t1,s4
	j	DecideQuemAumenta2
DecideQuemAumenta1:
	addi	s10,s10,1
	mv 	t1,s10
DecideQuemAumenta2:
	mv	s9,t1
	li	t0,1
	bne	s9,t0,pula_1
	la	a0,Image18 # 1
pula_1:
	li	t0,2
	bne	s9,t0,pula_2
	la	a0,Image19 # 2
pula_2:	
	li	t0,3
	bne	s9,t0,pula_3
	la	a0,Image20 # 3
pula_3:
	li	t0,4
	bne	s9,t0,pula_4
	la	a0,Image21 # 4
pula_4:
	li	t0,5
	bne	s9,t0,Imprime
	la	a0,Image22 # 5
Imprime:
	li	a3,0
	call	PRINT
	li	a3,1
	call	PRINT
Reinicia_Board:
	li	t1,60
	li	t2,24
	li	t3,3
Loop_reinicia1:
	li	t4,3
Loop_reinicia2:
	la	a0,Image23 # casa branca
	mv	a1,t1
	mv	a2,t2
	li	a3,0
	mv	a7,t1
	mv	a6,t2
	mv	a5,t4
	mv	a4,t3
	call	PRINT
	li	a3,1
	call	PRINT
	mv	t4,a5
	mv	t3,a4
	mv 	t1,a7
	mv	t2,a6
	addi	t4,t4,-1
	addi	t1,t1,68
	bnez	t4,Loop_reinicia2
	addi	t1,t1,-204
	addi	t3,t3,-1
	addi	t2,t2,68
	bnez	t3,Loop_reinicia1
	la	t0,posicao_seletor
	li	t1,60
	sh	t1,0(t0)
	li	t1,24
	sh	t1,2(t0)
	la	t0,posicao_seletor_velha
	li	t1,60
	sh	t1,0(t0)
	li	t1,24
	sh	t1,2(t0)
	la	t0,BOARD
	li	t2,0
Loop_limpaBoard:
	sw	zero,0(t0)
	addi	t0,t0,4
	addi	t2,t2,1
	slti	t3,t2,9
	bnez	t3,Loop_limpaBoard
	la 	a0, Image5 # carrega o seletor
	li	a3,1
	li 	a1, 60 # x = 0
	li 	a2, 24 # y = 0
	call 	PRINTSeletor
	li	a3,0
	call 	PRINTSeletor #chama a função print
	beqz	s11,volta
	li	s11,9
	j	Fim_ganha

Exit:	
	
	add	t0,s3,s4
	add	t0,t0,s10
	slti	t1,t0,20
	bnez	t1,Pula20Partidas
	blt	s10,s4,EscolheGanhador1
	bgt	s10,s4,EscolheGanhador2
	add 	s3, s3, s10
	add 	s3, s3, s4
Pula20Partidas:
	li	t0,20
	bne	s3,t0,pula_empate
	la	s9,Image33 # tie branco
	la	s10,Image34 # tie amarelo
	la	a6,Image37 # tela de empate
pula_empate:
	li	t0,5
	bne	s4,t0,pula_perde
EscolheGanhador1:
	la	s9,Image31 # game over branco
	la	s10,Image32 # game over vermelho
	la	a6,Image24 # tela de game over
pula_perde:
	li	t0,5
	bne	s10,t0,Fim_decideGanhador
EscolheGanhador2:
	la	s9,Image29 # you win branco
	la	s10,Image30 # you win verde
	la	a6,Image38 # tela de vitoria
#até aqui coloquei nos registradores os respectivos endereços das label em cada caso
Fim_decideGanhador:
	li	a3,0
	mv	a0,a6
	li	a1,0
	li	a2,0
	call	PRINT
	mv	a0,s9
	li	a1,128
	li	a2,14
	call	PRINT
  	li 	a2, 113 # y = 138	
	li	a1, 88 # x = 40		
	la	a0,Image25 # Yes escolhido		
	call 	PRINT 			
	la 	a0,Image27 # No escolhido		
 	li	a1,192			
  	call	PRINT			
	li	s7,0
	li	s6,0
LOOP3:
	xori	s6,s6,1
	beqz	s6,Troca
	li	a1,128
	li	a2,14
	mv	a0,s10
	call PRINT
	j FimTroca
Troca:	li	a1,128
	li	a2,14
	mv	a0,s9
	call PRINT
FimTroca:
	la	a1, Image26
	la	a2, Image28
	la	a4, Image27
	la	a5, Image25
	li 	t1, 0xFF200000 # carrega o endereco de controle do KDMMIO
	lw 	t0, 0(t1) # Le bit de Controle Teclado
	andi 	t0, t0,0x0001 # mascara o bit menos significativo
   	beq 	t0, zero,FIM_Reset # Se nao ha tecla pressionada entao vai para FIM
  	lw 	t2, 4(t1) # le o valor da tecla teclada
	li 	t0, '\n' # carrega o valor da tecla enter em t0
	bne 	t0, t2,Char_Esquerda_Reset # se t2 não foi igual a t0 pula para a label
	j	Exit_Reset # pula para a label Exit_Setup
Char_Esquerda_Reset:
   	li 	t0, 'a' # carrega o codigo ascii de a no registrador t0
  	bne 	t0, t2,Char_Direita_Reset # verifica se o valor de t0 não é igual ao valor em t2 e se não for pula pra label
 	li 	a0, -1 # carrega em a0 -1 para indicar que está indo para esquerda
  	call	Movimenta_Setup1 # chama a função movimenta para movimentar o navegador
  	mv 	s7, a0 # até aqui a0 ainda é o resultado de Movimenta_Setup
Char_Direita_Reset:  	
	li 	t0, 'd' # carrega o codigo ascii de d no registrador t0
  	bne 	t0, t2,FIM_Reset # verifica se o valor de t0 não é igual ao valor em t2 e se não for pula pra label
 	li 	a0, 1 # carrega em a0 1 para indicar que está indo para direita
  	call	Movimenta_Setup1 # chama a função movimenta para movimentar o navegador
  	mv 	s7, a0 # até aqui a0 ainda é o resultado de Movimenta_Setup
FIM_Reset:	
	j 	LOOP3 # pula para a label LOOP1
Exit_Reset:
	beqz	s7,Setup
	li	a7,10
	ecall
#	interessante fazer uma tela de saída reaproveitando o código da tela de escolha de simbolo
		
###################################### Funçoes ##########################################

#################################################
#	a0 = endereço imagem			#
#	a1 = x					#
#	a2 = y					#
#	a3 = frame (0 ou 1)			#
#################################################
#	t0 = endereco do bitmap display		#
#	t1 = endereco da imagem			#
#	t2 = contador de linha			#
# 	t3 = contador de coluna			#
#	t4 = largura				#
#	t5 = altura				#
#	Não retorna nada			#
#################################################

PRINT:	
	addi 	sp, sp, -4 #aloca espaço na pilha
	sw 	ra, 0(sp) #salva o endereço de retorno
	li 	t0, 0xFF0 # carrega 0xFF0 em t0
	add 	t0, t0,a3 # adiciona o frame ao FF0 (se o frame for 1 vira FF1, se for 0 fica FF0)
	slli 	t0, t0,20 # shift de 20 bits pra esquerda (0xFF0 vira 0xFF000000, 0xFF1 vira 0xFF100000)
	add 	t0, t0,a1 # adiciona x ao t0
	li 	t1, 320 # t1 = 320
	mul 	t1, t1,a2 # t1 = 320 * y
	add 	t0, t0,t1 # adiciona t1 ao t0
	addi 	t1, a0,8	# t1 = a0 + 8
	mv 	t2, zero	# zera t2
	mv 	t3, zero # zera t3
	lw 	t4, 0(a0) # carrega a largura em t4
	lw 	t5, 4(a0) # carrega a altura em t5
PRINT_LINHA:	
	lw 	t6, 0(t1) # carrega em t6 uma word (4 pixeis) da imagem
	sw 	t6, 0(t0) # imprime no bitmap a word (4 pixeis) da imagem
	addi 	t0, t0,4	# incrementa endereco do bitmap
	addi 	t1, t1,4	# incrementa endereco da imagem
	addi 	t3, t3,4	# incrementa contador de coluna
	blt 	t3, t4,PRINT_LINHA # se contador da coluna < largura, continue imprimindo
	addi 	t0, t0,320 # t0 += 320
	sub 	t0, t0,t4 # t0 -= largura da imagem
	# ^ isso serve pra "pular" de linha no bitmap display
	mv 	t3, zero	# zera t3 (contador de coluna)
	addi 	t2, t2,1	# incrementa contador de linha
	bgt 	t5, t2,PRINT_LINHA # se altura > contador de linha, continue imprimindo
	lw 	ra, 0(sp) # recupera o valor do ponteiro de retorno
	addi 	sp, sp, 4 # desoloca memoria na pilha
	ret 	# retorna para o programa que chamou a função

#########################################################################################

#################################################
#	a0 = endereço imagem			#
#	a1 = x					#
#	a2 = y					#
#	a3 = frame (0 ou 1)			#
#################################################
#	t0 = endereco do bitmap display		#
#	t1 = endereco da imagem			#
#	t2 = contador de linha			#
# 	t3 = contador de coluna			#
#	t4 = largura				#
#	t5 = altura				#
#	Não retorna nada			#
#################################################

PRINTSeletor:	
	addi 	sp, sp, -4 #aloca espaço na pilha
	sw 	ra, 0(sp) #salva o endereço de retorno
	li 	t0, 0xFF0 # carrega 0xFF0 em t0
	add 	t0, t0,a3 # adiciona o frame ao FF0 (se o frame for 1 vira FF1, se for 0 fica FF0)
	slli 	t0, t0,20 # shift de 20 bits pra esquerda (0xFF0 vira 0xFF000000, 0xFF1 vira 0xFF100000)
	add 	t0, t0,a1 # adiciona x ao t0
	li 	t1, 320 # t1 = 320
	mul 	t1, t1,a2 # t1 = 320 * y
	add 	t0, t0,t1 # adiciona t1 ao t0
	addi 	t1, a0,8	# t1 = a0 + 8
	mv 	t2, zero	# zera t2
	mv 	t3, zero # zera t3
	lw 	t4, 0(a0) # carrega a largura em t4
	lw 	t5, 4(a0) # carrega a altura em t5
PRINT_LINHASeletor:	
	lb 	t6, 0(t1) # carrega em t6 uma word (1 pixeis) da imagem
	li	s9,-57
	beq	t6,s9,PulaInvisivel
	sb 	t6, 0(t0) # imprime no bitmap a word (1 pixeis) da imagem
PulaInvisivel:
	addi 	t0, t0,1	# incrementa endereco do bitmap
	addi 	t1, t1,1	# incrementa endereco da imagem
	addi 	t3, t3,1	# incrementa contador de coluna
	blt 	t3, t4,PRINT_LINHASeletor # se contador da coluna < largura, continue imprimindo
	addi 	t0, t0,320 # t0 += 320
	sub 	t0, t0,t4 # t0 -= largura da imagem
	# ^ isso serve pra "pular" de linha no bitmap display
	mv 	t3, zero	# zera t3 (contador de coluna)
	addi 	t2, t2,1	# incrementa contador de linha
	bgt 	t5, t2,PRINT_LINHASeletor # se altura > contador de linha, continue imprimindo
	lw 	ra, 0(sp) # recupera o valor do ponteiro de retorno
	addi 	sp, sp, 4 # desoloca memoria na pilha
	ret 	# retorna para o programa que chamou a função

#########################################################################################

#################################################
#	a0 = offset				#
#	a1 = imediato				#
#################################################

Movimenta:
	addi 	sp, sp, -4 #aloca espaço na pilha
	sw 	ra, 0(sp) #salva o endereço de retorno
	la 	t0, posicao_seletor # carrega a posicao atual do personagem
	la 	t1, posicao_seletor_velha # carrega a posicao antiga do personagem 
	lw 	t2, 0(t0) # grava no registrador t2 as duas posições 
	sw 	t2, 0(t1) # salva no endereco da posicao antiga do personagem a localização atual
	add	t0,t0,a0
	lh 	t1, 0(t0) # grava no registrador t1 o valor dentro do endereço t0+offsset
	add 	t1, t1,a1 # adiciona o imediato em t1
	mv 	t3, a0 # carrega o valor de offset no registrador t3
	slti 	t3, t3,1 # seta t3 com 0 ou 1 depedendo do se o t3 for menor que o imediato 1
	li 	t4, 60 # carrega o imediato 320 no registrador t4
	bnez 	t3, escolhelimite2 # se t3 não for igual a zero vai para a label indicada
	 li 	t4, 24 # carrega o imediato 240 no registrador t4
escolhelimite2:	
	bltu 	t1, t4, Game_Loop #condição que verifica os limites
	li 	t4, 263 # carrega o imediato 320 no registrador t4
	bnez 	t3, escolhelimite1 # se t3 não for igual a zero vai para a label indicada
	 li 	t4, 227 # carrega o imediato 240 no registrador t4
escolhelimite1:	
	bgeu 	t1, t4, Game_Loop #condição que verifica se os limites estão entre 0 e 320 ou 240
	sh 	t1, 0(t0) # grava no endereço t0+offset o valor no registrador t1
	li	a3,0
	la 	t0, Image5 # carrega o sprite com o seletor
	CarregaSprite(t0,posicao_seletor) # prepara os argumetos para a função print
	call 	PRINTSeletor # chama a função print
	li	a3,1
	call	PRINTSeletor
	la	t0,Image4
	li	a3,0
	CarregaSprite(t0,posicao_seletor_velha) # chama o macro CarregaSprite
	call 	PRINTSeletor # chama a funçao print
	li	a3,1
	call	PRINTSeletor
	lw 	ra, 0(sp) # recupera o valor do ponteiro de retorno
	addi 	sp, sp, 4 # desoloca memoria na pilha
	ret 	# retorna para o programa que chamou a função

#########################################################################################

#################################################
#	t0 = bit de controle do teclado		#
#	t1 = endereco do KDMMIO			#
#	t2 = valor da tecla teclada		#
#	t0 = valor de teclas possiveis		#
#	Não retorna nada			#
#################################################

Controle:
	addi 	sp, sp, -4 # aloca espaço na pilha
	sw 	ra, 0(sp) # guarda o ponteiro de retorno
	li 	t1, 0xFF200000 # carrega o endereco de controle do KDMMIO
	lw 	t0, 0(t1) # Le bit de Controle Teclado
	andi 	t0, t0,0x0001 # mascara o bit menos significativo
   	beq 	t0, zero,FIM # Se nao ha tecla pressionada entao vai para FIM
  	mv	s5,t1
  	la 	a4,posicao_seletor # carrega a posição do seletor no  tabuleiro
	lh 	a1,0(a4) # atribui o primeiro valor da posição em a1
	lh 	a2,2(a4) # atribui o primeiro valor da posição em a2
	addi	t0,a2,-24
	li	t1,68
	div	t0,t0,t1
	mv 	t2,t0
	li	t0,3
	mul	t2,t2,t0
  	mv	a4,t2
  	addi	t0,a1,-60
	li	t1,68
	div	t0,t0,t1
	mv	a5,t0
	add	t2,t2,t0
	mv	a6,t2
	slli	t2,t2,2
	la	t0,BOARD
	add	t0,t0,t2
  	lw	t0,0(t0)
  	mv	t1,s5
  	mv	s5,t0 # salva o valor que está naquela posição do Board
  	lw 	t2, 4(t1) # le o valor da tecla tecla  	
	li 	t0, '\n'
	bne 	t0, t2,Char_Esquerda # verifica se a tecla clicada é igual a \n
	la 	a0, Image2 # carrega o simbolo O no registrador a0
	beqz 	s7, pula_controle # pula para a label pula controle se o simbolo escolhido for diferente de zero
	la	a0, Image3 # carrega o simbolo X no registrador a0
pula_controle:
	bnez	s5,FIM
	call 	PRINT_animado # chama a função para printar o simbolo
	la 	a0,Image5
	call 	PRINTSeletor
	jal 	bmp_vira_indice # posição no bitmap gera índice no BOARD, cujo conteúdo muda para "2" (0 -> 2) 
	addi 	s11,s11,-1
	li s8, 1 # peça do usuário é impressa => vez é agora do PC
	li 	a7,2
	call 	ganhou #recebe como argumento o registrador a7, a6,a4 e a5 qual simbolo quero testar a vitoria
	# index do board, linha,coluna
	j	FIM
Char_Esquerda:
   	li 	t0, 'a' # carrega o codigo ascii de a no registrador t0
  	bne 	t0, t2, Char_Cima # verifica se o valor de t0 não é igual ao valor em t2 e se não for pula pra label
  	li	a0,0
  	li	a1,-68
  	call	Movimenta # chama o macro Movimenta
  	j	FIM
Char_Cima:
 	li 	t0, 'w' # carrega o codigo ascii de w no registrador t0
  	bne 	t0, t2,Char_Direita  # verifica se o valor de t0 não é igual ao valor em t2 e se não for pula pra label
  	li	a0,2
  	li	a1,-68
  	call	Movimenta # chama o macro Movimenta
  	j	FIM	
Char_Direita:  	
	li 	t0, 'd' # carrega o codigo ascii de d no registrador t0
  	bne 	t0, t2, Char_Baixo  # verifica se o valor de t0 não é igual ao valor em t2 e se não for pula pra label
  	li	a0,0
  	li	a1,68
  	call	Movimenta # chama o macro Movimenta
  	j	FIM
Char_Baixo:  	
	li 	t0, 's' #carrega o codigo ascii de s no registrador t0
	bne 	t0, t2, FIM  # verifica se o valor de t0 não é igual ao valor em t2 e se não for pula pra label
	li	a0,2
  	li	a1,68
	call	Movimenta # chama o macro Movimenta
  	j	FIM
FIM:	
	lw 	ra, 0(sp) # recupera o ponteiro de retorno
	addi 	sp, sp, 4 # desaloca memoria na pilha
	slti	t0,s10,5
	bnez	t0,condicao_1
	j	Exit
condicao_1:
	ret 	# retorna para o programa que chamou a função

	
#########################################################################################
	
#################################################
#	a0 = quantidade movimento		#
#	a1 = endereço da primeira label	#
#	a2 = endereço da segunda label		#
#	a4 = endereço da terceira label	#
#	a5 = endereço da quarta label		#
#################################################	
#################################################
#	a0 = retorna 0 ou 1			#
#################################################
			
Movimenta_Setup1:
	addi 	sp, sp, -4 # aloca memoria na pilha
	sw 	ra, 0(sp) # salva o ponteiro de retorno nan pilha
	mv	a7, a2
	li 	a2, 113 # y = 113
	bltz	a0, pula_mov1 # se a quantidade de movimento for negativa eu estou na esquerda caso contrario na direita
	mv 	a0, a1 # endereço do sprite que quero imprimir
	li	a1, 88 # x = 88
	call 	PRINT # chamo a função para imprimir
	mv	a0, a7 # endereço do sprite que quero imprimir
	li	a1, 192 # x = 180
	call 	PRINT # chamo a função para imprimir
	li	a0, 1 # troca o resultado da função Movimenta_Setup
	j 	Fim_mov1 # pulo para o final da função Movimenta_Setup
pula_mov1:
	mv 	a0, a4 # endereço do sprite que quero imprimir
	li	a1, 192 # x = 192
	call 	PRINT # chamo a
	mv 	a0, a5 # endereço do sprite que quero imprimir função para imprimir
	li	a1, 88 # x = 88
	call 	PRINT # chamo a função para imprimir
	li	a0, 0	#troca o resultado da função movimenta_setup
Fim_mov1:	
	lw 	ra, 0(sp) # recupero o ponteiro de retorno da pilha	
	addi 	sp, sp, 4 # desaloco memoria da pilha
	ret 	# retorna para o programa que chamou a função
	
#########################################################################################

#################################################
#	a6 = posição inicial do nav no sprite	#
#	a0 = quantidade movimento		#
#################################################
#################################################
#	t0 = endereços de sprite		#
#	t1 = variavel temporaria da nova pos	#
#	t2 = limite do navegador		#
#################################################	
#################################################
#	a0 = retorna 0 ou 1 ou 2		#
#################################################
						
			
Movimenta_Setup2:
	addi 	sp, sp, -4 # aloca memoria na pilha
	sw 	ra, 0(sp) # salva o ponteiro de retorno nan pilha
	li 	a2, 113 # y = 138
	add	t1, a0, a6
	li	t2, 3
	bgeu	t1, t2, Fim_mov2
	mv 	a7, a0
	la 	a0, Image13
	li	t3, 1
	li	a1, 88
	blt	a6, t3, pula1_mov2
	la 	a0, Image14
	li	t3, 2
	li	a1, 140
	blt	a6, t3, pula1_mov2
	la 	a0, Image16
	li	a1, 192
pula1_mov2:
	add	a6, a6, a7 # troca o valor do registrador em a6 que indica qual dificuldade estamos selecionando
	mv	a7, t1
	call	PRINT
	mv	t1, a7
	la 	a0, Image12
	li	t3, 1
	li	a1, 88
	blt	t1, t3, pula2_mov2
	la 	a0, Image15
	li	t3, 2
	li	a1, 140
	blt	t1, t3, pula2_mov2
	la 	a0, Image17
	li	a1, 192
pula2_mov2:
	call	PRINT
Fim_mov2:
	mv 	a0, a6	# retorna a0 como sendo o valor em a6
	lw 	ra, 0(sp) # recupero o ponteiro de retorno da pilha	
	addi 	sp, sp, 4 # desaloco memoria da pilha
	ret 	# retorna para o programa que chamou a função
	
#########################################################################################


jogada_pc:
	addi sp, sp, -4
	sw ra, 0(sp)
	slti t0,s1,1
	beqz t0,pula_IA1
	jal IA_facil           # pula para cada IA. Se ela não foi a escolhida, retorna sem fazer nada
	j Fim_IA
pula_IA1:
	slti t0,s1,2
	beqz t0,pula_IA2
	jal IA_media
	j Fim_IA
pula_IA2:
	jal IA_dificil			 
Fim_IA:
	li s8, 0               # turn = 0 => vez é do usuário
	li s0, 0               # available = 0
	
	lw ra, 0(sp)	
	addi sp, sp, 4
	slti	t0,s4,5	
	bnez	t0,condicao_2
	j	Exit
condicao_2:
	ret
#

###########################################################################
# imprime o char do PC na primeira casa desocupada vista, atualiza BOARD
#################################################################
#	a1 = índice do BOARD onde a impressão deve ser feita	#
#################################################################
PRINT_PC:   
	addi sp, sp, -4
	sw ra, 0(sp)
	
	li s0, 1      # seta available=1 (somente para a IA_dificil)
	# board[a1] deve ser atualizado
	la t0, BOARD
	slli t1, a1, 2
	add t0, t0, t1 # t0 = endereço de board[a1]
	li t1, 1       # t1 = 1
	sw t1, 0(t0)   # board[a1] = 1 (0 para vago, 1 para PC e 2 para USER)
	# mapeamento índice do board -> posição no bitmap
	# queremos deslocar a posição inicial (x0, y0) em 
	# (+ux. +vy), u e v inteiros que dependem do índice a1 
	# por inspeção, encontrei que (generalizar para tabuleiro m x n)
	# u = a1  % 3 (n?)
	# v = a1 // 3 (m?)
	li t2, 3       # setando t2 = 3 para div e mul
	rem t3, a1, t2 # t3 <- u
	div t4, a1, t2 # t4 <- v 
	mv a6,a1
	li a4,3
	mul a4,a4,t4
	mv a5,t3
	# valores de x e y em t2 e t5
	li t0, 68      # t0 <- tamanho do pulo em x
	li t1, 68      # t1 <- tamanho do pulo em y
	mul t3, t3, t0 # t3 <- ux 
	mul t4, t4, t1 # t4 <- vy 
	li t0, 60      # t0 <- x0 = 60 => pos. de referência em x
	li t1, 24      # t1 <- y0 = 25 => pos. de referência em y
	add t3, t3, t0 # t3 <- ux + x0 => pos. inicial em x
	add t4, t4, t1 # t3 <- vy + y0 => pos. inicial em y	
	# impressão no bitmap
	
	la a0,Image2
	bnez s7,pula_PC
	la a0, Image3 # Image3 = X
pula_PC:
	mv a1, t3     # carrega o endereço correto de x no bitmap para impressão 
	mv a2, t4     # carrega o endereço correto de y no bitmap para impressão
	li a3, 0      # frame de impressão
	call 	PRINT_animado # chama a função para printar o simbolo
	addi s11, s11, -1       # occupied++ 
	li a7,1 #passa qual o simbolo que quero testar se ganhou
	call ganhou
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	
############################################################################

# verifica pelo BOARD se uma casa está vazia
#################################################
#	a0 = 0 se não, 1 se sim		        #
#	a1 = endereço da casa			#
#################################################
vazia:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	la t0, BOARD 
	slli t1, a1, 2
	add t0, t0, t1
	lw t0, 0(t0)      # t0 = BOARD[a1]
	beqz t0, ta_vazia # BOARD[a1]=0? casa vazia:casa ocupada
	li a0, 0          # casa ocupada => a0=0
	
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
ta_vazia:
	li a0, 1          # casa vazia => a0=1
	
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	
########################################################################### 

# atualiza no BOARD que o jogador ocupou a casa relacionada a a1 e a2
bmp_vira_indice:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	li t0, 68      # dimensão do pulo (68x68)
	div t1, a1, t0 # t1 <- a1 // 68 
	div t0, a2, t0 # t0 <- a2 // 68
	li t2, 3
	mul t0, t0, t2 # t0 <- 3*y
	add t0, t0, t1 # t0 <- 3*y + x = índice
	
	mv s9, t0 # user_char <- indice
	
	la t1, BOARD
	slli t0, t0, 2 # t2 <- 4*t0
	add t1, t1, t0 # t1 <- endereço do board[índice]
	li t2, 2
	sw t2, 0(t1)   # board[índice] = 2
	
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	
###########################################################################

# verifica se duas casas são iguais ao int a4 dado
# assume-se que a2 =/= a3 são adjacentes
#################################################
#       a0 -> 1 se iguais, 0 se não		#
#	a2 -> índice de uma casa 		#
#	a3 -> índice da outra casa		#
#	a4 -> valor a ser buscado no board      #
#################################################
dois_iguais:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	la t0, BOARD
	slli t1, a2, 2
	add t1, t1, t0 
	lw t1, 0(t1)                # t1 = board[a2]
	slli t2, a3, 2 
	add t2, t2, t0 
	lw t2, 0(t2)                # t2 = board[a3]
	bne t1, a4, fim_dois_iguais # board[a2] = a4? continua:fim
	bne t2, a4, fim_dois_iguais # board[a3] = a4? continua:fim
	li a0, 1                    # retorna 1 se ambas as casas forem int
	
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
fim_dois_iguais:
	li a0, 0                    # retorna 0 se não
	
	lw ra, 0(sp)
	addi sp, sp, 4
	ret



###########################################################################

# verifica se a maquina ou o jogador ganhou
#################################################
#       a4 -> linha*3				#
#	a5 -> coluna		 		#
#	a6 -> P(linha,coluna)			#
#	a7 -> Indica quem está usando a função	#
#################################################

ganhou:
	addi 	sp, sp, -4 #aloca espaço na pilha
	sw 	ra, 0(sp) #salva o endereço de retorno
	andi	t0,a6,1
	bnez	t0,IMPAR
PAR:	
	la	t0,BOARD
	li	t1,8
	add	t1,t0,t1
	li	t2,2
	li	t6,0
Loop_ganha_D1:
	lw	t4,0(t0)
	bne	t4,a7,Fim_D1
	addi	t0,t0,16
	addi	t6,t6,1
	addi	t2,t2,-1
	slti	t3 ,t2,0
	beqz	t3,Loop_ganha_D1
	li	t2,3
	beq	t6,t2,Aumenta_Score
Fim_D1:
	li	t6,0
	li	t2,2
Loop_ganha_D2:
	lw	t4,0(t1)
	bne	t4,a7,IMPAR
	addi	t1,t1,8
	addi	t6,t6,1
	addi	t2,t2,-1
	slti	t3 ,t2,0
	beqz	t3,Loop_ganha_D2
	li	t2,3
	beq	t6,t2,Aumenta_Score
IMPAR:	
	la	t0,BOARD
	slli	a4,a4,2
	add	t1,t0,a4
	li	t6,0
	li	t2,2
Loop_ganha_L:
	lw	t4,0(t1)
	bne	t4,a7,Fim_Impar
	addi	t6,t6,1
	addi	t1,t1,4
	addi	t2,t2,-1
	slti	t3,t2,0
	beqz	t3,Loop_ganha_L
	li	t2,3
	beq	t6,t2,Aumenta_Score
Fim_Impar:
	slli	a5,a5,2
	add	t1,t0,a5
	li	t2,2
	li	t6,0
Loop_ganha_C:
	lw	t4,0(t1)
	bne	t4,a7,Fim_ganha
	addi	t6,t6,1
	addi	t1,t1,12
	addi	t2,t2,-1
	slti	t3,t2,0
	beqz	t3,Loop_ganha_C
	li	t2,3
	beq	t6,t2,Aumenta_Score
Fim_ganha:
	lw 	ra, 0(sp) # recupera o valor do ponteiro de retorno
	addi 	sp, sp, 4 # desoloca memoria na pilha
	ret


###########################################################################	

PRINT_animado:
	addi 	sp, sp, -24 # desoloca memoria na pilha
	mv 	t0,sp
	sw 	ra, 0(sp) # recupera o valor do ponteiro de retorno
	sw	a6, 4(sp)
	sw	a5, 8(sp)
	sw	a4, 12(sp)
	sw	s3, 16(sp)
	sw	s0, 20(sp)
	lw 	t4, 0(a0) # carrega a largura em t4
	lw	t5, 4(a0)
	li 	a6, 0xFF0 # carrega 0xFF0 em t0
	add 	a6, a6,a3 # adiciona o frame ao FF0 (se o frame for 1 vira FF1, se for 0 fica FF0)
	slli 	a6, a6,20 # shift de 20 bits pra esquerda (0xFF0 vira 0xFF000000, 0xFF1 vira 0xFF100000)
	add 	a6, a6,a1 # adiciona x ao t0
	li	t3,320
	li	t1,0 
	mul	t3,t3,t1
	add	a6,a6,t3
	mv	t2,zero
	mv	t3,zero
	mv	s9,sp
	addi	a3,a2,68
SalvaSprite:
	addi	sp, sp, -4
	lw	t6, 0(a6) # carrega do bit map e coloca na pilha
	sw	t6, 0(sp)
	addi	a6, a6, 4
	addi	t3, t3, 4
	blt 	t3, t4, SalvaSprite # se contador da coluna < largura, continue imprimindo
	addi 	a6, a6, 320 # t0 += 320
	sub 	a6, a6, t4 # t0 -= largura da imagem
	# ^ isso serve pra "pular" de linha no bitmap display
	mv 	t3, zero	# zera t3 (contador de coluna)
	addi	t2, t2,1	
	bgt	a3, t2,SalvaSprite # se altura > contador de linha, continue imprimindo
	li	a7,0
	li	s3,0
Loop:
	xori	s0, s0,1
	mv 	a3, s0
	li 	a6, 0xFF0 # carrega 0xFF0 em t0
	add 	a6, a6,a3 # adiciona o frame ao FF0 (se o frame for 1 vira FF1, se for 0 fica FF0)
	slli 	a6, a6,20 # shift de 20 bits pra esquerda (0xFF0 vira 0xFF000000, 0xFF1 vira 0xFF100000)
	add 	a6, a6,a1 # adiciona x ao t0
	li	t3, 320
	mv	t1, a7 #lembrar de aumentar esse t1
	mul	t3, t3, t1
	add	a6, a6, t3
	mv	t2,zero
	mv	t3,zero
	addi	t1,a0,8
	mv	a3,t0
PRINT_LINHA_animado:
	lb 	t6, 0(t1) # carrega em t6 uma word (4 pixeis) da imagem
	li	t0, -57
	beq	t0,t6,pula_animado
	sb	t6, 0(a6) # imprime no bitmap a word (4 pixeis) da imagem
pula_animado:
	addi 	a6, a6,1	# incrementa endereco do bitmap
	addi 	t1, t1,1	# incrementa endereco da imagem
	addi 	t3, t3,1	# incrementa contador de coluna
	blt 	t3, t4,PRINT_LINHA_animado # se contador da coluna < largura, continue imprimindo
	addi 	a6, a6,320 # t0 += 320
	sub 	a6, a6,t4 # t0 -= largura da imagem
	# ^ isso serve pra "pular" de linha no bitmap display
	mv 	t3, zero	# zera t3 (contador de coluna)
	addi 	t2, t2,1	# incrementa contador de linha
	bgt 	t5, t2,PRINT_LINHA_animado # se altura > contador de linha, continue imprimindo
	
	li t0,0xFF200604		# carrega em t0 o endereco de troca de frame
	sw s0,0(t0)
	
	mv	t0,a3
				
	mv	a3,s0
	xori	a3,a3,1
	
	li 	a6, 0xFF0 # carrega 0xFF0 em t0
	add 	a6, a6,a3 # adiciona o frame ao FF0 (se o frame for 1 vira FF1, se for 0 fica FF0)
	slli 	a6, a6,20 # shift de 20 bits pra esquerda (0xFF0 vira 0xFF000000, 0xFF1 vira 0xFF100000)
	add 	a6, a6,a1 # adiciona x ao t0
	li	t3, 320
	mv	t1, s3 #lembrar de aumentar esse t1
	mul	t3, t3, t1
	add	a6, a6, t3
	mv	t2,zero
	
	mv	t3,zero
	
	
RecuperaSprite:
	addi	s9,s9,-4
	lw	t6,0(s9) # carrega a word que foi salva na pilha
	sw 	t6, 0(a6) # imprime no bitmap a word (4 pixeis) que foi salva na pilha
	addi 	a6, a6,4	# incrementa endereco do bitmap
	addi	t3,t3,4
	blt 	t3, t4,RecuperaSprite # se contador da coluna < largura, continue imprimindo
	addi 	a6, a6,320 # t0 += 320
	sub 	a6, a6,t4 # t0 -= largura da imagem
	# ^ isso serve pra "pular" de linha no bitmap display
	mv 	t3, zero	# zera t3 (contador de coluna)
	addi 	t2, t2,1	
	bgt 	t5, t2,RecuperaSprite # se altura > contador de linha, continue imprimindo
	
	li	t1,4624
	ble	a7,s3,pula_incrementa
	li	t1,4488
	addi	s3,s3,2
pula_incrementa:
	addi	a7,a7,2
	add	s9,t1,s9
	ble	a7, a2, Loop

	mv	sp,t0
	
	xori 	s0,s0,1
	mv 	a3,s0
	
	call PRINTSeletor
	
	li s0,0
	li t0,0xFF200604		# carrega em t0 o endereco de troca de frame
	sw s0,0(t0)

	lw 	ra, 0(sp) # recupera o valor do ponteiro de retorno
	lw	a6, 4(sp)
	lw	a5, 8(sp)
	lw	a4, 12(sp)
	lw	s3, 16(sp)
	lw	s0, 20(sp)
	addi 	sp, sp, 24 # desoloca memoria na pilha
	ret
				
###########################################################################

.include "IA_facil.s"
.include "IA_media.s"
.include "IA_dificil.s"

###########################################################################

.data
.include "sprites/Image1.data"
.include "sprites/Image2.data"
.include "sprites/Image3.data"
.include "sprites/Image4.data"
.include "sprites/Image5.data"
.include "sprites/Image6.data"
.include "sprites/Image7.data"
.include "sprites/Image8.data"
.include "sprites/Image9.data"
.include "sprites/Image10.data"
.include "sprites/Image11.data"
.include "sprites/Image12.data"
.include "sprites/Image13.data"
.include "sprites/Image14.data"
.include "sprites/Image15.data"
.include "sprites/Image16.data"
.include "sprites/Image17.data"
.include "sprites/Image18.data"
.include "sprites/Image19.data"
.include "sprites/Image20.data"
.include "sprites/Image21.data"
.include "sprites/Image22.data"
.include "sprites/Image23.data"
.include "sprites/Image24.data"
.include "sprites/Image25.data"
.include "sprites/Image26.data"
.include "sprites/Image27.data"
.include "sprites/Image28.data"
.include "sprites/Image29.data"
.include "sprites/Image30.data"
.include "sprites/Image31.data"
.include "sprites/Image32.data"
.include "sprites/Image33.data"
.include "sprites/Image34.data"
.include "sprites/Image35.data"
.include "sprites/Image36.data"
.include "sprites/Image37.data"
.include "sprites/Image38.data"
.include "sprites/Image39.data"



