.data
    n_esimo: .asciiz "Digite um número maior que 1: "
.text

main:
    
    li $v0, 4           # print the string n_esimo
    la $a0, n_esimo     # load its address to $a0
    syscall

    li $v0, 5           # read the integer from user to $v0
    syscall 

    addi $a0, $v0, 0    # $a0 = $v0 + 0
    addi $v0, $0, 0     # $v0 = $0 + 0

    jal		fib				# jump to fib and save position to $ra
    
    addi	$a0, $v0, 0			# $a0 = $v0 + 0
    addi	$v0, $0, 1		# system call #1 - print int
    syscall						# execute

    j		exit				# jump to exit

fib:
    slti	$t0, $a0, 2			# $t0 = ($a0 < 2) ? 1 : 0
    beq		$t0, $zero, fib_recursive	# if $t0 == $zero then goto fib_recursive
    addi	$v0, $a0, 0			# $v0 = $a0 + 0
    jr		$ra					# jump to $ra

fib_recursive:
    # The Stack values could be improved, since $a0 could be stored in some safe variable instead of the stack
    addi	$sp, $sp, -8			# $sp = $sp + -8
    sw		$ra, 0($sp)		# 
    sw		$a0, 4($sp)		# 
    
    subi	$a0, $a0, 1			# $t0 = $a0 - 1
    jal		fib				# jump to fib and save position to $ra
    addi	$sp, $sp, -4			# $sp = $sp + -4
    sw		$v0, 0($sp)		# 

    lw		$a0, 8($sp)		# 
    subi	$a0, $a0, 2			# $a0 = $a0 - 1
    jal		fib				# jump to fib and save position to $ra

    lw		$t0, 0($sp)		# 
    lw		$ra, 4($sp)	# 
    addi	$sp, $sp, 12			# $sp = $sp + 12

    add		$v0, $t0, $v0		# $v0 = $t0 + $v0
    jr		$ra					# jump to $ra
    
fib_finish:
    addi	$v0, $a0, 0			# $v0 = $a0 + 0
    jr		$ra					# jump to $ra
    
exit:
    addi	$v0, $0, 10		# System call 10 - Exit
    syscall					# execute