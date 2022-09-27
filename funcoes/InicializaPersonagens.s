InicializaPersonagens:
	la	t0, Lyn
	li	t1, 80
	sw	t1, 0(t0)	
	sw	t1, 4(t0)
	sw	t1, 8(t0)	
	sw	t1, 12(t0)
	sw	zero, 16(t0)
	
	la	t0, Brigand
	li	t1, 80
	sw	t1, 0(t0)
	sw	t1, 8(t0)
	li	t1, 144	
	sw	t1, 4(t0)	
	sw	t1, 12(t0)
	sw	zero, 16(t0)
	
	la	t0, Yogi
	li	t1, 112
	sw	t1, 0(t0)
	sw	t1, 8(t0)
	li	t1, 80	
	sw	t1, 4(t0)
	sw	t1, 12(t0)
	sw	zero, 16(t0)
	
	la	t0, Soldier
	li	t1, 112
	sw	t1, 0(t0)
	sw	t1, 8(t0)
	li	t1, 144	
	sw	t1, 4(t0)
	sw	t1, 12(t0)
	sw	zero, 16(t0)
	
	la	t0, Dorcas
	li	t1, 144
	sw	t1, 0(t0)
	sw	t1, 8(t0)
	li	t1, 80	
	sw	t1, 4(t0)
	sw	t1, 12(t0)
	sw	zero, 16(t0)
	
	la	t0, Assassin
	li	t1, 144
	sw	t1, 0(t0)
	sw	t1, 8(t0)
	li	t1, 144	
	sw	t1, 4(t0)
	sw	t1, 12(t0)
	sw	zero, 16(t0)
	
	la	t0, Dart
	li	t1, 176
	sw	t1, 0(t0)
	sw	t1, 8(t0)
	li	t1, 80	
	sw	t1, 4(t0)
	sw	t1, 12(t0)
	sw	zero, 16(t0)
	
	la	t0, Brigand2
	li	t1, 176
	sw	t1, 0(t0)
	sw	t1, 8(t0)
	li	t1, 144
	sw	t1, 4(t0)
	sw	t1, 12(t0)
	sw	zero, 16(t0)
	
	la	t0, Sain
	li	t1, 208
	sw	t1, 0(t0)
	sw	t1, 8(t0)
	li	t1, 80
	sw	t1, 4(t0)
	sw	t1, 12(t0)
	sw	zero, 16(t0)
	
	la	t0, Soldier2
	li	t1, 208
	sw	t1, 0(t0)
	sw	t1, 8(t0)
	li	t1, 144
	sw	t1, 4(t0)
	sw	t1, 12(t0)
	sw	zero, 16(t0)
	
	ret
	
