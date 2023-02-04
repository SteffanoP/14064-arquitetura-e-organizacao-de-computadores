.data
    string: .asciiz "Minha String"
    copia: .asciiz "String Minha"
    num: .word 4

.text

main:
    # strcpy example
    la		$a1, string		# 
    la		$a0, copia		# 
    jal		strcpy			# jump to strcpy and save position to $ra

    addi	$a0, $v0, 0			# $t0 = $t1 + 0
    addi	$v0, $0, 4		# system call #4 - print string
    syscall						# execute

    # Print new line
    addi	$a0, $0, 10			# $a0 = $0 + 10
    addi $v0, $0, 11
    syscall

    # memcpy example
    la		$a1, string		# 
    la		$a0, copia		#
    lw		$a2, num		# 
    
    jal		memcpy			# jump to strcpy and save position to $ra

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

memcpy:
    addi	$t0, $a2, 0			# $t0 = $a2 + 0
    addi	$t1, $a0, 0			# $t1 = $a0 + 0
    addi	$t2, $a1, 0			# $t2 = $a1 + 0

loop_over_num:
    beq		$t0, $zero, finish_memcpy	# if $t0 == $zero then goto finish_memcpy
    
    lb		$t3, 0($t2)		# 
    sb		$t3, 0($t1)		# 

    addi	$t1, $t1, 1			# $t1 = $t1 + 1
    addi	$t2, $t2, 1			# $t1 = $t1 + 1
    subi	$t0, $t0, 1			# $t0 = $t0 - 1
    j loop_over_num
    
finish_memcpy:
    sb		$zero, 0($t1)		# 
    addi	$v0, $a0, 0			# $v0 = $a0 + 0
    jr		$ra					# jump to $ra

exit:
    addi	$v0, $0, 10		# System call 10 - Exit
    syscall					# execute