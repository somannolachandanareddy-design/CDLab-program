#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

void keyw(char *p);

int i = 0, id = 0, kw = 0, num = 0, op = 0;

char keys[28][10] = {
    "auto","break","case","char","continue","default","do","double",
    "else","extern","float","for","goto","if","int","long",
    "register","return","short","signed","static","switch",
    "typedef","union","unsigned","void","volatile","while"
};

int main()
{
    char source[1000];
    char str[25];
    char seps[] = " \t\n,;(){}[]#\"<>";
    char oper[] = "!%^&*-+=~|.<>/?";
    int j, k;
    char ch;

    printf("Enter a C statement/program:\n");
    fgets(source, sizeof(source), stdin);

    for (k = 0; source[k] != '\0'; k++)
    {
        ch = source[k];

        /* Check operators */
        for (j = 0; oper[j] != '\0'; j++)
        {
            if (ch == oper[j])
            {
                printf("%c is an operator\n", ch);
                op++;

                str[i] = '\0';
                keyw(str);
                break;
            }
        }

        /* Check separators */
        for (j = 0; seps[j] != '\0'; j++)
        {
            if (i == -1)
                break;

            if (ch == seps[j])
            {
                str[i] = '\0';
                keyw(str);
                break;
            }
        }

        if (i != -1)
        {
            str[i] = ch;
            i++;
        }
        else
        {
            i = 0;
        }
    }

    /* Process last token */
    str[i] = '\0';
    keyw(str);

    printf("\nKeywords    : %d", kw);
    printf("\nIdentifiers : %d", id);
    printf("\nOperators   : %d", op);
    printf("\nNumbers     : %d\n", num);

    return 0;
}

void keyw(char *p)
{
    int k, flag = 0;

    if (strcmp(p, "") == 0)
    {
        i = -1;
        return;
    }

    for (k = 0; k < 28; k++)
    {
        if (strcmp(keys[k], p) == 0)
        {
            printf("%s is a keyword\n", p);
            kw++;
            flag = 1;
            break;
        }
    }

    if (flag == 0)
    {
        if (isdigit(p[0]))
        {
            printf("%s is a number\n", p);
            num++;
        }
        else
        {
            printf("%s is an identifier\n", p);
            id++;
        }
    }

    i = -1;
}
