.data
	s: .asciiz "Digite aqui uma frase: "
	c1: .asciiz "Digite um caracter: "
	c2: .asciiz "Agora digite outro caracter: "
	space: .space 256
.text

.macro print (%string)
	la $a0, %string
	addi $v0, $0, 4
	syscall
.end_macro

.macro read (%max_length)
	li $v0, 8        # Lê o char c2 do usuario
	la $a0, space
	li $a3, %max_length
	syscall
.end_macro

start:
	# TODO: Leitura da String e Char do usuário
	la	$a0, s

	la	$a1, c1		# s1
 	lb	$a1, 0($a1)		# 

	la	$a2, c2
	lb	$a2, 0($a2)	# s2 
	
	print(s)
	read(256)

	print(c1)
	read(1)

	print(c2)
	read(1)

	add	$t0, $a0, $t0		# a0$t0 = $s0 + $t0 Salva a entrada s em $t0
	add $t1, $a1, $t1
	add $t2, $a2, $t2

loop_over_string:
	lb	$t3, 0($t0)
	
	beq	$t3, $zero, exit	# if $t1 == $zero then goto exit
	bne	$t3, $t1, not_equal	# if $t1 != $s1 then goto not_equal
	sb	$t2, 0($t0)		# Substituição

not_equal:
	addi	$t0, $t0, 1			# $t0 = $t0 + 1
	sll	$t3, $0, 4			# $t1 = $t1 << 4
	j	loop_over_string

exit:
	addi	$v0, $0, 4		# system call #4 - print string
	add	$a0, $a0, $zero		# $a0 = $s0 + $zero
	syscall						# execute

	addi	$v0, $0, 10		# System call 10 - Exit
	syscall					# execute
  