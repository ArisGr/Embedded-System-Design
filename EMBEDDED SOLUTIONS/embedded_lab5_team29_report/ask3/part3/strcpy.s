.text
.align 4
.global strcpy
.type strcpy, %function

start:
	mov r2, r0 @save the address of the destination string
	sub r0, r0, #1 @for the inital store
	sub r1, r1, #1 @for the initial load
loop:
	ldrb r3, [r1,#1]! @auto-indexing addressing, r3=mem[r1+1],r1=r1+1 
	strb r3, [r0,#1]! @auto-indexing addressing, mem[r0+1]=r3,r0=r0+1, store even if null
	cmp r3, #0 @ if null exit
	bne loop
exit:
	mov r0, r2 @return the destination address
	bx lr 
