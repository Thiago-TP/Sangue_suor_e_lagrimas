# IA media -> marca uma casa aletória desde que ela esteja desocupada
IA_facil:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	#li t0, 1 
	#bne s1, t0, fim_facil    # diff_choice =/= 1 => IA facil não foi escolhida
loop_facil:	
	li a7, 30                # tempo em ms de 1/1/1970 até hoje
	ecall
	li t0, 9 
	rem a1, a0, t0           # a0 mod 9 implica 0 <= a1 <= 8
	jal vazia 
	beq a0, zero, loop_facil # se a casa estiver ocupada, tenta de novo
	jal PRINT_PC
fim_facil:	
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
#
