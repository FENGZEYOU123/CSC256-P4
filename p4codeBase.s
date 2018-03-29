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
    li $s0, 0       # int sum = 0
  
    li $t0, 1       # int i = 1
    li $t3, 100
    
loop:
    bge $t0, $t3, loop2        #i <= 100
    add $s0, $s0, $t0          #sum = sum + i
    addi $t0, $t0, 1           #i++
    j loop

    li $s3, 45689   #int num = 45689
    li $s2, 0       #int rev = 0
    li $t1, -1      #int d = -1
  
    ble $s3, 0, loop3   #( num > 0)
loop2:

    rem $t1, $s3, $t2   #d = num % 10

    mul $t4, $s2, $t2   # store in t4 rev*10
    add $s2, $t4, $t1   #rev = rev*10 + d
    div $s3, $s3, $t2   #num = num / 10
    j loop2

    li $s6, 0       #int beg = 0
    li $s7, 8       #int end = 8
    li $s4, 1       #int isPalindrome = 1
    la $s4, arr     #address for array

    bge $s6,$s7, exit #while(beg < end)

loop3:

    lw $s6, 0
    lw $s7, 8
    sll $t0, $s6, 4
    add $t0, $t5, $s4
    lw $t6, 0($t5)

    sll $t7, $s7, 4
    add $t7, $t7, $s4
    lw $t8, 0($t7)

    ble $t6, $t8,if    # if (arr[beg] != arr[end]){
    li $s4, -1
    j loop3
if:
    addi $s6, $s6, 1
    addi $s7, $s7, -1
    
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
