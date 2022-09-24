.data
	.eqv	daninho		3
	.eqv	dano		6
	.eqv	danao		10
	.eqv	crit		5
.text
#########################################################
#	esta funcao decide o dano de um ataque		#
#	de um personagem sobre outro (inimigo),		#
#	de acordo com seus tipos de armas,		#
#	retornando o valor do dano			#
#########################################################
#	- Inputs -					#
#	a0 = tipo de arma 1 [atacante] (0, 1 ou 2)	#
#	a1 = tipo de arma 2 (0, 1 ou 2)			#
#########################################################
#	- Outputs -					#
#	a0 = dano 					#
#########################################################
#	- Variaveis internas -				#
#	t1 = 1						#
#	t2 = 2						#
#	t3 = rand int					#
#########################################################
#	espada > machado > lanca > espada ...	
Ataque:	
	# numero "aleatorio" para crit e erro
	csrr	t3, time
	li	t1, 10
	rem	t3, t3, t1	# t4 <- t4 mod 10
	bnez	t3, NaoErrou	# nao errou ? calcula dano : retorna com 0 dano
	mv	a0, x0
	ret
NaoErrou:
	# esquema pedra-papel-tesoura:
	# espada > machado > lanca > espada
	li	t1, 1
	li	t2, 2
	beqz	a0, Espada	# a0 tem valor da espada?
	beq	a0, t1, Machado	# a0 tem valor de machado?
# Lanca em a0 (a0=2)
Lanca:	
	beqz	a1, Forte
	beq	a1, t1, Fraca	   	
	j	Normal
	
# Machado em a0 (a0=1)
Machado:	
	beq	a1, t2, Forte
	beqz	a1, Fraca	   	
	j	Normal

# Espada em a0 (a0=0)	
Espada:	
	beq	a1, t1, Forte
	beq	a1, t2, Fraca
	j	Normal
	
Forte:	li	a0, danao   	
	j	fimAtaque
Fraca:	li	a0, daninho	
	j	fimAtaque
Normal:	li	a0, dano
	
fimAtaque:
	li	t1, 9
	bne	t3, t1, FoiQuase	# nao critou ? calcula dano : dano <- crit + calculo
	li	t1, crit
	add	a0, a0, t1		# dano += crit
FoiQuase:
	ret
