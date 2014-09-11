@ Blinking an LED off a GPIO

@ This program will blink an LED on GPIO <67>
@ Blinking responds to button input on GPIO <73>
@ 
@
@ LED to blink on and off:
@	1 time after the pushbutton is pressed the first time,
@	2 times after the 2nd button press,
@	3 times after the 3rd button press,
@	4 times after the 4th button press, 
@	5 times after the 5th button press. 
@	reset counter
@
@ Uses registers R0-4, R6-R8, R12
@ Original by Jeffrey Whissen, 6/07/2013

.text
.global _start
_start:

.EQU GPCR2, 0x40E0002C			@Clear Register address for GPIO <64:95>
.EQU GPDR2, 0x40E00014			@Direction Register address for GPIO <64:95>
.EQU GPDR0, 0x40E0000C			@Direction Register address for GPIO <0:31>
.EQU GRER0, 0x40E00030			@Rising Edge register address for GPIO <0:31>
.EQU GEDR0, 0x40E00048			@Edge Detect register address for GPIO <0:31>
.EQU GPSR2, 0x40E00020			@Set Register address for GPIO <64:95>
.EQU ICMR, 0x40D00004

@Load registers with info on GPIO and LED to use
		LDR R0, =GPCR2			@Write a 1 to bit 3 in GPCR2 at 0x40E0002C, so GPIO<67> low when output
		LDR R1, [R0]
		ORR R1, R1, #8
		STR R1, [R0]
		LDR R0, =GPDR2			@Write a 1 to bit 3 in GPDR2 at 0x40E00014, to make GPIO<67> an output
		LDR R1, [R0]
		ORR R1, R1, #8
		STR R1, [R0]
		LDR R0, =GPDR0			@Write a 0 to bit 9 in GPDR0 at 0x40E0000C, to make GPIO <73> an input
		LDR R1, [R0]
		LDR R2, =0x200
		BIC R1, R1, R2
		STR R1, [R0]
		LDR R0, =GRER0			@Write a 1 to bit 9 in GRER0 at 0x40E00030, to detect rising edge on GPIO<73>
		LDR R1, [R0]
		ORR R1, R1, R2
		STR R1, [R0]
		LDR R0, =0x40D00004		@Write a 1 to bit 10 in ICMR at 0x40D00004, to unmask IP<10>
		LDR R1, [R0]
		ORR R1, R1, #0x400
		STR R1, [R0]
		MOV R0, #0x18			@Hook IRQ vector and install INT_DIRECTOR procedure address
		LDR R1, [R0]
		LDR R2, =0xFFF
		AND R1, R1, R2
		ADD R1, R1, #0x20
		LDR R2, [R1]
		STR R2, BTLDR_IRQ_ADDRESS
		LDR R0, =INT_DIRECTOR
		STR R0, [R1]
		MRS R0, CPSR			@Write a 0 to bit 7 in CPSR
		BIC R0, R0, #0x80
		MSR CPSR_c, R0
		
LOOP:	NOP						@Wait for Interrupt
		B LOOP		
		
INT_DIRECTOR:					@Store Registers that get used
		STMFD SP!, {R0-R4,LR}
		LDR R0, =0x40D0000		@Check for Interrupt
		LDR R1, [R0]
		TST R1, #0x400
		BNE PASSON
		LDR R0, =GEDR0			@Check if 1 in bit 9 in GEDR0, means GPIO<13> asserted
		LDR R1, [R0]
		LDR R2, =0x200
		TST R1, R2
		BNE BUTTON_SVC
		
PASSON:	LDMFD SP!, {R0-R4,LR}	@Load back Registers that were used
		LDR PC, BTLDR_IRQ_ADDRESS
		
BUTTON_SVC:						@Reset GEDR0 bit 13 and BLINKS
		BIC R1, R2
		STR R1,[R0]
		STMFD SP!, {R0-R4,LR}
		BL BLINKS
		LDMFD SP!, {R0-R4,LR}
		SUBS PC, LR, #4

BLINKS:	LDR R0, =COUNTER
		LDR R3, [R0]
		CMP R3, #5
		MOVEQ R3, #0
		ADD R3, R3, #1
		STR R3, [R0]
BLINKING:
		SUBS R3, R3, #1
		STMFD SP!, {R0-R4,LR}
		BLPL BLINK
		LDMFD SP!, {R0-R4,LR}
		CMP R3, #0
		BNE BLINKING
		MOV PC, LR
		
BLINK:	STMFD SP!, {R0-R4,LR}
		LDR R1, =GPSR2
		BL TIMER
		LDR R0, [R1]
		ORR R0, R0, #8
		STR R0, [R1]
		BL TIMER
		LDR R1, =GPCR2
		LDR R0, [R1]
		ORR R0, R0, #8
		STR R0, [R1]
		LDMFD SP!, {R0-R4,LR}
		MOV PC, LR
		
TIMER:  LDR R4,=250000000
DELAY:	SUBS R4, R4, #1
		BNE DELAY
		MOV PC, LR
		
		NOP
	
	
	
BTLDR_IRQ_ADDRESS:	.word 0x0		@store 
COUNTER:			.word 0x0		@counter for num of blinks	
	
.end
