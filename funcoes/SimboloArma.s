SimboloArma:
	lb	t0, 22(a0)	# t0 <- byte do personagem
	beqz	t0, printLyn
	li	t1, 1
	beq	t0, t1, printBrigand
	li	t1, 2
	beq	t0, t1, printYogi
	li	t1, 3
	beq	t0, t1, printSoldier
	li	t1, 4
	beq	t0, t1, printDorcas
	li	t1, 5
	beq	t0, t1, printAssassin
	li	t1, 6
	beq	t0, t1, printDart
	li	t1, 7
	beq	t0, t1, printBrigand
	li	t1, 8
	beq	t0, t1, printSain
	li	t1, 9
	beq	t0, t1, printSoldier
	
printLyn:
	la	a0, symbolLyn
	ret
printBrigand:
	la	a0, symbolBrigand
	ret
printYogi:
	la	a0, symbolYogi
	ret
printSoldier:
	la	a0, symbolSoldier
	ret
printDorcas:
	la	a0, symbolDorcas
	ret
printAssassin:
	la	a0, symbolAssassin
	ret
printDart:
	la	a0, symbolDart
	ret
printSain:
	la	a0, symbolSain
	ret
