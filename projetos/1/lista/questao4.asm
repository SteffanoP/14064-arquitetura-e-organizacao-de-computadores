.data
    string: .asciiz "Minha String"
    copia: .asciiz "String Minha"
    num: .word 4
    str1: .asciiz "String"
    str2: .asciiz "String"

.text

main:                       # função inicial do programa
    # exemplo strcpy 
    la		$a1, string		# carrega o endereço de 'string' para $a1
    la		$a0, copia		# carrega o endereço de 'copia' para $a0
    jal		strcpy			# realiza jump para 'strcpy' e salva a posição em $ra

    addi	$a0, $v0, 0		# $a0 = v0 + 0, adiciona o valor de $v0 à $a0
    addi	$v0, $0, 4		# system call #4 - imprime string
    syscall					# chamada ao sistema para executar

    addi	$a0, $0, 10		# $a0 = $0 + 10, imprime uma nova linha
    addi $v0, $0, 11        # imprime o caracter
    syscall                 # chamada ao sistema para executar

    # exemplo memcpy 
    la		$a1, string		# carrega o endereço de 'string' para $a1
    la		$a0, copia		# carrega o endereço de 'copia' para $a0
    lw		$a2, num		# carrega o valo de 'num' em $a2
    
    jal		memcpy			# realiza jump para 'memcpy' e salva a posição em $ra

    addi	$a0, $v0, 0		# $t0 = $t1 + 0
    addi	$v0, $0, 4		# system call #4 - print string
    syscall					# chamada ao sistema para executar

    addi	$a0, $0, 10		# $a0 = $0 + 10, imprime uma nova linha
    addi $v0, $0, 11        # imprime o caracter
    syscall                 # chamada ao sistema para executar

    # exemplo strcmp 
    la		$a0, str1		# carrega o endereço de 'str1' para $a0
    la		$a1, str2		# carrega o endereço de 'str2' para $a1 
    
    jal		strcmp			# realiza jump para 'strcmp' e salva a posição em $ra

    addi	$a0, $v0, 0		# $a0 = $v0 + 0, adiciona o valor de $v0 à $a0
    addi	$v0, $0, 1		# system call #1 - imprime int
    syscall					# chamada ao sistema para executar

    addi	$a0, $0, 10		# $a0 = $0 + 10, imprime uma nova linha
    addi $v0, $0, 11        # imprime o caracter
    syscall                 # chamada ao sistema para executar

    # exemplo strncmp 
    la		$a0, str1		# carrega o endereço de 'str1' para $a0
    la		$a1, str2		# carrega o endereço de 'str2' para $a1  
    lw		$a3, num		# carrega o endereço de 'num' para $a3
    
    jal		strncmp			# realiza jump para 'strncmp' e salva a posição em $ra

    addi	$a0, $v0, 0		# $a0 = $v0 + 0, adiciona o valor de $v0 à $a0
    addi	$v0, $0, 1		# system call #1 - imprime int
    syscall					# chamada ao sistema para executar

    addi	$a0, $0, 10		# $a0 = $0 + 10, imprime uma nova linha
    addi $v0, $0, 11        # imprime o caracter
    syscall                 # chamada ao sistema para executar

    # exemplo strcat 
    # AVISO: pode resultar em overlap se seu destino não tiver memória
    # alocada para concatenação, nesse caso, o resultado é undefined.
    la		$a0, str1		# carrega o endereço de 'str1' para $a0
    la		$a1, str2		# carrega o endereço de 'str2' para $a1 

    jal		strcat			# realiza jump para 'strcat' e salva a posição em $ra

    addi	$a0, $v0, 0		# $a0 = $v0 + 0, adiciona o valor de $v0 à $a0
    addi	$v0, $0, 4		# system call #1 - imprime int
    syscall					# chamada ao sistema para executar

    j		exit			# realiza jump para 'exit'

strcpy:
    addi	$t0, $a0, 0		# $t0 = $a1 + 0
    addi	$t1, $a1, 0		# $t1 = $a0 + 0

loop_over_string:
    lb		$t2, 0($t1)		# carrega byte por byte da string de $t1 para $t2
    sb		$t2, 0($t0)		# armazena byte por byte de $t2 para $t0 
    beq		$t2, $zero, finish_strcpy	# se $t2 == $zero então vai para 'finish_strcpy'
    
    addi	$t1, $t1, 1			# $t0 = $t0 + 1, passa para o próximo caracter da string
    addi	$t0, $t0, 1			# $t0 = $t0 + 1, passa para o próximo espaço vazio para armazenar o novo caracter
	j	loop_over_string        # realiza jump para 'loop_over_string'
    
finish_strcpy:
    addi $v0, $a0, 0            # $v0 = $a0 + 0, move o valor de $a0 para $v0
    jr		$ra					# jump para o endereço presente em $ra

memcpy:
    addi	$t0, $a2, 0			# $t0 = $a2 + 0, atribuição do valor para registrador temporário $t0
    addi	$t1, $a0, 0			# $t1 = $a0 + 0, atribuição do valor para registrador temporário $t1
    addi	$t2, $a1, 0			# $t2 = $a1 + 0, atribuição do valor para registrador temporário $t2

loop_over_num:
    beq		$t0, $zero, finish_memcpy	# se $t0 == $zero então vai para 'finish_memcpy'
    
    lb		$t3, 0($t2)		    # carrega byte por byte da string de $t2 para $t3
    sb		$t3, 0($t1)		    # armazena byte por byte de $t3 para $t1

    addi	$t1, $t1, 1			# $t1 = $t1 + 1, passa para o próximo espaço vazio para armazenar o novo número
    addi	$t2, $t2, 1			# $t1 = $t1 + 1, passa para o próximo número
    subi	$t0, $t0, 1			# $t0 = $t0 - 1
    j loop_over_num             # jump para 'loop_over_num'
    
finish_memcpy:
    sb		$zero, 0($t1)		# armazena byte por byte de $zero para $t1
    addi	$v0, $a0, 0			# $v0 = $a0 + 0, passa o valor de $a0 para $v0 como resultado
    jr		$ra					# jump para $ra

strcmp:
    addi	$t0, $a0, 0			# $t0 = $a0 + 0, atribuição do valor para registrador temporário $t0 
    addi	$t1, $a1, 0			# $t1 = $a1 + 0, atribuição do valor para registrador temporário $t1
    addi	$v0, $zero, 0       # $v0 = $zero + 0, valor de $v0 volta a ser 0

loop_over_strings:
    lb		$t3, 0($t0)		    # carrega byte por byte da string de $t0 para $t3
    lb		$t4, 0($t1)		    # carrega byte por byte da string de $t1 para $t4
    bne		$t3, $t4, compare_greater	# se $t3 != $t4 então vai para 'compare_greater'
    beq		$t3, $zero, finish_strcmp	# se $t3 == $zero então vai para 'finish_strcmp'

    addi	$t0, $t0, 1			# $t0 = $t0 + 0, passa para o próximo caracter
    addi	$t1, $t1, 1			# $t1 = $t1 + 0, passa para o próximo caracter
    j		loop_over_strings	# jump para 'loop_over_strings'

# CONTINUAR COMENTÁRIOS A PARTIR DAQUI
compare_greater:
    addi $v0, $v0, 1            # $v0 = $v0 + 1
    slt		$t3, $t3, $t4		# $t3 = ($t3 < $t4) ? 1 : 0
    beq		$t3, $zero, finish_strcmp	# se $t3 == $zero então vai para 'finish_strcmp'
    subi	$v0, $v0, 2			# $v0 = $v0 - 2

finish_strcmp:
    jr		$ra					# jump para $ra

strncmp:
    addi	$t0, $a0, 0			# $t0 = $a0 + 0
    addi	$t1, $a1, 0			# $t1 = $a1 + 0
    addi	$t5, $a3, 0			# $t5 = $a3 + 0

    addi	$v0, $zero, 0

loop_over_num_strings:
    beq		$t5, $zero, finish_strncmp	# se $t5 == $zero então vai para 'finish_strncmp

    lb		$t3, 0($t0)		# 
    lb		$t4, 0($t1)		# 
    bne		$t3, $t4, strncmp_compare_greater	# se $t3 != $t4 então vai para 'compare_greater
    beq		$t3, $zero, finish_strncmp	# se $t3 == $zero então vai para 'finish_strcmp

    addi	$t0, $t0, 1			# $t0 = $a0 + 0
    addi	$t1, $t1, 1			# $t1 = $a1 + 0
    subi	$t5, $t5, 1			# $t5 = $t5 - 1
    j		loop_over_num_strings	# jump para loop_over_strings
    
strncmp_compare_greater:
    addi $v0, $v0, 1
    slt		$t3, $t3, $t4		# $t3 = ($t3 < $t4) ? 1 : 0
    beq		$t3, $zero, finish_strncmp	# se $t3 == $zero então vai para 'finish_strcmp
    subi	$v0, $v0, 2			# $v0 = $v0 - 2

finish_strncmp:
    jr		$ra					# jump para $ra

strcat:
    addi	$t0, $a0, 0			# $t0 = $a0 + 0
    addi	$t1, $a1, 0			# $t1 = $a1 + 0
    
strcat_search_null_address:
    lb		$t2, 0($t0)		# 
    beq		$t2, $zero, strcat_loop_write_string	# se $t2 == $zero então vai para 'strcat_write_string
    addi	$t0, $t0, 1			# $t0 = $t0 + 1
    j strcat_search_null_address

strcat_loop_write_string:
    lb		$t2, 0($t1)		# 
    beq		$t2, $zero, strcat_finish	# se $t2 == $zero então vai para 'strcat_finish
    sb		$t2, 0($t0)		# 

    addi	$t0, $t0, 1			# $t0 = $t0 + 1
    addi	$t1, $t1, 1			# $t1 = $t1 + 1
    j strcat_loop_write_string
    
strcat_finish:
    addi	$v0, $a0, 0			# $v0 = $a0 + 0
    jr		$ra					# jump para $ra

exit:
    addi	$v0, $0, 10		# System call 10 - Exit
    syscall					# chamada ao sistema para executar