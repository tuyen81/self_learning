%{
#include <stdio.h>
%}
%%
[0-9]+ { printf("%s\n", yytext); }
.|\n     ;
%%
main()
{
   int i;

 for (i = 0; i < 26; i++)
   vbltable[i] = 0;
 yyparse();
 for (i = 0; i < 26; i++)
  if (vbltable[i] != 0)
   printf("Table: %d :%d\n",  i, vbltable[i]);

}
