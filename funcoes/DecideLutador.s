#########################################################################
#	esta funcao decide qual sprite de luta deve ser		# 
#	impressa, e em qual altura 0<= y < 240 no bitmap	#			
#########################################################################
#	- Inputs -							#
#	a0 = valor codificador de personagem				#
#########################################################################
#	- Outputs -							#
#	a0 = label da sprite						#
#	a2 = y da sprite						#
#########################################################################
DecideLutador:
	li	a2, 100			# y padrao
#ehLyn:
	li	t0, 0
	bne	a0, t0, ehBrigand
	la	a0, LutaLyn
	j	FimDecideLutador
ehBrigand:
	li	t0, 1
	bne	a0, t0, ehYogi
	la	a0, LutaBrigand
	j	FimDecideLutador
ehYogi:
	li	t0, 2
	bne	a0, t0, ehSoldier
	la	a0, LutaYogi
	j	FimDecideLutador
ehSoldier:
	li	t0, 3
	bne	a0, t0, ehDorcas
	la	a0, LutaSoldier
	j	FimDecideLutador
ehDorcas:
	li	t0, 4
	bne	a0, t0, ehAssassin
	la	a0, LutaDorcas
	j	FimDecideLutador
ehAssassin:
	li	t0, 5
	bne	a0, t0, ehDart
	la	a0, LutaAssassin
	j	FimDecideLutador
ehDart:
	li	t0, 6
	bne	a0, t0, ehBrigand2
	la	a0, LutaDart
	li	a2, 83			# y do Dart
	j	FimDecideLutador
ehBrigand2:
	li	t0, 7
	bne	a0, t0, ehSain
	la	a0, LutaBrigand
	j	FimDecideLutador
ehSain:
	li	t0, 8
	bne	a0, t0, ehSoldier2
	la	a0, LutaSain
	li	a2, 88			# y do Sain
	j	FimDecideLutador
ehSoldier2:
	li	t0, 9
	bne	a0, t0, FimDecideLutador
	la	a0, LutaSoldier
FimDecideLutador:
	ret
