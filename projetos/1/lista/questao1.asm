.data
	s: .asciiz "Digite uma frase (max 256 char): "
	c1: .asciiz "Digite um caracter para ser substituído: "
	c2: .asciiz "\nAgora digite outro caracter para substituir: "
	space: .space 256
.text

.macro print (%string)
	li $v0, 4
	la $a0, %string
	syscall
.end_macro

.macro read
	li $v0, 8    # Se deixar o código 12 a palavra impressa no final do programa é a sem modificação 
	la $a0, space
	li $a1, 2
	syscall
.end_macro

start:
	print(s)
	# read(256)
	li $v0, 8      
	la $a0, space
	li $a1, 256
	la	$a0, s
	add	$t0, $a0, $t0
	syscall

	print(c1)
	read
	lb $a2, 0($a0)
	add	$t1, $a2, $t1

	print(c2)
	read
	lb $a3, 0($a0)
	add	$t2, $a3, $t2

	add	$a0, $t0, $0 # A palavra modificada, por incrível que pareça, não é exibida ao final do programa sem essa linha...

loop_over_string:
	lb	$t3, 0($t0)  #$t3 tá sendo igual ao char desejado para substituir
	
	beq	$t3, $zero, exit	# if $t3 == $zero then goto exit
	bne	$t3, $t1, not_equal	# if $t3 != $s1 then goto not_equal
	sb	$t2, 0($t0)		# Substituição

not_equal:
	addi	$t0, $t0, 1			# $t0 = $t0 + 1
	sll		$t3, $0, 4			# $t1 = $t1 << 4
	j		loop_over_string

exit:		
	addi	$v0, $0, 4		# system call #4 - print string
	add		$a0, $a0, $zero		# $a0 = $s0 + $zero
	syscall

	addi	$v0, $0, 10		# System call 10 - Exit
	syscall					