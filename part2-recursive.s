.global _start

N: 			.word	5	// input parameter n
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
      // your code starts here
	  PUSH {V1, V2, LR}
	  CMP A1, #1 // Check if n = 1 (1st base case)
	  BNE _if // Branch if condition not satisfied
	  MOV A1, #1
	  B _end
	  
_if:
	CMP A1, #0 // Check if n = 0 (2nd base case)
	BNE _rec // Branch if condition not satisfied
	MOV A1, #0
	B _end

_rec:
	SUB A1, A1, #1 // n = n - 1
	MOV V1, A1 // Save n in V1
	MOV V2, V1 // Save n-1 in V2
	SUB V2, V2, #1 // New value n-2
	BL pell // Recursively call pell with n-1
	LSL A1, #1 // Multiply the result by 2
	MOV V1, A1 // Move res for 2 * n-1 into V1
	MOV A1, V2 // Move n-2 into argument position
	PUSH {V1} // Save result for pell(n-1)
	BL pell // Recursively call pell with n-2
	MOV V2, A1 // Move res for n-2 into V2
	POP {V1} // Pop result for pell(n-1)
	ADD V1, V1, V2 // Add results
	MOV A1, V1 // Move result into A1
	  
_end:
	POP {V1, V2, LR}
	BX LR