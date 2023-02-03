.data
    string: .asciiz "Minha String"
    copia: .asciiz "String Minha"

.text

main: 
    la		$a1, string		# 
    la		$a0, copia		# 
    jal		strcpy			# jump to strcpy and save position to $ra

    addi	$a0, $v0, 0			# $t0 = $t1 + 0
    addi	$v0, $0, 4		# system call #4 - print string
    syscall						# execute
    j		exit				# jump to exit

strcpy:
    addi	$t0, $a0, 0		# $t0 = $a1 + 0
    addi	$t1, $a1, 0		# $t1 = $a0 + 0

loop_over_string:
    lb		$t2, 0($t1)		# 
    sb		$t2, 0($t0)		# 
    beq		$t2, $zero, finish_strcpy	# if $t2 == $zero then goto finish_strcpy
    
    addi	$t1, $t1, 1			# $t0 = $t0 + 1
    addi	$t0, $t0, 1			# $t0 = $t0 + 1
	j	loop_over_string
    
finish_strcpy:
    addi $v0, $a0, 0
    jr		$ra					# jump to $ra

exit:
    addi	$v0, $0, 10		# System call 10 - Exit
    syscall					# execute