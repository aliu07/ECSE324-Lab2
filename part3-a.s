.global _start


Stuff:		.byte -3,-2,1,0 // input array
			.space 0	// to align next word
N: 			.word 4	// number of elements in Stuff
Sorted:		.space 4	// (optional) sorted output
			.space 0	// to align next word

_start:
	ldr		A1, =Stuff	// get the address of Stuff
	ldr		A2, N		// get the number of things in Stuff
	bl		sort		// go!
	
stop:
	b		stop

// Sorting algorithm
// pre-- A1: Address of array of signed bytes to be sorted
// pre-- A2: Number of elements in array
// post- A1: Address of sorted array
sort:
	// BUBBLE SORT
	// your code starts here
	MOV A3, #0 // Instantiate index i
	
_iter1:
	MOV V1, A2 // Make copy of length n
	SUB V1, V1, #1 // Compute n - 1
	CMP A3, V1 // Check i < n - 1
	BGE stop // If condition is not met, break from loop
	MOV A4, #0 // Instantiate index j
	MOV V2, V1 // Move n-1 value stored in V1 into V2
	SUB V2, V2, A3 // Compute n-i-1
	
_iter2:
	CMP A4, V2 // Check j < n-i-1
	BGE _endIter1 // If condition is not met, branch
	LDRSB V3, [A1, A4] // Fetch stuff[j]
	ADD A4, A4, #1 // j = j + 1
	LDRSB V4, [A1, A4] // Fetch stuff[j + 1]
	CMP V3, V4 // Check stuff[j] > stuff[j+1]
	BLE _iter2 // If condition is not met, run next iteration of nested loop
	MOV V5, V3 // temp = stuff[j]
	SUB A4, A4, #1 // Restore index j from j+1 back to j
	STRB V4, [A1, A4] // stuff[j] = stuff[j+1]
	ADD A4, A4, #1 // j = j + 1... don't need to sub again since we have to increment this index anyways
	STRB V5, [A1, A4] // stuff[j+1] = temp
	B _iter2 // Go to next iteration of nested loop
	
_endIter1:
	ADD A3, A3, #1 // i++
	B _iter1 // Go to next iteration of outer loop