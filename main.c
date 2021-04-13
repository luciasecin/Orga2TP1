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

    //type_t type = TypeString;
    type_t type = TypeInt;
    uint8_t capacity = 3;
    array_t* array = arrayNew(type, capacity);

    //char* dato = "lucy";
    //char* dato_2 = "sebas";
    uint32_t dato = 4;
    uint32_t dato_2 = 7;
    arrayAddLast(array, &dato);
    arrayAddLast(array, &dato_2);
    arrayAddLast(array, &dato);
    arrayRemove(array, 1);
    uint8_t size = arrayGetSize(array);

    //arrayRemove(array, 1);

    printf("Test arrayGetSize: %d\n", size);

    FILE *fp_array = fopen("array_print.txt", "w");
    arrayPrint(array, fp_array);    
    fclose(fp_array);

    arrayDelete(array);

    printf("FIN\n");

    /*//TEST CARDNEW, CARDGETSUIT, CARDGETNUMBER ////////////////////////////////////////////

    char* suit = "espada";
    int32_t number = 9;
    card_t* carta = cardNew(suit, &number);

    res = true;
    res = (suit == cardGetSuit(carta)) && (number == *cardGetNumber(carta));
    printf("Test cardNew, cardGetSuit & cardGetNumber: %s\n", res ? "Paso el test" : "No paso el test");*/

    return 0;
}




