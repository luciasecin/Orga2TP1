#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>
#include <math.h>

#include "lib.h"

int main (void){  

    //TEST INTCMP

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

    //TEST INTCLONE
    int32_t *temp[10];
    res = true;
    for (int32_t i = 0; i < (int)(sizeof(temp)/sizeof(temp[0])); i++){
        temp[i] = intClone(&i);
        res &= i == *temp[i];
    }
    
    printf("Test intClone: %s\n", res ? "Paso el test" : "No paso el test");

    //TEST INTDELETE

    for (int32_t i = 0; i < (int)(sizeof(temp)/sizeof(temp[0])); i++) {
        intDelete(temp[i]);
    }
    
    //TEST INTPRINT

    FILE *fp = fopen("texto.txt", "w");
    int32_t a = 68;
    intPrint(&a, fp);
    return 0;
}




