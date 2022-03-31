[BITS 16]
[ORG 0x7c00]

corVermelha db 0x04

call Segmentos
call Modo_Video_VGA
mov si, texto
call Mostrar_Texto

mov si, texto2
call Mostrar_Texto
call Pressionar_Enter
jmp $

Segmentos:
    mov ax, es
    mov ds, ax
    mov ss, ax
ret

Modo_Video_VGA:
    mov ah, 0x00
    mov al, 0x13
    int 0x10
    mov ax, 0x13
ret

Mostrar_Texto:
    mov ah, 0x0e
    mov bl, [corVermelha]
    mov al, [si]
    loop_texto:
        int 0x10
        inc si
        mov al, [si]
        cmp al, 0
        jne loop_texto
ret

Pressionar_Enter:
    mov ah, 0x00
    int 0x16
    cmp al, 0x0d
    je Reinciar
    jmp Pressionar_Enter

Reinciar:
    db 0x0ea
    dw 0x0000
    dw 0xffff

texto db 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, "MrEmpy MBR Overwrite", 13,10, 0
texto2 db 10,10, "This is just a test about MBR I did.", 13, 10, "Thanks for testing ;)", 0

times 510 - ($-$$) db 0
dw 0xaa55