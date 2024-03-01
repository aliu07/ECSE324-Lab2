.global _start

N: .word 12
Numbers: .short 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13
Primes: .space 24

_start:
    // your code starts here
    LDR R0, N
    LDR R1, =Numbers
    LDR R2, =Primes
	MOV R3, #0 // num = 0
	MOV R4, #0 // pri = 0
	MOV R5, #1 // prime = 1
	MOV R6, #0 // done = false
	
while1:
	CMP R6, #1
	BEQ end
	SUB R3, R5, #1 // num = prime - 1
	
while2:
	CMP R3, R0 // Check if num < n... if not, branch to if
	BGE ifBlock
	MOV R8, R3, LSL #1 // Compute offset
	LDRH R7, [R1, R8] // Fetch numbers[num]
	CMP R7, #0 // Check if numbers[num] == 0... if not, branch to ifBlock
	BNE ifBlock
	ADD R3, R3, #1 // num++
	B while2
	
ifBlock: 
	CMP R3, R0 // Check if num < n... if not, branch to else
	BLT elseBlock
	MOV R6, #1 // done = true
	B while1

elseBlock:
	MOV R8, R3, LSL #1 // Find offset
	LDRH R5, [R1, R8] // prime = numbers[num]
	MOV R8, R4, LSL #1 // Find offset
	STRH R5, [R2, R8] // LSL by 1 i.e. multiply by 2 since we have shorts
	ADD R4, R4, #1 // pri++
	
while3:
	CMP R3, R0
	BGE while1
	MOV R9, #0 // Need to move constant 0 to R
	MOV R8, R3, LSL #1 // Find offset
	STRH R9, [R1, R8]
	ADD R3, R3, R5
	B while3
	

end:
	MOV R0, #0 // Return with exit code 0
	B inf
	
inf:
	B inf
