#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>
#include <math.h>

#include "lib.h"

int main (void){  

    //TEST INTCMP///////////////////////////////////////////////////////////////////////

    bool res = true;
    for (int32_t i = 0; i < 10; i++){
        for (int32_t j = 5; j < 15; j++){
            int32_t c = 0;
            if(i < j) c = 1;
            else if (i == j) c = 0;
            else c = -1;

            res &= c == intCmp(&i, &j);
        }
        
    }

    printf("Test intCmp: %s\n", res ? "Paso el test" : "No paso el test");

    //TEST INTCLONE///////////////////////////////////////////////////////////////////////

    int32_t *temp[10];
    res = true;
    for (int32_t i = 0; i < (int)(sizeof(temp)/sizeof(temp[0])); i++){
        temp[i] = intClone(&i);
        res &= i == *temp[i];
    }
    
    printf("Test intClone: %s\n", res ? "Paso el test" : "No paso el test");

    //TEST INTDELETE///////////////////////////////////////////////////////////////////////

    for (int32_t i = 0; i < (int)(sizeof(temp)/sizeof(temp[0])); i++) {
        intDelete(temp[i]);
    }

    //TEST INTPRINT///////////////////////////////////////////////////////////////////////

    FILE *fp_int = fopen("int_print.txt", "w");
    int32_t a = 68;
    intPrint(&a, fp_int);
    fclose(fp_int);

    //TEST STRCMP///////////////////////////////////////////////////////////////////////

    char* s_1 = "sebas"; //mayor
    char* s_2 = "lucy"; //menor
    res = true;

    res = 0 == strCmp(s_1, s_1) && 1 == strCmp(s_2, s_1) && -1 == strCmp(s_1, s_2) && 0 == strCmp(s_2,s_2);

    printf("Test strCmp: %s\n", res ? "Paso el test" : "No paso el test");

    //TEST STRPRINT///////////////////////////////////////////////////////////////////////

    FILE *fp_str = fopen("str_print.txt", "w");
    char* s = "Paso el test";
    strPrint(s, fp_str);
    fclose(fp_str);

    //TEST STRCLONE///////////////////////////////////////////////////////////////////////

    char* s_clon = strClone(s);
    printf("Test strClone: %s\n", s_clon);

    //TEST STRDELETE///////////////////////////////////////////////////////////////////////

    strDelete(s_clon);

    //TESTS ARRAY/////////////////////////////////////////////////////////////////////////

    type_t type = 3;
    uint8_t capacity = 3; //no puedo seguir vpy a llorar un rato a la banieira si queres mas tarde intentar de nuevp avisame
    // intenta una ultima ves por consola
    // creo que se arreglo el delete
    //oki, ?? f no? con los chicos estamos con el gdb, y podemos ver que registros se cambian con el malloc
    //me sigue tirando error, dejame que me banio y si queres vemos el gdb, ????? dale
     // cuantos bytes perdemos? 24? si
     // no ves el 
     // no, no se por que se me cerro y no puedo ver
     //ahi? nope apreta el play arriba a la derechadsps vemos, anda tranca kookkko
    array_t* array = arrayNew(type, capacity);
    uint32_t size = arrayGetSize(array);

    printf("Test arrayGetSize1: %d", size);

    arrayDelete(array);

    /*//TEST CARDNEW, CARDGETSUIT, CARDGETNUMBER ////////////////////////////////////////////

    char* suit = "espada";
    int32_t number = 9;
    card_t* carta = cardNew(suit, &number);

    res = true;
    res = (suit == cardGetSuit(carta)) && (number == *cardGetNumber(carta));
    printf("Test cardNew, cardGetSuit & cardGetNumber: %s\n", res ? "Paso el test" : "No paso el test");*/

    return 0;
}




