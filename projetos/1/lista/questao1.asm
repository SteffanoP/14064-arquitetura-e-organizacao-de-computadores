.data
	s: .asciiz "Digite uma frase (max 256 char): "
	c1: .asciiz "Digite um caracter para ser substituído: "
	c2: .asciiz "\nAgora digite outro caracter para substituir: "
	space: .space 256
.text

.macro print (%string)  # macro para imprimir uma string
	li $v0, 4			# carrega o código 4 do syscall para imprimir a string 
	la $a0, %string		# carrega o endereço da string em $a0
	syscall				# chamada ao sistema para executar
.end_macro

.macro read				# macro para ler uma string
	li $v0, 8    		# carrega o código 8 do syscall para ler a string. Se deixar o código 12 a palavra impressa no final do programa é a sem modificação 
	la $a0, space		# salva espaço para armazenar o caracter em $a0
	li $a1, 2			# carrega o imediato 2 em $a1 para pegar o comprimento máximo do caracter e o '\0'
	syscall		 		# chamada ao sistema para executar
.end_macro

start:					# função inicial do programa
	print(s) 			# chama a macro para imprimir a string s
	
	li $v0, 8      		# carrega o código 8 do syscall para ler a string
	la $a0, space		# salva espaço para armazenar a string em $a0
	li $a1, 256			# carrega o imediato 256 em $a1 para pegar o comprimento máximo da string e o '\0'
	la	$a0, s			# carrega o endereço da string em $a0
	add	$t0, $a0, $t0	# $t0 = $a0 + $t0, move o conteúdo de $a0 para $t0
	syscall 			# chamada ao sistema para executar

	print(c1)			# chama a macro 'print' para imprimir o caracter c1
	read				# chama a macro 'read' para ler o caracter
	lb $a2, 0($a0)		# carrega byte por byte do conteúdo de $a0 em $a2
	add	$t1, $a2, $t1	# $t1 = $a2 + $t1, adiciona o conteúdo de $a2 em $t1

	print(c2)			# chama a macro 'print' para imprimir o caracter c2
	read				# chama a macro 'read' para ler o caracter
	lb $a3, 0($a0)		# carrega byte por byte do conteúdo de $a0 em $a3
	add	$t2, $a3, $t2	# $t2 = $a3 + $t2, adiciona o conteúdo de $a3 em $t2

	add	$a0, $t0, $0 	# $a0 = $t0 + $0, retorna para $a0 o conteúdo de $t0, ou seja, a string
						# a palavra modificada, por incrível que pareça, não é exibida ao final do programa sem essa linha...

loop_over_string:			# função que percorre a string
	lb	$t3, 0($t0)			# carrega byte por byte do conteúdo de $t0 em $t3
	
	beq	$t3, $zero, exit	# se $t3 == $zero então vai para 'exit'
	bne	$t3, $t1, not_equal	# se $t3 != $t1 então vai para 'not_equal'
	sb	$t2, 0($t0)			# substituição do caracter em $t2 e armazenamento deste em $t0

not_equal:						# função que muda de caracter na string quando este não é igual que que se deseja modificar
	addi	$t0, $t0, 1			# $t0 = $t0 + 1, passa para o próximo caracter presente na string
	sll		$t3, $0, 4			# $t3 = $t3 << 4, desloca 4 bits para setar o valor 0 em $t3
	j		loop_over_string	# realiza um jump para o 'loop_over_string', ou seja, volta para o looping

exit: 							# função para finalizar o programa
	addi	$t0, $a0, 0			# $t0 = $a0 + 0, move o conteúdo de $a0 para $t0

    addi $a0, $0, 10			# $a1 = $0 + 10, imprime nova linha
    addi $v0, $0, 11			# $v0 = $0 + 11, carrega o código 11 para imprimir um caracter
    syscall						# chamada ao sistema para executar

	addi	$v0, $0, 4		# system call #4 - imprime string
	addi	$a0, $t0, 0		# $a0 = $s0 + 0, atribui o valor em $t0 à $a0 novamente
	syscall					# chamada ao sistema para executar

	addi	$v0, $0, 10		# System call 10 - Exit
	syscall					# chamada ao sistema para executar