/* File parser.mly */
%{
%}
%token <string> INT
%token X
%token Y
%token Z
%token INC
%token DEC
%token ZERO
%token ELSE
%token STOP
%token EOF
%token NEWLINE

%left 

%start instlist             /* the entry point */
%type <Ast.inst list> instlist
%%

instlist :                       { [] }
         | inst NEWLINE instlist { $1::$3 }
;

inst : INC var                   { Ast.INC $2 }
     | DEC var                   { Ast.DEC $2 }
     | ZERO var INT ELSE INT     { Ast.ZERO ($2, 
				 	     int_of_string $3,
					     int_of_string $5) } 
     | STOP                      { Ast.STOP }
;

var : X                          { Ast.X }
    | Y                          { Ast.Y }
    | Z                          { Ast.Z }
;
