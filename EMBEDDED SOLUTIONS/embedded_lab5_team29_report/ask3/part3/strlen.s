.text
.align 4 
.global strlen
.type strlen, %function 

start:
	@r0 is the address of the string

	sub r0, r0, #1 @now ro is the address of the previous byte of the string
	mov r2, #0 @initialize counter 

loop:
	ldrb r1, [r0,#1]! @auto-indexing addressing, r1=mem[r0+1],r0=r0+1 
	cmp r1, #0 @if r1 is the null character you should exit 
	beq exit
	add r2, r2, #1 @if it isnt null then add to the counter 
	b loop @loop until null

exit: 
	mov r0, r2
	bx lr 
