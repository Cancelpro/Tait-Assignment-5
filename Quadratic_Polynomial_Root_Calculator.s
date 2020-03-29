#this program 
    .text
    .globl __start
__start:
    la $a0, opening    #prints out the opening
    li $v0, 4
    syscall

    la $a0, prompt1    #asks the user to enter the a value for A
    li $v0, 4
    syscall

    jal getuserInput    #gets the user input for the A variable
    move $t0, $v0    #stores the integer stored in v0 to t0

    la $a0, prompt2   #asks the user to enter the a value for B
    li $v0, 4
    syscall

    jal getuserInput    #gets the user input for the B variable
    move $t1, $v0    #stores the integer stored in v0 to t1

    la $a0, prompt3    #asks the user to enter the a value for C
    li $v0, 4
    syscall

    jal getuserInput    #gets the user input for the C variable
    move $t2, $v0    #stores the integer stored in v0 to t2

    #starts algorithm to find the value of D
    mul $t1, $t1, $t1 #squares the B value in t1 and stores in t1
    mul $t0, $t2, $t0 #multiplies C*A and stores in t0
    mul $t0, $t0, 4 #multiplies ((C*A)*4) and stores in t0
    sub $t0, $t1, $t0 #subtracts B^2 - (4*A*C) and stores in t0

    la $a0, Dvalue #prints out the string leading up to value for D
    li $v0, 4
    syscall 

    li $v0, 1 #prints out the value for D stored in t0
    move $a0, $t0
    syscall

    la $a0, endl #prints newline
    li $v0, 4
    syscall

    beqz $t0, soleRoot # if t0 = 0 then goto soleRoot
    bgt	$t0, 0, twoRoot	# if  > $t1 then goto twoRoot
    #ELSE
    j noRoot #jump to no Roots

getuserInput:
    li $v0,5 #get an integer from user and store in v0
    syscall
    jr $ra #return to caller

soleRoot: 
    la $a0, soleRoots #prints out that the Quadratic polynomial has one root
    li $v0, 4
    syscall
    j Terminate #jumps to terminate the program

twoRoot: 
    la $a0, twoRoots #prints out that the Quadratic polynomial has two roots
    li $v0, 4
    syscall
    j Terminate #jumps to terminate the program

noRoot: 
    la $a0, neinRoots #prints out that the Quadratic polynomial has no roots
    li $v0, 4
    syscall
    j Terminate #jumps to terminate the program

Terminate: 
    la $a0, goodbye #prints out "Goodbye!"
    li $v0, 4
    syscall

    li $v0, 10 #kills the program
    syscall


    .data
        opening: .asciiz "Hello, This program calculates the discriminant of a quadratic polynomial\n"
        prompt1: .asciiz "Please enter the value for A: "
        prompt2: .asciiz "Please enter the value for B: "
        prompt3: .asciiz "Please enter the value for C: "
        Dvalue: .asciiz "The value for D = "
        soleRoots: .asciiz "Quadratic polynomial has a sole root."
        twoRoots: .asciiz "Quadratic polynomial has two roots."
        neinRoots: .asciiz "This Quadratic polynomial has no real roots."
        goodbye: .asciiz "\nGoodbye! \n" #I did this because I wanted to be under 100 lines of code....
        endl: .asciiz "\n"   