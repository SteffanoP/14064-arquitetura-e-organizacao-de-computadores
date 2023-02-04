.data
    receiver_ready: .word 0xffff0000
    receiver_data: .word 0xffff0004

    transmitter_ready: .word 0xffff0008
    transmitter_data: .word 0xffff000c

.text

main:
    lw		$s0, receiver_ready		# 
    lw		$s1, receiver_data		# 
    lw		$s2, transmitter_ready	# 
    lw		$s3, transmitter_data	# 
    
loop_wait_for_character:
    lb		$t0, 0($s0)		# 
    bne		$t0, $zero, read_and_write_character	# if $t0 != $zero then goto read_character
    j		loop_wait_for_character			# jump to loop

read_and_write_character:
    lw		$t0, 0($s1)		# 
    sw		$t0, 0($s3)		#

wait_display_to_write:
    lb		$t0, 0($s2)		# 
    beq		$t0, $zero, wait_display_to_write	# if $t0 == $zero then goto wait_display_to_write
    j		loop_wait_for_character				# jump to loop
    
