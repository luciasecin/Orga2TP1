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
<<<<<<< HEAD
=======
global listPrint
>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997
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
extern getCloneFunction
<<<<<<< HEAD
extern getDeleteFunction
extern listPrint
=======
>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997

section .data
    formato_fprintf_i: db "%d", 0
    formato_fprintf_s: db "%s", 0
<<<<<<< HEAD
    formato_fprintf_c_1: db "{", 0
    formato_fprintf_c_2: db " - ", 0
    formato_fprintf_c_3: db "}", 0
=======
>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997
    %define LIST_TYPE 0
    %define LIST_SIZE 4
    %define LIST_FIRST 8
    %define LIST_LAST 16
    %define NODE_DATA 0
    %define NODE_NEXT 8
    %define NODE_PREV 16
<<<<<<< HEAD
    %define CARD_SUIT 0
    %define CARD_NUMBER 8
    %define CARD_STACKED 16
=======
>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997

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

    mov rax, 0
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
    mov rbp, rsp     ;pila alineada
    push r12
    sub rsp, 8

    mov r12, rdi
    call strLen

    .allocate:
    inc rax
    mov rdi, rax
    call malloc
    mov rcx, 0

    .write:
    mov dl, [r12 + rcx] 
    mov [rax + rcx], dl
    inc rcx
    cmp dl, 0
    je .fin
    jmp .write
    
     
    .fin:
    add rsp, 8
    pop r12
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

    mov rax, 0
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

    mov qword [rax], 0
    mov [rax], r10d
    mov qword [rax+4], 0
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
    push r9
    push r10

    mov rax, 0
    mov rdx, rdi ; struct
    mov al, [rdx + 4]  ; size
    mov dil, [rdx + 5]   ; cap
    cmp al, dil
<<<<<<< HEAD
    jge .fin
=======
    je .fin
>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997

    .agregar:
    mov rdi, [rdx + 8] ;primer puntero del array de data
    
    mov cl, 8
    mul cl
    add rax, rdi
    mov rdi, rax ; principio de los 8 bytes del nuevo dato
    
    inc byte [rdx + 4]

<<<<<<< HEAD
    mov r9, rdi     ; pos del nuevo dato
=======
    mov r9, rdi    ; inicio del struct array
>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997
    mov r10, rsi    ; puntero a data
    
    mov rdi, 0
    mov edi, [edx]          ; paso a rdi el type de la funcion
    call getCloneFunction   ; llamo a la funcion para clonar queda en rax el puntero 
    mov rdi, r10            ; pongo en rdi lo que hay que copiar
    call rax                ; llamo al clonador magico, en rax esta lo clonado
    mov [r9], rax

    .fin:
    pop r10
    pop r9
    pop rbp
    ret

; void* arrayGet(array_t* a, uint8_t i)
arrayGet:
    push rbp
    mov rbp, rsp     ;pila alineada

    mov rax, 0
    mov rdx, rdi ; struct
    mov al, [rdx + 4]  ; size
    cmp sil, al
    jge .fin
    mov al, sil

    mov rdi, [rdx + 8] ;primer puntero del array de data
    
    mov cl, 8
    mul cl
    add rax, rdi
    mov rax, [rax]

    .fin:
    pop rbp
    ret

; void* arrayRemove(array_t* a, uint8_t i)
arrayRemove:
    push rbp
    mov rbp, rsp     ;pila alineada
<<<<<<< HEAD
    push r12
    push r13
    push r14
    sub rsp, 8

    mov r12, rdi
    mov r13, rsi

    mov al, [r12 + 4]  ; size
    cmp sil, al
    jge .fueraDeRango

    mov rsi, 0
    mov sil, [r12+4]
    dec rsi
    call arrayGet
    mov r14, rax
    dec byte [r12 + 4]

    .ciclo:
    mov rdi, [r12+4]
    mov rsi, r13
    cmp sil, dil
    je .fin
    mov rdi, r12
    inc r13
    mov rdx, r13    ;j
    call arraySwap
    jmp .ciclo

    .fueraDeRango:
    mov r14, 0
    jmp .fin

    .fin:
    mov rax, r14
    add rsp, 8
    pop r14
    pop r13
    pop r12
=======
    push r9
    push r10
    push rbx
    sub rsp, 8

    ;Quita el i-esimo elemento del arreglo, si i se encuentra fuera de rango, retorna 0. El arreglo es
    ;reacomodado de forma que ese elemento indicado sea quitado y retornado.

    mov rax, 0
    mov al, [rdi + 4]  ; size
    cmp sil, al
    jge .fueraDeRango
    mov r9, rdi        ;a
    mov bl, al         ;size
    mov r10, rsi       ;i

    .ciclo:
    mov rdi, r9
    mov rsi, 0
    mov rdx, 0
    mov rsi, r10 
    inc rsi          ;j
    mov rdx, r10     ;i
    cmp sil, bl
    je .borrarUltimo
    call arraySwap
    inc r10

    .borrarUltimo:
    mov rdx, [r9 + 8]
    mov rax, 0
    mov rax, r10
    mov cl, 8
    mul cl
    add rax, rdx
    mov rdi, [rax]
    call free
    dec bl
    mov byte [r9 + 4], bl
    jmp .fin

    .fueraDeRango:
    mov rax, 0
    jmp .fin

    .fin:
    add rsp, 8
    pop rbx
    pop r10
    pop r9
>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997
    pop rbp
    ret

; void  arraySwap(array_t* a, uint8_t i, uint8_t j)
arraySwap:
    push rbp
    mov rbp, rsp     ;pila alineada

    mov rax, 0
    mov al, [rdi + 4]  ; size
    cmp sil, al
    jge .fin
    cmp dl, al
    jge .fin
    cmp sil, dl
    je .fin

    .calculo:
    mov rdi, [rdi + 8] ;primer puntero del array de data
    
    mov rax, 0
    mov al, sil
    mov cl, 8
    mul cl
    add rax, rdi
    mov rsi, rax ; puntero a i

    mov rax, 0
    mov al, dl
    mov cl, 8
    mul cl
    add rax, rdi ; puntero a j en rax

    .swap:
    mov rdi, [rsi]
    mov rdx, [rax]
    mov [rsi], rdx
    mov [rax], rdi
    
    .fin:
    pop rbp
    ret

; void  arrayDelete(array_t* a)
arrayDelete:
    push rbp
    mov rbp, rsp     ;pila alineada
    push rbx
    push r12
<<<<<<< HEAD
    push r13
=======
>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997

    mov r12, rdi
    mov rbx, 0
    mov rax, [rdi + 4]
    mov bl, al  ;size

    .ciclo:
    mov rdi, r12
    cmp bl, 0
    je .fin
    dec rbx
    mov rsi, 0
    mov rsi, rbx
    call arrayRemove
<<<<<<< HEAD
    mov r13, rax
    mov rdi, [r12]
    call getDeleteFunction
    mov rdi, r13
    call rax
=======
>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997
    jmp .ciclo

    .fin:
    mov rdi, r12
    mov rsi, rdi
    mov rdi, [rdi+8]
    call free
    mov rdi, rsi
    call free
<<<<<<< HEAD
    
    pop r13
=======

>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997
    pop r12
    pop rbx
    pop rbp
    ret

; ** Lista **

; list_t* listNew(type_t t)
listNew:
    push rbp
    mov rbp, rsp     ;pila alineada
    push rbx
    sub rsp, 8

    mov ebx, edi
    mov rdi, 0
    mov edi, 24

    call malloc
    
    mov dword [rax + LIST_TYPE], ebx
    mov byte [rax + LIST_SIZE], 0
    mov qword [rax + LIST_FIRST], 0
    mov qword [rax + LIST_LAST], 0

    add rsp, 8
    pop rbx
    pop rbp
    ret

; uint8_t  listGetSize(list_t* l)
listGetSize:
    push rbp
    mov rbp, rsp     ;pila alineada

    mov rax, 0
    mov al, [rdi + LIST_SIZE]

    pop rbp
    ret

; void listAddFirst(list_t* l, void* data)
listAddFirst:
    push rbp
    mov rbp, rsp     ;pila alineada
    push rbx
    push r10
    push r12
    sub rsp, 8

    mov r12, rsi
    mov rbx, rdi
    mov rdi, 24
    call malloc

    mov rdx, [rbx + LIST_FIRST]
    mov [rax + NODE_NEXT], rdx
    mov dil, [rbx + LIST_SIZE]
    cmp dil, 1
    jge .cambiarAnterior
    jmp .seguir

    .cambiarAnterior:
    mov [rdx + NODE_PREV], rax

    .seguir:
    mov qword [rax + NODE_PREV], 0

    mov r10, rax

    mov rdi, 0
    mov edi, [rbx + LIST_TYPE]          ; paso a rdi el type de la funcion
    call getCloneFunction               ; llamo a la funcion para clonar queda en rax el puntero 
    mov rdi, r12                        ; pongo en rdi lo que hay que copiar
    call rax                            ; llamo al clonador magico, en rax esta lo clonado
    mov [r10 + NODE_DATA], rax
    
    mov [rbx + LIST_FIRST], r10

    mov dl, [rbx + LIST_SIZE]
    cmp dl, 0
    jne .fin
    mov [rbx + LIST_LAST], r10

    .fin:
    inc byte [rbx + LIST_SIZE]

    add rsp, 8
    pop r12
    pop r10
    pop rbx
    pop rbp
    ret

; void* listGet(list_t* l, uint8_t i)
listGet:
    push rbp
    mov rbp, rsp     ;pila alineada

    mov dl, [rdi + LIST_SIZE]
    cmp sil, dl
    jge .fin
    mov rdi, [rdi + LIST_FIRST]

    .ciclo:
    cmp sil, 0
    je .salida
    mov rdi, [rdi + NODE_NEXT]
    dec sil
    jmp .ciclo


    .salida:
    mov rax, [rdi + NODE_DATA]

    .fin:
    pop rbp
    ret

; void* listRemove(list_t* l, uint8_t i)
listRemove:
    push rbp
<<<<<<< HEAD
    mov rbp, rsp
    push r12
    push r13
    push r14
    sub rsp, 8

    mov r12, rdi
    movzx r13, sil

    mov dil, [r12 + LIST_SIZE]
    cmp sil, dil
    jge .fueraDeRango

    mov rdx, [r12 + LIST_FIRST]
    mov rax, 0
    
    .ciclo:
    cmp rax, r13
    je .break
    mov rdx, [rdx + NODE_NEXT]
    inc rax
    jmp .ciclo

    .break:
    mov rsi, [rdx + NODE_PREV]
    mov rdi, [rdx + NODE_NEXT]

    cmp rsi, 0
    jne .noEsPrimero
    mov [r12 + LIST_FIRST], rdi
    jmp .siguiente

    .noEsPrimero:
    mov [rsi + NODE_NEXT], rdi

    .siguiente:
    cmp rdi, 0
    jne .noEsUltimo
    mov [r12 + LIST_LAST], rsi
    jmp .end

    .noEsUltimo:
    mov [rdi + NODE_PREV], rsi

    .end:
    dec byte [r12 + LIST_SIZE]
    mov r14, [rdx + NODE_DATA]
    mov rdi, rdx
    call free
    jmp .fin

    .fueraDeRango:
    mov r14, 0

    .fin:
    mov rax, r14
    add rsp, 8
    pop r14
    pop r13
    pop r12
    pop rbp
    ret 
=======
    mov rbp, rsp     ;pila alineada
    push rbx
    push r12

    ;poner en el next de i-1 a i+1
    ;poner en el prev de i+1 a i-1

    mov r12, rdi
    mov rbx, rsi
    mov dl, [rdi + LIST_SIZE]
    cmp sil, dl
    jge .fin
    dec byte [rdi + LIST_SIZE]
    mov rdi, [rdi + LIST_FIRST]
    
    .ciclo:
    cmp sil, 0
    je .salida
    mov rdi, [rdi + NODE_NEXT]
    dec sil
    jmp .ciclo
    
    .salida:
    mov rsi, [rdi + NODE_NEXT] ; rsi siguiente
    mov rdx, [rdi + NODE_PREV] ; rdx anterior

    ;[rdx, rdi, rsi]
    
    cmp rsi, 0
    je .esElUltimo
    mov [rsi + NODE_PREV], rdx 

    .continuar:
    cmp rdx, 0
    je .esElPrimero
    mov [rdx + NODE_NEXT], rsi          ;siguiente del anterior (rdx) de i es el es siguiente de i
    jmp .liberarMemoria

    .esElUltimo:
    mov [r12 + LIST_LAST], rdx            ;nuevo last es el anterior
    jmp .continuar

    .esElPrimero:
    mov [r12 + LIST_FIRST], rsi           ;nuevo primero es el siguiente
    jmp .liberarMemoria

    ;ahora libero la memoria de i
    ;rdi tiene nodo    

    .liberarMemoria:
    mov rbx, rdi
    mov rdi, [rdi + NODE_DATA]
    call free
    mov rdi, rbx
    call free


    .fin:
    pop r12
    pop rbx
    pop rbp
    ret
>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997

   
; void  listSwap(list_t* l, uint8_t i, uint8_t j)
listSwap:
    push rbp
    mov rbp, rsp     ;pila alineada

<<<<<<< HEAD
    mov cl, [rdi + LIST_SIZE]
    cmp dl, cl
    jge .fin
    cmp sil, cl
    jge .fin
    cmp dl, sil
    je .fin
    mov rax, [rdi + LIST_FIRST]
    mov rcx, [rdi + LIST_FIRST]

    .ciclo:
    cmp sil, 0
    je .ciclo2
    mov rax, [rax + NODE_NEXT]
    dec sil
    jmp .ciclo

    .ciclo2:
    cmp dl, 0
    je .seguir
    mov rcx, [rcx + NODE_NEXT]
    dec dl
    jmp .ciclo2

    .seguir:
    mov rsi, [rcx + NODE_DATA]
    mov rdi, [rax + NODE_DATA]
    mov [rcx + NODE_DATA], rdi
    mov [rax + NODE_DATA], rsi

    .fin:
=======
    

>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997
    pop rbp
    ret

; list_t* listClone(list_t* l)
listClone:
    push rbp
    mov rbp, rsp     ;pila alineada
<<<<<<< HEAD
    push r12
    push r13
    push rbx

    mov r12, rdi
    mov rdi, [r12 + LIST_TYPE]
    call listNew
    mov r13, rax
    mov rbx, 0
    mov bl, [r12 + LIST_SIZE]

    .ciclo:
    cmp bl, 0
    je .fin
    mov rdi, r12
    dec rbx
    mov rsi, rbx
    call listGet
    mov rdi, r13
    mov rsi, rax
    call listAddFirst
    jmp .ciclo

    .fin:
    mov rax, r13
    pop rbx
    pop r13
    pop r12
=======

    

>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997
    pop rbp
    ret

; void listDelete(list_t* l)
listDelete:
    push rbp
    mov rbp, rsp     ;pila alineada
<<<<<<< HEAD
    push r12
    push r13
    push rbx
    sub rsp, 8

    mov r12, rdi                    ;guardo la lista
    mov rbx, 0                      ;guardo en rbx el size de la lista
    mov bl, [r12+LIST_SIZE]

    .ciclo:
    cmp bl, 0
    je .break
    mov rdi, r12
    mov rsi, 0
    call listRemove
    mov r13, rax
    mov rdi, [r12]
    call getDeleteFunction
    mov rdi, r13
    call rax
    dec bl
    jmp .ciclo

    .break:
    mov rdi, r12
    call free

    add rsp, 8
    pop rbx
    pop r13
    pop r12
=======
    push rbx
    push r10

    mov r10, rdi                    ;guardo la lista
    mov bl, [r10 + LIST_SIZE]       ;guardo en rbx el size de la lista

    .ciclo:
    cmp bl, 0
    je .fin
    mov rdi, r10
    mov rsi, 0
    call listRemove
    dec bl
    jmp .ciclo

    .fin:
    mov rdi, r10
    call free

    pop r10
    pop rbx
>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997
    pop rbp
    ret

; ** Card **

; card_t* cardNew(char* suit, int32_t* number)
<<<<<<< HEAD

;
;typedef struct s_card {
;	char*     suit;	//0				
;	int32_t* number; //8
;	list_t* stacked; //16
;} card_t;	//24

cardNew:
    push rbp
    mov rbp, rsp     ;pila alineada
    push r12
    push r13
    push r14
    sub rsp, 8

    mov r12, rdi        ;r12 = suit
    mov r13, rsi        ;r13 = number

    mov rdi, 24
    call malloc
    mov r14, rax        ;r14 = nueva carta

    mov rdi, r12
    call strClone
    mov [r14 + CARD_SUIT], rax

    mov rdi, r13
    call intClone
    mov [r14 + CARD_NUMBER], rax

    mov qword [r14 + CARD_STACKED], 0

    mov rax, r14  

    add rsp, 8
    pop r14
    pop r13
    pop r12
=======
cardNew:
    push rbp
    mov rbp, rsp     ;pila alineada
      

>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997
    pop rbp
    ret

; char* cardGetSuit(card_t* c)
cardGetSuit:
    push rbp
    mov rbp, rsp     ;pila alineada

<<<<<<< HEAD
    mov rax, [rdi + CARD_SUIT]

=======
>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997
    pop rbp
    ret

; int32_t* cardGetNumber(card_t* c) 
cardGetNumber:
    push rbp
    mov rbp, rsp     ;pila alineada

<<<<<<< HEAD
    mov rax, [rdi + CARD_NUMBER]

=======
>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997
    pop rbp
    ret

; list_t* cardGetStacked(card_t* c)
cardGetStacked:
    push rbp
    mov rbp, rsp     ;pila alineada

<<<<<<< HEAD
    mov rax, [rdi + CARD_STACKED]
=======
    
>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997

    pop rbp
    ret

; int32_t cardCmp(card_t* a, card_t* b)
cardCmp:
    push rbp
    mov rbp, rsp     ;pila alineada
<<<<<<< HEAD
    push r12
    push r13

    mov r12, rdi
    mov r13, rsi

    mov rdi, [r12 + CARD_SUIT]
    mov rsi, [r13 + CARD_SUIT]
    
    call strCmp
    cmp rax, 0
    je .mismoSuit
    jmp .fin

    .mismoSuit:
    mov rdi, [r12 + CARD_NUMBER]
    mov rsi, [r13 + CARD_NUMBER]
    call intCmp

    .fin:
    pop r13
    pop r12
=======

    

>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997
    pop rbp
    ret

; card_t* cardClone(card_t* c)
cardClone:
    push rbp
    mov rbp, rsp     ;pila alineada
<<<<<<< HEAD
    push r12
    push r13
    sub rsp, 8

    mov r12, rdi
    mov rdi, [r12+CARD_SUIT]
    mov rsi, [r12+CARD_NUMBER]
    call cardNew
    mov r13, rax
    
    mov rdi, [r12+CARD_STACKED]
    cmp rdi, 0
    je .fin
    call listClone
    mov [r13 + CARD_STACKED], rax
    
    .fin:
    mov rax, r13
    add rsp, 8
    pop r13
    pop r12
=======


>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997
    pop rbp
    ret

; void cardAddStacked(card_t* c, card_t* card)
<<<<<<< HEAD
;Agrega una copia de la carta card a las cartas apiladas debajo de c. La carta debe ser agregada al
;comienzo de dicha pila.
cardAddStacked:
    push rbp
    mov rbp, rsp     ;pila alineada
    push r12
    push r13
    sub rsp, 8
    
    mov r12, rdi    ;r12 tiene la carta og
    mov r13, rsi    ;r13 tiene la carta a agregar

    mov rdi, [r12 + CARD_STACKED] ;rdi puntero a las stacked, rsi la carta a stackear
    cmp rdi, 0
    jne .agregarCarta
    mov rdi, 0
    mov rdi, 3
    call listNew
    mov [r12 + CARD_STACKED], rax
    mov rdi, rax    
    
    .agregarCarta:
    call listAddFirst
    jmp .fin
    
    .fin:
    add rsp, 8
    pop r13    
    pop r12
=======
cardAddStacked:
    push rbp
    mov rbp, rsp     ;pila alineada

    

>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997
    pop rbp
    ret

; void cardDelete(card_t* c)
cardDelete:
    push rbp
    mov rbp, rsp     ;pila alineada
<<<<<<< HEAD
    push r12
    sub rsp, 8

    mov r12, rdi
    
    mov rdi, [r12+CARD_SUIT]
    call strDelete

    mov rdi, [r12+CARD_NUMBER]
    call intDelete

    mov rdi, [r12+CARD_STACKED]
    cmp rdi, 0
    je .fin
    call listDelete

    .fin:
    mov rdi, r12
    call free

    add rsp, 8
    pop r12
=======

    call free

>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997
    pop rbp
    ret

; void cardPrint(card_t* c, FILE* pFile)
<<<<<<< HEAD
;Escribe la carta c en el stream indicado a través de pFile. El formato de impresión tiene la forma:
;{suit-number-list of stacked cards}
cardPrint:
    push rbp
    mov rbp, rsp     ;pila alineada
    push r12
    push r13
    sub rsp, 8

    mov r12, rdi
    mov r13, rsi
    
    mov rax, 0
    mov rdi, r13
    mov rsi, formato_fprintf_c_1
    call fprintf
    
    mov rax, 0
    mov rdi, [r12 + CARD_SUIT]
    mov rsi, r13
    call strPrint

    mov rax, 0
    mov rdi, r13
    mov rsi, formato_fprintf_c_2
    call fprintf

    mov rax, 0
    mov rdi, [r12 + CARD_NUMBER]
    mov rsi, r13
    call intPrint

    mov rax, 0
    mov rdi, r13
    mov rsi, formato_fprintf_c_2
    call fprintf

    mov rax, 0
    mov rdi, [r12 + CARD_STACKED]
    mov rsi, r13
    call listPrint

    mov rax, 0
    mov rdi, r13
    mov rsi, formato_fprintf_c_3
    call fprintf

    add rsp, 8
    pop r13
    pop r12
=======
cardPrint:
    push rbp
    mov rbp, rsp     ;pila alineada

    

>>>>>>> 0ab9a87373d780c93157b6c9a764b4d5c717f997
    pop rbp
    ret
