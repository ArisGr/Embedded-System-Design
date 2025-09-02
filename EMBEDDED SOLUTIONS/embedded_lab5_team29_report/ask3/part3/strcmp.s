.text
.align 4 
.global strcmp
.type strcmp, %function 

start:
	push {r4}
	sub r0, r0, #1 @for the inital load
	sub r1, r1, #1 @for the initial load

loop:
	ldrb r2, [r0,#1]! @auto-indexing addressing, r2=mem[r0+1],r0=r0+1 
	ldrb r3, [r1,#1]! @auto-indexing addressing, r3=mem[r1+1],r1=r1+1
	cmp r2,r3 
	beq equal
	blt less
	mov r4, #1 @if the value isnt the same or less then it is greater so exit with 1 
	b exit

equal:
	cmp r2, #0 @since they are equal then r3 = #0 so exit with 0 
	bne loop
	mov r4, #0
	b exit

less:
	mov r4, #0xffffffff @exit with -1 since the value of the first arg is less than the value of the second
	b exit
	
exit:
	mov r0, r4
	pop {r4}
	bx lr
