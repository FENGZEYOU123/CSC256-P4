.data
    endl:    .asciiz  "\n"   # used for cout << endl;
    sumlbl:    .asciiz  "Sum: " # label for sum
    revlbl:    .asciiz  "Reversed Number: " # label for rev
    pallbl:    .asciiz  "Is Palindrome: " # label for isPalindrome
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

# sum            --> $s0
# rev            --> $s1
# num            --> $s2
# isPalindrome   --> $s3
# address of arr --> $s4
# i              --> $s5
# beg            --> $s6
# end            --> $s7
# d              --> $t0
# 10             --> $t1
# 100            --> $t3
main:
    li $s0, 0       #int sum = 0;
    li $s5, 1       #int i = 1
    li $t3, 100
    li $t1, 10
loop:
    bge $s5, $t3, loop2        #i <= 100
    add $s0, $s0, $s5          #sum = sum + i
    addi $s5, $s5, 1           #i++
    j loop

    li $s2, 45689   #int num = 45689
    li $s1, 0       #int rev = 0
    li $t0, -1      #int d = -1

    ble $s2, 0, loopThree   #( num > 0)
loopTwo:

    rem $t0, $s2, $t1   #d = num % 10

    mul $t4, $s1, $t1   # store in t4 rev*10
    add $s1, $t4, $t0   #rev = rev*10 + d
    div $s2, $s2, $t1   #num = num / 10
    j loopTwo

    li $s6, 0       #int beg = 0
    li $s7, 8       #int end = 8
    li $s3, 1       #int isPalindrome = 1
    la $s4, arr     #address for array

    bge $s6,$s7, exit #while(beg < end)

loopThree:

    lw $s6, 0
    lw $s7, 8
    sll $t5, $s6, 4
    add $t5, $t5, $s4
    lw $t6, 0($t5)

    sll $t7, $s7, 4
    add $t7, $t7, $s4
    lw $t8, 0($t7)

    ble $t6, $t8,if    # if (arr[beg] != arr[end]){
    li $s3, -1
    j loopThree
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
