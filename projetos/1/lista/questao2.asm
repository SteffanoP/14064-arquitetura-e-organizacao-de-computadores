.data
	string: .asciiz "Minha String"

.text
	# TODO: Ler String do usuário
	la		$a0, string		# 
	jal		string_size		# jump to string_size and save position to $ra
	addi	$t0, $v0, 0		# $t0 = $v0 + 0

	add		$a0, $0, $v0
	addi	$v0, $0, 1		# system call #1 - print int
	syscall					# execute

	j exit

string_size:
	addi	$t0, $a0, 0		# $t0 = $a0 + 0

loop_over_string:
	lb		$t1, 0($t0)		# 
	
	beq		$t1, $zero, end_string	# if $t1 == $zero then goto end_string

	addi	$v0, $v0, 1			# $t2 = $t2 + 1
	addi	$t0, $t0, 1			# $t0 = $t0 + 1
	sll		$t1, $0, 4			# $t1 = $t1 << 4
	j		loop_over_string	# jump to loop_over_string

end_string:
	jr		$ra					# jump to $ra

exit:
	addi	$v0, $0, 10		# System call 10 - Exit
	syscall					# execute