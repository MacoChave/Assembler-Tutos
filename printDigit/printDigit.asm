data segment
    res db 4 dup('$')
    number db 58
    break db 13, 10, '$'
ends
stack segment
    dw 128 dup(0)
ends
code segment
    printString MACRO string 
        mov ah, 09h
        mov dx, offset string
        int 21h
    ENDM 
    
    numAscii MACRO num
        LOCAL extractDig, convertDig
        mov ax, num
        mov cx, 0
        mov bx, 10
        
        extractDig:
            mov dx, 0
            div bx
            push dx
            inc cx
            cmp ax, 9
            ja extractDig
        
        inc cx
        mov bx, 0
        convertDig:
            add al, 30h
            mov res + bx, al
            
            pop ax
            inc bx
        LOOP convertDig
        mov res + bx, '$'
    ENDM
    
    exitApp MACRO
        mov ax, 4c00h
        int 21h
    ENDM

    start:
        mov ax, data
        mov ds, ax
        mov es, ax
        
        numAscii 185
        printString res

        printString break

        xor ax, ax
        mov al, number
        numAscii ax
        printString res
        
        exitApp
    ends
end start