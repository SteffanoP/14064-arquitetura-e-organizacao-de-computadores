.data
	string: .asciiz "Digite uma frase (max 40 char): "
	space: .space 40

.text

	li $v0, 4       # print string "Digite uma frase..."
	la $a0, string
	syscall

	li $v0, 8       # read string entered by user
	la $a0, space   # save space to store the string
	li $a1, 40      # settle the max length
	la $a0, string	# load string
	add $t0, $a0, $t0    # $t0 = $a0 + $t0
	syscall

	addi $v0, $0, 0 # $v0 = $0 + 0 restore $v0 valeu to 0
	 
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
	
	beq		$t1, 10, end_string	# if $t1 == 10 then goto end_string (10 represents a new line because of the Enter button pressed)

	addi	$v0, $v0, 1			# $t2 = $t2 + 1
	addi	$t0, $t0, 1			# $t0 = $t0 + 1
	sll		$t1, $0, 4			# $t1 = $t1 << 4
	j		loop_over_string	# jump to loop_over_string

end_string:
	jr		$ra					# jump to $ra

exit:
	addi	$v0, $0, 10		# System call 10 - Exit
	syscall					# execute