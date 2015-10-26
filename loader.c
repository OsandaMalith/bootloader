__asm__(".code16\n");
__asm__("jmpl $0x0000, $main\n");

void main() {
     __asm__ __volatile__("movb $'H' , %al\n");
     __asm__ __volatile__("movb $0x0e, %ah\n");
     __asm__ __volatile__("int  $0x10\n");

     __asm__ __volatile__("movb $'e' , %al\n");
     __asm__ __volatile__("movb $0x0e, %ah\n");
     __asm__ __volatile__("int  $0x10\n");

     __asm__ __volatile__("movb $'l' , %al\n");
     __asm__ __volatile__("movb $0x0e, %ah\n");
     __asm__ __volatile__("int  $0x10\n");

     __asm__ __volatile__("movb $'l' , %al\n");
     __asm__ __volatile__("movb $0x0e, %ah\n");
     __asm__ __volatile__("int  $0x10\n");

     __asm__ __volatile__("movb $'o' , %al\n");
     __asm__ __volatile__("movb $0x0e, %ah\n");
     __asm__ __volatile__("int  $0x10\n");

}
