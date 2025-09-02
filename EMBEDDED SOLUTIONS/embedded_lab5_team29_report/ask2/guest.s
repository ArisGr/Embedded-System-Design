.text
.global main
.extern tcsetattr

main:

open:
    ldr r0, =serial_port    @ serial_port name  
    ldr r1, =#258           @ O_RDWR | O_NOCTTY  
    mov r7, #5              @ open syscall  
    swi 0

    mov r6, r0              @ save fd from r0, will be needed to read/write 

setup:
    mov r0, r6              @ call tcsetattr to set the settings for our port  
    ldr r2, =options
    mov r1, #0
    bl tcsetattr

read:
    mov r0, r6              @ read from fd stored in r6  
    ldr r1, =input          @ our 64 byte input array
    mov r2, #64
    mov r7, #3              @ read syscall
    swi 0

    ldr r0, =input          @ r0 has the input string loaded, and will be used to check all characters
    ldr r1,=freq_array      @ r1 has the frequency array loaded, and will be used to update the frequencies
calculate_freq:
    ldrb r2, [r0], #1       @ get  ascii code of character, and increase address by 1 for next iteration
    cmp r2, #10             @ if character is \n, we have scanned all of the input characters
    beq freq_calculated     @ if so, check which character is the most frequent
    ldrb r3, [r1,r2]        @ else load the frequency of ascii character in r2, from frequency array r1 
    add r3,r3,#1            @ increase its frequency by 1
    strb r3, [r1,r2]        @ store the increased value back
    b calculate_freq        @ repeat for next iteration

freq_calculated:
   mov r0, #0           @ r0 will store max, current_max = 0
   ldr r1,=freq_array   @ r1 has the frequencies again
   mov r2,#33           @ r2 is the offset used to parse the frequency array, we begin by character with ascci code 33
                        @ because all the previous characters are not printable
   
find_max:
   ldrb r3, [r1,r2]     @ get frequency with offset r2 (initially 33 = character '!')
   cmp r0,r3            @ compare the frequency of the character with the max frequency until now
   movlt r0,r3          @ if we found new max, update r0  with the max frequency  
   movlt r4, r2         @ and store the ascii code of the most frequent char in r4
   add r2,r2,#1         @ increase r2 for next iteration
   cmp r2,#256          @ if we've checked all 256 ascii characters
   beq all_calculated   @ we can exit the function
   b find_max           @ else repeat for next iteration

all_calculated:
  ldr r1,=output        
  strb r4, [r1]         @ store ascii code of most frequent character in output[0]
  strb r0, [r1,#2]      @ store the value of frequency (+48 because we initialized with freq_array with 0) in output[2]
                        @ we subtract by 48 to get the number at the host
	
	

write:
    mov r0, r6
    ldr r1, =output
    ldr r2, =output_len
    mov r7, #4          @ write system call  
    swi 0

close:
    mov r0, r6          
    mov r7, #6          @ close system call  
    swi 0

exit:
    mov r0, #0
    mov r7, #1          @ exit system call  
    swi 0

.data
    options: .word 0x00000000 @ c_iflag  
             .word 0x00000000 @ c_oflag  
             .word 0x000008bd @ c_cflag  
             .word 0x00000002 @ c_lflag  
             .byte 0x00       @ c_line  
             .word 0x00000000 @ c_cc[0-3]  
             .word 0x00010000 @ c_cc[4-7]  
             .word 0x00000000 @ c_cc[8-11]  
             .word 0x00000000 @ c_cc[12-15]  
             .word 0x00000000 @ c_cc[16-19]  
             .word 0x00000000 @ c_cc[20-23]  
             .word 0x00000000 @ c_cc[24-27]  
             .word 0x00000000 @ c_cc[28-31]  
             .byte 0x00       @ padding  
             .hword 0x0000    @ padding  
             .word 0x0000000d @ c_ispeed  
             .word 0x0000000d @ c_ospeed  

    serial_port: .asciz "/dev/ttyAMA0"

    input: .ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
    freq_array: .ascii "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
    output: .asciz "0000\n"
    output_len = . - output
