/*
 * Title: A Simple Bootloader in AT&T Assembly
 * Author: Osanda Malith Jayathissa (@OsandaMalith)
 * Website: http://OsandaMalith.wordpress.com
 */        
        .code16
        .section .text
        .global main
main:

/* 
        Disk description table, to make it a valid floppy
        FAT12 file system format
*/
        jmp _start
        .byte   144             #NOP 
        .ascii  "OsandaOS"      #OEMLabel               
        .word   512             #BytesPerSector           
        .byte   1               #SectorsPerCluster        
        .word   1               #ReservedForBoot           
        .byte   2               #NumberOfFats             
        .word   224             #RootDirEntries (224 * 32 = 7168 = 14 sectors to read)          
        .word   2880            #LogicalSectors             
        .byte   0xf0            #MediumByte               
        .word   9               #SectorsPerFat            
        .word   18              #SectorsPerTrack          
        .word   2               #Sides                    
        .long   0               #HiddenSectors              
        .byte   0               #LargeSectors           
        .byte   0               #DriveNo                                   
        .byte   0x29            #Signature (41 for Floppy)
        .long   0x12345678      #VolumeID
        .ascii  "My First OS"   #VolumeLabel
        .ascii  "FAT12   "      #FileSystem

_start:
        movw $0, %ax
        movw %ax, %ss
        movw %ax, %ds
        movw %ax, %es
        movw $string, %si
loop:
        movb    $0xe, %ah
        movb    (%si), %al
        cmpb    $0, %al
        je      done
        int     $0x10
        addw    $1, %si
        jmp     loop
done:
        jmp     done            #infinite loop

string:
        .ascii  "Welcome to @OsandaMalith's First OS :)"
        .byte 0

        .fill 0x1fe - (. - main) ,1,0   #Pad remainder of boot sector with 0s
        .word   0xaa55                  #The standard PC boot signature
