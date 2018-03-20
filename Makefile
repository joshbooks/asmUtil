%.o: %.asm
	nasm -f elf64 $*.asm -o $*.o
%: %.o
	ld $*.o -o $*
