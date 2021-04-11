global intCmp
global intClone
global intDelete
global intPrint
global strCmp
global strClone
global strDelete
global strPrint
global strLen
global arrayNew
global arrayGetSize
global arrayAddLast
global arrayGet
global arrayRemove
global arraySwap
global arrayDelete
global listNew
global listGetSize
global listAddFirst
global listGet
global listRemove
global listSwap
global listClone
global listDelete
global listPrint
global cardNew
global cardGetSuit
global cardGetNumber
global cardGetStacked
global cardCmp
global cardClone
global cardAddStacked
global cardDelete
global cardPrint

extern malloc
extern free
extern fprintf

section .data
    formato_fprintf_i: db "%d", 10, 0
    formato_fprintf_s: db "%s", 10, 0

section .text

; ** Int **

; orden registros: rdi,rsi,rdx,rcx,r8,r9
; punto flotante xmm0 hasta xmm7
; despues a la pila
; registros para usar de esos q se mantienen rbx, 

; int32_t intCmp(int32_t* a, int32_t* b) a = b -> 0 a < b -> 1 b < a -> -1
; (rdi)edi -> a
; (rsi)esi -> b
intCmp:
    push rbp
    mov rbp, rsp     ;pila alineada 

    mov edi, [rdi]
    mov esi, [rsi]
    cmp edi, esi
    je .igual
    jg .mayor

    mov rax, 1
    jmp .fin
    .mayor:
    mov rax, -1
    jmp .fin
    .igual:
    mov rax, 0

    .fin:
    pop rbp
    ret

; int32_t* intClone(int32_t* a)
; edi -> a
intClone:
    push rbp
    mov rbp, rsp     ;pila alineada\

    mov esi, [rdi]
    mov rdi, 4
    call malloc
    mov [rax], esi   
     
    pop rbp
    ret

; void intDelete(int32_t* a)
intDelete:
    push rbp
    mov rbp, rsp     ;pila alineada

    call free

    pop rbp
    ret

; void intPrint(int32_t* a, FILE* pFile)
; edi -> *a
; rsi -> *pfile  uwu iwi owo ewe
intPrint:
    push rbp
    mov rbp, rsp     ;pila alineada

    mov edx, [rdi]
    mov rdi, rsi
    mov rsi, formato_fprintf_i
    call fprintf  

    pop rbp
    ret

; ** String **

; int32_t strCmp(char* a, char* b)
strCmp:
    push rbp
    mov rbp, rsp     ;pila alineada 
    push rbx
    
    mov rcx, 0

    .cmp:
    mov bl, [rdi+rcx]
    mov dl, [rsi+rcx]
    add rcx, 1
    cmp bl, dl
    jg .mayor
    jl .menor
    cmp bl, 0
    je .mismos
    jmp .cmp
    
    .mismos:
    mov rax, 0
    jmp .fin
    
    .mayor:
    mov rax, -1
    jmp .fin
    
    .menor:
    mov rax, 1
    

    .fin:
    pop rbx
    pop rbp
    ret

; char* strClone(char* a)
strClone:
    push rbp
    mov rbp, rsp     ;pila alineada\

    mov rsi, rdi
    call strLen

    .allocate:
    inc rax
    mov rdi, rax
    call malloc
    mov rcx, 0

    .write:
    mov dl, [rsi + rcx] 
    mov [rax + rcx], dl
    inc rcx
    cmp dl, 0
    je .fin
    jmp .write
    
     
    .fin:
    pop rbp
    ret

; void strDelete(char* a)
strDelete:
    push rbp
    mov rbp, rsp     ;pila alineada

    call free

    pop rbp
    ret

; void strPrint(char* a, FILE* pFile)
; rdi -> *a
; rsi -> *pFile
strPrint:
    push rbp
    mov rbp, rsp     ;pila alineada

    mov rdx, rdi
    mov rdi, rsi
    mov rsi, formato_fprintf_s
    call fprintf  

    pop rbp
    ret

; uint32_t strLen(char* a)
strLen:
    push rbp
    mov rbp, rsp     ;pila alineada

    mov rcx, 0

    .count:
    mov dl, [rdi+rcx]
    cmp dl, 0
    je .fin
    inc rcx
    jmp .count
    
    .fin:
    mov rax, rcx
    pop rbp
    ret

; ** Array **

; array_t* arrayNew(type_t t, uint8_t capacity)
; rdi -> type
; rsi -> capacity
arrayNew:
    push rbp
    mov rbp, rsp     ;pila alineada
    push r9
    push r10
    push r12
    sub rsp, 8

    mov r10d, edi ; type
    mov r12d, esi

    mov eax, r12d
    mov cl, 8
    mul cl
    movzx rdi, al
    call malloc ; rax ->**data
    mov r9, rax

    mov rdi, 16
    call malloc

    mov [rax], r10d
    mov byte [rax+4], 0
    mov [rax+5], r12d
    mov [rax+8], r9

    add rsp, 8
    pop r12
    pop r10
    pop r9
    pop rbp
    ret

; uint8_t  arrayGetSize(array_t* a)
arrayGetSize:
    push rbp
    mov rbp, rsp     ;pila alineada

    mov rax, [rdi + 4] 

    pop rbp
    ret

; void  arrayAddLast(array_t* a, void* data)
; rdi -> a
; rsi -> data
arrayAddLast:
    push rbp
    mov rbp, rsp     ;pila alineada

    
    pop rbp
    ret

; void* arrayGet(array_t* a, uint8_t i)
arrayGet:
    push rbp
    mov rbp, rsp     ;pila alineada

    ; ir a la posicion i*8 y deberia estar ahi fml

    pop rbp
    ret

; void* arrayRemove(array_t* a, uint8_t i)
arrayRemove:
    push rbp
    mov rbp, rsp     ;pila alineada

    

    pop rbp
    ret

; void  arraySwap(array_t* a, uint8_t i, uint8_t j)
arraySwap:
    push rbp
    mov rbp, rsp     ;pila alineada

    

    pop rbp
    ret

; void  arrayDelete(array_t* a)
arrayDelete:
    push rbp
    mov rbp, rsp     ;pila alineada

    mov rsi, rdi
    mov rdi, [rdi+8]
    call free
    mov rdi, rsi
    call free

    pop rbp
    ret

; ** Lista **

; list_t* listNew(type_t t)
listNew:
    push rbp
    mov rbp, rsp     ;pila alineada

    

    pop rbp
    ret

; uint8_t  listGetSize(list_t* l)
listGetSize:
    push rbp
    mov rbp, rsp     ;pila alineada

    

    pop rbp
    ret

; void listAddFirst(list_t* l, void* data)
listAddFirst:
    push rbp
    mov rbp, rsp     ;pila alineada

    

    pop rbp
    ret

; void* listGet(list_t* l, uint8_t i)
listGet:
    push rbp
    mov rbp, rsp     ;pila alineada

    

    pop rbp
    ret

; void* listRemove(list_t* l, uint8_t i)
listRemove:
    push rbp
    mov rbp, rsp     ;pila alineada

    

    pop rbp
    ret

; void  listSwap(list_t* l, uint8_t i, uint8_t j)
listSwap:
    push rbp
    mov rbp, rsp     ;pila alineada

    

    pop rbp
    ret

; list_t* listClone(list_t* l)
listClone:
    push rbp
    mov rbp, rsp     ;pila alineada

    

    pop rbp
    ret

; void listDelete(list_t* l)
listDelete:
    push rbp
    mov rbp, rsp     ;pila alineada

    

    pop rbp
    ret

; ** Card **

; card_t* cardNew(char* suit, int32_t* number)
cardNew:
    push rbp
    mov rbp, rsp     ;pila alineada
      

    pop rbp
    ret

; char* cardGetSuit(card_t* c)
cardGetSuit:
    push rbp
    mov rbp, rsp     ;pila alineada

    pop rbp
    ret

; int32_t* cardGetNumber(card_t* c) 
cardGetNumber:
    push rbp
    mov rbp, rsp     ;pila alineada

    pop rbp
    ret

; list_t* cardGetStacked(card_t* c)
cardGetStacked:
    push rbp
    mov rbp, rsp     ;pila alineada

    

    pop rbp
    ret

; int32_t cardCmp(card_t* a, card_t* b)
cardCmp:
    push rbp
    mov rbp, rsp     ;pila alineada

    

    pop rbp
    ret

; card_t* cardClone(card_t* c)
cardClone:
    push rbp
    mov rbp, rsp     ;pila alineada


    pop rbp
    ret

; void cardAddStacked(card_t* c, card_t* card)
cardAddStacked:
    push rbp
    mov rbp, rsp     ;pila alineada

    

    pop rbp
    ret

; void cardDelete(card_t* c)
cardDelete:
    push rbp
    mov rbp, rsp     ;pila alineada

    call free

    pop rbp
    ret

; void cardPrint(card_t* c, FILE* pFile)
cardPrint:
    push rbp
    mov rbp, rsp     ;pila alineada

    

    pop rbp
    ret
