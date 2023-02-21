.data
    shell_user: .asciiz "\nHJJS-shell>> "
    nl: .word 10
    bs: .word 8
    ff: .word 12
    sep_args: .asciiz "-"

    receiver_ready: .word 0xffff0000
    receiver_data: .word 0xffff0004
    transmitter_ready: .word 0xffff0008
    transmitter_data: .word 0xffff000c

    # ad_morador data
    cmd_ad_morador: .asciiz "ad_morador"
    cmd_ad_morador_sucessfull_message: .asciiz "Morador cadastrado com sucesso!"
    cmd_ad_morador_error_format_1: .asciiz "\nad_morador não está formatado corretamente, verifique se você especificou a <option1>-<option2> corretamente.\n"
    cmd_ad_morador_error_format_2: .asciiz "\nValor de apartamento inválido, certifique que o valor está no padrão X0Z, tal que X é o andar e Z é o número do apartamento\n"
    sep_apt_number: .asciiz "0"
    cmd_ad_morador_error_invalid_floor: .asciiz "\nO andar possui um valor inválido. Por favor verifique novamente.\n"
    cmd_ad_morador_error_invalid_apartament: .asciiz "\nO apartamento possui um valor inválido. Por favor verifique novamente.\n"
    cmd_ad_morador_error_invalid_name_size: .asciiz "\nO nome do morador excede o tamanho de 20 caracteres. Por favor tente novamente com um nome menor.\n"

    cmd_help: .asciiz "help"
    std_help: .asciiz "\n\nThese are common commands used in various situations:\n\nad_morador-<option1>-<option2>\tEste comando adiciona um morador a um apartamento\nespecificado pela <option1>. O nome do morador é especificado pela <option2>.\n\nrm_morador-<option1>-<option2>\tEste comando remove um morador de um apartamento\n especificado pela <option1>. O nome do morador é especificado pela <option2>.\n\nad_auto-<option1>-<option2>-<option3>-<option4>\tEste comando adiciona um automóvel\n a um apartamento especificado pela <option1>. O tipo de automóvel é especificado pela \n<option2>.O modelo do automóvel é especificado pela <option3> e a sua cor pela <option4>.\n\nrm_auto-<option1>-<option2>-<option3>-<option4>\tEste comando remove um automóvel\nde um apartamento especificado pela <option1> .O tipo de automóvel é especificado pela\n<option2>. O modelo do automóvel é especificado pela <option3> e a sua cor pela <option4>.\n\nlimpar_ap-<option1>\tEste comando exclui todos os moradores e automóveis cadastrados\npara o apartamento especificado pela <option1>.\n\ninfo_ap-<option1>\tEste comando imprime na tela todas as informações cadastradas\nreferente a um apartamento especificado pela <option1>.\n\ninfo_geral\tDeve apresentar o panorama geral de apartamentos vazios e não vazios.\n\nsalvar\tDeve salvar todas as informações registradas em um arquivo externo.\n\nrecarregar\tRecarrega as informações salvas no arquivo externo na execução atual\ndo programa.\n\nformatar\tApaga todas as informações da execução atual do programa, deixando todos\nos apartamentos vazios.\n"

    cmd_exit: .asciiz "exit"
    cmd_not_found: .asciiz "\nCommand Not Found, type \"help\" to see all commands available."
.text

.macro write_shell (%string_address)
    la		$t0, (%string_address)	# 
    lw		$t2, transmitter_data		# 
    lw		$t3, transmitter_ready		# 
    
    write_byte:
        lb		$t1, 0($t0)		# 
        beq		$t1, $zero, end_write	# if $t1 == $zero then goto finish_write
        sw		$t1, 0($t2)		# 

    wait_display_to_write:
        lb		$t4, 0($t3)		# 
        beq		$t4, $zero, wait_display_to_write	# if $t0 == $zero then goto wait_display_to_write
        addi	$t0, $t0, 1			# $t0 = $t0 + 1
        j		write_byte				# jump to write_byte
            
    end_write:
.end_macro

.macro wait_new_char
    lw		$t0, receiver_ready		# 
    loop_wait_new_char:
        lb		$t2, 0($t0)		# 
        beq		$t2, $zero, loop_wait_new_char	# if $t2 == $zero then goto loop_wait_new_char

.end_macro

.macro print_error (%data_label)
    la		$t0, %data_label		# 
    write_shell($t0)
.end_macro

init:
    la		$t0, shell_user		# 
    write_shell($t0)
    
    # Allocate 64 of bytes in memory
    addi	$a0, $0, 64		# 64 bytes to be allocated
    addi	$v0, $0, 9		# system call #9 - allocate memory
    syscall					# execute
    addi	$s0, $v0, 0			# $s0 = $v0 + 0
    
main:
    wait_new_char
    lw		$s1, receiver_data
    lw		$t2, 0($s1)		# 
    lw		$t1, nl	# 
    beq		$t2, $t1, process_command	# if $t0 == $t1 then goto exit
    lw		$t1, bs		# 
    beq		$t2, $t1, backspace	# if $t2 == $t1 then goto backspace
    
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    addi	$a1, $s1, 0			# $a1 = $t2 + 0
    
    jal		strcat				# jump to strcat and save position to $ra

    write_shell($s1)
    j		main				# jump to main

backspace:
    la		$t0, ff		# 
    write_shell($t0)
    la		$t0, shell_user		# 
    write_shell($t0)
    
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    jal		strrm1				# jump to strrm1 and save position to $ra
    write_shell($s0)
    j		main				# jump to main

process_command:
    # Command is a ASCII String on Address $s0 and it ends with \0

    # If no command is written, then go back to main
    lb		$t0, 0($s0)		    # 
    beq		$t0, $zero, write_current_shell_cmd	# if $t0 == $zero then goto write_current_shell_cmd

    # Command ad_morador
    la		$a0, cmd_ad_morador	# 
    addi	$a1, $s0, 0			# $a1 = $s0 + 0
    jal		check_prefix		# jump to check_prefix and save position to $ra
    beq		$v0, $zero, ad_morador	# if $v0 == $zero then goto ad_morador

    # Command help
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    la		$a1, cmd_help		# 
    jal		strcmp				# jump to strcmp and save position to $ra
    beq		$v0, $zero, help	# if $v0 == $zero then goto exit

    # Command exit
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    la		$a1, cmd_exit		# 
    jal		strcmp				# jump to strcmp and save position to $ra
    beq		$v0, $zero, exit	# if $v0 == $zero then goto exit

    # If command not found suggest typing help
    la		$t0, cmd_not_found		# 
    write_shell($t0)

write_current_shell_cmd:
    la		$t0, shell_user		# 
    write_shell($t0)
    write_shell($s0)

    j		main				# jump to main

ad_morador:
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    jal		jump_prefix				# jump to jump_prefix and save position to $ra

    # Check format <option1>-<option2>
    lb		$t0, 3($v0)		# 
    lb		$t1, sep_args	#
    bne		$t0, $t1, ad_morador_error_format_1	# if $t0 != $t1 then goto ad_morador_error_format

    # Check format X0Z from apartment's number
    lb		$t0, 1($v0)		# Load char on the position whereas should be the separator from X and Z
    lb		$t1, sep_apt_number		# Load separator of floor (X) and apartaments (Z) => ("0")
    bne		$t0, $t1, ad_morador_error_format_2	# if $t0 != $t1 then goto ad_morador_error_format_2

    # Check if floor is valid ([0,9])
    lb		$t0, 0($v0)		# Load char on the position whereas should be the floor
    subi	$t0, $t0, 48			# $t0 = $t0 - 48 => Convert char into dec
    slti	$t0, $t0, 10			# $t0 = ($t0 < 10) ? 1 : 0 => Check if less than 10
    beq		$t0, $zero, ad_morador_error_invalid_floor	# if $t0 == $zero then goto ad_morador_error_invalid_floor

    # Check if Apartament Number is valid
    lb		$t0, 2($v0)		# Load char on the position whereas should be the apartment number
    subi	$t0, $t0, 48			# $t0 = $t0 - 48 => Convert char into dec
    slti	$t1, $t0, 5			# $t1 = ($t0 < 5) ? 1 : 0 => Check if less than 5
    beq		$t1, $zero, ad_morador_error_invalid_apartment	# if $t1 == $zero then goto ad_morador_error_invalid_apartment
    # Check if is not zero
    beq		$t0, $zero, ad_morador_error_invalid_apartment	# if $t0 == $zero then goto ad_morador_error_invalid_apartment
    
    # Check size of the string from morador name's
    addi	$t6, $v0, 0			# $t6 = $v0 + 0 | Move $v0 into $t6, because $t6 is the last temporary to be assumed as temp
    addi	$a0, $t6, 4			# $a0 = $t6 + 4 | Move $t6 into $a0.
    jal		strlen				# jump to strlen and save position to $ra
    slti	$t0, $v0, 21			# $t0 = ($v0 < 21) ? 1 : 0 | Check if size is less or equals the limit of 20 characters
    beq		$t0, $zero, ad_morador_error_invalid_name_size	# if $t0 == $zero then goto ad_morador_error_invalid_name_size

    # Allocate necessary space to store object
    # Allocate 28 of bytes in memory
    addi	$a0, $0, 28		# 26 bytes to be allocated
    addi	$v0, $0, 9		# system call #9 - allocate memory
    syscall					# execute
    addi	$t0, $v0, 0			# $t0 = $v0 + 0

    # Store object in linked list    
    addi	$t1, $s2, 0			# $t1 = $s2 + 0
    bne		$s2, $zero, ad_morador_check_where_to_store	# if $s2 != $zero then goto ad_morador_check_where_to_store
    addi	$s2, $t0, 0			# $s2 = $t0 + 0
    addi	$t1, $s2, 0			# $t1 = $s2 + 0

ad_morador_check_where_to_store:
    # Verifies where in the linked list is available to store data
    # It goes from the address stored in $s2 and tries to 
    lb		$t2, 1($t1)		#
    beq		$t2, $zero, ad_morador_store_morador	# if $t2 == $zero then goto ad_morador_store_morador
    lw		$t2, 24($t1)		# 
    beq		$t2, $zero, ad_morador_jump_to_next_block	# if $t2 == $zero then goto ad_morador_jump_to_next_block
    addi	$t1, $t2, 0			# $t1 = $t2 + 0
    j		ad_morador_check_where_to_store				# jump to ad_morador_check_where_to_store

ad_morador_jump_to_next_block:
    # In case the current block is already fullfilled, jump to the next block
    sw		$t0, 24($t1)		# 
    addi	$t1, $t0, 0			# $t1 = $t0 + 0
    j		ad_morador_check_where_to_store				# jump to ad_morador_check_where_to_store

ad_morador_store_morador:  
    # Read from command and stores it in the current block
    
    # Floor and Apartment number
    lb		$t3, 0($t6)		# 
    sb		$t3, 0($t1)		# 
    lb		$t3, 2($t6)		# 
    sb		$t3, 1($t1)		# 
    
    # The name of the morador
    addi	$a0, $t1, 2			# $a0 = $t1 + 2
    addi	$a1, $t6, 4			# $a1 = $t6 + 4
    jal		strcpy				# jump to strcpy and save position to $ra   

    # Storing is successfull, than shall return success message and clear command
    la		$t0, nl		# 
    write_shell($t0) # Print of \n
    la		$t0, cmd_ad_morador_sucessfull_message		# Load Address of sucessfull message
    write_shell($t0) # Print Sucessfull message
    j		write_current_shell_cmd				# jump to write_current_shell_cmd

ad_morador_error_format_1:
    print_error(cmd_ad_morador_error_format_1)
    j		write_current_shell_cmd				# jump to write_current_shell_cmd

ad_morador_error_format_2:
    print_error(cmd_ad_morador_error_format_2)
    j		write_current_shell_cmd				# jump to write_current_shell_cmd

ad_morador_error_invalid_floor:
    print_error(cmd_ad_morador_error_invalid_floor)
    j		write_current_shell_cmd				# jump to write_current_shell_cmd

ad_morador_error_invalid_apartment:
    print_error(cmd_ad_morador_error_invalid_apartament)
    j		write_current_shell_cmd				# jump to write_current_shell_cmd

ad_morador_error_invalid_name_size:
    print_error(cmd_ad_morador_error_invalid_name_size)
    j		write_current_shell_cmd				# jump to write_current_shell_cmd

help:
    la		$t0, std_help		# 
    write_shell($t0)
    j		write_current_shell_cmd				# jump to write_current_shell_cmd

exit:
    addi	$v0, $0, 10		# System call 10 - Exit
    syscall					# execute

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

strrm1:
    addi	$t0, $a0, 0			# $t0 = $a0 + 0
    addi	$t1, $zero, 0			# $t1 = $zero + 0
    
strrm1_loop_over_string:
    lb		$t2, 0($t0)		# 
    beq		$t2, $zero, strrm1_remove_last	# if $t2 == $zero then goto strrm1_remove_last
    addi	$t0, $t0, 1			# $t0 = $t0 + 1
    j		strrm1_loop_over_string				# jump to strrm1_loop_over_string
    
strrm1_remove_last:
    subi	$t0, $t0, 1			# $t0 = $t0 - 1
    sb		$zero, 0($t0)		# 
    jr		$ra					# jump to $ra

strlen:
    addi	$v0, $a0, 0			# $t0 = $a0 + 0

strlen_loop_over_str:
    lb		$t2, 0($v0)		# 
    beq		$t2, $zero, strlen_finish	# if $t2 == $t1 then goto strlen_finish
    addi	$v0, $v0, 1			# $t0 = $t0 + 1
    j strlen_loop_over_str

strlen_finish:
    sub		$v0, $v0, $a0		# $v0 = $v0 - $a0
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
    beq		$t3, $zero, finish_strcmp	# if $t3 == $zero then goto finish_strcmp
    subi	$v0, $v0, 2			# $v0 = $v0 - 2

finish_strncmp:
    jr		$ra					# jump to $ra

check_prefix:
    # input:
    # $a0 => prefix to check
    # $a1 => the command
    # return:
    # $zero => if prefix is equals to the command prefix
    # -1 or 1 => if prefix is not equal to the command prefix

    # Save $ra before jump and link
    subi	$sp, $sp, 4			# $sp = $sp - 4
    sw		$ra, 0($sp)		# 

check_prefix_len_word:
    jal		strlen				# jump to strlen and save position to $ra
    
check_prefix_compare_words:
    #Check prefix word
    addi	$a3, $v0, 0			# $a3 = $v0 + 0
    jal		strncmp				# jump to strncmp and save position to $ra
    bne		$v0, $zero, check_prefix_finish	# if $v0 != $zero then goto check_prefix_finish

    # Load separator
    la		$t2, sep_args		# 
    lb		$t2, 0($t2)		# 

    add		$t0, $a1, $a3		# $t0 = $a1 + $a3
    lb		$t0, 0($t0)		# 
    beq		$t0, $t2, check_prefix_finish	# if $t0 == $t2 then goto check_prefix_finish
    addi	$v0, $v0, 1			# $v0 = $v0 + 1
    
check_prefix_finish:
    # Get $ra back
    lw		$ra, 0($sp)		# 
    addi	$sp, $sp, 4			# $sp = $sp + 4

    jr		$ra					# jump to $ra

jump_prefix:
    # Input:
    # $a0 => prefix address to jump
    # return:
    # address without prefix
    addi	$t0, $a0, 0			# $t0 = $a0 + 0
    lw		$t1, sep_args		# 
    
jump_prefix_loop_until_sep_arg:
    lb		$t2, 0($t0)		# 
    beq		$t2, $t1, jump_prefix_end	# if $t0 == $t1 then goto jump_prefix_end
    addi	$t0, $t0, 1			# $t0 = $t0 + 1
    j		jump_prefix_loop_until_sep_arg				# jump to jump_prefix_loop_until_sep_arg
    
jump_prefix_end:
    addi	$v0, $t0, 1			# $v0 = $t0 + 1 | Get address after the sep
    jr		$ra					# jump to $ra
strcpy:
    addi	$t0, $a0, 0		# $t0 = $a1 + 0
    addi	$t1, $a1, 0		# $t1 = $a0 + 0

loop_over_string:
    lb		$t2, 0($t1)		# carrega byte por byte da string de $t1 para $t2
    sb		$t2, 0($t0)		# armazena byte por byte de $t2 para $t0 
    beq		$t2, $zero, finish_strcpy	# se $t2 == $zero então vai para 'finish_strcpy'
    
    addi	$t1, $t1, 1			# $t0 = $t0 + 1, passa para o próximo caracter da string
    addi	$t0, $t0, 1			# $t0 = $t0 + 1, passa para o próximo espaço vazio para armazenar o novo caracter
	j	loop_over_string        # realiza jump para 'loop_over_string'
    
finish_strcpy:
    addi $v0, $a0, 0            # $v0 = $a0 + 0, move o valor de $a0 para $v0
    jr		$ra					# jump para o endereço presente em $ra
