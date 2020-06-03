data segment
    str1 db "Soy una cadena de texto", '$'
    ; 13 -> Retorno de carro
    ; 10 -> Nueva linea
    brake db 13, 10, '$'
ends
stack segment
    dw 128 dup(0)
ends
code segment
    printChar MACRO char 
        mov ah, 02h
        mov dl, char
        int 21h ; dl <- caracter a imprimir
    ENDM 

    printString MACRO string 
        mov ah, 09h
        mov dx, offset string
        int 21h ; dx <- inicio de cadena de caracteres
    ENDM 
    
    exitApp PROC
        mov ax, 4c00h
        int 21h
    ENDP
    
    start:
        mov ax, data
        mov ds, ax
        mov es, ax

        printString str1 
        printString brake 
        ; 9 -> Identar
        printChar 9
        printChar 'H' ; Modo caracter
        printChar 79 ; Modo decimal del ascii '0'
        printChar 4Ch ; Modo hexadecimal del ascii 'L'
        printChar 101o ; Modo octal del ascii 'A'
        
        call exitApp
    ends
end start