ORG 0x7c00 ; set starting point to address of byte 511
BITS 16 ; set architecture type so assembler only assembles 16 bit instructions

; start label
start:
    mov si, message ; move the address of the label message into the si register
    call print ; call the print function
    jmp $ ; endless loop jumping to it's own memory address

print:
    mov bx, 0 ; load the character the register is pointing to then increment it

.loop:
    lodsb
    cmp al, 0 ; compare the al register with 0 and continue if true
    je .done ; jump to the .done label (this label only applies to print due to the . operator)
    call print_char
    jmp .loop

.done:
    ret

print_char:
    mov ah, 0eh ; move value in ah register, and use the 0eh (print) command
    int 0x10 ; calling the bios routine
    ret

message: db 'Hello world!', 0 ; fill 510 bytes of data, or if we don't use all the memory space, fill the rest with 0
times 510-($ - $$) db 0 ; intel machines are little endian so the address will be reversed so the words don't get reversed
dw 0xAA55
