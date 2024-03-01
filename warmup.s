.global _start

//     int a[4] = {1, 2, 3, 4};
matrixA: .word 1, 2, 3, 4
lengthA: .word 4


//     int b[8] = {2, 3, 5, 7, 11, 13, 17, 19};
matrixB: .word 2, 3, 5, 7, 11, 13, 17, 19
lengthB: .word 8

// we’ll save our results here
results: .space 8

// Summation
// Sum the integers in the given array
//  pre-- A1: address of array
//  pre-- A2: length of array
//  post- A1: sum of elements
sum:
	// **you** push any registers used below onto the stack
	PUSH {V2} // Idk why we don't push the index as well
	// int answer = 0;
	// for (int index=0; index<length; index++)
	// **you** answer=0
	MOV A3, #0
	// **you** index=0
	MOV A4, #0

sumIter:
	// **you** index<length?
	CMP A2, A4 // CMP stores value of A2 - A3 in a special register...
	// **you** if not, branch to sumDone
	BLE sumDone // BLE compares A2 - R1 to constant 0
	// answer += array[index];
	// **you** read the element at index in the array
	LDR V2, [A1, A4, LSL #2] // A4
	// **you** accumulate the answer
	ADD A3, V2, A3
	// **you** index++
	ADD A4, A4, #1
	// repeat until done!
	B 	sumIter

sumDone:
	// **you** move the final answer into A1
	MOV A1, A3
    // **you** pop any registers pushed above
	POP {V2}
	// return!
	BX LR

_start: 
//     int a_s = sum((int *) a, 4); // 10
	LDR	A1, =matrixA  // put the address of A in A1
	LDR	A2, lengthA   // put the length of A in A2
	BL	sum           // call the function
	LDR	V1, =results  // put the address of Results in V1
	STR   A1, [V1]      // save the answer (in A1) in result+0

//     int b_s = sum((int *) b, 8); // 77
	// **you** put the address of B in A1 
	LDR A1, =matrixB
	// **you** put the length of B in A2
	LDR A2, lengthB
	// **you** call the function
	BL sum
	// **you** save the answer (in A1) in result+4
	STR A1, [V1, #4]

inf: 
	B 	inf     // infinite loop!
