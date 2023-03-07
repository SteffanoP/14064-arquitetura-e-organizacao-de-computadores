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
    
    # rm_morador data
    cmd_rm_morador: .asciiz "rm_morador"
    cmd_rm_morador_successfull_message: .asciiz "\nMorador removido com sucesso do apartamento.\n"
    cmd_rm_morador_error_not_found: .asciiz "\nO Morador não foi encontrado nesse apartamento.\n"

    # ad_auto data
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

    # rm_auto data
    cmd_rm_auto: .asciiz "rm_auto"
    cmd_rm_auto_successfull_message: .asciiz "\nAutomóvel removido com sucesso!\n"
    cmd_rm_auto_error_auto_not_found: .asciiz "\nNão foi possível encontrar o veículo informado para essa apartamento.\nTente novamente com o nome exato do veículo.\n"

    # limpar_ap data
    cmd_limpar_ap: .asciiz "limpar_ap"
    cmd_limpar_ap_successfull_message: .asciiz "\nO apartamento foi limpado com sucesso!\n"

    # info_ap data
    cmd_info_ap: .asciiz "info_ap"
    cmd_info_ap_error_format: .asciiz "\nFalha, apartamento inválido. O info_ap não foi escrito de maneira correta. Verifique se o comando está no formato info_ap-<option1>.\n"
    cmd_info_ap_apt_is_empty: "\nEste apartamento encontra-se vazio. Não é possível obter informações do apartamento solicitado.\n"
    cmd_info_ap_error_invalid_floor: .asciiz "\nO andar possui um valor inválido. Por favor verifique novamente.\n"
    cmd_info_ap_error_format_2: .asciiz "\nnão está formatado corretamente, verifique se você especificou a <option1>"
    cmd_info_ap_message_ap: .asciiz "\nAP: "
    cmd_info_ap_message_moradores: .asciiz "\nMoradores: \n"
    cmd_info_ap_message_moradores_linha: .asciiz "\n"
    cmd_info_ap_message_carro: .asciiz "\nCarro \nModelo: \n"
    cmd_info_ap_message_moto: .asciiz "\nMoto \nModelo: \n"
    cmd_info_ap_message_cor: .asciiz "\nCor: \n"

    # salvar
    cmd_salvar: .asciiz "salvar"
    cmd_salvar_colunas: .asciiz "Apartamento, Morador 1, Morador 2, Morador 3, Morador 4, Morador 5, Veiculo Tipo 1, Modelo 1, Cor 1, Veiculo Tipo 2, Modelo 2, Cor 2"
    cmd_salvar_sucessfull_message: .asciiz "Dados salvos com sucesso."
    cmd_salvar_file: .asciiz "projeto_teste.csv" # coloque aqui o diretório do arquivo
    .align 2 # dados do arquivo
    cmd_salvar_data: .space 200

    # info_geral data
    cmd_info_geral: .asciiz "info_geral"
    cmd_info_geral_message_nao_vazios: .asciiz "\nNão vazios:\t"
    cmd_info_geral_message_percentage_1: .asciiz " ("
    cmd_info_geral_message_percentage_2: .asciiz "%).\n"
    cmd_info_geral_message_vazios: .asciiz "Vazios:\t\t"

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
        beq		$t1, $zero, end_write	# se $t1 == $zero então vá para finish_write
        sw		$t1, 0($t2)		# 

    wait_display_to_write:
        lb		$t4, 0($t3)		# 
        beq		$t4, $zero, wait_display_to_write	# se $t0 == $zero então vá para wait_display_to_write
        addi	$t0, $t0, 1			# $t0 = $t0 + 1
        j		write_byte				# pular para write_byte
            
    end_write:
.end_macro

.macro wait_new_char
    lw		$t0, receiver_ready		# 
    loop_wait_new_char:
        lb		$t2, 0($t0)		# 
        beq		$t2, $zero, loop_wait_new_char	# se $t2 == $zero então vá para loop_wait_new_char

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
    beq		$t2, $t1, process_command	# se $t0 == $t1 então vá para exit
    lw		$t1, bs		# 
    beq		$t2, $t1, backspace	# se $t2 == $t1 então vá para backspace
    
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    addi	$a1, $s1, 0			# $a1 = $t2 + 0
    
    jal		strcat				# pular para strcat e salvar posição em $ra

    write_shell($s1)
    j		main				# pular para main

backspace:
    la		$t0, ff		# 
    write_shell($t0)
    la		$t0, shell_user		# 
    write_shell($t0)
    
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    jal		strrm1				# pular para strrm1 e salvar posição em $ra
    write_shell($s0)
    j		main				# pular para main

process_command:
    # Command is a ASCII String on Address $s0 and it ends with \0

    # se no command is written, then go back to main
    lb		$t0, 0($s0)		    # 
    beq		$t0, $zero, write_current_shell_cmd	# se $t0 == $zero então vá para write_current_shell_cmd

    # Command ad_morador
    la		$a0, cmd_ad_morador	# 
    addi	$a1, $s0, 0			# $a1 = $s0 + 0
    jal		check_prefix		# pular para check_prefix e salvar posição em $ra
    beq		$v0, $zero, ad_morador	# se $v0 == $zero então vá para ad_morador

    # Comando rm_auto
    la		$a0, cmd_rm_morador	# 
    addi	$a1, $s0, 0			# $a1 = $s0 + 0
    jal		check_prefix		# pular para check_prefix e salvar posição em $ra
    beq		$v0, $zero, rm_morador	# se $v0 == $zero então vá para rm_morador

    # Comando ad_auto
    la		$a0, cmd_ad_auto		# 
    addi	$a1, $s0, 0			# $a1 = $s0 + 0
    jal		check_prefix				# pular para check_prefix e salvar posição em $ra
    beq		$v0, $zero, ad_auto	# se $v0 == $zero então vá para ad_auto

    # Comando rm_auto
    la		$a0, cmd_rm_auto		# 
    addi	$a1, $s0, 0			# $a1 = $s0 + 0
    jal		check_prefix				# pular para check_prefix e salvar posição em $ra
    beq		$v0, $zero, rm_auto	# se $v0 == $zero então vá para rm_auto

    # Comando limpar_ap
    la		$a0, cmd_limpar_ap		# 
    addi	$a1, $s0, 0			# $a1 = $s0 + 0
    jal		check_prefix				# pular para check_prefix e salvar posição em $ra
    beq		$v0, $zero, limpar_ap	# se $v0 == $zero então vá para limpar_ap

    # Comando info_ap
    la      $a0, cmd_info_ap
    addi    $a1, $s0, 0
    jal     check_prefix
    beq     $v0, $zero, info_ap

    # Comando salvar
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    la		$a1, cmd_salvar		# 
    jal		strcmp				# pular para strcmp e salvar posição em $ra
    beq		$v0, $zero, salvar	# se $v0 == $zero então vá para exit

    # Comando info_geral
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    la		$a1, cmd_info_geral		# 
    jal		strcmp				# pular para strcmp e salvar posição em $ra
    beq		$v0, $zero, info_geral	# se $v0 == $zero então vá para info_geral

    # Command help
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    la		$a1, cmd_help		# 
    jal		strcmp				# pular para strcmp e salvar posição em $ra
    beq		$v0, $zero, help	# se $v0 == $zero então vá para exit

    # Command exit
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    la		$a1, cmd_exit		# 
    jal		strcmp				# pular para strcmp e salvar posição em $ra
    beq		$v0, $zero, exit	# se $v0 == $zero então vá para exit

    # se command not found suggest typing help
    la		$t0, cmd_not_found		# 
    write_shell($t0)

write_current_shell_cmd:
    la		$t0, shell_user		# 
    write_shell($t0)
    write_shell($s0)

    j		main				# pular para main

clear_current_shell_cmd:
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    addi	$a1, $zero, 64			# $a1 = $zero + 64
    jal		fill_with_null_byte				# pular para fill_with_null_byte e salvar posição em $ra

    j		write_current_shell_cmd				# pular para write_current_shell_cmd

# Função que adiciona morador ao condomínio
ad_morador:
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    jal		jump_prefix				# pular para jump_prefix e salvar posição em $ra

    # Check format <option1>-<option2>
    lb		$t0, 3($v0)		# 
    lb		$t1, sep_args	#
    bne		$t0, $t1, ad_morador_error_format_1	# se $t0 != $t1 então vá para ad_morador_error_format

    # Check format X0Z from apartment's number
    lb		$t0, 1($v0)		# Load char on the position whereas should be the separator from X and Z
    lb		$t1, sep_apt_number		# Load separator of floor (X) and apartaments (Z) => ("0")
    bne		$t0, $t1, ad_morador_error_format_2	# se $t0 != $t1 então vá para ad_morador_error_format_2

    # Check se floor is valid ([0,9])
    lb		$t0, 0($v0)		# Load char on the position whereas should be the floor
    subi	$t0, $t0, 48			# $t0 = $t0 - 48 => Convert char into dec
    slti	$t0, $t0, 10			# $t0 = ($t0 < 10) ? 1 : 0 => Check se less than 10
    beq		$t0, $zero, ad_morador_error_invalid_floor	# se $t0 == $zero então vá para ad_morador_error_invalid_floor

    # Check se Apartament Number is valid
    lb		$t0, 2($v0)		# Load char on the position whereas should be the apartment number
    subi	$t0, $t0, 48			# $t0 = $t0 - 48 => Convert char into dec
    slti	$t1, $t0, 5			# $t1 = ($t0 < 5) ? 1 : 0 => Check se less than 5
    beq		$t1, $zero, ad_morador_error_invalid_apartment	# se $t1 == $zero então vá para ad_morador_error_invalid_apartment
    # Check se is not zero
    beq		$t0, $zero, ad_morador_error_invalid_apartment	# se $t0 == $zero então vá para ad_morador_error_invalid_apartment
    
    # Check size of the string from morador name's
    addi	$t6, $v0, 0			# $t6 = $v0 + 0 | Move $v0 into $t6, because $t6 is the last temporary to be assumed as temp
    addi	$a0, $t6, 4			# $a0 = $t6 + 4 | Move $t6 into $a0.
    jal		strlen				# pular para strlen e salvar posição em $ra
    slti	$t0, $v0, 21			# $t0 = ($v0 < 21) ? 1 : 0 | Check se size is less or equals the limit of 20 characters
    beq		$t0, $zero, ad_morador_error_invalid_name_size	# se $t0 == $zero então vá para ad_morador_error_invalid_name_size

    # Verifica se o apartamento já existe
    addi	$a0, $t6, 0			# $a0 = $t6 + 0
    addi	$a1, $s2, 0			# $a1 = $s2 + 0
    jal		search_if_apt_exists				# pular para search_if_apt_exists e salvar posição em $ra
    bne		$v0, $zero, ad_morador_into_existing_apt	# se $v0 != $zero então vá para ad_morador_into_existing_apt

    # Antes de alocar um novo bloco de memória, verifica se há endereços disponíveis na stack
    lw		$t0, 0($sp)		# 
    beq		$t0, $zero, ad_morador_allocate_memory	# se $t0 == $zero então vá para ad_morador_allocate_memory
    addi	$sp, $sp, 4			# $sp = $sp + 4
    j		ad_morador_store_object_in_ll				# pular para ad_morador_store_object_in_ll

    ad_morador_allocate_memory:
    # A partir daqui aloca um novo bloco de memória para o apartamento
    # Allocate necessary space to store object
    # Allocate 200 of bytes in memory
    addi	$a0, $0, 200		# 200 bytes to be allocated
    addi	$v0, $0, 9		# system call #9 - allocate memory
    syscall					# execute
    addi	$t0, $v0, 0			# $t0 = $v0 + 0
    
    ad_morador_store_object_in_ll:
    # Store object in linked list    
    addi	$t1, $s2, 0			# $t1 = $s2 + 0
    bne		$s2, $zero, ad_morador_check_where_to_store	# se $s2 != $zero então vá para ad_morador_check_where_to_store
    addi	$s2, $t0, 0			# $s2 = $t0 + 0
    addi	$t1, $s2, 0			# $t1 = $s2 + 0

ad_morador_check_where_to_store:
    # Verifies where in the linked list is available to store data
    # It goes from the address stored in $s2 and tries to 
    lb		$t2, 1($t1)		#
    beq		$t2, $zero, ad_morador_store_morador	# se $t2 == $zero então vá para ad_morador_store_morador
    lw		$t2, 196($t1)		# 
    beq		$t2, $zero, ad_morador_jump_to_next_block	# se $t2 == $zero então vá para ad_morador_jump_to_next_block
    addi	$t1, $t2, 0			# $t1 = $t2 + 0
    j		ad_morador_check_where_to_store				# pular para ad_morador_check_where_to_store

ad_morador_jump_to_next_block:
    # In case the current block is already fullfilled, pular para the next block
    sw		$t0, 196($t1)		# 
    addi	$t1, $t0, 0			# $t1 = $t0 + 0
    j		ad_morador_check_where_to_store				# pular para ad_morador_check_where_to_store

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
    jal		store_morador				# pular para store_morador e salvar posição em $ra

    # Storing is successfull, than shall return success message and clear command
    la		$t0, nl		# 
    write_shell($t0) # Print of \n
    la		$t0, cmd_ad_morador_sucessfull_message		# Load Address of sucessfull message
    write_shell($t0) # Print Sucessfull message
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

ad_morador_into_existing_apt:
    addi	$t0, $v0, 0			# $t0 = $v0 + 0
    
    # Verifica se o apartamento está cheio
    lw		$t1, 4($t0)		#
    addi	$t2, $t1, 0			# $t2 = $t1 + 0
    slti	$t2, $t2, 5			# $t2 = ($t2 < 5) ? 1 : 0
    beq		$t2, $zero, ad_morador_error_apt_is_full	# se $t2 == $zero então vá para ad_morador_error_apt_is_full

    # Adiciona +1 a quantidade de moradores no apartamento
    addi	$t1, $t1, 1			# $t1 = $t1 + 1
    sw		$t1, 4($t0)		# 
    
    # Armazena o nome do morador no slot disponível
    addi	$a0, $t0, 0			# $a0 = $t0 + 0
    addi	$a1, $t6, 0			# $a1 = $t6 + 0
    addi	$a2, $t1, 0			# $a2 = $t1 + 0
    jal		store_morador				# pular para store_morador e salvar posição em $ra
    
    write_shell($s2)
    # Storing is successfull, than shall return success message and clear command
    la		$t0, nl		# 
    write_shell($t0) # Print of \n
    la		$t0, cmd_ad_morador_sucessfull_message		# Load Address of sucessfull message
    write_shell($t0) # Print Sucessfull message
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

ad_morador_error_format_1:
    print_error(cmd_ad_morador_error_format_1)
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

ad_morador_error_format_2:
    print_error(cmd_ad_morador_error_format_2)
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

ad_morador_error_invalid_floor:
    print_error(cmd_ad_morador_error_invalid_floor)
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

ad_morador_error_invalid_apartment:
    print_error(cmd_ad_morador_error_invalid_apartament)
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

ad_morador_error_invalid_name_size:
    print_error(cmd_ad_morador_error_invalid_name_size)
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

ad_morador_error_apt_is_full:
    print_error(cmd_ad_morador_error_apt_is_full)
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

# Função que adiciona um automóvel a um apartamento a partir das especificações no formato:
# ad_auto-<option1>-<option2>-<option3>-<option4>,
# onde option1 é o apartamento no formato XYZ (X = andar, Y = 0, Z = [1,4]),
# option2 é o tipo do automóvel ("m" para moto ou "c" para carro),
# option3 é o modelo e
# option4 a cor.
# As condições para essa operação acontecer com sucesso são:
# O apartamento existir e
# serem adicionadas duas motos ou apenas um carro.
# Possíveis falhas são:
# Formato inválido,
# apartamento inválido e
# tipo não existente.
ad_auto:
    # Pula e Armazena a entrada para ad_auto
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    jal		jump_prefix				# pular para jump_prefix e salvar posição em $ra
    addi	$t6, $v0, 0			# $t0 = $v0 + 0

    # 303-c-Fiat Uno-Verde
    
    # Verifica formatação do comando ad_auto-<option1>-<option2>-<option3>
    lb		$t1, 3($t6)		# 
    lb		$t2, sep_args	#
    bne		$t1, $t2, ad_auto_error_format_1	# se $t1 != $t2 então vá para ad_auto_error_format
    lb		$t1, 5($t6)		# 
    bne		$t1, $t2, ad_auto_error_format_1	# se $t0 != $t1 então vá para ad_auto_error_format
    
    # Verifica formatação entre <option3>-<option4>
    addi	$a0, $t6, 6			# $a0 = $t6 + 6
    lb		$a1, sep_args		# 
    jal		strlen_until_sep				# pular para strlen_until_sep e salvar posição em $ra
    beq		$v0, $zero, ad_auto_error_format_1	# se $v0 == $zero então vá para ad_auto_error_format_1
    addi	$t1, $v0, 6			# $t1 = $v0 + 6
    add		$t1, $t1, $t6		# $t1 = $t1 + $t6
    lb		$t3, 0($t1)		# 
    lb		$t2, sep_args		# 
    bne		$t3, $t2, ad_auto_error_format_1	# se $t3 != $t2 então vá para ad_auto_error_format_1
    addi	$t1, $t1, 1			# $t1 = $t1 + 1
    lb		$t3, 0($t1)		# 
    beq		$t3, $zero, ad_auto_error_format_1	# se $t3 == $zero então vá para ad_auto_error_format_1

    # Verifica se o tipo do automóvel é válido
    lb		$t1, cmd_ad_auto_type_moto		# 
    lb		$t2, 4($t6)		# 
    beq		$t1, $t2, ad_auto_type_valid	# se $t1 == $t2 então vá para ad_auto_type_valid
    lb		$t1, cmd_ad_auto_type_carro		# 
    beq		$t1, $t2, ad_auto_type_valid	# se $t1 == $t2 então vá para ad_auto_type_valid
    j		ad_auto_error_invalid_auto_type				# pular para ad_auto_error_invalid_auto_type
    ad_auto_type_valid:
    
    # Verifica o tamanho das Strings de Modelo e Cor do automóvel
    addi	$a0, $t6, 6			# $a0 = $t6 + 6
    lb		$a1, sep_args		# 
    jal		strlen_until_sep				# pular para strlen_until_sep e salvar posição em $ra
    slti	$t1, $v0, 21			# $t1 = ($v0 < 21) ? 1 : 0
    beq		$t1, $zero, ad_auto_error_invalid_modelo_size	# se $t1 == $zero então vá para ad_auto_error_invalid_modelo_size
    addi	$a0, $v0, 7			# $a0 = $v0 + 6
    add		$a0, $a0, $t6		# $a0 = $a0 + $t6
    jal		strlen				# pular para strlen e salvar posição em $ra
    slti	$t1, $v0, 15			# $t1 = ($v0 < 15) ? 1 : 0
    beq		$t1, $zero, ad_auto_error_invalid_cor_size	# se $t1 == $zero então vá para ad_auto_error_invalid_cor_size

    # Verifica se o apartamento está cadastrado no condomínio
    addi	$a0, $t6, 0			# $a0 = $t6 + 0
    addi	$a1, $s2, 0			# $a1 = $s2 + 0
    jal		search_if_apt_exists				# pular para search_if_apt_exists e salvar posição em $ra
    beq		$v0, $zero, ad_auto_error_apt_not_found	# se $v0 == $zero então vá para ad_auto_error_apt_not_found

    #Verifica se há espaço para veículos no apartamento
    lb		$t1, 4($t6)		# 
    lb		$t2, cmd_ad_auto_type_carro		# 
    beq		$t1, $t2, ad_auto_check_size_for_carros	# se $t1 == $t2 então vá para ad_auto_check_size_for_carros
    
    # Verifica para adicionar moto no condomínio
    lb		$t2, 118($v0)		# 
    lb		$t3, 156($v0)		# 
    lb		$t4, cmd_ad_auto_type_carro		# 
    beq		$t2, $t4, ad_auto_error_not_enough_size	# se $t2 == $t4 então vá para ad_auto_error_not_enough_size
    beq		$t3, $t4, ad_auto_error_not_enough_size	# se $t3 == $t4 então vá para ad_auto_error_not_enough_size
    and		$t2, $t2, $t3		# $t2 = $t2 & $t3
    beq		$t1, $t2, ad_auto_error_not_enough_size	# se $t1 == $t2 então vá para ad_auto_error_not_enough_size
    j		ad_auto_has_enough_space				# pular para ad_auto_has_enough_space
    
    # Verifica para adicionar carro no condomínio
    ad_auto_check_size_for_carros:
    lb		$t2, 118($v0)		# 
    bne		$t2, $zero, ad_auto_error_not_enough_size	# se $t2 != $zero então vá para função alvo
    lb		$t2, 156($v0)		# 
    bne		$t2, $zero, ad_auto_error_not_enough_size	# se $t2 != $zero então vá para ad_auto_error_not_enough_size
    
    ad_auto_has_enough_space:

    addi	$a0, $t6, 0			# $a0 = $t6 + 0
    addi	$a1, $v0, 0			# $a1 = $v0 + 0
    jal		store_auto				# pular para store_auto e salvar posição em $ra

    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

# Mensagem de erro de formato 1: verificar se <option1>-<option2>-<option3> está especificada corretamente.
ad_auto_error_format_1:
    print_error(cmd_ad_auto_error_format_1)
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

# Mensagem de erro de tipo: tipo inválido.
ad_auto_error_invalid_auto_type:
    print_error(cmd_ad_auto_error_invalid_type_auto)
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

# Mensagem de erro de tamanho do modelo: tamanho da especificação do modelo excedido.
ad_auto_error_invalid_modelo_size:
    print_error(cmd_ad_auto_error_invalid_modelo_size)
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

# Mensagem de erro de tamanho da cor: tamanho da especificação da cor excedido.
ad_auto_error_invalid_cor_size:
    print_error(cmd_ad_auto_error_invalid_cor_size)
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

# Mensagem de erro de apartamento inválido: apartamento não encontrado.
ad_auto_error_apt_not_found:
    print_error(cmd_ad_auto_error_apt_not_found)
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

# Mensagem de erro de espaço: não é possível cadastrar mais um automóvel.
ad_auto_error_not_enough_size:
    print_error(cmd_ad_auto_error_not_enough_size)
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

# Função que remove um morador de um apartamento a partir das especificações no formato:
# rm_morador-<option1>-<option2>,
# onde option1 é o apartamento no formato XYZ (X = andar, Y = 0, Z = [1,4]),
# option2 é o nome do morador.
# As condições para essa operação acontecer com sucesso são:
# O apartamento e o morador existirem.
# Possíveis falhas são:
# Formato inválido,
# apartamento inválido e
# morador não encontrado.
rm_morador:
    # Pula e armazena a entrada para rm_auto
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    jal		jump_prefix			# pular para jump_prefix e salvar posição em $ra
    addi	$t6, $v0, 0			# $t0 = $v0 + 0

    # Check format <option1>-<option2>
    lb		$t0, 3($v0)		# 
    lb		$t1, sep_args	#
    bne		$t0, $t1, ad_morador_error_format_1	# se $t0 != $t1 então vá para ad_morador_error_format

    # Verifica se o apartamento está cadastrado no condomínio
    addi	$a0, $t6, 0			# $a0 = $t6 + 0 | 303-XXXXXXXX
    addi	$a1, $s2, 0			# $a1 = $s2 + 0
    jal		search_if_apt_exists				# pular para search_if_apt_exists e salvar posição em $ra
    beq		$v0, $zero, ad_auto_error_apt_not_found	# se $v0 == $zero então vá para ad_auto_error_apt_not_found
    # Se cadastrado vamos armazenar o endereço do bloco da lista ligada em $t7
    addi	$t7, $v0, 0			# $t1 = $v0 + 0

    # Pula o número do apartamento para o nome do morador
    addi	$a0, $t6, 0			# $a0 = $t6 + 0
    jal		jump_prefix			# pular para jump_prefix e salvar posição em $ra
    addi	$t6, $v0, 0			# $t0 = $v0 + 0

    # Verifica se só há 1 morador
    lw		$t1, 0($s1)		# 
    subi	$t1, $t1, 1			# $t1 = $t1 - 1
    bne		$t1, $zero, rm_morador_mais_de_um_morador	# se $t1 != $zero então vá para rm_morador_mais_de_um_morador
    # Verifica se é o primeiro e único morador
    addi	$a0, $t6, 0			# $a0 = $t6 + 0
    addi	$a1, $t7, 8			# $a1 = $t7 + 0
    jal		strcmp				# pular para strcmp e salvar posição em $ra
    beq		$v0, $zero, limpar_ap	# se $v0 == $zero então vá para função alvo
    
    rm_morador_mais_de_um_morador:

    # Verifica se é o último morador
    addi	$a0, $t6, 0			# $a0 = $t6 + 0
    addi	$a1, $t7, 96			# $a1 = $t7 + 96
    jal		strcmp				# pular para strcmp e salvar posição em $ra
    beq		$v0, $zero, rm_morador_removes_last_morador	# se $v0 == $zero então vá para rm_morador_removes_last_morador

    # Pesquisa pelo morador
    addi	$a0, $t6, 0			# $a0 = $t6 + 0
    addi	$a1, $t7, 0			# $a1 = $t7 + 0
    jal		search_morador_in_apt				# pular para search_morador_in_apt e salvar posição em $ra
    beq		$v0, $zero, rm_morador_error_not_found	# se $v0 == $zero então vá para rm_morador_error_not_found

    # Remove o morador encontrado
    # Faz a equação (último morador) = (quantidade de moradores * tamanho morador) + posição inicial de moradores
    lw		$t0, 4($t7)		#
    subi	$t0, $t0, 1			# $t0 = $t0 - 1
    addi	$t1, $zero, 22			# $t1 = $zero + 22
    mul     $t0, $t0, $t1
    addi	$t0, $t0, 8			# $t0 = $t0 + 8
    # Prepara a função delete_morador
    addi	$a0, $v0, 0			# $a0 = $v0 + 0
    add		$a1, $t7, $t0		# $a1 = $t7 + $t0
    jal		delete_morador				# pular para delete_morador e salvar posição em $ra

    # Subtrai a quantidade total de moradores
    lw		$t0, 4($t7)		# 
    subi	$t0, $t0, 1			# $t0 = $t0 - 1
    sw		$t0, 4($t7)		# 

    # Faz o print de morador removido com sucesso
    la		$t0, cmd_rm_morador_successfull_message		# 
    write_shell($t0)

    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

# Mensagem de erro de último morador removido: apartamento vazio.
rm_morador_removes_last_morador:
    addi	$a0, $t7, 96			# $a0 = $t7 + 96
    addi	$a1, $zero, 21			# $a1 = $zero + 21
    jal		fill_with_null_byte				# pular para fill_with_null_byte e salvar posição em $ra
    
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

# Mensagem de erro de último morador não existente no apartamento: morador não encontrado.
rm_morador_error_not_found:
    print_error(cmd_rm_morador_error_not_found)
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

# Remove um automóvel de um apartamento
rm_auto:
    # Pula e armazena a entrada para rm_auto
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    jal		jump_prefix			# pular para jump_prefix e salvar posição em $ra
    addi	$s4, $v0, 0			# $t0 = $v0 + 0

    # Verifica se o apartamento está cadastrado no condomínio
    addi	$a0, $s4, 0			# $a0 = $s4 + 0 | 303-XXXXXXXX
    addi	$a1, $s2, 0			# $a1 = $s2 + 0
    jal		search_if_apt_exists				# pular para search_if_apt_exists e salvar posição em $ra
    beq		$v0, $zero, ad_auto_error_apt_not_found	# se $v0 == $zero então vá para ad_auto_error_apt_not_found
    # Se cadastrado vamos armazenar o endereço do bloco da lista ligada em $t7
    addi	$t7, $v0, 0			# $t1 = $v0 + 0

    # TODO: Verificar se entrada tem os prefixos corretos
    # Pula o número do apartamento para o tipo do veículo
    addi	$a0, $s4, 0			# $a0 = $s4 + 0
    jal		jump_prefix			# pular para jump_prefix e salvar posição em $ra
    addi	$s4, $v0, 0			# $s4 = $v0 + 0
    # Pula o tipo do veículo para o nome do veículo
    addi	$a0, $s4, 0			# $a0 = $t6 + 0
    jal		jump_prefix			# pular para jump_prefix e salvar posição em $ra
    addi	$t6, $v0, 0			# $t6 = $v0 + 0
    #Pula do nome do veículo para a cor
    addi	$a0, $t6, 0			# $a0 = $t6 + 0
    jal		jump_prefix				# pular para jump_prefix e salvar posição em $ra
    addi	$s5, $v0, 0			# $s5 = $v0 + 0

    # Verifica se deseja remover o primeiro veículo
    # Verifica se é do mesmo tipo
    lb		$t0, 0($s4)		# 
    lb		$t1, 118($t7)		# 
    bne		$t0, $t1, rm_auto_1st_auto_wrong_color	# se $t0 != $t7 então vá para rm_auto_1st_auto_wrong_color
    # Verifica a cor do veículo
    addi	$a0, $t7, 140			# $a0 = $t7 + 140
    addi	$a1, $s5, 0			# $a1 = $s5 + 0
    jal		strcmp				# pular para strcmp e salvar posição em $ra
    bne		$v0, $zero, rm_auto_1st_auto_wrong_color	# se $v0 != $zero então vá para rm_auto_1st_auto_wrong_color
    # Verifica se é o modelo do carro
    addi	$a0, $t6, 0			# $a0 = $t6 + 0
    lb		$a1, sep_args		# 
    jal		strlen_until_sep				# pular para strlen_until_sep e salvar posição em $ra
    addi	$a3, $v0, 0			# $a2 = $v0 + 0    
    addi	$a0, $t7, 119		# $t7 = $t7 + 119
    addi	$a1, $t6, 0			# $a1 = $t6 + 0
    jal		strncmp				# pular para strncmp e salvar posição em $ra
    beq		$v0, $zero, rm_auto_delete_auto	# se $v0 == $zero então vá para rm_auto_delete_auto

    rm_auto_1st_auto_wrong_color:

    # Verifica se deseja remover o segundo veículo
    # Verifica se é do mesmo tipo
    lb		$t0, 0($s4)		# 
    lb		$t1, 156($t7)		# 
    bne		$t0, $t1, rm_auto_error_auto_not_found	# se $t0 != $t7 então vá para rm_auto_1st_auto_wrong_color
    # Verifica primeiro a cor do veículo
    addi	$a0, $t7, 178			# $a0 = $t7 + 178
    addi	$a1, $s5, 0			# $a1 = $s5 + 0
    jal		strcmp				# pular para strcmp e salvar posição em $ra
    bne		$v0, $zero, rm_auto_error_auto_not_found	# se $v0 != $zero então vá para rm_auto_error_auto_not_found
    # Verifica se é o modelo do carro
    addi	$a0, $t6, 0			# $a0 = $t6 + 0
    lb		$a1, sep_args		# 
    jal		strlen_until_sep				# pular para strlen_until_sep e salvar posição em $ra
    addi	$a3, $v0, 0			# $a2 = $v0 + 0  
    addi	$a0, $t7, 157		# $t7 = $t7 + 119
    addi	$a1, $t6, 0			# $a1 = $t6 + 0
    jal		strncmp				# pular para strncmp e salvar posição em $ra
    beq		$v0, $zero, rm_auto_delete_auto	# se $v0 == $zero então vá para rm_auto_delete_auto

    j		rm_auto_error_auto_not_found				# pular para rm_auto_error_auto_not_found

rm_auto_delete_auto:
    subi	$a0, $a0, 1			# $t1 = $a0 - 1
    addi	$a1, $zero, 38			# $a1 = $zero + 38
    jal		fill_with_null_byte				# pular para fill_with_null_byte e salvar posição em $ra 
    
    la		$t0, cmd_rm_auto_successfull_message		# 
    write_shell($t0)
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

rm_auto_error_auto_not_found:
    print_error(cmd_rm_auto_error_auto_not_found)
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

# Função que limpa o apartamento a partir das especificações no formato:
# limpar_ap-<option1>,
# onde option1 é o apartamento no formato XYZ (X = andar, Y = 0, Z = [1,4]).
# As condições para essa operação acontecer com sucesso são:
# O apartamento existir.
# Possíveis falhas são:
# Formato inválido e
# apartamento inválido.
limpar_ap:
    # Pula e Armazena a entrada para limpar_ap
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    jal		jump_prefix				# pular para jump_prefix e salvar posição em $ra
    addi	$t6, $v0, 0			# $t0 = $v0 + 0

    # Verifica se o apartamento está cadastrado no condomínio
    addi	$a0, $t6, 0			# $a0 = $t6 + 0
    addi	$a1, $s2, 0			# $a1 = $s2 + 0
    jal		search_if_apt_exists				# pular para search_if_apt_exists e salvar posição em $ra
    beq		$v0, $zero, ad_auto_error_apt_not_found	# se $v0 == $zero então vá para ad_auto_error_apt_not_found    

    # Atualiza o link anterior para excluir o nó da lista ligada
    addi	$t1, $v0, 0			# $t1 = $v0 + 0
    addi	$t2, $v1, 0			# $t2 = $v1 + 0
    # Caso esteja na cabeça do link, trata diretamente com o registrador $s2
    lw		$t3, 196($t1)		# 
    bne		$t2, $zero, limpar_ap_not_in_s2	# se $t2 != $zero então vá para limpar_ap_not_in_s2 | 
    addi	$s2, $t3, 0			# $s2 = $t3 + 0
    j		limpar_ap_in_s2_continue				# pular para limpar_ap_in_s2_continue

    limpar_ap_not_in_s2:
    sw		$t3, 196($t2)		# 

    limpar_ap_in_s2_continue:

    # Limpa todo o bloco com null bytes
    addi	$a0, $t1, 0			# $a0 = $t1 + 0
    addi	$a1, $zero, 200			# $a1 = $zero + 200
    jal		fill_with_null_byte				# pular para fill_with_null_byte e salvar posição em $ra

    # Salva o endereço na Stack para usar em na criação de um novo apartamento
    addi	$sp, $sp, -4			# $sp = $sp + -4
    sw		$a0, 0($sp)		# 

    la		$t3, cmd_limpar_ap_successfull_message		# 
    write_shell($t3)
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd


# Função que mostra a informação do apartamento
info_ap:
    # Pula e Armazena a entrada para info_ap
    addi	$a0, $s0, 0			# $a0 = $s0 + 0
    jal		jump_prefix				# pular para jump_prefix e salvar posição em $ra
    addi	$t6, $v0, 0			# $t0 = $v0 + 0
    addi	$s7, $s2, 0			# $t0 = $v0 + 0

    # Verifica o formato X0Z do número do apartamento
    lb		$t0, 1($v0)		# Carrega um char na posição onde deveria estar o separador de X e Z
    lb		$t1, sep_apt_number		# Carrega o separador do andar (X) e apartamentos (Z), que é o '0'
    bne		$t0, $t1, info_ap_error_format	# se $t0 != $t1 vá para info_ap_error_format
    
    # Verifica se o andar é válido ([0,9])
    lb		$t0, 0($v0)		# Carrega um char na posição onde deveria ser o andar
    subi	$t0, $t0, 48			# $t0 = $t0 - 48 => Converter de char para decimal
    slti	$t0, $t0, 10			# $t0 = ($t0 < 10) ? 1 : 0 => Verifica se é menor que 10
    beq		$t0, $zero, info_ap_error_invalid_floor	# se $t0 == $zero vá para info_ap_error_invalid_floor

    # Check format -<option1>  OBS: Não possui um limite para os apartamentos [1:4]. Verificar como fazer.
    lb		$t0, 3($v0)		# carrega o endereço 3 de v0 em t0 byte por byte
    lb		$t1, sep_args	# carrega a função sep_args em t1 byte por byte
    beq		$t0, $t1, info_ap_error_format_2 # se t1 == t0, vá para info_ap_error_format_2

    # Verifica se o apartamento está cadastrado no condomínio
    addi    $a0, $v0, 0                         # a0 = v0 + 0
    addi    $a1, $s2, 0                         # a1 = s2 + 0
    jal     search_if_apt_exists                # faz um jal para verificar se o apartamento existe e retorna endereço do bloco do ap em $v0
    beq     $v0, $zero, info_ap_apt_is_empty    # se v0 == zero, vá para info_ap_apt_is_empty

escrever_moradores:
     # Pegando as informações de um apartamento específico e imprimindo no shell 
    la      $t0, cmd_info_ap_message_ap
    write_shell($t0)
    la      $a0, 0($v0) #
    write_shell($t0)
    la      $v0, 1($v0)
    write_shell($t0)

    la      $t0, cmd_info_ap_message_moradores
    write_shell($t0)
    # Moradores {
    la      $t0, 7($v0)     # primeiro morador (tem que ter pelo menos um morador no apartamento)
    write_shell($t0)
    la		$t0, nl		# 
    write_shell($t0) # Print of \n

    
    # morador 2 (se existir)
    la      $t0, 29($v0)    # verifica se existe um segundo morador
    beq     $t0, $zero, jump_to_auto
    write_shell($t0)
    la		$t0, nl		# 
    write_shell($t0) # Print of \n

    # morador 3 (se existir)
    la      $t0, 51($v0)    # verifica se existe um segundo morador
    beq     $t0, $zero, jump_to_auto
    write_shell($t0)
    la		$t0, nl		# 
    write_shell($t0) # Print of \n

    # morador 4 (se existir)
    la      $t0, 73($v0)    # verifica se existe um segundo morador
    beq     $t0, $zero, jump_to_auto
    write_shell($t0)
    la		$t0, nl		# 
    write_shell($t0) # Print of \n

    # morador 5 (se existir)
    la      $t0, 95($v0)    # verifica se existe um segundo morador
    beq     $t0, $zero, jump_to_auto
    write_shell($t0)
    j       jump_to_auto
     # }


jump_to_auto:
    lb		$t1, cmd_ad_auto_type_carro		# 
    lb		$t2, 117($v0)		# 
    beq		$t1, $t2, imprime_carro	# se $t1 == $t2 então vá para imprime_carro
    lb      $t1, cmd_ad_auto_type_moto
    beq     $t1, $t2, imprime_moto
    j       clear_current_shell_cmd

imprime_carro:
    la      $t0, cmd_info_ap_message_carro
    write_shell($t0)
    la      $t0, 118($v0)
    write_shell($t0)
    la      $t0, cmd_info_ap_message_cor
    write_shell($t0)
    la      $t0, 139($v0)
    write_shell($t0)
    j       clear_current_shell_cmd

imprime_moto:
    la      $t0, cmd_info_ap_message_moto
    write_shell($t0)
    la      $t0, 118($v0)
    write_shell($t0)
    la      $t0, cmd_info_ap_message_cor
    write_shell($t0)
    la      $t0, 139($v0)
    write_shell($t0)
    
    lb      $t0, 155($v0)
    bne     $t0, $zero, imprime_moto_2
    j       clear_current_shell_cmd

imprime_moto_2:
    la      $t0, cmd_info_ap_message_moto
    write_shell($t0)
    la      $t0, 156($v0)
    write_shell($t0)
    la      $t0, cmd_info_ap_message_cor
    write_shell($t0)
    la      $t0, 177($v0)
    write_shell($t0)
    j       clear_current_shell_cmd

info_ap_apt_is_empty:
    print_error(cmd_info_ap_apt_is_empty)
    j       clear_current_shell_cmd         # pular para write_current_shell_cmd #mudar para clear_current_shell

info_ap_error_format:
    print_error(cmd_info_ap_error_format)
    j       clear_current_shell_cmd         # pular para write_current_shell_cmd

info_ap_error_format_2:
    print_error(cmd_info_ap_error_format_2)
    j       clear_current_shell_cmd

info_ap_error_invalid_floor:
    print_error(cmd_info_ap_error_invalid_floor)
    j		clear_current_shell_cmd				# pular para write_current_shell_cmd


info_geral:
    
    la		$t0, cmd_info_geral_message_nao_vazios		# 
    write_shell($t0)

    # Allocate 32 of bytes in memory
    addi	$a0, $0, 32		# 32 bytes to be allocated
    addi	$v0, $0, 9		# system call #9 - allocate memory
    syscall					# execute
    addi	$s1, $v0, 0			# $s1 = $v0 + 0

    # Calcula a quantidade de nós na ll
    addi	$a0, $s2, 0			# $a0 = $s2 + 0
    jal		calculate_links_on_ll				# pular para calculate_links_on_ll e salvar posição em $ra
    addi	$s3, $v0, 0			# $a0 = $v0 + 0

    # Converte o inteiro em string
    addi	$a0, $s3, 0			# $a0 = $s3 + 0
    addi	$a1, $s1, 0			# $a1 = $s1 + 0 
    jal		int2str				# pular para int2str e salvar posição em $ra
    write_shell($s1)

    la		$t0, cmd_info_geral_message_percentage_1		# 
    write_shell($t0)

    # Calcula as porcentagens
    addi	$a0, $s3, 0			# $a0 = $s3 + 0
    jal		calculate_info_geral_percentage				# pular para calculate_info_geral_percentage e salvar posição em $ra

    # Converte o inteiro em string
    addi	$a0, $v0, 0			# $a0 = $v0 + 0
    addi	$a1, $s1, 0			# $a1 = $s1 + 0 
    jal		int2str				# pular para int2str e salvar posição em $ra
    write_shell($s1)

    la		$t0, cmd_info_geral_message_percentage_2		# 
    write_shell($t0)
    
    la		$t0, cmd_info_geral_message_vazios		# 
    write_shell($t0)

    # Converte o inteiro em string
    addi	$t0, $zero, 40			# $t0 = $zero + 40
    sub		$a0, $t0, $s3		# $a0 = $t0 - $s3
    addi	$a1, $s1, 0			# $a1 = $s1 + 0
    jal		int2str				# pular para int2str e salvar posição em $ra
    write_shell($s1)

    la		$t0, cmd_info_geral_message_percentage_1		# 
    write_shell($t0)

    addi	$a0, $v1, 0			# $a0 = $v1 + 0
    addi	$a1, $s1, 0			# $a1 = $s1 + 0 
    jal		int2str				# pular para int2str e salvar posição em $ra
    write_shell($s1)

    la		$t0, cmd_info_geral_message_percentage_2		# 
    write_shell($t0)
    
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

salvar:
    addi	$a0, $0, 1000		# 1000 bytes para serem alocados
    addi	$v0, $0, 9		# comando sycall 9 para alocar memória
    syscall					# execução do syscall
    addi	$s4, $v0, 0			# $s4 = $v0 + 0, salvando o resultado da alocação em $s4

	li $v0, 13 # comando sycall 13 para abrir um arquivo
	la $a0, cmd_salvar_file # carregando o endereço do caminhos do arquivo em $a0
	la $a1, 1 # seta permisão de escrita no arquivo em $a1
	syscall # execução do syscall
	addi $s3, $v0, 0 # $s3 = $v0 + 0, salvando o resultado da abertura em $s4

	la $a3, cmd_salvar_colunas # carrega o endereço das colunas que existirão no arquivo em $a3
	la $t0, ($s2) # carrega o endereço da linked list
	la $t1, ($a3) # carrega o endereço da string que contém as colunas do arquivo
    la $t2, ($s4) # carrega o endereço da alocação de memória na heap
    li $t3, 0 # flag indicando se o número do apartamento já foi lido
	li $t4, 0 # flag indicando se o nome do morador já foi lido
    li $t5, 0 # flag para finalizar a leitura
    li $s1, 0 # flag para não haver um novo carregamento dos nomes das colunas quando o cmd_salvar for chamado novamente
    addi $s1, $s1, 1 # incrementa o $s1 para novas chamadas do cmd_salvar

# Função que realiza a leitura da string referente às colunas do arquivo
loop_over_string_columns:
    bne $s1, 1, write_newline
   
	lb $t6, 0($t1) # carrega byte a byte da string em $t6
	beq $t6, $zero, write_newline # se $t6 == 0 então vai para 'write_newline', ou seja, as colunas já foram lidas
	sb $t6, ($t2) # armazena byte a byte da string em $t2 (heap)
	addi $t1, $t1, 1 # avança um caractere da string
	addi $t2, $t2, 1 # avança uma coluna na heap
	
	j loop_over_string_columns # realiza o jump para 'loop_over_string_columns'

# Função que verifica as flags para designas as próximas funções
while_loop:
    beq $t3, $zero, read_morador_apt # se $t3 == 0, então vai para 'read_morador_apt'
    beq $t4, $zero, read_morador_name # se $t4 == 0, então vai para 'read_morador_name'
    beq $t9, $zero, read_morador_auto_type # se $t9 == 0, então vai para 'read_morador_auto_type'
    beq $t5, $zero, write_newline # se $t5 == 0, então vai para 'write_newline'

    j write_file # realiza o jump para 'write_file', pois todos os dados já foram lidos

# Função que vai ler e salvar na heap os números do andar e do apartamento do(a) morador(a)
read_morador_apt:
    # essa linha subtrai pq em 'write_mewline' há um incremente do endereço para não sobrescrever o '\n'
    subi $t0, $t0, 1 # está dando problema na segunda volta para poder ler o 2º endereço
    la $s6, ($t0) # carrega o endereço do atual bloco da linked list em $s6
    lb $t3, 0($t0) # carregamento do número do andar em $t3
    sb $t3, ($t2) # armazena $t3 em $t2 (heap)
    addi $t2, $t2, 1 # avança uma coluna em $t2 (heap)

    lb $t3, 1($t0) # carrega o número do apartamento em $t3
    sb $t3, ($t2) # armazena $t3 em $t2 (heap)
    addi $t2, $t2, 1 # avança uma coluna em $t2 (heap)
  
    addi $t6, $t6, 44 # carrega o valor do caractere ','
    sb $t6, ($t2) # armazena a ',' em $t2 (heap)
	addi $t2, $t2, 1 # avança uma coluna na heap
	sll $t6, $0, 4 # seta $t6 para 0

    li $t3, 1 # altera a bandeira $t3 para 1, pois o número do apartamento já foi lido
    j while_loop # realiza o jump para 'while_loop'

# Função que vai ler e salvar na heap o nome do(a) morador(a)
read_morador_name:
    sll $t3, $0, 4 # seta $t3 para 0

    lb $t3, 8($t0) # carrega byte por byte do nome do(a) morador(a) a partir do offset 8, no qual o nome começa
    beq $t3, $zero, name_read # se $t3 == 0 então vai para 'name_read', ou seja, o nome do(a) morador(a) já foi lido

    sll $t7, $0, 4 # seta $t7 para 0
    sb $t3, ($t2) # armazena $t3 em $t2 (heap)
    addi $t2, $t2, 1 # avança uma coluna em $t2 (heap)
    addi $t0, $t0, 1 # avança uma posição da linked list em $t0
   
    j read_morador_name # realiza o jump para 'read_morador_name'

# Função que adiciona uma vírgula após a leitura do nome de um morador
name_read:
    beq $t7, 1, loop_over_linked_list # se $t7 == 1 então vai para 'loop_over_linked_list'
    li $t3, 1 # seta $t3 para 1

    sll $t6, $0, 4 # seta $t6 para 0
    addi $t6, $t6, 44 # carrega o valor do caractere ','
    sb $t6, ($t2) # armazena a ',' em $t2 (heap)
	sll $t6, $0, 4 # seta $t6 para 0
	addi $t2, $t2, 1 # avança uma coluna em $t2 (heap)
    addi $t0, $t0, 1 # avança uma posição da linked list em $t0

    li $t4, 1 # seta $t4 para 1
    addi $t7, $0, 1 # adiciona 1 à $t7 para indicar que uma vírgula já foi adicionado, logo é preciso iterear a lista 
    sll $s7, $0, 4 # seta $t7 para 0
    j read_morador_name # realiza o jump para 'read_morador_name'

# Função para ler o tipo do veículo
read_morador_auto_type:
    beq $t6, 1, read_morador_auto_detail # se $t6 == 1 então vai para 'read_morador_auto_detail' 

    sll $t3, $0, 4 # seta $t3 para 0
    lb $t3, 8($t0) # carrega o byte do endereço atual em $t3

    sb $t3, ($t2) # armazena $t3 em $t2 (heap)
    addi $t2, $t2, 1 # adiciona 1 ao valor em $t2
    sll $t6, $0, 4 # limpa $t6 para 0
    addi $t6, $t6, 44 # carrega o valor do caractere ','
    sb $t6, ($t2) # armazena a ',' em $t2 (heap)

	sll $t6, $0, 4 # limpa $t6 para 0
	addi $t2, $t2, 1 # avança uma coluna na heap
    addi $t0, $t0, 1 # avança uma posição da linked list em $t0
    li $t6, 1 # seta $t6 para 0

    j read_morador_auto_type # realiza o jump para 'read_morador_auto_type'

# Função para ler os outros detalhes do veículo (nome e cor)
read_morador_auto_detail:
    sll $t3, $0, 4 # seta $t3 para 0
    lb $t3, 8($t0) # carrega o byte do endereço atual em $t3
    beq $t3, $zero, auto_name_read # se $t3 == 0 então vai para 'auto_name_read' 

    sb $t3, ($t2) # armazena $t3 em $t2 (heap)
    addi $t2, $t2, 1 # avança uma coluna na heap
    addi $t0, $t0, 1 # avança uma posição da linked list em $t0

    j read_morador_auto_detail # realiza o jump para 'read_morador_auto_detail'

# Função que adiciona uma vírgula após a leitura dos detalhes do veículo serem lidos (nome e cor)
auto_name_read:
    beq $t7, 1, loop_over_list # se $t7 == 1 então vai para 'loop_over_list'
    sll $t6, $0, 4 # limpa $t6 para 0
    addi $t6, $t6, 44 # carrega o valor do caractere ','
    sb $t6, ($t2) # armazena a ',' em $t2 (heap)
	sll $t6, $0, 4 # limpa $t6 para 0
	addi $t2, $t2, 1 # avança uma coluna
    addi $t0, $t0, 1 # avança uma posição da linked list em $t0

    addi $t7, $t7, 1 # adiciona 1 ao valor em $t7

    j read_morador_auto_detail # realiza o jump para 'read_morador_auto_detail'

loop_over_list:
    bne $t3, $zero, set_flag # se $t3 == 0 então vai para 'set_flag'

    # final de um bloco de moradores + veículo(s), então, adiciona um nova linha para salvar os próximos endereços
    la $t4, ($s2) # carrega o endereço da lista ligada em $t4
    addi $t4, $t4, 186 # soma 186 ao valor em $t4
    sll $t3, $0, 4 # seta $t3 para 0
    sll $s7, $0, 4 # seta $t7 para 0
    beq $t0, $t4, write_new_line # se $t0 == $t4 então vai para 'write_new_line'

    sll $t9, $0, 4 # seta $t9 para 0
    sll $t3, $0, 4 # seta $t3 para 0
    sll $t4, $0, 4 # seta $t4 para 0

    addi $t0, $t0, 1 # avança uma posição da linked list em $t0
    lb $t3, 8($t0) # carrega o byte do endereço atual em $t3
    sll $t7, $0, 4 # seta $t7 para 0

    j loop_over_list # realiza o jump para 'loop_over_list'

set_flag:
    li $t4, 1 # seta $t4 para 1
    sll $t7, $0, 4 # seta $t7 para 0
    j read_morador_auto_detail # realiza o jump para 'read_morador_auto_detail'

# Função que realiza o loop na linked list até completar o tamanho do bloco dos 5 possíveis moradores ou encontrar um novo caractere em $t3
loop_over_linked_list:
    bne $t3, $zero, count_morador # se $t3 != 0, então existe um caractere para ser lido, logo vai para 'count_morador'

    addi $a0, $s6, 0 # adiciona o endereço presente em $s6 no registrador $a0 para a função abaixo
    jal check_linked_list_last_position  # realiza o jal para 'check_linked_list_last_position'

    continue_looping:
    addi $s7, $0, 1 # seta $s7 para 1
    li $t3, 1 # seta $t3 para 1
    li $t9, 1 # seta $t9 para 1
    sll $t5, $0, 0 # seta $t5 para 0
    beq $t0, $v0, while_loop # se $t0 == $t6, então vai para 'while_loop', pois todos os moradores do apartamento foram lidos

    sll $t3, $0, 4 # seta $t3 para 0
    sll $t9, $0, 4 # seta $t9 para 0

    addi $t0, $t0, 1 # avança uma posição da linked list em $t0
    lb $t3, 8($t0) # carrega o byte do endereço atual em $t3
    sll $t7, $0, 4 # seta $t7 para 0
    j loop_over_linked_list # realiza o jump para 'loop_over_linked_list'

count_morador:
    lw $t8, 4($s6) # carrega a quantidade de moradores do atual apartamento
    addi $s5, $s5, 1 # incrementa $s5 cada vez que passa pela label (é um contador)
    sll $t4, $0, 4 # seta $t4 para 0
    beq $t8, $s5, while_loop # se $t8 == $s5 então vai para 'while_loop'
    j read_morador_name # realiza o jump para 'read_morador_name'

write_newline:
    sll $t6, $0, 4 # seta $t6 para 0
	addi $t6, $t6, 10 # carrega o '\n' em $t6
	sb $t6, ($t2) # armazena o '\n' na heap
	addi $t2, $t2, 1 # avança uma coluna na heap

    sll $t6, $0, 4 # seta $t6 para 0
    sll $t4, $0, 4 # seta $t4 para 0

    addi $s6, $s6, 186
    beq $t0, $s6, load_next_block_address # se $t0 == $s6 então vai para 'load_next_block_address'
    sll $t6, $0, 4 # seta $t6 para 0
    addi $t0, $t0, 1 # avança uma posição na linked list

    li $t5, 1 # altera a bandeira $t5 para 1
    li $t9, 1 # altera a bandeira $t9 para 1

    j while_loop # realiza o jump para 'while_loop'

write_new_line:
    sll $t4, $0, 4 # seta $t4 para 0
	addi $t6, $t6, 10 # carrega o '\n' em $t6
	sb $t6, ($t2) # armazena o '\n' na heap
	addi $t2, $t2, 1 # avança uma coluna na heap
    sll $t6, $0, 4 # seta $t6 para 0

    addi $s6, $s6, 186
    beq $t0, $s6, load_next_block_address
    addi $t0, $t0, 1 # avança uma posição na linked list
    sll $t6, $0, 4 # seta $t6 para 0

    j read_morador_name # realiza o jump para 'read_morador_name'

# Função para carregar o próximo endereço que pode conter um novo apartamento ou não
load_next_block_address:
    sll $t6, $0, 4 # seta $t6 para 0
    subi $s6, $s6, 186 # subtrai 186 do valor presente em $s6
    lw $t7, 196($s6) # carrega o endereço do próximo bloco do novo apartamento em $t7
    addi $t0, $t7, 0 # adiciona $t7 à $t0 para continuar a leitura a partir desse novo endereço
    beq $t0, $zero, write_file # se $t0 == 0 significa que não há um novo endereço para ser lido, então vai para 'write_file'
    lb $t3, 0($t0) # carrega o próximo byte da linked list
    addi $t0, $t0, 1 # adiciona 1 ao valor em $t0
    j read_morador_apt # realiza o jump para 'read_morador_apt'

# Função que escreve os dados e fecha o arquivo
write_file:
    addi $a0, $s3, 0 # recupera o valor da abertura do arquivo em $s3 e coloca em $a0
    
    la $a1, ($s4) # carrega o endereço da alocação de memória em $a1
    li $a2, 1000 # especifica o valor máximo disponível para o length do arquivo em $a2
    li $v0, 15 # chamada do syscall para escrita no arquivo com código 15
    syscall  # execução do syscall

    addi $a0, $s3, 0 # recupera o valor da abertura do arquivo em $s3 e coloca em $a0
    li $v0, 16 # chamada do syscall para fechamento no arquivo com código 16
    syscall  # execução do syscall
    sll $s1, $0, 4 # seta $s1 para 0

    # Dados salvos com sucesso no arquivo
    la		$t0, nl		# carrega o endereço da quebra de linha
    write_shell($t0) # imprime o '\n'
    la		$t0, cmd_salvar_sucessfull_message		# carrega o endereço da mensagem de sucesso
    write_shell($t0) # imprime a mensagem de sucesso
    j		clear_current_shell_cmd				# realiza o jump para 'clear_current_shell_cmd'

# Função que mostra os comandos que podem ser utilizados pelo usuário do programa a partir da entrada "help".
help:
    la		$t0, std_help		# Compara se 
    write_shell($t0)
    j		clear_current_shell_cmd				# pular para clear_current_shell_cmd

exit:
    addi	$v0, $0, 10		# System call 10 - Exit
    syscall					# execute

check_linked_list_last_position:
    bne $s7, $zero, continue_looping
    add $t1, $a0, $0
    addi $t1, $t1, 186 # $t6 = $t6 + 186, ou seja, o endereço de $s2 somado à 186 nos dá um endereço de parada, pois esse representa o tamanho de até 5 moradores
    addi $v0, $t1, 0
    sll $t1, $0, 4
    jr $ra

# Função que compara duas strings apontadas nesse código em $a0 e $a1 e devolve em $v0 o resultado (verdadeiro ou falso).
strcmp:
    addi	$t0, $a0, 0			# $t0 = $a0 + 0
    addi	$t1, $a1, 0			# $t1 = $a1 + 0
    addi	$v0, $zero, 0
# Continuação da função strcmp: compara caractere por caractere até alcançar um caractere null.
loop_over_strings:
    lb		$t3, 0($t0)		# 
    lb		$t4, 0($t1)		# 
    bne		$t3, $t4, compare_greater	# se $t3 != $t4 então vá para compare_greater
    beq		$t3, $zero, finish_strcmp	# se $t3 == $zero então vá para finish_strcmp

    addi	$t0, $t0, 1			# $t0 = $a0 + 0
    addi	$t1, $t1, 1			# $t1 = $a1 + 0
    j		loop_over_strings	# pular para loop_over_strings
# Continuação da função strcmp: compara os valores dos caracteres segundo a tabela ascii.
compare_greater:
    addi    $v0, $v0, 1
    slt		$t3, $t3, $t4		# $t3 = ($t3 < $t4) ? 1 : 0
    beq		$t3, $zero, finish_strcmp	# se $t3 == $zero então vá para finish_strcmp
    subi	$v0, $v0, 2			# $v0 = $v0 - 2
# Fim da função strcmp.
finish_strcmp:
    jr		$ra					# pular para $ra

strcat:
    addi	$t0, $a0, 0			# $t0 = $a0 + 0
    addi	$t1, $a1, 0			# $t1 = $a1 + 0
    
strcat_search_null_address:
    lb		$t2, 0($t0)		# 
    beq		$t2, $zero, strcat_loop_write_string	# se $t2 == $zero então vá para strcat_write_string
    addi	$t0, $t0, 1			# $t0 = $t0 + 1
    j strcat_search_null_address

strcat_loop_write_string:
    lb		$t2, 0($t1)		# 
    beq		$t2, $zero, strcat_finish	# se $t2 == $zero então vá para strcat_finish
    sb		$t2, 0($t0)		# 

    addi	$t0, $t0, 1			# $t0 = $t0 + 1
    addi	$t1, $t1, 1			# $t1 = $t1 + 1
    j strcat_loop_write_string
    
strcat_finish:
    addi	$v0, $a0, 0			# $v0 = $a0 + 0
    jr		$ra					# pular para $ra

strrm1:
    addi	$t0, $a0, 0			# $t0 = $a0 + 0
    addi	$t1, $zero, 0			# $t1 = $zero + 0
    
strrm1_loop_over_string:
    lb		$t2, 0($t0)		# 
    beq		$t2, $zero, strrm1_remove_last	# se $t2 == $zero então vá para strrm1_remove_last
    addi	$t0, $t0, 1			# $t0 = $t0 + 1
    j		strrm1_loop_over_string				# pular para strrm1_loop_over_string
    
strrm1_remove_last:
    subi	$t0, $t0, 1			# $t0 = $t0 - 1
    sb		$zero, 0($t0)		# 
    jr		$ra					# pular para $ra

strlen:
    addi	$v0, $a0, 0			# $t0 = $a0 + 0

strlen_loop_over_str:
    lb		$t2, 0($v0)		# 
    beq		$t2, $zero, strlen_finish	# se $t2 == $t1 então vá para strlen_finish
    addi	$v0, $v0, 1			# $t0 = $t0 + 1
    j strlen_loop_over_str

strlen_finish:
    sub		$v0, $v0, $a0		# $v0 = $v0 - $a0
    jr		$ra					# pular para $ra

# Função que compara duas strings até o fim da primeira, apontadas nesse código em $a0 e $a1 e devolve em $v0 o resultado (verdadeiro ou falso).
strncmp:
    addi	$t0, $a0, 0			# $t0 = $a0 + 0
    addi	$t1, $a1, 0			# $t1 = $a1 + 0
    addi	$t5, $a3, 0			# $t5 = $a3 + 0

    addi	$v0, $zero, 0
# Continuação da função strncmp: compara caractere por caractere até que chegue ao tamanho da primeira string.
loop_over_num_strings:
    beq		$t5, $zero, finish_strncmp	# se $t5 == $zero então vá para finish_strncmp

    lb		$t3, 0($t0)		# 
    lb		$t4, 0($t1)		# 
    bne		$t3, $t4, strncmp_compare_greater	# se $t3 != $t4 então vá para compare_greater
    beq		$t3, $zero, finish_strncmp	# se $t3 == $zero então vá para finish_strcmp

    addi	$t0, $t0, 1			# $t0 = $a0 + 0
    addi	$t1, $t1, 1			# $t1 = $a1 + 0
    subi	$t5, $t5, 1			# $t5 = $t5 - 1
    j		loop_over_num_strings	# pular para loop_over_strings
# Continuação da função strncmp: compara os valores dos caracteres segundo a tabela ascii.
strncmp_compare_greater:
    addi $v0, $v0, 1
    slt		$t3, $t3, $t4		# $t3 = ($t3 < $t4) ? 1 : 0
    beq		$t3, $zero, finish_strcmp	# se $t3 == $zero então vá para finish_strcmp
    subi	$v0, $v0, 2			# $v0 = $v0 - 2
# Fim da função strcmp.
finish_strncmp:
    jr		$ra					# pular para $ra

check_prefix:
    # input:
    # $a0 => prefix to check
    # $a1 => the command
    # return:
    # $zero => se prefix is equals to the command prefix
    # -1 or 1 => se prefix is not equal to the command prefix

    # Save $ra before jump and link
    subi	$sp, $sp, 4			# $sp = $sp - 4
    sw		$ra, 0($sp)		# 

check_prefix_len_word:
    jal		strlen				# pular para strlen e salvar posição em $ra
    
check_prefix_compare_words:
    #Check prefix word
    addi	$a3, $v0, 0			# $a3 = $v0 + 0
    jal		strncmp				# pular para strncmp e salvar posição em $ra
    bne		$v0, $zero, check_prefix_finish	# se $v0 != $zero então vá para check_prefix_finish

    # Load separator
    la		$t2, sep_args		# 
    lb		$t2, 0($t2)		# 

    add		$t0, $a1, $a3		# $t0 = $a1 + $a3
    lb		$t0, 0($t0)		# 
    beq		$t0, $t2, check_prefix_finish	# se $t0 == $t2 então vá para check_prefix_finish
    addi	$v0, $v0, 1			# $v0 = $v0 + 1
    
check_prefix_finish:
    # Get $ra back
    lw		$ra, 0($sp)		# 
    addi	$sp, $sp, 4			# $sp = $sp + 4

    jr		$ra					# pular para $ra

jump_prefix:
    # Input:
    # $a0 => prefix address to jump
    # return:
    # address without prefix
    addi	$t0, $a0, 0			# $t0 = $a0 + 0
    lw		$t1, sep_args		# 
    
jump_prefix_loop_until_sep_arg:
    lb		$t2, 0($t0)		# 
    beq		$t2, $t1, jump_prefix_end	# se $t0 == $t1 então vá para jump_prefix_end
    addi	$t0, $t0, 1			# $t0 = $t0 + 1
    j		jump_prefix_loop_until_sep_arg				# pular para jump_prefix_loop_until_sep_arg
    
jump_prefix_end:
    addi	$v0, $t0, 1			# $v0 = $t0 + 1 | Get address after the sep
    jr		$ra					# pular para $ra
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
    addi	$v1, $zero, 0			# $v1 = $zero + 0

search_if_apt_exists_loop_over_ll:
    beq		$t0, $zero, search_if_apt_exists_false	# se $t0 == $zero então vá para search_if_apt_exists_false
    
    addi	$sp, $sp, -8			# $sp = $sp + -8
    sw		$ra, 0($sp)		# 
    sw		$t0, 4($sp)		# 
    addi	$a0, $a0, 0			# $a0 = $a0 + 0
    addi	$a1, $t0, 0			# $a1 = $t0 + 0
    jal		check_apt				# pular para check_apt e salvar posição em $ra
    lw		$ra, 0($sp)		# 
    lw		$t0, 4($sp)		# 
    addi	$sp, $sp, 8			# $sp = $sp + 8
    bne		$v0, $zero, search_if_apt_exists_true	# se $v0 != $zero então vá para write_current_shell_cmd
    addi	$v1, $t0, 0			# $v1 = $t0 + 0 | Mantém em $v1 o último apartamento antes do que se procura
    jump_to_next_ll($t0)
    j		search_if_apt_exists_loop_over_ll				# pular para search_if_apt_exists_loop_over_ll

search_if_apt_exists_true:
    addi	$v0, $t0, 0			# $v0 = $t0 + 0
    jr		$ra					# pular para $ra

search_if_apt_exists_false:
    addi	$v0, $zero, 0			# $v0 = $zero + 0
    jr		$ra					# pular para $ra

# Função que checa se o morador está no apartamento indicado e caso esteja retorna em $v0 o endereço em que se encontra o nome do morador.
search_morador_in_apt:
    # $a0 => Endereço da String do nome do morador
    # $a1 => Endereço do bloco apartamento
    # $v0 => Endereço do morador OU $zero se não encontrou nenhum
    addi	$t0, $a0, 0			# $t0 = $a0 + 0
    addi	$t1, $a1, 8			# $t1 = $a1 + 8
    lw		$t2, 4($a1)		# Lê a quantidade de moradores que há

    # Armazena na stack o valor de $ra
    addi	$sp, $sp, -4			# $sp = $sp + -4
    sw		$ra, 0($sp)		# 
# Continuação de search_morador_in_apt: compara os nomes de morador em morador cadastrado no apartamento.
search_morador_in_apt_loop:
    # Verifica quando não há mais moradores para procurar
    beq		$t2, $zero, search_morador_in_apt_finish_not_found	# se $t2 == $zero então vá para search_morador_in_apt_finish_not_found

    # Armazena $t0, $t1 e $t2 na pilha
    addi	$sp, $sp, -12			# $sp = $sp + -12
    sw		$t0, 0($sp)		# 
    sw		$t1, 4($sp)		# 
    sw		$t2, 8($sp)		# 

    # Verifica o morador atual
    addi	$a0, $t0, 0			# $a0 = $t0 + 0
    addi	$a1, $t1, 0			# $a1 = $t1 + 0
    jal		strcmp				# pular para strcmp e salvar posição em $ra
    # Pega $t0, $t1 e $t2 da pilha
    lw		$t0, 0($sp)		# 
    lw		$t1, 4($sp)		# 
    lw		$t2, 8($sp)		# 
    addi	$sp, $sp, 12			# $sp = $sp + 12
    # Verifica o strcmp
    beq		$v0, $zero, search_morador_in_apt_finish_found	# se $v0 == $zero então vá para search_morador_in_apt_finish_found

    # Se não encontrado
    # Subtrai a quantidade de moradores
    subi	$t2, $t2, 1			# $t2 = $t2 - 1
    # Pula para o próximo morador
    addi	$t1, $t1, 22			# $t1 = $t1 + 22

    # E reinicia o loop
    j		search_morador_in_apt_loop				# pular para search_morador_in_apt_loop

# Continuação de search_morador_in_apt: resultado caso o morador não seja encontrado.
search_morador_in_apt_finish_not_found:
    addi	$t1, $zero, 0			# $t1 = $zero + 0
# Continuação de search_morador_in_apt: resultado caso o morador seja encontrado.
search_morador_in_apt_finish_found:
    # Pega o endereço armazenado na pilha e volta com o resultado
    addi	$v0, $t1, 0			# $v0 = $t1 + 0
    lw		$ra, 0($sp)		# 
    addi	$sp, $sp, 4			# $sp = $sp + 4
    jr		$ra					# pular para $ra    

check_apt:
    addi	$t0, $a0, 0			# $t0 = $a0 + 0
    addi	$t1, $a1, 0			# $t1 = $a1 + 0

    # Verifica se o endereço armazenado em $t1 está vazio
    beq		$t1, $zero, check_apt_false	# se $t1 == $zero então vá para check_apt_false

    # Verifica o andar
    lb		$t2, 0($t0)		# 
    lb		$t3, 0($t1)		#
    bne		$t2, $t3, check_apt_false	# se $t2 != $t3 então vá para check_apt_false

    # Verifica o número do apt
    lb		$t2, 2($t0)		# 
    lb		$t3, 1($t1)		# 
    bne		$t2, $t3, check_apt_false	# se $t2 != $t3 então vá para check_apt_false

    # O apartamento está nesse bloco (True):
    addi	$v0, $zero, 1			# $v0 = $zero + 1
    jr		$ra					# pular para $ra
    
check_apt_false:
    addi	$v0, $zero, 0			# $v0 = $zero + 0
    jr		$ra					# pular para $ra

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
    jal		strcpy				# pular para strcpy e salvar posição em $ra
    lw		$ra, 0($sp)		# 
    addi	$sp, $sp, 4			# $sp = $sp + 4
    jr		$ra					# pular para $ra

# Função que exclui um morador e reorganiza a quantidade e as posições dos moradores na lista ligada.
delete_morador:
    # $a0 => Endereço do morador no bloco do apartamento
    # $a1 => Endereço do último morador no apartamento

    # Armazena $ra e $a1 na stack
    addi	$sp, $sp, -8			# $sp = $sp + -8
    sw		$a1, 0($sp)		# 
    sw		$ra, 4($sp)		#

    # Preenche o endereço do morador a ser deletado com \0
    addi	$a0, $a0, 0			# $a0 = $a0 + 0
    addi	$a1, $zero, 22			# $a1 = $zero + 22
    jal		fill_with_null_byte				# pular para fill_with_null_byte e salvar posição em $ra

    # Obtém $a1 da Stack
    lw		$a1, 0($sp)		# 

    # Copia último morador e coloca-o na posição do morador excluído
    jal		strcpy				# pular para strcpy e salvar posição em $ra

    # Preenche o endereço do morador movido com \0
    addi	$a0, $a1, 0			# $a0 = $a1 + 0
    addi	$a1, $zero, 22			# $a1 = $zero + 22
    jal		fill_with_null_byte				# pular para fill_with_null_byte e salvar posição em $ra

    # Pega $ra e volta para o retorno
    lw		$ra, 4($sp)		# 
    addi	$sp, $sp, 8			# $sp = $sp + 8
    jr		$ra					# pular para $ra

# Função que calcula o tamanho de uma String até um separador
# Porém, caso um \0 aconteça, termina ali
strlen_until_sep:
    addi	$v0, $a0, 0			# $t0 = $a0 + 0
    addi	$a1, $a1, 0			# $a1 = $a1 + 0

strlen_until_sep_loop_over_str:
    lb		$t2, 0($v0)		# 
    beq		$t2, $a1, strlen_until_sep_finish	# se $t2 == $t1 então vá para strlen_until_sep_finish
    beq		$t2, $zero, strlen_until_sep_finish	# se $t2 == $zero então vá para strlen_until_sep_finish
    addi	$v0, $v0, 1			# $t0 = $t0 + 1
    j strlen_until_sep_loop_over_str

strlen_until_sep_finish:
    sub		$v0, $v0, $a0		# $v0 = $v0 - $a0
    jr		$ra					# pular para $ra

# Armazena o automóvel em algum slot disponível
store_auto:
    addi	$t1, $a0, 0			# $t1 = $a0 + 0 | Carrega as informações do comando digitado
    addi	$t2, $a1, 0			# $t2 = $a1 + 0 | Carrega o bloco da lista ligada
    lb		$t3, 118($t2)		# 
    addi	$t2, $t2, 118			# $t2 = $t2 + 118
    beq		$t3, $zero, store_auto_slot_1	# se $t3 == $zero então vá para store_auto_slot_1
    # Cada slot de cada automóvel tem 38 bytes, basicamente estamos pulando 38 bytes para o slot 2
    addi	$t2, $t2, 38			# $t2 = $t2 + 38
# Armazena cada informação do automóvel (tipo, modelo e cor) nos slots de memória certos.
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
    jal		strlen_until_sep				# pular para strlen_until_sep e salvar posição em $ra
    lw		$t1, 4($sp)		# 
    lw		$t2, 8($sp)		# 

    addi	$a0, $t2, 1			# $a0 = $t2 + 1
    addi	$a1, $t1, 6			# $a1 = $t1 + 6
    addi	$a2, $v0, 0			# $a2 = $v0 + 0
    jal		memcpy				# pular para strcpy e salvar posição em $ra
    lw		$t1, 4($sp)		# 
    lw		$t2, 8($sp)		# 

    # Armazena a cor do automóvel
    addi	$a1, $t1, 7			# $a1 = $t1 + 7
    add		$a1, $a1, $a2		# $a1 = $a1 + $a2

    addi	$a0, $t2, 22			# $a0 = $t2 + 22
    jal		strcpy				# pular para strcpy e salvar posição em $ra

    lw		$ra, 0($sp)		# 
    addi	$sp, $sp, 12			# $sp = $sp + 12

    la		$t1, cmd_ad_auto_sucessfull_message		# 
    write_shell($t1)
    jr		$ra					# pular para $ra

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
    beq		$t1, $t2, fill_with_null_byte_finish	# se $t1 == $t2 então vá para fill_with_null_byte_finish
    sb		$zero, 0($t2)		# 
    addi	$t2, $t2, 1			# $t2 = $t2 + 1
    j		fill_with_null_byte_loop				# pular para fill_with_null_byte_loop  

fill_with_null_byte_finish:
    jr		$ra					# pular para $ra

calculate_links_on_ll:
    # $a0 => cabeça da lista ligada
    # $v0 => quantidade de links
    addi	$t0, $zero, 0			# $t0 = $zero + 0
    addi	$t1, $a0, 0			# $t1 = $a0 + 0
    
    beq		$t1, $zero, calculate_links_on_ll_finish	# se $t1 == $zero então vá para calculate_links_on_ll_finish
    addi	$t0, $t0, 1			# $t0 = $t0 + 1
    
calculate_links_on_ll_loop:
    lw		$t2, 196($t1)		#
    beq		$t2, $zero, calculate_links_on_ll_finish	# se $t2 == $zero então vá para calculate_links_on_ll_finish
    addi	$t0, $t0, 1			# $t0 = $t0 + 1
    jump_to_next_ll($t1)
    j		calculate_links_on_ll_loop				# pular para calculate_links_on_ll_loop    
    
calculate_links_on_ll_finish:
    addi	$v0, $t0, 0			# $v0 = $t0 + 0
    jr		$ra					# pular para $ra

calculate_info_geral_percentage:
    # $a0 => quantidade de apartamentos ocupados
    # $v0 => Porcentagem de ocupados
    # $v1 => Porcentagem de vazios
    addi	$t0, $zero, 40			# $t0 = $zero + 40
    addi	$t1, $a0, 0			# $t1 = $a0 + 0
    addi	$t2, $zero, 100			# $t4 = $zero + 100
    mult	$t1, $t2			# $t1 * $t2 = Hi and Lo registers
    mflo	$t1					# copy Lo to $t1

    div		$t1, $t0			# $t1 / $t0
    mflo	$t4					# $t2 = floor($t1 / $t0) 
    mfhi	$t3					# $t3 = $t1 % $t0 

    addi	$v0, $t4, 0			# $v0 = $t2 + 0
    sub		$v1, $t2, $v0		# $v1 = $t2 - $v0

    jr		$ra					# pular para $ra    

# Função que faz a conversão de um inteiro para uma string:
# Entradas: $a0 é o inteiro a ser convertido e
# $a1 é o  endereço da string onde o número convertido será armazenado.
int2str:
    addi $sp, $sp, -4         # salvando o registrador $t0 que é usado nessa função em pilha
    sw   $t0, ($sp)           # para que o valor não mude na chamada
    bltz $a0, neg_num         # num < 0 ?
    j    next0                # se não, vá para 'next0'
# Coninuação de int2str: se num < 0.
neg_num:                  
    li   $t0, '-'
    sb   $t0, ($a1)           # *str = ASCII de '-' 
    addi $a1, $a1, 1          # str++
    li   $t0, -1
    mul  $a0, $a0, $t0        # num *= -1
# Coninuação de int2str: se num >= 0.
next0:
    li   $t0, -1
    addi $sp, $sp, -4         # armazenar espaço na pilha
    sw   $t0, ($sp)           # e salvar -1 como fim da pilha
# Coninuação de int2str: loop de conversão.
push_digits:
    blez $a0, next1           # num < 0? se sim, terminar loop (ir para 'next1')
    li   $t0, 10              # se não, continuar no loop
    div  $a0, $t0             # fazer divisão: num / 10. LO = Quociente, HI = resto
    mfhi $t0                  # $t0 = num % 10
    mflo $a0                  # num = num // 10  
    addi $sp, $sp, -4         # armazenar espaço na pilha
    sw   $t0, ($sp)           # armazenar num % 10
    j    push_digits          # voltar para começo do loop
# Coninuação de int2str: checar sinal do número.
next1:
    lw   $t0, ($sp)           # $t0 = tirar "sinal" da pilha
    addi $sp, $sp, 4          # e 'restaurar' pilha

    bltz $t0, neg_digit       # se sinal <= 0, vá para neg_digit (i.e, num = 0)
    j    pop_digits           # se não vá para popping em um loop
# Coninuação de int2str: sinal negativo.
neg_digit:
    li   $t0, '0'
    sb   $t0, ($a1)           # *str = ASCII de '0'
    addi $a1, $a1, 1          # str++
    j    next2                # pular para next2
# Coninuação de int2str: converter sinal negativo.
pop_digits:
    bltz $t0, next2           # se sinal <= 0 vá para next2
    addi $t0, $t0, '0'        # se não, $t0 = ASCII do sinal
    sb   $t0, ($a1)           # *str = ASCII do sinal
    addi $a1, $a1, 1          # str++
    lw   $t0, ($sp)           # sinal = tirar da pilha
    addi $sp, $sp, 4          # restaurar pilha
    j    pop_digits           # e voltar ao começo do loop
# Fim de int2str e restauração da pilha.
next2:
    sb  $zero, ($a1)          # *str = 0 (fim da string)

    lw   $t0, ($sp)           # restaurar valor de $t0 para o de antes da chamada da função
    addi $sp, $sp, 4          # restaurar pilha
    jr  $ra                   # pular para caller