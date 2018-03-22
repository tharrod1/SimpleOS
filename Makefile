all: os-image

run: all
	bochs
os-image: boot_sect.bin kernel.bin
	cat $^ > os-image
#Build the kernel binary 
kernel.bin: kernel_entry.o kernel.o 
	ld -o kernel.bin -Ttext 0x1000 $^ --oformat binary
# Build the kernel object file 
kernel.o : kernel.c 
	gcc -ffreestanding -c $< -o $@
# Build the kernel entry object file. 
kernel_entry.o : kernel_entry.asm 
	nasm $< -f elf -o $@
boot_set.bin : boot_sect.asm
	nasm $< -f bin -I -o $@
clean:
	rm -fr *.bin *.o *.dis os-image *.map
kernel.dis : kernel.binary
	ndisass -b 32 $< > $@



