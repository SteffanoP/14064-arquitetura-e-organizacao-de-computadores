.data
	string: .asciiz "Digite uma frase (max 40 char): "
	space: .space 40

.text

	li $v0, 4       		# print string "Digite uma frase..."
	la $a0, string			# carrega o endereço da string 'string' em $a0
	syscall					# chamada ao sistema para executar

	li $v0, 8       		# lê a string digitada pelo usuário
	la $a0, space   		# salva espaço para armazenar a string
	li $a1, 40      		# seta o comprimento máximo em $a1 para a string
	la $a0, string			# carrega a string
	add $t0, $a0, $t0   	# $t0 = $a0 + $t0, move o conteúdo de $a0 para $t0
	syscall					# chamada ao sistema para executar

	addi $v0, $0, 0 		# $v0 = $0 + 0, restaura o valor de $v0 para 0
	 
	jal		string_size		# realiza o jump para 'string_size' e salva a posição em $ra
	addi	$t0, $v0, 0		# $t0 = $v0 + 0, move o valor de $v0 para $t0

	add		$a0, $0, $v0	# $a0 = $0 + $v0, move o valor de $v0 para $a0
	addi	$v0, $0, 1		# system call #1 - imprime int
	syscall					# chamada ao sistema para executar

	j exit					# realiza o jump para 'exit'

string_size:
	addi	$t0, $a0, 0		# $t0 = $a0 + 0, coloca o conteúdo atual da string no temporário $t0

loop_over_string:			# função que percorre a string
	lb		$t1, 0($t0)		# carrega byte por byte da string de $t0 para $t1
	
	beq		$t1, 10, end_string	# se $t1 == 10 então vai para 'end_string' (10 representa uma nova linha por causa do botão Enter pressionado pelo usuário)

	addi	$v0, $v0, 1			# $v0 = $v0 + 1, $v0 recebe o valor referente a quantidade de caracteres lidos
	addi	$t0, $t0, 1			# $t0 = $t0 + 1, passa para o próximo caracter presente na string em $t0
	sll		$t1, $0, 4			# $t1 = $t1 << 4, descolca 4 bytes em $t1 para voltar valor para 0
	j		loop_over_string	# realiza o jump para continuar em 'loop_over_string'

end_string:						# quando o final da string foi identificado
	jr		$ra					# realiza o jump para o endereço presente em $ra

exit: 						# fim do programa
	addi	$v0, $0, 10		# System call 10 - Exit
	syscall					# chamada ao sistema para executar