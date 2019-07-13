/*
 * hex2dec.c
 *
 *  Created on: May 21, 2015
 *      Author: bill.chatfield
 */

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    int i;
    unsigned int n;
    int conversionResult;

    for (i = 1; i < argc; i++) {
        /* %x means a signed or unsigned hexadecimal integer. */
        conversionResult = sscanf(argv[i], "%x", &n);

        if (conversionResult == EOF || conversionResult != 1) {
            fprintf(stderr, "%s: invalid hexadecimal number\n", argv[i]);
        }
        else {
            /* %u means unsigned decimal. */
            printf("%u\n", n);
        }
    }
    return EXIT_SUCCESS;
}

