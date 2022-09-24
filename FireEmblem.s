.data
MenuAtivado:	.byte	0	# indica se o menu está ativado
Fase:		.byte	1	# numero da fase
musicTime:	.word	0	# tempo em ms desde a ultima nota	
noteCounter:	.word	0	# quantidade de notas tocadas

# Cor do menu de batalha #

MenuBatalha:	.byte	0,255

# posicoes em quantidade de pulos 16x16
PosicaoAtualCursor: 	.word 0, 0
PosicaoAnteriorCursor: 	.word 0, 0	# mudei esse aqui so de zueira / aqui não tem brincadeira >:(

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
	call	Fase1
	call	Fase2
	call	Fase3
	call	Fase4
	call	Fase5
	fim: 	j fim	
																

.include "Fase1.s"
.include "Fase2.s"
.include "Fase3.s"
.include "Fase4.s"
.include "Fase5.s"

.include "DecideMapa.s"
.include "InicializaPersonagens.s"


.include "../funcoes/funcoes.s"

# funcoes do Rodrigo		
.include "FuncaoDeEscritaNoBitmap/PrintByteInverso.s"
.include "Mapa/FuncaoMapa/MapaMain.s" 
.include "Mapa/FuncaoMapa/ImprimeAreaMovimentacao.s" 
.include "Mapa/FuncaoMapa/EscolhePersonagem.s" 
.include "Mapa/FuncaoMapa/DecideMudanca.s" 
.include "Mapa/FuncaoMapa/MovimentaMenu.s"

.include "Mapa/FuncaoMapa/EscolheIdleAssassin.s" 
.include "Mapa/FuncaoMapa/EscolheIdleBrigand.s" 
.include "Mapa/FuncaoMapa/EscolheIdleBrigand2.s"
.include "Mapa/FuncaoMapa/EscolheIdleLyn.s" 
.include "Mapa/FuncaoMapa/EscolheIdleDart.s"		
.include "Mapa/FuncaoMapa/EscolheIdleDorcas.s"		
.include "Mapa/FuncaoMapa/EscolheIdleSain.s"
.include "Mapa/FuncaoMapa/EscolheIdleSoldier.s"
.include "Mapa/FuncaoMapa/EscolheIdleSoldier2.s"
.include "Mapa/FuncaoMapa/EscolheIdleYogi.s"

.include "Mapa/FuncaoMapa/RecuperaSprite.s" 
.include "Mapa/FuncaoMapa/SalvaSprite.s"
.include "Mapa/FuncaoMapa/MovimentaCursor.s"
.include "Mapa/FuncaoMapa/MontaMenu.s" 
.include "../funcoes/PrintBalao.s"



.data
.include "../sprites_e_tilemaps/datas.s"
.include "../falas/falas.s"

.include "Mapa/SpritesMapa/Cursor1.s"
.include "Mapa/SpritesMapa/Cursor2.s"
.include "Mapa/SpritesMapa/seletor_verm.data"
.include "Mapa/SpritesMapa/seletor_azul.data"

# sprites de mapa da Lyn
.include "Mapa/SpritesMapa/Lyn_datas.data"

# sprites de mapa do Yogi
.include "Mapa/SpritesMapa/Knight_datas.data"

# sprites de mapa do Dorcas
.include "Mapa/SpritesMapa/Dorcas_datas.data"

# sprites de mapa do Dart
.include "Mapa/SpritesMapa/Dart_datas.data"

# sprites de mapa do Sain
.include "Mapa/SpritesMapa/Sain_datas.data"

# sprites de mapa do Brigand 
.include "Mapa/SpritesMapa/Brigand_datas.data"

# sprites de mapa do Soldier
.include "Mapa/SpritesMapa/Lanca_datas.data"

# sprites de mapa do Assassin
.include "Mapa/SpritesMapa/Assassin_datas.data"

# sprites de menu

.include "Mapa/SpritesMapa/LadoMenu.data"
.include "Mapa/SpritesMapa/BordaMenuC.data"
.include "Mapa/SpritesMapa/LadoMenuB.data"
.include "Mapa/SpritesMapa/BordaMenuB.data"
.include "Mapa/SpritesMapa/LadoMenuC.data"
.include "Mapa/SpritesMapa/MioloMenu.data"
