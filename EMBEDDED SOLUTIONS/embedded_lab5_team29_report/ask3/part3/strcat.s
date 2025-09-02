.text
.align 4 
.global strcat
.type strcat, %function 

start:
	mov r2, r0 @save the destination address
	sub r0, r0, #1 @for the inital load
	sub r1, r1, #1 @for the initial load

end_of_dst:
	ldrb r3, [r0, #1]! @auto-indexing addressing, r3=mem[r0+1],r0=r0+1, load destination char 
	cmp r3, #0 
	bne end_of_dst @you didnt find the end so loop
loop:
	ldrb r3, [r1, #1]! @auto-indexing addressing, r3=mem[r1+1],r1=r0+1, load src char
	strb r3, [r0], #1 @post-index addressing, mem[r0]=r3, r0 = r0+1, store the src char to the dest string end
	cmp r3, #0
	bne loop @you didnt find the end of src string so loop

exit:
	mov r0, r2 @return dest address
	bx lr
	 
	
	
