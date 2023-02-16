.data
    receiver_ready: .word 0xffff0000
    receiver_data: .word 0xffff0004

    transmitter_ready: .word 0xffff0008
    transmitter_data: .word 0xffff000c

.text

main:                               # função inicial do programa
    lw		$s0, receiver_ready		# carrega o valor de 'receiver_ready' em $s0
    lw		$s1, receiver_data		# carrega o valor de 'receiver_data' em $s1
    lw		$s2, transmitter_ready	# carrega o valor de 'transmitter_ready' em $s2
    lw		$s3, transmitter_data	# carrega o valor de 'transmitter_data' em $s3
    
loop_wait_for_character:
    lb		$t0, 0($s0)		# carrega um byte de memória a partir do endereço armazenado em $s0 e o coloca no $t0
    bne		$t0, $zero, read_and_write_character	# se $t0 != $zero, vá para 'read_character'
    j		loop_wait_for_character			# jump para 'loop_wait_for_character'

read_and_write_character:
    lw		$t0, 0($s1)		# carrega uma palavra de memória a partir do endereço armazenado em $s1 e a coloca em $t0
    sw		$t0, 0($s3)		# armazena o conteúdo do $t0 na memória, no endereço armazenado em $s3.

wait_display_to_write:
    lb		$t0, 0($s2)		# carrega um byte de memória a partir do endereço armazenado em $s2 e o coloca em $t0
    beq		$t0, $zero, wait_display_to_write	# se $t0 == $zero, então vá para 'wait_display_to_write'
    j		loop_wait_for_character				# jump para 'loop_wait_for_character'
    
