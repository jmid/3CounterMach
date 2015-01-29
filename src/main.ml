(* main.ml -*- tuareg -*- *)

open Parser

let printf = Printf.printf

  let string_of_token = function
    | INT s -> s
    | X -> "x"
    | Y -> "y"
    | Z -> "z"
    | INC -> "inc"
    | DEC -> "dec"
    | ZERO -> "zero"
    | ELSE -> "else"
    | STOP -> "stop"
    | EOF -> "<EOF>"
    | NEWLINE -> "\n"

  let run chn input trace =
      let lexbuf = Lexing.from_channel chn in
      try
	let ast = Parser.instlist Lexer.token lexbuf in
	let () = 
	  print_endline "Program:\n";
	  Ast.prettyprint ast in
	if Wellformed.check ast
	then
	  let () =
	    print_endline
	      ("Running with input " ^ (string_of_int input) ^ "\n") in
	  let _ = Eval.run ast input trace in
	  ()
	else ()
      with Parsing.Parse_error -> 
	let curr_pos = lexbuf.Lexing.lex_curr_p in
	let line     = curr_pos.Lexing.pos_lnum in
	let col      = curr_pos.Lexing.pos_cnum - curr_pos.Lexing.pos_bol in
	Printf.printf "Parse error, line %i column %i\n" line col


  let _ =
    let input = ref 0 in
    let trace = ref false in
    let filenum  = ref 0 in
    let speclist = [("-input", Arg.Set_int input, "Input value of x (non-negative), default is 0");
		    ("-trace", Arg.Set trace, "Trace machine execution, default is false")] in
    let usagestr = "Usage: " ^ Sys.argv.(0) ^ " [options] <filename>" in
    if not (!Sys.interactive)
    then
      begin
	Arg.parse
	  speclist
	  (fun s -> try
  		      let inch = open_in s in
		      incr filenum;
		      print_string ("Opening file \"" ^ s ^ "\"\n\n");
		      (if !input >= 0
		       then run inch !input !trace
	               else Arg.usage speclist usagestr);
		      close_in inch;
		      exit 0
  	            with Sys_error e -> raise (Arg.Bad e)
	  ) usagestr;
	(if !filenum != 1 then Arg.usage speclist usagestr else ())
      end
    else ()
