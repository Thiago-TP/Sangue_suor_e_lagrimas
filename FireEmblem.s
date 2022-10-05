.data
FPGA:		.byte	0	#  1 => FPGA  
GuardaHack:	.byte 	0	# precisei disso pra guardar o sp certo na hora de retornar do Fase1.s
GuardaLugarMenu: .byte	0
AtaqueAtivado:	.byte	0
MenuAtivado2:	.byte	0
MenuAtivado:	.byte	0	# indica se o menu estÃ¡ ativado
Fase:		.byte	1	# numero da fase
Vez:		.byte	0	# flag de vez do PC
GameOver:	.byte	0 	# flag de derrota :(
Win:		.byte	0	# flag de vitoria :)
musicTime:	.word	0	# tempo em ms desde a ultima nota	
noteCounter:	.word	0	# quantidade de notas tocadas

# tempos para animacoes (estados) da tela de vitoria/derrota
animTime12:	.word	0x00000000	# tempo em ms desde que o estado 1 foi atingido
animTime23:	.word	0x00000000	# tempo em ms desde que o estado 2 foi atingido
animTime31:	.word	0x00000000	# tempo em ms desde que o estado 3 foi atingido

MenuPause: 	.byte 255,0,0,0,0,0,0	# o ultimo diz sobre o qual está sendo selecionado

# Cores do menu	#
MenuBatalha:	.byte	0, 255			# Cor do menu de batalha 
MenuFinais:	.word	0x0000c73f, 0x0000c703	# Cor do menu de vitoria/derrota  

# posicao Ficticia Cursor

PosicaoInimigo: .word 0, 0

# posicoes em quantidade de pulos 16x16
PosicaoAtualCursor: 	.word 0, 0
PosicaoAnteriorCursor: 	.word 0, 0	# mudei esse aqui so de zueira / aqui nÃ£o tem brincadeira >:(

# posicoes em (x,y) do bitmap + parametro para tipo de animacao
#		       	x    y  estado
Lyn:		.word	80, 80, 80, 80, 0	# Aliado  1  
		.byte	18,		# pontos de vida
			0,		# tipo de arma => 0 = espada
			0		# classificacao do personagem => 0 = Lyn 	
Brigand: 	.word  	80, 144, 80, 144, 0	# Inimigo 1
		.byte	20,		# hp
			1,		# tipo de arma => 0 = machado
			1		# classificacao do personagem => 1 = Brigand
Yogi:		.word 	112, 80, 112, 80, 0	# Aliado  2 (knight)
		.byte	25,		# hp
			2,		# tipo de arma => 2 = lanca
			2		# classificacao do personagem => 2 = Knight (Yogi)
Soldier: 	.word 	112, 144, 112, 144, 0	# Inimigo 2
		.byte	20,		# hp
			2,		# tipo de arma => 2 = lanca
			3		# classificacao do personagem => 3 = Soldier (Lanca)
# resto abaixo ainda nao implementado
Dorcas:		.word 	144, 80, 144, 80, 0	# Aliado  3 (warrior)	
		.byte	20,		# hp
			1,		# tipo de arma => 1 = machado
			4		# classificacao do personagem => 4 = Dorcas (Warrior)
Assassin: 	.word 	144, 144, 144, 144, 0	# Inimigo 3
		.byte	18,		# hp
			0,		# tipo de arma => 0 = espada
			5		# classificacao do personagem => 5 = Assassin
Dart:		.word 	176, 80, 176, 80, 0	# Aliado  4 (berserker)
		.byte	20,		# hp
			1,		# tipo de arma => 1 = machado
			6		# classificacao do personagem => 6 = Dart (berserker)
Brigand2: 	.word 	176, 144, 176, 144, 0	# Inimigo 4
		.byte	20,		# hp
			1,		# tipo de arma => 1 = machado
			7		# classificacao do personagem => 7 = Brigand (2)
Sain: 		.word 	208, 80, 208, 80, 0	# Aliado  5 (cavalier)
		.byte	25,		# hp
			2,		# tipo de arma => 2 = lanca
			8		# classificacao do personagem => 8 = Sain (Cavalier)
Soldier2: 	.word 	208, 144, 208, 144, 0	# Inimigo 5
		.byte	20,		# hp
			2,		# tipo de arma => 2 = lanca
			9		# classificacao do personagem => 2 = Soldier (2)
.text
	
TrataHack:
	la	t0,GuardaHack
	lb	t1,0(t0)
	beqz	t1,PulaTratamentoHack
	sb	zero,0(t0)
	li	t0,1
	beq	t1,t0,FASE1
	li	t0,2
	beq	t1,t0,FASE2
	li	t0,3
	beq	t1,t0,FASE3
	li	t0,4
	beq	t1,t0,FASE4
	li	t0,5
	beq	t1,t0,FASE5
PulaTratamentoHack:
FASE1:
	call	Fase1
	la	t0,GameOver
	lb	t1,0(t0)
	bnez	t1,PulaParaDerrota
	la	t0,GuardaHack
	lb	t1,0(t0)
	bnez	t1,TrataHack
FASE2:
	call	Fase2
	la	t0,GameOver
	lb	t1,0(t0)
	bnez	t1,PulaParaDerrota
	la	t0,GuardaHack
	lb	t1,0(t0)
	bnez	t1,TrataHack
FASE3:
	call	Fase3
	la	t0,GameOver
	lb	t1,0(t0)
	bnez	t1,PulaParaDerrota
	la	t0,GuardaHack
	lb	t1,0(t0)
	bnez	t1,TrataHack
FASE4:
	call	Fase4
	la	t0,GameOver
	lb	t1,0(t0)
	bnez	t1,PulaParaDerrota
	la	t0,GuardaHack
	lb	t1,0(t0)
	bnez	t1,TrataHack
FASE5:
	call	Fase5
	la	t0,GameOver
	lb	t1,0(t0)
	bnez	t1,PulaParaDerrota
	la	t0,GuardaHack
	lb	t1,0(t0)
	bnez	t1,TrataHack
	call	Vitoria
	la	t0,GuardaHack
	lb	t1,0(t0)
	bnez	t1,TrataHack
	j fim
PulaParaDerrota:
	call	Derrota
	la	t0,GuardaHack
	lb	t1,0(t0)
	bnez	t1,TrataHack
fim: 	j fim													

.include "fases/Fase1.s"
.include "fases/Fase2.s"
.include "fases/Fase3.s"
.include "fases/Fase4.s"
.include "fases/Fase5.s"

.include "fases/Dialogo1.s"
.include "fases/Dialogo2.s"
.include "fases/Dialogo3.s"
.include "fases/Dialogo4.s"
.include "fases/Dialogo5.s"

.include "funcoes/DecideMapa.s"
.include "funcoes/InicializaPersonagens.s"	
.include "funcoes/PrintByteInverso.s"
.include "funcoes/SetupMapa.s" 
.include "funcoes/ImprimeAreaMovimentacao.s" 
.include "funcoes/EscolhePersonagem.s" 
.include "funcoes/DecideMudanca.s" 
.include "funcoes/MovimentaMenu.s"

.include "funcoes/EscolheIdleAssassin.s" 
.include "funcoes/EscolheIdleBrigand.s" 
.include "funcoes/EscolheIdleBrigand2.s"
.include "funcoes/EscolheIdleLyn.s" 
.include "funcoes/EscolheIdleDart.s"		
.include "funcoes/EscolheIdleDorcas.s"		
.include "funcoes/EscolheIdleSain.s"
.include "funcoes/EscolheIdleSoldier.s"
.include "funcoes/EscolheIdleSoldier2.s"
.include "funcoes/EscolheIdleYogi.s"

.include "funcoes/RecuperaSprite.s" 
.include "funcoes/SalvaSprite.s"
.include "funcoes/MovimentaCursor.s"
.include "funcoes/MontaMenu.s" 
.include "funcoes/PrintBalao.s"

.include "funcoes/Ataque.s"
.include "funcoes/AtualizaHP.s"
.include "funcoes/ClearScreen.s"
.include "funcoes/DecideLutador.s"
.include "funcoes/Dialogo.s"
.include "funcoes/FuncoesDoSystem.s"
.include "funcoes/GetEnt.s"
.include "funcoes/Luta.s"
.include "funcoes/midiAtaque.s"
.include "funcoes/midiDano.s"
.include "funcoes/midiHP.s"
.include "funcoes/midiTexto.s"
.include "funcoes/Musica.s"
.include "funcoes/PRINT.s"
.include "funcoes/PrintByte.s"
.include "funcoes/PrintHP.s"
.include "funcoes/PrintTiling.s"

.include "funcoes/VerificaVez.s"
.include "funcoes/VerificaGameOver.s"
.include "funcoes/VerificaWin.s"

.include "funcoes/AtualizaLuta.s"
.include "funcoes/CobreMensagem.s"

.include "funcoes/TerrenoEspecial.s"

.include "funcoes/SimboloArma.s"
.include "funcoes/SimboloSetas.s"

.include "funcoes/LimpaFala.s"
.include "funcoes/Decoracoes.s"
.include "funcoes/PrintInt.s"

.include "funcoes/Vitoria.s"
.include "funcoes/Derrota.s"
.include "funcoes/ImprimeBrigand.s"
.include "funcoes/ImprimeSoldier.s"
.include "funcoes/ImprimeAssassin.s"
.include "funcoes/AtualizaEstados.s"
.include "funcoes/CobreTela.s"
.include "funcoes/ImprimeOpcoes.s"
.include "funcoes/MovimentaCursor2.s"

.include "funcoes/ImprimeLyn.s"
.include "funcoes/ImprimeYogi.s"
.include "funcoes/ImprimeDorcas.s"
.include "funcoes/ImprimeDart.s"
.include "funcoes/ImprimeSain.s"
.include "funcoes/MontaMenu2.s"
.include "funcoes/MontaMenu3.s"
.include "funcoes/MovimentaMenu2.s"

.data

.include "sprites/numeros/numzero.data"
.include "sprites/numeros/um.data"
.include "sprites/numeros/dois.data"
.include "sprites/numeros/tres.data"
.include "sprites/numeros/quatro.data"
.include "sprites/numeros/cinco.data"
.include "sprites/numeros/seis.data"
.include "sprites/numeros/sete.data"
.include "sprites/numeros/oito.data"
.include "sprites/numeros/nove.data"
.include "sprites/tiles/quadroMarromE.data"
.include "sprites/tiles/quadroVermE.data"
.include "sprites/tiles/quadroAzulE.data"
.include "sprites/tiles/square.data"
.include "sprites/tiles/miss.data"
.include "sprites/tiles/arrowUP.data"
.include "sprites/tiles/arrowDOWN.data"
.include "sprites/tiles/symbolAssassin.data"
.include "sprites/tiles/symbolBrigand.data"
.include "sprites/tiles/symbolDart.data"
.include "sprites/tiles/symbolDorcas.data"
.include "sprites/tiles/symbolLyn.data"
.include "sprites/tiles/symbolSain.data"
.include "sprites/tiles/symbolSoldier.data"
.include "sprites/tiles/symbolYogi.data"

# datas de tilemap

.include "sprites/tilemaps/tilemap_praia.data"
.include "sprites/tilemaps/tilemap_floresta.data"
.include "sprites/tilemaps/tilemap_estrada.data"
.include "sprites/tilemaps/tilemap_FimDaEstrada.data"
.include "sprites/tilemaps/tilemap_himalaia.data"

# sprites da fase 1

.include "sprites/tiles/TileAreia.data"
.include "sprites/tiles/TileBeiraMar.data"
.include "sprites/tiles/TileMar.data"
.include "sprites/tiles/TileTubarao.data"
.include "sprites/tiles/TileCasa.data"
.include "sprites/tiles/TilePedra.data"

# sprites da fase 2

.include "sprites/tiles/TileGrama.data"
.include "sprites/tiles/TileFloresta.data"

# sprites da fase 3

.include "sprites/tiles/TileGramaTarde.data"
.include "sprites/tiles/TileFlorestaTarde.data"
.include "sprites/tiles/TileChao.data"
.include "sprites/tiles/TileGramaChaoD.data"
.include "sprites/tiles/TileGramaChaoE.data"

# sprites da fase 4

.include "sprites/tiles/TileNeve.data"
.include "sprites/tiles/TilePedraFria.data"
.include "sprites/tiles/TileArvoreNeve.data"

# sprites da fase 5

.include "sprites/tiles/TileGramaNoite.data"
.include "sprites/tiles/TileFlorestaNoite.data"
.include "sprites/tiles/TileGramaChaoNoite.data"
.include "sprites/tiles/TileChaoNoite.data"
.include "sprites/tiles/TileGramaChaoNoiteD.data"
.include "sprites/tiles/TileCD.data"
.include "sprites/tiles/TileCE.data"
.include "sprites/tiles/TileFim.data"

# sprites de mugshots

.include "sprites/personagens/mugshot_juLynete.data"	
.include "sprites/personagens/mugshot_Lyn.data"	
.include "sprites/personagens/mugshot_Carolina.data"	

# sprites de mapa dos personagens

.include "sprites/personagens/Lyn_datas.data"
.include "sprites/personagens/Knight_datas.data"
.include "sprites/personagens/Dorcas_datas.data"
.include "sprites/personagens/Dart_datas.data"
.include "sprites/personagens/Sain_datas.data"
.include "sprites/personagens/Brigand_datas.data"
.include "sprites/personagens/Lanca_datas.data"
.include "sprites/personagens/Assassin_datas.data"

# sprites de luta

.include "sprites/personagens/LutaAssassin.data"
.include "sprites/personagens/LutaBrigand.data"
.include "sprites/personagens/LutaDart.data"
.include "sprites/personagens/LutaDorcas.data"
.include "sprites/personagens/LutaLyn.data"
.include "sprites/personagens/LutaSain.data"
.include "sprites/personagens/LutaSoldier.data"
.include "sprites/personagens/LutaYogi.data"
.include "sprites/tiles/umHP.data"
.include "sprites/tiles/umHPinvisivel.data"

# strings do jogo

.include "falas/falas.s"

# sprites de menu

.include "sprites/menus/LadoMenu.data"
.include "sprites/menus/BordaMenuC.data"
.include "sprites/menus/LadoMenuB.data"
.include "sprites/menus/BordaMenuB.data"
.include "sprites/menus/LadoMenuC.data"
.include "sprites/menus/MioloMenu.data"

# sprites de cursor

.include "sprites/cursor/Cursor1.s"
.include "sprites/cursor/Cursor2.s"
.include "sprites/cursor/seletor_verm.data"
.include "sprites/cursor/seletor_azul.data"

# sprites do balao

.include "sprites/tiles/cantoSD.data"
.include "sprites/tiles/cantoID.data"
.include "sprites/tiles/arestaD.data"
.include "sprites/tiles/arestaS.data"
.include "sprites/tiles/arestaR.data"
.include "sprites/tiles/arestaI.data"
.include "sprites/tiles/miolo.data"
.include "sprites/tiles/rabo_esquerdo.data"
.include "sprites/tiles/rabo_direito.data"
