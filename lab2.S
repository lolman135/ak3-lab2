.global lab2
.syntax unified

#define A #12
#define B #10
#define C #4

lab2:	
	// link register to stack
	push {lr}
	
	// Write A to r0
	mov r0, A
	// Write B to r1
	mov r1, B
	// Write C to r2
	mov r2, C

	// Run calculations
	bl calculate
	
	// End of program
	pop {pc}

calculate:
	// Saving r4, r5 and link register to stack
	push {r4, r5, lr}
	
	// step 1: (a & b)
	and r3, r0, r1

	// step 2: Logical shift (a & b)>> by one sign
	lsr r3, r2, #1

	// Preparing r4 and r5 for calculating factorial
	// r4 contains result of calculation, r5 is counter
	mov r4, #1 // Result
	mov r5, r2 // Counter

fuctorial:
	// Check number of iteration
	cmp r5, #1
	// If r5 equals 1 or less - jump to factorial_done
	ble factorial_done
	
	// Counting factorial. Multiply r4 and r5. r4 contains result
	// r4 contains 1, and r5 is containing last number in factorial sequence
	// so 1*2*..*n == n*(n-1)*..*1
	mul r4, r4, r5
	// Decrementing counter
	subs r5, r5, #1
	
	// Looping calculation
	b factorial

	
fuctorial_done:
	// Writing result to r0
	add r0, r3, r4 
	// Restore r4, r5 and return from function
	pop {r4, r5, pc}
