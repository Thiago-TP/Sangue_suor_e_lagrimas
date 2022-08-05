# IA media -> ocupa a primeira casa desocupada do tabuleiro,
# verificando de linha a linha
IA_media:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	#li t0, 2 
	#bne s1, t0, fim_media  # diff_choice =/= 2 => IA média não foi escolhida
	
	li a1, 0                # inicia o loop na posição 0
for_media:
	jal vazia
	bnez a0, fim_for_media # casa desocupada => sai do for
	li t0, 8
	blt t0, a1, fim_media   # checagem de segurança index<=8
	addi a1, a1, 1          # posição++
	j for_media             # continua o loop
fim_media:	     # retorno da função sem marcar o tabuleiro
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
fim_for_media:
	jal PRINT_PC # retorno da função com marca no tabuleiro
	
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
#
