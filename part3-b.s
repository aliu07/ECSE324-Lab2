.global _start


Stuff:		.byte -3,-2,1,0 // input array
			.space 0	// to align next word
N: 			.word 4	// number of elements in Stuff
Sorted:		.space 3	// (optional) sorted output
			.space 1	// to align next word

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
	// INSERTION SORT
	// your code starts here
	MOV A3, #1 // Instantiate index i = 1
	
_forLoop: 
	CMP A3, A2 // Check i < n
	BGE stop // If condition is not met, break
	LDRSB V1, [A1, A3] // Fetch stuff[i] => key = arr[i]
	MOV A4, A3 // Make copy of index i into A4
	SUB A4, A4, #1 // Instantiate j = i - 1
	
_whileLoop:
	CMP A4, #0 // Check j >= 0
	BLT _endForLoop // If condition is not met, break
	LDRSB V2, [A1, A4] // Fetch stuff[j] and store into V2
	CMP V2, V1 // Check stuff[j] > key
	BLE _endForLoop // If condition is not met, break
	ADD A4, A4, #1 // j = j + 1
	STRB V2, [A1, A4] // stuff[j+1] = stuff[j]
	SUB A4, A4, #2 // j = j - 2... decrement by 2 because we incremented by 1 to find offset j+1 and we have to decrement AGAIN after
	B _whileLoop // Go to next iteration

_endForLoop:
	ADD A4, A4, #1 // j = j + 1
	STRB V1, [A1, A4] // stuff[j+1] = key
	ADD A3, A3, #1 // i++
	B _forLoop // Go to next iteration