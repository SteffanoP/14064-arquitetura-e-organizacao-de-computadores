.data
	s:		.asciiz "aaa"
	c1: 	.asciiz "a" 
	c2: 	.asciiz "b"

.text

start:
	# TODO: Leitura da String e Char do usuário
	la	$s0, s

	la	$s1, c1		# 
 	lb	$s1, 0($s1)		# 

	la	$s2, c2
	lb	$s2, 0($s2)	# 
	
	add	$t0, $s0, $t0		# $t0 = $s0 + $t0

loop_over_string:
	lb	$t1, 0($t0)
	
	beq	$t1, $zero, exit	# if $t1 == $zero then goto exit
	bne	$t1, $s1, not_equal	# if $t1 != $s1 then goto not_equal
	sb	$s2, 0($t0)		# Substituição

not_equal:
	addi	$t0, $t0, 1			# $t0 = $t0 + 1
	sll	$t1, $0, 4			# $t1 = $t1 << 4
	j	loop_over_string

exit:
	addi	$v0, $0, 4		# system call #4 - print string
	add	$a0, $s0, $zero		# $a0 = $s0 + $zero
	syscall						# execute

	addi	$v0, $0, 10		# System call 10 - Exit
	syscall					# execute
  