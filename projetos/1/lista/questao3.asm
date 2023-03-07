.data
    n_esimo: .asciiz "Digite um número maior que 1: "
.text

main:                       # função inicial do programa
    li $v0, 4               # imprime a string 'n_esimo'
    la $a0, n_esimo         # carrega o endereço de 'n_esimo' para $a0
    syscall                 # chamada ao sistema para executar

    li $v0, 5               # ler o inteiro do usuário para $v0
    syscall                 # chamada ao sistema para executar

    addi $a0, $v0, 0        # $a0 = $v0 + 0, move o valor de $v0 para $a0
    addi $v0, $0, 0         # $v0 = $0 + 0, restaura o valor 0 para $v0

    jal		fib				# realiza jump para 'fib' e salva a posição em $ra
    
    addi	$a0, $v0, 0		# $a0 = $v0 + 0, move o valor de $v0 para $a0
    addi	$v0, $0, 1		# system call #1 - imprime int
    syscall                 # chamada ao sistema para executar

    j		exit			# realiza jump para 'exit'

fib:
    slti	$t0, $a0, 2			        # $t0 = ($a0 < 2) ? 1 : 0
    beq		$t0, $zero, fib_recursive	# se $t0 == $zero então vai para 'fib_recursive'
    addi	$v0, $a0, 0			        # $v0 = $a0 + 0, move o valor de $a0 para $v0
    jr		$ra					        # realiza jump para o endereço salvo em $ra

fib_recursive:                          # função que calcula o fibonacci
                                        # os valores da pilha podem ser melhorados, já que $a0 poderia ser armazendado em alguma variável segura ao invés da pilha
    addi	$sp, $sp, -8	            # $sp = $sp + -8, reserva espaço para 2 entradas na pilha
    sw		$ra, 0($sp)		            # $sp = $ra, salva na pilha o endereço presente em $ra 
    sw		$a0, 4($sp)		            # armazena parâmetros na pilha
    
    subi	$a0, $a0, 1			        # $t0 = $a0 - 1, subtrai 1 do atual númeto em $a0 e atualiza
    jal		fib				            # realiza jump para 'fib' e salva o endereço da posição em $ra
    addi	$sp, $sp, -4			    # $sp = $sp + -4, reserva espaço para 1 entrada na pilha
    sw		$v0, 0($sp)		            # armazena parâmetros na pilha

    lw		$a0, 8($sp)		            # carrega o conteúdo da pilha em $a0
    subi	$a0, $a0, 2			        # $a0 = $a0 - 2, subtrai 2 do atual número em $a0 e atualiza
    jal		fib				            # realiza o jump para 'fib' e salva o endereço da posição em $ra

    lw		$t0, 0($sp)		            # carrega o conteúdo da pilha em $t0
    lw		$ra, 4($sp)	                # restaura o endereço salva na pilha para $ra
    addi	$sp, $sp, 12			    # $sp = $sp + 12, remove espaço para 3 entradas na pilha

    add		$v0, $t0, $v0		        # $v0 = $t0 + $v0, adiciona conteúdo em $v0
    jr		$ra					        # realiza jump para o endereço em $ra
    
fib_finish:                             # função que termina o cálculo
    addi	$v0, $a0, 0			        # $v0 = $a0 + 0, atribui valor à $v0
    jr		$ra					        # realiza jump para $ra
    
exit:                                   # função que termina o programa
    addi	$v0, $0, 10		            # System call 10 - Exit
    syscall                             # chamada ao sistema para executar