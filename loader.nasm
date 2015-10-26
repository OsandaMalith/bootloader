%if 0; 
 * Title: A Simple Bootloader in NASM
 * Author: Osanda Malith Jayathissa (@OsandaMalith)
 * Website: http://OsandaMalith.wordpress.com
%endif; 	

	BITS 16

	jmp short _start	; Jump past disk description section
	nop	
	
; Disk description table, to make it a valid floppy
OEMLabel		db "OsandaOS"	; Disk label
BytesPerSector		dw 512		; Bytes per sector
SectorsPerCluster	db 1		; Sectors per cluster
ReservedForBoot		dw 1		; Reserved sectors for boot record
NumberOfFats		db 2		; Number of copies of the FAT
RootDirEntries		dw 224		
LogicalSectors		dw 2880		; Number of logical sectors
MediumByte		db 0F0h		; Medium descriptor byte
SectorsPerFat		dw 9		; Sectors per FAT
SectorsPerTrack		dw 18		; Sectors per track (36/cylinder)
Sides			dw 2		; Number of sides/heads
HiddenSectors		dd 0		; Number of hidden sectors
LargeSectors		dd 0		; Number of LBA sectors
DriveNo			dw 0		; Drive No: 0
Signature		db 41		; Drive signature: 41 for floppy
VolumeID		dd 12345678h	; Volume ID: any number
VolumeLabel		db "My First OS"; Volume Label: any 11 chars
FileSystem		db "FAT12   "	; File system type: don't change!


_start:
	mov ax, 07C0h		; move 0x7c00 into ax
	mov ds, ax			; set data segment to where we're loaded

	mov si, string	; Put string position into SI
	call print_string	; Call our string-printing routine

	jmp $			; infinite loop!

	string db "Welcome to @OsandaMalith's First OS :)", 0

print_string:		
	mov ah, 0Eh		; int 10h 'print char' function

.loop:
	lodsb			; load string byte to al
	cmp al, 0 		; cmp al with 0
	je .done		; if char is zero, ret
	int 10h			; else, print
	jmp .loop

.done:
	ret

	times 510-($-$$) db 0	; Pad remainder of boot sector with 0s
	dw 0xAA55				; The standard PC boot signature
