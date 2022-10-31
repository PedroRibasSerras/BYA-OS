all: clean kernel.bin bootloader.bin os-image
	sudo dd if=os-image of=/dev/sdc1 obs=1 conv=notrunc seek=0

clean:
	touch bootloader.brm kernel.brm os-imagrm
	rm bootloader.b* kernel.b* os-imag*


kernel.bin:
	nasm kernel/kernel.asm -f bin -o kernel.bin

bootloader.bin:
	nasm bootloader/bootloader.asm -f bin -o bootloader.bin

os-image: bootloader.bin kernel.bin
	cat bootloader.bin kernel.bin > os-image