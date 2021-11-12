.data
freq: .space 128
specialChar: .asciiz ":" 
ast: .asciiz "*" 
newline2: .asciiz "\n"
dash: .asciiz "\ "
el: .asciiz "\n"
.text

findIndex:
    # your code goes here
    
    blez $a1, arrayEr
    j okay
    
    arrayEr:
    addi $t7, $0, -1
    move $v0, $t7
    move $v1, $t7
    j last
    
    okay:
    #a0 is array, $a1 is array size
    
    addi $t0, $0, 0 #Storing the Min
    addi $t1, $0, 0 #Storing the Max
    
    lw $t0, 0($a0)
    lw $t1, 0($a0)
    
    #Loop Counter
    addi $s0, $0, 0
    addi $s1, $0, 1
    
    #Loop
    find:
    beq $s0, $a1, index
    
    #arr[i]
    addi $t5, $0, 4
    mul $t5, $s0, $t5
    add $t2, $t5, $a0
   
    lw $t3, ($t2)
    blt $t3, $t0, min
    j next
    min:
    lw $t0, ($t2)
    
    j next
   
    next:
    bgt $t3, $t1, max
    j next2
    max:
    lw $t1, ($t2)
    j next2
    
    next2:
    
    add $s0, $s0, $s1
    j find
    index:
    
    move $s0, $zero
    
    
    do:
    beq $s0, $a1, last
    
    addi $t5, $0, 4
    
    mul $t5, $s0, $t5
    
    add $t2, $t5, $a0
    
    lw $t4, ($t2)
    beq $t4, $t0, minR
    j new
    minR:
    move $v1, $s0
    addi $t0, $t0, -1
    j new

    new:
    beq $t4, $t1, maxR
    j new2
    maxR:
    move $v0, $s0
    addi $t1, $t1, 1
    j new2
    
    new2:
    
    add $s0, $s0, $s1
    j do
    last:
   
    jr $ra

maxCharFreq:
    # your code goes here
    
    lb $k0, 0($a0)
    li $k1, -1
    beq $k0, $zero, empty
    j aokay
    
    empty:
    addi $t7, $0, -1
    move $v0, $k1
    move $v1, $t7
   
    j here
    
    aokay:   
    
    lb $k0, 0($a0)
    la $t6, dash
    beq $t6, $k0, endl
    j fins
    
    endl:
    addi $t7, $0, 1
    la $t6, el
    move $v0, $t6
    move $v1, $t7
    j here
    
    fins:    
    
    la $t0, freq
    
    addi $s0, $0, 0
    addi $s1, $0, 1
    addi $s2, $0, 128
    addi $s3, $0, 0
    
    for: #loop to set freq values all to 0
    bge $s0, $s2, done
 
    add $t5, $t0, $s0
    sb $s3, ($t5)

    add $s0, $s0, $s1
    j for
    done:
    
    move $s0, $zero
    
    addi $t1, $0, -1
    #Normal Result
    lb $v0, ($a0)# loading the first cahrachter into final(v0)
    
    addi $s5, $0, 0
    #Result Pointer
    add $s5, $t0, $v0 #set s5 to point to the frequncy of final(v0) which is max, s5 is the adress of max
    
    addi $s6, $0, 0
    
    move $s7, $a0
   
    #Counting String
    while:
	lb $t2, 0($a0)
	beqz $t2, fin
	
	add $t3, $t0, $t2 #loading adress of freq of the cahrachter($t2)
	
	lb $t4,($t3) #loading frequecy of charachter(t2)
			#t4 is frequncy of the current charachter(t2)
	add $t4, $t4, $s1 #incrementiong frequncy of charachter(t2)
	
	sb $t4, ($t3) #storing frequncy of charachter(t2) back into freq
	lb $s6, ($s5)#loading frequency of final(v0)
	blt $s6, $t4, done2 #comparing frequncy of current char(t2) to final(v0), s6 is frequncy of final, t4 is frequncy of s2
	j done3
	
	done2:
	move $v0, $t2 #setting final(v0) to current char(t2)
	move $s5, $t3 #set s5 to point to frequncy of current char(s2) which is currently the final(v0), which is stroed in t3
	j done3
	
	done3:
	
	add $a0, $a0, $s1

	j while
    fin:
    
    lb  $v1, ($s5)   # Loding the max freq into $v1 for transfert to antoehr file 
    
    lb $v0, ($s7)
    
    add $k0, $t0, $v0
    lb $v1, ($k0)
    
    again:
    lb $t6, 0($s7)
    beqz $t6, friday
    
    add $t1, $t0, $t6
    lb $t2, ($t1)
    
    bgt $t2, $v1, right
    j notit
    
    right:
    move $v1, $t2
    move $v0, $t6
    
    notit:
   
    add $s7, $s7, $s1
    j again
    friday:
    
    here:
    
    jr $ra

countAllChars:
    # your code goes here   
    
    addi $s0, $0, 0
    addi $s1, $0, 1
    addi $s2, $0, 26
    addi $s3, $0, 0
    
    alp: #loop to set freq values all to 0
    bge $s0, $s2, pha
    
    addi $t6, $0, 4
    mul $t6, $s0, $t6
    add $t7, $t6, $a1

    sw $s3, ($t7)

    add $s0, $s0, $s1
    j alp
    pha:
    
    move $s0, $zero
    
    addi $t1, $0, -1
    #Normal Result
    lb $v0, ($a0)# loading the first cahrachter into final(v0)
    
    addi $s5, $0, 0
    #Result Pointer
    add $s5, $a1, $v0 #set s5 to point to the frequncy of final(v0) which is max, s5 is the adress of max
    
    addi $s6, $0, 0
   
    #Counting String
    move $v0, $zero #letters
    move $v1, $zero #space
    
    beta:
	lb $t2, 0($a0)
	beqz $t2, final
	
	#Lower
    	li $t9, 0x20 # ' '
    	beq $t2, $t9, gamma3	
    	li $t9, 0x41 # A
    	li $t8, 0x59 # Z
    	ble $t2, $t8, gamma2
    	li $t9, 0x61 # a
    	li $t8, 0x7A # z
    	ble $t2, $t8, gamma
    	j final3

	#if statements 
	gamma:
	bge $t2, $t9, lower
	j final3
	
	gamma2:
	bge $t2, $t9, upper
	j final3
	
	lower:
	sub $t2, $t2, $t9
	j finally
	
	upper: 
	sub $t2, $t2, $t9
	j finally
	
	finally:
	
	add $v1, $v1, $s1
	
	addi $t6, $0, 4
        mul $t6, $t2, $t6
        add $t7, $t6, $a1 #loading adress of freq of the cahrachter($t2)
	
	lw $t4,($t7) #loading frequecy of charachter(t2)
			#t4 is frequncy of the current charachter(t2)
	add $t4, $t4, $s1 #incrementiong frequncy of charachter(t2)
	
	sw $t4, ($t7) #storing frequncy of charachter(t2) back into freq

	j final3
	
	final3:
	
	add $a0, $a0, $s1
	
	j beta
	gamma3:
	add $v0, $v0, $s1
	j final3
    final:	
	
    jr $ra

createHist:
    # your code goes here
    
    # Making $v0 zero
    move $v0, $zero
    
    # Letters
    addi $s2, $0, 26  
    
    # Loop Counter
    addi $s0, $0, 0
    addi $s1, $0, 1
        
    move $a2, $a0
    
    dently:
        
    bge $s0, $s2, harvey
    
    # Next Letter
    addi $t0, $0, 4
    mul $t0, $s0, $t0
    add $t1, $t0, $a2 
  
    lw $t2, ($t1)
    bltz $t2, theEnd
    add $s0, $s0, $s1
    j dently
    
    theEnd:
    li $k0, -1
    move $v0, $k0
    j lastly
        
    harvey: 
    
    move $s0, $zero
    
    # $v0 counter
    addi $t5, $0, 0
    
    move $a1, $a0
 
    # Loop
    star:
    
    # End Loop
    bge $s0, $s2, night
    
    # Next Letter
    addi $t0, $0, 4
    mul $t0, $s0, $t0
    add $t1, $t0, $a1 
  
    lw $t2, ($t1)
    
    # Check Array
    bgtz $t2, nonzero
    j nothing
    
   
    # Star Printing and Returning Value Process	
    nonzero:
    
    # Increment Return Value
    add $t5, $t5, $s1 
    
    # Loading a
    li $t3, 0x61
        
    # Finding out what letter has stars
    add $t4, $t3, $s0
    
    # Print Letter
    move $a0, $t4
    li $v0, 11
    syscall	
   
    # Print :
    la $a0, specialChar
    li $v0, 4
    syscall
    
    addi $s4, $0, 0
    addi $s5, $0, 1
    
    starprint:
    beq $s4, $t2, stop
    
    # Print *
    la $a0, ast
    li $v0, 4
    syscall   
    
    add $s4, $s4, $s5
    j starprint
    stop:
    
    move $s4, $zero
    
    #print newline
    la $a0, newline2
    li $v0, 4
    syscall
     
    j nothing
    
    nothing:
    
    # Increment
    add $s0, $s0, $s1
    j star
    
    night:
    
    move $v0, $t5
    j lastly
    
    lastly:
  
    jr $ra

split:
    # your code goes here
    
    # Securing Array
    move $t0, $a0
    
    # Grab First Char of the String
    lb $s2, 0($a2)
    li $t7, 0x7F
    bgtu $a3, $t7, error1
    # Put First Char Address in Array
    sw $a2, ($t0)
    
    # Next in the Address
    addi $s4, $0, 4
    add $t0, $t0, $s4
     
    move $v1, $zero
    
    addi $s0, $0, 0
    addi $s1, $0, 1
    move $v0, $s1
    li $s3, 0
    
    errorCode:
    beq $a2, $zero, error1
    
    j split_while
    
    error1:
    li $v0, -1
    
    error2:
    li $v1, -1
    j long
    
    split_while:
    beq $s2, $s3, loopEnd
    beq $s2, $a3, compare
    j skip
     
    compare:
    beq $a1, $v0, error2
    add $v0, $v0, $s1
    add $t1, $a2, $s1
    sw $t1, ($t0)
    add $t0, $t0, $s4
    sb $s3, ($a2)
    
    skip:
    add $a2, $a2, $s1
    lb $s2, ($a2)
    add $s0, $s0, $s1
    j split_while
    loopEnd:
        
    long:
    
    jr $ra