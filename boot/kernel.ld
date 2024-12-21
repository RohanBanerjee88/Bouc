/* Linker script for Raspberry Pi 4 */

ENTRY(_start)              /* Entry point, matches _start in start.S */

SECTIONS {
    /* Place the text (code) section at 0x80000 */
    . = 0x80000;

    .text : {
        *(.text)           /* All .text sections from object files */
    }

    .rodata : {
        *(.rodata)         /* Read-only data (e.g., string literals) */
    }

    .data : {
        *(.data)           /* Initialized global/static variables */
    }

    .bss : {
        _bss_start = .;    /* Mark the start of the BSS section */
        *(.bss)            /* Uninitialized global/static variables */
        _bss_end = .;      /* Mark the end of the BSS section */
    }

    /* Stack memory at the end of our allocated sections */
    . = . + 0x1000;        /* Reserve 4KB for the stack */
    _stack_top = .;        /* Mark the top of the stack */
}