   .text
   .globl main
   main:
   jal createList
   li $a0, 1
   jal insertAtTail
   li $a0, 2
   jal insertAtTail
   li $a0, 5
   jal insertAtTail
   
   li $a0, 1
   jal insertAtTail
   li $a0, 2
   jal insertAtTail
   li $a0, 5
   jal insertAtTail
   
   li $a0, 1
   jal insertAtTail
   li $a0, 2
   jal insertAtTail
   li $a0, 5
   jal insertAtTail
   
   li $a0, 1
   jal insertAtTail
   li $a0, 2
   jal insertAtTail
   li $a0, 5
   jal insertAtTail

   li $a0, 1
   jal insertAtTail
   li $a0, 2
   jal insertAtTail
   li $a0, 5
   jal insertAtTail
   
   li $a0, 1
   jal insertAtTail
   li $a0, 2
   jal insertAtTail
   li $a0, 5
   jal insertAtTail
   
   li $a0, 1
   jal insertAtTail
   li $a0, 2
   jal insertAtTail
   li $a0, 5
   jal insertAtTail
         
   jal traverse
   # Exit the program nicely
   li $v0, 10
   syscall
