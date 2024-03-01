.global _start

N: 			.word	25	// input parameter n
P:			.space 4	// Pell number result

_start:
	ldr		A1, N		// get the input parameter
	bl		pell		// go!
	str		A1, P		// save the result
	
stop:
	b		stop

// Pell number calculation
// pre-- A1: Pell number index i to calculate, n >= 0
// post- A1: Pell number P = pell(n)
pell:
	PUSH {V1, V2, LR}
	// your code starts here
	MOV A2, #0 // seed1 = 0
	MOV A3, #1 // seed2 = 1
	MOV A4, #0 // sum
	MOV V1, #2 // Instantiate index (starts at 2 since we checked 2 base cases)
	CMP A1, #0 // Check if n = 0
	BEQ _end // Branch to _end if condition is met
	CMP A1, #1 // Check if n = 1
	BNE _iter // Branch to iter if condition is not met
	MOV A4, #1 // Set sum to 1
	B _end // If we make it to this point, then exit function
	  
_iter:
	CMP V1, A1  // Check if index <= n
	BGT _end // Branch out of loop if condition is not met
	MOV V2, #2 // Move value 2 into register
	MLA A4, V2, A3, A2 // sum = 2 * seed2 + seed1
	MOV A2, A3 // seed1 = seed2
	MOV A3, A4 // seed2 = sum
	ADD V1, V1, #1 // index++
	B _iter // Branch back to start of loop body
	
_end:
	MOV A1, A4 // Return sum
	POP {V1, V2, LR}
	BX LR