## David Krawchuk 
## 12/04/2013
## Linked Lists
##
## This program containis a group of functions that: create a list, insert a new node, 
##  and traverses and prints the contents of the to output. We will use a dummy head node.
##  That is, the first node in the list will not contain any valid data. With a dummy head 
##  node we never have to check whether $s0 and $s1 contain valid addresses.Register $s0 will
##  point to the head of the dummy node. $S1 will point to the tail of the dummy node. 
##  The list will be built around 8 byte nodes. The first four bytes contain the data we are 
##  storing. The second four bytes will contain the address of the next node. If there is not
##  next node, the second four bytes should contain 0.

## Begin .text Block ##
.text

## Begin createList: Block ##
# createList will do a syscall to allocate 8 bytes for the dummy head node. It will 
#  then set #both $s0 and $s1 to contain the address of the node.
#  By convention the conents of the memory pointed to by the head and tail nodes will 
#  contain the value zero.
#
# Used Registers :
#	$v0 = Loading system commands for system calls. 
#	      Returns address of newly allocated memory. 
#	$a0 = Register used to pass wanted amount of allocated BYTES from the heap.
#	$s0 = Register used as head of dummy node.
#	$s1 = Register used as tail of dummy node.

.globl createList
createList: 
li $v0, 9 		# Load system call 9 instruction into register $v0. Instruction 9 is the allocation instruction.
li $a0, 8		# Load register $a0 with the value 8; allocate 8 bytes from the heap.
syscall 		# Perform system call. Address returned in register $v0

# Load returned value into head and tail dummy node
move $s0, $v0		# Copy returned address from register $v0 into register $s0.
add $s1, $v0, 4		# Set tail pointer to point to head + 4 bytes.

# Store value zero in allocated memory address of head and tail pointer by convention.
sw $zero, 0($s0)
sw $zero, 0($s1)

# Return to caller.
jr $ra
end_CreateList:
## End createList Block ## 

## Begin insertTail Block ##
#insertAtTail:
# InsertAtTail assumes that $a0 contains the data that is to be inserted into the list. It should
#  start #by storing $a0 into a temp register. It should then do a syscall to obtain 8 bytes. It 
#  should #initialize these bytes to contain the data, and, since we are inserting at the tail, 0, 
#  in the next #field. Finally, it should splice this new node onto the tail of the list by storing
#  its address in the #previous node?s next location, and updating $s1 to point to this node.
#
# Used Registers : 
#	$a0 = Register used to pass data wanted to store into memory pointed to by head of node.
#	      Register used to pass how many bytes function wants to allocate from the heap.
#	$v0 = Register used to load alloc instruction.
# 	      Register returns address of newly allocated memory from the heap.
#	$t0 = Register used to temporarly hold parameter passed to function. (the int to be stored)
#	$s1 = Register represents the location in memory pointed to by the tail of the dummy node
#		that points to the memory location of the last node in the list.
#	$zero = Register represents the value zero. Used to set the default value of node.


.globl insertAtTail
insertAtTail:

move $t0, $a0 			# Move parameter from $a0 into temp register $t0. 

# Allocate memory from the heap.
li $v0, 9 			# Load alloc instruction. 
li $a0, 8			# Load 8-bytes from the heap.
syscall				# Perform system call.

# Initialization of allocated node.
sw $t0, 0($v0)			# Store parameter into head of node.
sw $zero, 4($v0)		# Store zero into tail of node by convention.

# Set addresses of previous node's tail and set dummy tail to new node's tail.
sw $v0, 0($s1)            	# Store address of allocated node head into dummy tail address.
la $s1, 4($v0)             	# Set register $s1 to allocated node head address.

# Return to caller.
jr $ra
end_InsertAtTail:
## End insertTail Block ##

## Begin traverse Block ##
# traverse:
# traverse should walk through the list, printing each integer.
# Registers used : 
# $s0 : Register points to start of list. Register belongs to dummy node HEAD.
# $s1 : Register points to the end of the list. Register belongs to dummy node TAIL.
# $t1 : Register is used first as a temporary memory address reference; then used to hold value stored 
#	in moemory location referenced by register $t1.

## Begin traverse Block ##
.globl traverse
traverse:

beq $s1, 0, end_traverse		# Break to end_traverse if tail of dummy node is equal to defalut value zero.
la $t1, 0($s0)				# Load address pointed to by dummy node head into temp. register $t1 to prepair 
					#  for transvering through the list.

### Begin Loop Block ### 
loop:

la $t1, 4($t1)				# Load the address stored at the memory address pointed to by ($t1 + 4 bytes) back into $t1.
beq $s1, $t1, end_loop			# Break if address in temp register $t1 points to the same address as the dummy tail node in $s1.				
lw $t1, 0($t1)				# Store the contents in the memory location pointed to by $t1 into $t1.			

li $v0, 1 				# Load the print integer command into register $v0.
lw $a0, 0($t1)				# Load the value from memory pointed to by register $t0 into register $a0.
syscall					# Perform system call and print value.

li $v0, 11				# Load the print character command into register $v0.
li $a0, ' '				# Load the space character into the argument register $a0.
syscall					# Perform sytem call and print the space between integer values.

j loop					# Return to the beginning of the loop block.

end_loop:
### End Loop Block ###

# Return to caller.
jr $ra
end_traverse:
## End traverse Block ##

## End .text Block ##