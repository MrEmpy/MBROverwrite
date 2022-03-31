CC = gcc

all:
	nasm -f bin message.asm -o message.bin
	$(CC) -static mbroverwrite.c -o mbroverwrite

clean:
	rm message.bin mbroverwrite
