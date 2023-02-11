.data
    string: .asciiz "Minha String"
    copia: .asciiz "String Minha"
    num: .word 4
    str1: .asciiz "String"
    str2: .asciiz "String"

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

    # Print new line
    addi	$a0, $0, 10			# $a0 = $0 + 10
    addi $v0, $0, 11
    syscall

    #strcmp example
    la		$a0, str1		# 
    la		$a1, str2		# 
    
    jal		strcmp			# jump to strcpy and save position to $ra

    addi	$a0, $v0, 0			# $t0 = $t1 + 0
    addi	$v0, $0, 1		# system call #1 - print int
    syscall						# execute

    # Print new line
    addi	$a0, $0, 10			# $a0 = $0 + 10
    addi $v0, $0, 11
    syscall

    #strncmp example
    la		$a0, str1		# 
    la		$a1, str2		# 
    lw		$a3, num		# 
    
    jal		strncmp			# jump to strcpy and save position to $ra

    addi	$a0, $v0, 0			# $t0 = $t1 + 0
    addi	$v0, $0, 1		# system call #1 - print int
    syscall						# execute

    # Print new line
    addi	$a0, $0, 10			# $a0 = $0 + 10
    addi $v0, $0, 11
    syscall

    #strcat example
    #WARNING: It may overlap if your destination does not have allocated
    #memory for concatenation, in this case, the result is undefined.
    la		$a0, str1		# 
    la		$a1, str2		# 

    jal		strcat			# jump to strcpy and save position to $ra

    addi	$a0, $v0, 0			# $t0 = $t1 + 0
    addi	$v0, $0, 4		# system call #1 - print int
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

strcmp:
    addi	$t0, $a0, 0			# $t0 = $a0 + 0
    addi	$t1, $a1, 0			# $t1 = $a1 + 0
    addi	$v0, $zero, 0

loop_over_strings:
    lb		$t3, 0($t0)		# 
    lb		$t4, 0($t1)		# 
    bne		$t3, $t4, compare_greater	# if $t3 != $t4 then goto compare_greater
    beq		$t3, $zero, finish_strcmp	# if $t3 == $zero then goto finish_strcmp

    addi	$t0, $t0, 1			# $t0 = $a0 + 0
    addi	$t1, $t1, 1			# $t1 = $a1 + 0
    j		loop_over_strings	# jump to loop_over_strings
    
compare_greater:
    addi $v0, $v0, 1
    slt		$t3, $t3, $t4		# $t3 = ($t3 < $t4) ? 1 : 0
    beq		$t3, $zero, finish_strcmp	# if $t3 == $zero then goto finish_strcmp
    subi	$v0, $v0, 2			# $v0 = $v0 - 2

finish_strcmp:
    jr		$ra					# jump to $ra

strncmp:
    addi	$t0, $a0, 0			# $t0 = $a0 + 0
    addi	$t1, $a1, 0			# $t1 = $a1 + 0
    addi	$t5, $a3, 0			# $t5 = $a3 + 0

    addi	$v0, $zero, 0

loop_over_num_strings:
    beq		$t5, $zero, finish_strncmp	# if $t5 == $zero then goto finish_strncmp

    lb		$t3, 0($t0)		# 
    lb		$t4, 0($t1)		# 
    bne		$t3, $t4, strncmp_compare_greater	# if $t3 != $t4 then goto compare_greater
    beq		$t3, $zero, finish_strncmp	# if $t3 == $zero then goto finish_strcmp

    addi	$t0, $t0, 1			# $t0 = $a0 + 0
    addi	$t1, $t1, 1			# $t1 = $a1 + 0
    subi	$t5, $t5, 1			# $t5 = $t5 - 1
    j		loop_over_num_strings	# jump to loop_over_strings
    
strncmp_compare_greater:
    addi $v0, $v0, 1
    slt		$t3, $t3, $t4		# $t3 = ($t3 < $t4) ? 1 : 0
    beq		$t3, $zero, finish_strncmp	# if $t3 == $zero then goto finish_strcmp
    subi	$v0, $v0, 2			# $v0 = $v0 - 2

finish_strncmp:
    jr		$ra					# jump to $ra

strcat:
    addi	$t0, $a0, 0			# $t0 = $a0 + 0
    addi	$t1, $a1, 0			# $t1 = $a1 + 0
    
strcat_search_null_address:
    lb		$t2, 0($t0)		# 
    beq		$t2, $zero, strcat_loop_write_string	# if $t2 == $zero then goto strcat_write_string
    addi	$t0, $t0, 1			# $t0 = $t0 + 1
    j strcat_search_null_address

strcat_loop_write_string:
    lb		$t2, 0($t1)		# 
    beq		$t2, $zero, strcat_finish	# if $t2 == $zero then goto strcat_finish
    sb		$t2, 0($t0)		# 

    addi	$t0, $t0, 1			# $t0 = $t0 + 1
    addi	$t1, $t1, 1			# $t1 = $t1 + 1
    j strcat_loop_write_string
    
strcat_finish:
    addi	$v0, $a0, 0			# $v0 = $a0 + 0
    jr		$ra					# jump to $ra

exit:
    addi	$v0, $0, 10		# System call 10 - Exit
    syscall					# execute