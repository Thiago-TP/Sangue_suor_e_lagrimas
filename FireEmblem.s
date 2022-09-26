.data
MenuAtivado:	.byte	0	# indica se o menu está ativado
Fase:		.byte	1	# numero da fase
musicTime:	.word	0	# tempo em ms desde a ultima nota	
noteCounter:	.word	0	# quantidade de notas tocadas

# Cor do menu de batalha #
MenuBatalha:	.byte	0, 255

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
.include "funcoes/PrintFala.s"
.include "funcoes/PrintHP.s"
.include "funcoes/PrintTiling.s"
.include "funcoes/VerificaLuta.s"




.data
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
