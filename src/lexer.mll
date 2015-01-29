(* lexer.mll -*- tuareg -*- *)
{
  open Parser
		   
  let get = Lexing.lexeme
}

let ws = [' ' '\t']
let newline = '\n' | '\r' | '\r' '\n' 
let digit = ['0'-'9']

rule token = parse
  | eof            { EOF }
(*  | ws+            { token lexbuf } *)
  | " "            { token lexbuf }
  | newline        { Lexing.new_line lexbuf; NEWLINE }
  | "x"            { X }
  | "y"            { Y }
  | "z"            { Z }
  | "inc"          { INC }
  | "dec"          { DEC }
  | "zero"         { ZERO }
  | "else"         { ELSE }
  | "stop"         { STOP }
  | digit+         { INT (get lexbuf) }
