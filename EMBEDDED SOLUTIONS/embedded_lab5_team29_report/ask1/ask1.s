.text 
.global main

main:
	push {ip,lr}

start:

    mov r0, #1         @ stdout
 	ldr r1, =out_mes   @ message to write to output
  	mov r2, #mes_len   @ length of output message
  	mov r7, #4         @ write syscall
   	swi 0

	mov r0, #0      @ stdin
    ldr r1, =inp    @ location of inp_str in memory
    mov r2, #33     @ read 32 characters + \n from input
   	mov r7, #3      @ read syscall
  	swi 0

	mov r3, #0		@ r3 used to count how many characters we convert

	@ r1 now has the input characters, and we will load them to r0 to make the conversions 
	@ the converted values will be stored again in r1, and printed 


	cmp r0, #2					@ check if input is 1 character + \n 
	bne start_conversion   		@ if it is more than 1 character, we begin the conversion
	ldrb r0, [r1]				@ else if input is 1 character 
	cmp r0, #113				@ check if it is q
	beq exit					@ if it is q exit
	cmp r0, #81					@ else check if it is Q
	beq exit					@ if it is Q exit, else convert the character

start_conversion:
	add r3, #1			@ we convert a new character, increase r3
	cmp r3, #33			@ if r3 is 33, we have converted 32 characters (all the input)
	beq print			@ if so exit
	ldrb r0, [r1]		@ else load the input character to r0
	cmp r0,#10			@ if the character is \n, the conversion is over 
	beq print			@ and we print to output

@first checking if character is number
	cmp r0,#57			@ else check ascii number
	bgt check_capital	@ if ascii number is over 57, the character is not a number, check if it is a capital letter
	cmp r0,#48			 
	blt store_content   @ if ascii number is lower than 48, the character is not a number and not a letter, so we store it as it is


	cmp r0,#53					@ if it is a number, we compare it with number 5 	 
    subge r0, #5				@ if it is greater than 5, subtract by 5
	addlt r0, #5				@ if it is lower than 5, increase by 5
	strb r0, [r1], #1			@ store it
	b start_conversion			@ check next character


check_capital:
	cmp r0,#90			@ check ascii number
	bgt check_lower		@ if it is more over 90, the character is not a capital letter, check if it is a lower case letter
	cmp r0,#65			
	blt store_content	@ if ascii number is lower than 65, the character is not a number or a letter, so we store it

	add r0,r0,#32			@ if it is a capital letter, make it lower
	strb r0, [r1], #1		@ and store it
	b start_conversion		@ check next character


check_lower:
	cmp r0,#122			@ check ascii number
	bgt store_content	@ if it is more over 122, the character is not a number or a letter, so we store it
	cmp r0,#97	
	blt store_content	@ if ascii number is lower than 97, the character is not a number or a letter, so we store it

	sub r0,r0,#32				@ if it is a lower case letter, make it capital
	strb r0, [r1], #1			@ store it and check next character
	b start_conversion

store_content:
	strb r0, [r1], #1			@ store character and check next
	b start_conversion



print:

	cmp r3,#33			@ check if string had 32 characters
	bne continue		@ if not, continue	
	mov r0,#10			@ if yes, add the \n character to the end of the string and continue
	strb r0,[r1],#1
continue:
    mov r0, #1 					@ stdout
	ldr r1,=result_mes			@ "result is" message
	mov r2,#result_mes_len		@ length
    mov r7, #4 					@ write syscall
    swi 0


	mov r0, #1      @ stdout
   	ldr r1, =inp    @ converted input message to write to output
  	mov r2, r3      @ length 
   	mov r7, #4      @ write syscall
    swi 0

	cmp r3,#33			@ lastly, if input is more than 32 characters, read until buffe is empty
	beq bigger_than_32
	b start

	

bigger_than_32:
    mov r0, #0 		@ stdin 
    ldr r1, =inp 	@ buffer that stores input/converted string
    mov r2, #32 	@ read 32 characters
    mov r7, #3  	@ read syscall 
    swi 0
    
    cmp r0, #32 		@ check what we cleared
    bne start			@ if we cleared less than 32 bytes, everything is cleared
    ldrb r3, [r1, #31]	@ else if we cleared 32 bytes, check if the last was \n 
    cmp r3, #10			@ if so we are set
    bne bigger_than_32	@ else clear more

    b start

exit:
	pop {ip,lr}
    mov r7, #1      @ exit syscall
   	swi 0

.data
    out_mes: .ascii "Input a string of up to 32 chars long: " 
    mes_len = . - out_mes @ .- indicates the length of  out_mes
    inp: .ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0" @  33 bytes with null character for input string 
    result_mes: .ascii "Result is: "
    result_mes_len = . - result_mes
