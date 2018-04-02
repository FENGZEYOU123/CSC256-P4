.data
    endl:    .asciiz  "\n"   # used for cout << endl;
    sumlbl:    .asciiz  "Sum: " # label for sum
    revlbl:    .asciiz  "Reversed Number: " # label for rev
    pallbl:    .asciiz  "Is Palindrome: " # label for isPalindrome
    sumarr:    .word 1
               .word 3
               .word 44
               .word 66
               .word 88
               .word 90
               .word 9
               .word 232
               .word 4325
               .word 2321
    arr:       .word 1
               .word 2
               .word 3
               .word 4
               .word 5
               .word 4
               .word 3
               .word 2
               .word 1

.text

# sum               --> $s0
# address of sumarr --> $s1
# rev               --> $s2
# num               --> $s3
# isPalindrome      --> $s4
# address of arr    --> $s5
# i                 --> $t0
# beg               --> $s6
# end               --> $s7
# d                 --> $t1
# 10                --> $t2
# 100               --> $t3

main:
   li $s0, 0        # sum=0
   la $s1, sumarr   # load sumarr to $s1
   li $s2, 0        # rev=0
   li $s3, 45689    # num=45689
   li $s4, 1        # isPalindrome1
   la $s5, arr      # load arr to $s5
   li $s6, 0        # beg=0
   li $s7, 8        # end = 8

   li $t0, 0        # i=0
   li $t1, -1       # d=-1
   li $t2, 10       # $st=10
  
Loop:  
       blt $t0, 10, EndLoop     #if i>=0 then endloop
       sll $t3, $t0, 2      
       add $t3, $t3, $s1
       lw $t3, 0($t3)
       add $s0, $s0, $t3
       addi $t0, $t0, 1
       j Loop
EndLoop:

LoopTwo:
       ble $s3, $t0, EndLoopTwo # if num<=0
       rem $t1, $s3, $t2        # d=num%10
       mul $s2, $s2, $t2        # rev=rev*10
       addu $s2, $s2, $t1            # rev=rev+d
       
       div $s3, $s3, $t2        # num/10
j LoopTwo
EndLoopTwo:
       
LoopThree:
       bge $s6, $s7, EndLoopThree  #if s6 >= s7
       sll $t4, $s6, 2
       add $t4, $t4, $s5
       lw $t4, 0($t4)
       sll $t5, $s7, 2
       add $t5, $t5, $s5
       lw $t5, 0($t5)
       
        bne $t4, $t5, then  # arr[beg] not equals arr [end]
addi    $s6,$s6,1
addi    $s7,$s7,-1
j LoopThree
then:  
       addi $s4, $s4, -2
EndLoopThree:

   
exit:
  la   $a0, sumlbl    # puts sumlbl into arg0 (a0 register) for cout
  addi $v0, $0, 4     # puts 4 in v0 which denotes we are printing a string
  syscall             # make a syscall to system

  move $a0, $s0       # puts sum into arg0 (a0 register) for cout
  addi $v0, $0, 1     # puts 1 in v0 to denote we are printing an int
  syscall             # make a syscall to system

  la   $a0, endl      # puts the address of the string endl into a0
  addi $v0, $0, 4     # puts 4 into v0 saying we are printing a string
  syscall

  la   $a0, revlbl    # puts revlbl into arg0 (a0 register) for cout
  addi $v0, $0, 4     # puts 4 in v0 which denotes we are printing an string
  syscall             # make a syscall to system

  move $a0, $s2       # puts rev into arg0 (a0 register) for cout
  addi $v0, $0, 1     # puts 1 in v0 to denote we are printing an int
  syscall             # make a syscall to system

  la   $a0, endl      # puts the address of the string endl into a0
  addi $v0, $0, 4     # puts 4 into v0 saying we are printing a string
  syscall

  la   $a0, pallbl    # puts pallbl into arg0 (a0 register) for cout
  addi $v0, $0, 4     # puts 4 in v0 which denotes we are printing a string
  syscall             # make a syscall to system

  move $a0, $s4       # puts isPalindrome into arg0 (a0 register) for cout
  addi $v0, $0, 1     # puts 1 in v0 to denote we are printing an int
  syscall             # make a syscall to system

  la   $a0, endl      # puts the address of the string endl into a0
  addi $v0, $0, 4     # puts 4 into v0 saying we are printing a string
  syscall


  addi $v0,$0, 10
  syscall
