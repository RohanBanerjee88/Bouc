.global _start           // Define the entry point

_start:
    // Disable interrupts
    msr DAIFSet, #0b111   // Mask (disable) all interrupts

    // Set the stack pointer (SP)
    ldr x0, =stack_top    // Load address of the top of the stack
    mov sp, x0            // Set the stack pointer to the top of the stack

    // Clear the .bss section (zero out uninitialized variables)
    ldr x1, =_bss_start   // Start of the .bss section
    ldr x2, =_bss_end     // End of the .bss section
    mov x3, 0             // Zero value
clear_bss:
    cmp x1, x2            // Check if we've reached the end
    b.ge bss_done         // If greater or equal, we are done
    str x3, [x1], #8      // Store zero, increment pointer
    b clear_bss           // Repeat for the next address
bss_done:

    // Call the main function
    bl main               // Branch with link to `main`

    // If `main` ever returns, halt the system
halt:
    wfi                   // Wait for interrupt (low-power mode)
    b halt                // Stay in an infinite loop

// Define the stack memory (aligned to 16 bytes)
.section .bss
.balign 16
stack:
    .space 4096           // Allocate 4KB for the stack
stack_top:

// Declare the .bss section for uninitialized data
_bss_start:
_bss_end: