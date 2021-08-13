		AREA prog, CODE, READONLY
		ENTRY
			
letter	EQU	0x40			;to check if character is a letter
lower	EQU 0x60			;to check if character is lowercase	
		
		LDRB R12, EoS		;Set R12 as end of string value 		
		ADR R4,STRING   	;Set R4 as address of the first character
		
		B Length            ;calculate the length of string  
notEnd	ADD R3,R3,#1	 	;r3 counts how long the string is
Length	LDRB R2,[R4,R3]  	;use r2 as the current character
		CMP R2,R12	  		;compare current char to string terminator
		BNE notEnd		  	;if its not null, continue to count 
			
		SUB R3,R3,#2		;adjust R3 so it is pointing to last character
		
							;R1 and R3 are now pointing to opposite ends of the string
		
notLetL	LDRB R5,[R4,R1]		;load character on left end
		CMP R5,#letter		;check if it is a letter
		ADDLT R1,R1,#1		;if its not a letter move to the next character	
		BLT notLetL			;Check if the new character on left end is a letter
		
		CMP R5,#lower		;check if it is a lowercase letter
		SUBGT R5,R5,#32		;if it is a lowercase, turn it into uppercase
		
		
notLetR	LDRB R9,[R4,R3]		;load character on right end
		CMP R9,#letter		;check if it is a letter 
		SUBLT R3,R3,#1		;if it is not a letter, move to the next character
		BLT notLetR			;check if the new character on right end is a letter
		
		CMP R9,#lower		;check if it is a lowercase letter
		SUBGT R9,R9,#32		;if it is a lowercase, turn it into uppercase
		
		
		CMP R5,R9			;compare the characters at opposite ends
		BNE NotPal			;if the characters are not equal, it is not a palindrome
		CMP	R1,R3			;compare the locations of characters
		ADDNE R1,R1,#1		;if they are not equal yet, get next character on left end 	
		SUBNE R3,R3,#1		;get next character on right end
		BNE notLetL			;compare the next characters
		BEQ IsPal			;if they are equal, it is a palindrome
		
NotPal	MOV R0,#0			;string is not a palindrome
loop	B	loop			;infinite loop to stop program
IsPal	MOV R0,#1			;string is a palindrome
		
			
Loop	B Loop				;infinite loop to stop program

	  	
EoS	DCB 0x00								;End of string
STRING 	DCB "Red rum, sir, is murder", EoS  ;string


		END