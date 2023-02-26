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
    cmd_ad_morador_error_apt_is_full: .asciiz "\nO apartamento informado já está em sua capacidade máxima. Não foi possível concluir sua transação\n"

    #ad_auto data
    cmd_ad_auto: .asciiz "ad_auto"
    cmd_ad_auto_type_moto: .asciiz "m"
    cmd_ad_auto_type_carro: .asciiz "c"
    cmd_ad_auto_sucessfull_message: .asciiz "\nAutomóvel Cadastrado com sucesso!"
    cmd_ad_auto_error_format_1: .asciiz "\nad_auto não está formatado corretamente, verifique se você especificou a <option1>-<option2>-<option3> corretamente.\n"
    cmd_ad_auto_error_invalid_type_auto: .asciiz "\nO tipo informado para o automóvel é inválido, por favor tente novamente com um tipo válido.\n"
    cmd_ad_auto_error_invalid_modelo_size: .asciiz "\nO nome do modelo excede o tamanho de 20 caracteres. Por favor tente novamente com um nome menor.\n"
    cmd_ad_auto_error_invalid_cor_size: .asciiz "\nO nome da cor excede o tamanho de 14 caracteres. Por favor tente novamente com um nome menor.\n"
    cmd_ad_auto_error_apt_not_found: .asciiz "\nO apartamento solicitado não está cadastrado no sistema e não será possível continuar a transação.\nTente cadastrar o seu apartamento com o comando ad_morador.\n"
    cmd_ad_auto_error_not_enough_size: .asciiz "\nVocê não tem mais espaço disponível para o seu automóvel nesse apartamento!\n"

    #limpar_ap data
    cmd_limpar_ap: .asciiz "limpar_ap"
    cmd_limpar_ap_successfull_message: .asciiz "\nO apartamento foi limpado com sucesso!\n"

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

.macro jump_to_next_ll (%current_ll_address)
    lw		%current_ll_address, 196(%current_ll_address) #
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

    # Comando ad_auto
    la		$a0, cmd_ad_auto		# 
    addi	$a1, $s0, 0			# $a1 = $s0 + 0
    jal		check_prefix				# jump to check_prefix and save position to $ra
    beq		$v0, $zero, ad_auto	# if $v0 == $zero then goto ad_auto

    # Comando limpar_ap
    la		$a0, cmd_limpar_ap		# 
    addi	$a1, $s0, 0			# $a1 = $s0 + 0
    jal		check_prefix				# jump to check_prefix and save position to $ra
    beq		$v0, $zero, limpar_ap	# if $v0 == $zero then goto limpar_ap

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

# Função que adiciona morador ao condomínio
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

    # Verifica se o apartamento já existe
    addi	$a0, $t6, 0			# $a0 = $t6 + 0
    addi	$a1, $s2, 0			# $a1 = $s2 + 0
    jal		search_if_apt_exists				# jump to search_if_apt_exists and save position to $ra
    bne		$v0, $zero, ad_morador_into_existing_apt	# if $v0 != $zero then goto ad_morador_into_existing_apt    

    # A partir daqui aloca um novo bloco de memória para o apartamento
    # Allocate necessary space to store object
    # Allocate 200 of bytes in memory
    addi	$a0, $0, 200		# 200 bytes to be allocated
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
    lw		$t2, 196($t1)		# 
    beq		$t2, $zero, ad_morador_jump_to_next_block	# if $t2 == $zero then goto ad_morador_jump_to_next_block
    addi	$t1, $t2, 0			# $t1 = $t2 + 0
    j		ad_morador_check_where_to_store				# jump to ad_morador_check_where_to_store

ad_morador_jump_to_next_block:
    # In case the current block is already fullfilled, jump to the next block
    sw		$t0, 196($t1)		# 
    addi	$t1, $t0, 0			# $t1 = $t0 + 0
    j		ad_morador_check_where_to_store				# jump to ad_morador_check_where_to_store

ad_morador_store_morador:  
    # Read from command and stores it in the current block
    
    # Floor and Apartment number
    lb		$t3, 0($t6)		# 
    sb		$t3, 0($t1)		# 
    lb		$t3, 2($t6)		# 
    sb		$t3, 1($t1)		# 

    # Adiciona +1 a quantidade de moradores
    lw		$t3, 4($t1)		# 
    addi	$t3, $t3, 1			# $t3 = $t3 + 1
    sw		$t3, 4($t1)		#     
    
    # Armazena o nome do morador
    addi	$a0, $t1, 0			# $a0 = $t1 + 0
    addi	$a1, $t6, 0			# $a1 = $t6 + 0
    addi	$a2, $t3, 0			# $a2 = $t3 + 0
    jal		store_morador				# jump to store_morador and save position to $ra

    # Storing is successfull, than shall return success message and clear command
    la		$t0, nl		# 
    write_shell($t0) # Print of \n
    la		$t0, cmd_ad_morador_sucessfull_message		# Load Address of sucessfull message
    write_shell($t0) # Print Sucessfull message
    j		write_current_shell_cmd				# jump to write_current_shell_cmd

ad_morador_into_existing_apt:
    addi	$t0, $v0, 0			# $t0 = $v0 + 0
    
    # Verifica se o apartamento está cheio
    lw		$t1, 4($t0)		#
    addi	$t2, $t1, 0			# $t2 = $t1 + 0
    slti	$t2, $t2, 5			# $t2 = ($t2 < 5) ? 1 : 0
    beq		$t2, $zero, ad_morador_error_apt_is_full	# if $t2 == $zero then goto ad_morador_error_apt_is_full

    # Adiciona +1 a quantidade de moradores no apartamento
    addi	$t1, $t1, 1			# $t1 = $t1 + 1
    sw		$t1, 4($t0)		# 
    
    # Armazena o nome do morador no slot disponível
    addi	$a0, $t0, 0			# $a0 = $t0 + 0
    addi	$a1, $t6, 0			# $a1 = $t6 + 0
    addi	$a2, $t1, 0			# $a2 = $t1 + 0
    jal		store_morador				# jump to store_morador and save position to $ra
    
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

ad_morador_error_apt_is_full:
    print_error(cmd_ad_morador_error_apt_is_full)
    j		write_current_shell_cmd				# jump to write_current_shell_cmd

# Função que adiciona um automóvel a um apartamento
ad_auto:
    # Pula e Armazena a entrada para ad_auto
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    jal		jump_prefix				# jump to jump_prefix and save position to $ra
    addi	$t6, $v0, 0			# $t0 = $v0 + 0

    # 303-c-Fiat Uno-Verde
    
    # Verifica formatação do comando ad_auto-<option1>-<option2>-<option3>
    lb		$t1, 3($t6)		# 
    lb		$t2, sep_args	#
    bne		$t1, $t2, ad_auto_error_format_1	# if $t1 != $t2 then goto ad_auto_error_format
    lb		$t1, 5($t6)		# 
    bne		$t1, $t2, ad_auto_error_format_1	# if $t0 != $t1 then goto ad_auto_error_format
    
    # Verifica formatação entre <option3>-<option4>
    addi	$a0, $t6, 6			# $a0 = $t6 + 6
    lb		$a1, sep_args		# 
    jal		strlen_until_sep				# jump to strlen_until_sep and save position to $ra
    beq		$v0, $zero, ad_auto_error_format_1	# if $v0 == $zero then goto ad_auto_error_format_1
    addi	$t1, $v0, 6			# $t1 = $v0 + 6
    add		$t1, $t1, $t6		# $t1 = $t1 + $t6
    lb		$t3, 0($t1)		# 
    lb		$t2, sep_args		# 
    bne		$t3, $t2, ad_auto_error_format_1	# if $t3 != $t2 then goto ad_auto_error_format_1
    addi	$t1, $t1, 1			# $t1 = $t1 + 1
    lb		$t3, 0($t1)		# 
    beq		$t3, $zero, ad_auto_error_format_1	# if $t3 == $zero then goto ad_auto_error_format_1

    # Verifica se o tipo do automóvel é válido
    lb		$t1, cmd_ad_auto_type_moto		# 
    lb		$t2, 4($t6)		# 
    beq		$t1, $t2, ad_auto_type_valid	# if $t1 == $t2 then goto ad_auto_type_valid
    lb		$t1, cmd_ad_auto_type_carro		# 
    beq		$t1, $t2, ad_auto_type_valid	# if $t1 == $t2 then goto ad_auto_type_valid
    j		ad_auto_error_invalid_auto_type				# jump to ad_auto_error_invalid_auto_type
    ad_auto_type_valid:
    
    # Verifica o tamanho das Strings de Modelo e Cor do automóvel
    addi	$a0, $t6, 6			# $a0 = $t6 + 6
    lb		$a1, sep_args		# 
    jal		strlen_until_sep				# jump to strlen_until_sep and save position to $ra
    slti	$t1, $v0, 21			# $t1 = ($v0 < 21) ? 1 : 0
    beq		$t1, $zero, ad_auto_error_invalid_modelo_size	# if $t1 == $zero then goto ad_auto_error_invalid_modelo_size
    addi	$a0, $v0, 7			# $a0 = $v0 + 6
    add		$a0, $a0, $t6		# $a0 = $a0 + $t6
    jal		strlen				# jump to strlen and save position to $ra
    slti	$t1, $v0, 15			# $t1 = ($v0 < 15) ? 1 : 0
    beq		$t1, $zero, ad_auto_error_invalid_cor_size	# if $t1 == $zero then goto ad_auto_error_invalid_cor_size

    # Verifica se o apartamento está cadastrado no condomínio
    addi	$a0, $t6, 0			# $a0 = $t6 + 0
    addi	$a1, $s2, 0			# $a1 = $s2 + 0
    jal		search_if_apt_exists				# jump to search_if_apt_exists and save position to $ra
    beq		$v0, $zero, ad_auto_error_apt_not_found	# if $v0 == $zero then goto ad_auto_error_apt_not_found

    #Verifica se há espaço para veículos no apartamento
    lb		$t1, 4($t6)		# 
    lb		$t2, cmd_ad_auto_type_carro		# 
    beq		$t1, $t2, ad_auto_check_size_for_carros	# if $t1 == $t2 then goto ad_auto_check_size_for_carros
    
    # Verifica para adicionar moto no condomínio
    lb		$t2, 118($v0)		# 
    lb		$t3, 156($v0)		# 
    lb		$t4, cmd_ad_auto_type_carro		# 
    beq		$t2, $t4, ad_auto_error_not_enough_size	# if $t2 == $t4 then goto ad_auto_error_not_enough_size
    beq		$t3, $t4, ad_auto_error_not_enough_size	# if $t3 == $t4 then goto ad_auto_error_not_enough_size
    and		$t2, $t2, $t3		# $t2 = $t2 & $t3
    beq		$t1, $t2, ad_auto_error_not_enough_size	# if $t1 == $t2 then goto ad_auto_error_not_enough_size
    j		ad_auto_has_enough_space				# jump to ad_auto_has_enough_space
    
    # Verifica para adicionar carro no condomínio
    ad_auto_check_size_for_carros:
    lb		$t2, 118($v0)		# 
    bne		$t2, $zero, ad_auto_error_not_enough_size	# if $t2 != $zero then goto target
    lb		$t2, 156($v0)		# 
    bne		$t2, $zero, ad_auto_error_not_enough_size	# if $t2 != $zero then goto ad_auto_error_not_enough_size
    
    ad_auto_has_enough_space:

    addi	$a0, $t6, 0			# $a0 = $t6 + 0
    addi	$a1, $v0, 0			# $a1 = $v0 + 0
    jal		store_auto				# jump to store_auto and save position to $ra

    j		write_current_shell_cmd				# jump to write_current_shell_cmd

ad_auto_error_format_1:
    print_error(cmd_ad_auto_error_format_1)
    j		write_current_shell_cmd				# jump to write_current_shell_cmd

ad_auto_error_invalid_auto_type:
    print_error(cmd_ad_auto_error_invalid_type_auto)
    j		write_current_shell_cmd				# jump to write_current_shell_cmd

ad_auto_error_invalid_modelo_size:
    print_error(cmd_ad_auto_error_invalid_modelo_size)
    j		write_current_shell_cmd				# jump to write_current_shell_cmd
    
ad_auto_error_invalid_cor_size:
    print_error(cmd_ad_auto_error_invalid_cor_size)
    j		write_current_shell_cmd				# jump to write_current_shell_cmd

ad_auto_error_apt_not_found:
    print_error(cmd_ad_auto_error_apt_not_found)
    j		write_current_shell_cmd				# jump to write_current_shell_cmd

ad_auto_error_not_enough_size:
    print_error(cmd_ad_auto_error_not_enough_size)
    j		write_current_shell_cmd				# jump to write_current_shell_cmd

# Função que limpa o apartamento
limpar_ap:
    # Pula e Armazena a entrada para limpar_ap
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    jal		jump_prefix				# jump to jump_prefix and save position to $ra
    addi	$t6, $v0, 0			# $t0 = $v0 + 0

    # Verifica se o apartamento está cadastrado no condomínio
    addi	$a0, $t6, 0			# $a0 = $t6 + 0
    addi	$a1, $s2, 0			# $a1 = $s2 + 0
    jal		search_if_apt_exists				# jump to search_if_apt_exists and save position to $ra
    beq		$v0, $zero, ad_auto_error_apt_not_found	# if $v0 == $zero then goto ad_auto_error_apt_not_found    

    # Atualiza o link anterior para excluir o nó da lista ligada
    addi	$t1, $v0, 0			# $t1 = $v0 + 0
    addi	$t2, $v1, 0			# $t2 = $v1 + 0
    lw		$t3, 196($t1)		# 
    sw		$t3, 196($t2)		# 

    # Limpa todo o bloco com null bytes
    addi	$a0, $t1, 0			# $a0 = $t1 + 0
    addi	$a1, $zero, 200			# $a1 = $zero + 200
    jal		fill_with_null_byte				# jump to fill_with_null_byte and save position to $ra

    # Salva o endereço na Stack para usar em na criação de um novo apartamento
    addi	$sp, $sp, -4			# $sp = $sp + -4
    sw		$t1, 0($sp)		# 

    la		$t3, cmd_limpar_ap_successfull_message		# 
    write_shell($t3)
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

# Verifica se o apartamento já está cadastrado no sistema
search_if_apt_exists:
    addi	$t0, $a1, 0			# $t0 = $a1 + 0

search_if_apt_exists_loop_over_ll:
    beq		$t0, $zero, search_if_apt_exists_false	# if $t0 == $zero then goto search_if_apt_exists_false
    
    addi	$sp, $sp, -8			# $sp = $sp + -8
    sw		$ra, 0($sp)		# 
    sw		$t0, 4($sp)		# 
    addi	$a0, $a0, 0			# $a0 = $a0 + 0
    addi	$a1, $t0, 0			# $a1 = $t0 + 0
    jal		check_apt				# jump to check_apt and save position to $ra
    lw		$ra, 0($sp)		# 
    lw		$t0, 4($sp)		# 
    addi	$sp, $sp, 8			# $sp = $sp + 8
    bne		$v0, $zero, search_if_apt_exists_true	# if $v0 != $zero then goto write_current_shell_cmd
    addi	$v1, $t0, 0			# $v1 = $t0 + 0 | Mantém em $v1 o último apartamento antes do que se procura
    jump_to_next_ll($t0)
    j		search_if_apt_exists_loop_over_ll				# jump to search_if_apt_exists_loop_over_ll

search_if_apt_exists_true:
    addi	$v0, $t0, 0			# $v0 = $t0 + 0
    jr		$ra					# jump to $ra

search_if_apt_exists_false:
    addi	$v0, $zero, 0			# $v0 = $zero + 0
    jr		$ra					# jump to $ra

check_apt:
    addi	$t0, $a0, 0			# $t0 = $a0 + 0
    addi	$t1, $a1, 0			# $t1 = $a1 + 0

    # Verifica se o endereço armazenado em $t1 está vazio
    beq		$t1, $zero, check_apt_false	# if $t1 == $zero then goto check_apt_false

    # Verifica o andar
    lb		$t2, 0($t0)		# 
    lb		$t3, 0($t1)		#
    bne		$t2, $t3, check_apt_false	# if $t2 != $t3 then goto check_apt_false

    # Verifica o número do apt
    lb		$t2, 2($t0)		# 
    lb		$t3, 1($t1)		# 
    bne		$t2, $t3, check_apt_false	# if $t2 != $t3 then goto check_apt_false

    # O apartamento está nesse bloco (True):
    addi	$v0, $zero, 1			# $v0 = $zero + 1
    jr		$ra					# jump to $ra
    
check_apt_false:
    addi	$v0, $zero, 0			# $v0 = $zero + 0
    jr		$ra					# jump to $ra

# Função que armazena o nome do morador em um apartamento
store_morador:
    # $a2 => Quantidade de moradores atualizada
    # Cálculo de offset da posição da string onde o nome do morador será inserido
    subi	$t1, $a2, 1			# $t1 = $a2 - 1
    addi	$t2, $zero, 22			# $t2 = $zero + 22
    mul     $t1, $t1, $t2       # $t1 = $t1 * $t2
    addi	$t1, $t1, 8			# $t1 = $t1 + 8
    
    # Copia o valor do registrador de comando para o bloco de memória
    addi	$sp, $sp, -4			# $sp = $sp + -4
    sw		$ra, 0($sp)		# 
    add		$a0, $a0, $t1		# $a0 = $a0 + $t1
    addi	$a1, $t6, 4			# $a1 = $t6 + 4
    jal		strcpy				# jump to strcpy and save position to $ra
    lw		$ra, 0($sp)		# 
    addi	$sp, $sp, 4			# $sp = $sp + 4
    jr		$ra					# jump to $ra

# Função que calcula o tamanho de uma String até um separador
# Porém, caso um \0 aconteça, termina ali
strlen_until_sep:
    addi	$v0, $a0, 0			# $t0 = $a0 + 0
    addi	$a1, $a1, 0			# $a1 = $a1 + 0

strlen_until_sep_loop_over_str:
    lb		$t2, 0($v0)		# 
    beq		$t2, $a1, strlen_until_sep_finish	# if $t2 == $t1 then goto strlen_until_sep_finish
    beq		$t2, $zero, strlen_until_sep_finish	# if $t2 == $zero then goto strlen_until_sep_finish
    addi	$v0, $v0, 1			# $t0 = $t0 + 1
    j strlen_until_sep_loop_over_str

strlen_until_sep_finish:
    sub		$v0, $v0, $a0		# $v0 = $v0 - $a0
    jr		$ra					# jump to $ra

# Armazena o automóvel em algum slot disponível
store_auto:
    addi	$t1, $a0, 0			# $t1 = $a0 + 0 | Carrega as informações do comando digitado
    addi	$t2, $a1, 0			# $t2 = $a1 + 0 | Carrega o bloco da lista ligada
    lb		$t3, 118($t2)		# 
    addi	$t2, $t2, 118			# $t2 = $t2 + 118
    beq		$t3, $zero, store_auto_slot_1	# if $t3 == $zero then goto store_auto_slot_1
    # Cada slot de cada automóvel tem 38 bytes, basicamente estamos pulando 38 bytes para o slot 2
    addi	$t2, $t2, 38			# $t2 = $t2 + 38

store_auto_slot_1:
    # Armazena o tipo
    lb		$t3, 4($t1)		# 
    sb		$t3, 0($t2)		# 

    # Armazena o modelo
    addi	$sp, $sp, -12			# $sp = $sp + -12
    sw		$ra, 0($sp)		# 
    sw		$t1, 4($sp)		# 
    sw		$t2, 8($sp)		# 

    # Obtém o tamanho do nome do modelo
    addi	$a0, $t1, 6			# $a0 = $t6 + 6
    lb		$a1, sep_args		# 
    jal		strlen_until_sep				# jump to strlen_until_sep and save position to $ra
    lw		$t1, 4($sp)		# 
    lw		$t2, 8($sp)		# 

    addi	$a0, $t2, 1			# $a0 = $t2 + 1
    addi	$a1, $t1, 6			# $a1 = $t1 + 6
    addi	$a2, $v0, 0			# $a2 = $v0 + 0
    jal		memcpy				# jump to strcpy and save position to $ra
    lw		$t1, 4($sp)		# 
    lw		$t2, 8($sp)		# 

    # Armazena a cor do automóvel
    addi	$a1, $t1, 7			# $a1 = $t1 + 7
    add		$a1, $a1, $a2		# $a1 = $a1 + $a2

    addi	$a0, $t2, 22			# $a0 = $t2 + 22
    jal		strcpy				# jump to strcpy and save position to $ra

    lw		$ra, 0($sp)		# 
    addi	$sp, $sp, 12			# $sp = $sp + 12

    la		$t1, cmd_ad_auto_sucessfull_message		# 
    write_shell($t1)
    jr		$ra					# jump to $ra

memcpy:
    addi	$t0, $a2, 0			# $t0 = $a2 + 0, atribuição do valor para registrador temporário $t0
    addi	$t1, $a0, 0			# $t1 = $a0 + 0, atribuição do valor para registrador temporário $t1
    addi	$t2, $a1, 0			# $t2 = $a1 + 0, atribuição do valor para registrador temporário $t2

loop_over_num:
    beq		$t0, $zero, finish_memcpy	# se $t0 == $zero então vai para 'finish_memcpy'
    
    lb		$t3, 0($t2)		    # carrega byte por byte da string de $t2 para $t3
    sb		$t3, 0($t1)		    # armazena byte por byte de $t3 para $t1

    addi	$t1, $t1, 1			# $t1 = $t1 + 1, passa para o próximo espaço vazio para armazenar o novo número
    addi	$t2, $t2, 1			# $t1 = $t1 + 1, passa para o próximo número
    subi	$t0, $t0, 1			# $t0 = $t0 - 1
    j loop_over_num             # jump para 'loop_over_num'
    
finish_memcpy:
    sb		$zero, 0($t1)		# armazena byte por byte de $zero para $t1
    addi	$v0, $a0, 0			# $v0 = $a0 + 0, passa o valor de $a0 para $v0 como resultado
    jr		$ra					# jump para $ra

fill_with_null_byte:
    add		$t1, $a0, $a1		# $t1 = $a0 + $a1
    addi	$t2, $a0, 0			# $t2 = $a0 + 0
    
fill_with_null_byte_loop:
    beq		$t1, $t2, fill_with_null_byte_finish	# if $t1 == $t2 then goto fill_with_null_byte_finish
    sb		$zero, 0($t2)		# 
    addi	$t2, $t2, 1			# $t2 = $t2 + 1
    j		fill_with_null_byte_loop				# jump to fill_with_null_byte_loop  

fill_with_null_byte_finish:
    jr		$ra					# jump to $ra
